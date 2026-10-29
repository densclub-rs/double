#!/usr/bin/env python3
"""Generate scoped release notes and a bounded Telegram HTML announcement."""
import argparse
import html
import json
import os
from pathlib import Path
import re
import subprocess
import sys
from datetime import date

from release_common import owned, parse, project_knowledge_path


def git(*args):
    return subprocess.check_output(['git', *args], text=True, stderr=subprocess.PIPE).strip()


def baseline(tag):
    machine, version, kind = parse(tag)
    target = git('rev-parse', '--verify', f'refs/tags/{tag}^{{commit}}')
    stable, rc = [], []
    for other in git('tag', '--merged', target).splitlines():
        try:
            om, ov, ok = parse(other)
        except ValueError:
            continue
        if om != machine or other == tag:
            continue
        commit = git('rev-parse', '--verify', f'refs/tags/{other}^{{commit}}')
        if commit == target:
            continue
        if ok == 'stable' and ov < version:
            stable.append((ov, other))
        if ok == 'rc' and (ov < version or (kind == 'stable' and ov == version)):
            rc.append((ov, other))
    candidates = stable + rc
    return max(candidates)[1] if candidates else None


def api(endpoint):
    # No Telegram credentials here. Missing GitHub API access degrades to Git.
    try:
        result = subprocess.run(['gh', 'api', endpoint], capture_output=True,
                                text=True, timeout=15, check=True)
        return json.loads(result.stdout)
    except (OSError, subprocess.SubprocessError, ValueError):
        return None


def pr_for_commit(repo, sha):
    if not (os.environ.get('GH_TOKEN') and repo):
        return None
    prs = api(f'repos/{repo}/commits/{sha}/pulls')
    return next((pr for pr in (prs or []) if pr.get('merged_at')), None)


def pr_is_scoped(repo, number, machine):
    paths = []
    # GitHub caps PR file responses at 3000 files; don't trust an incomplete set.
    for page in range(1, 31):
        files = api(f'repos/{repo}/pulls/{number}/files?per_page=100&page={page}')
        if not isinstance(files, list):
            return False
        paths.extend(f['filename'] for f in files)
        paths.extend(f['previous_filename'] for f in files if 'previous_filename' in f)
        if len(files) < 100:
            return bool(paths) and all(owned(p, machine) for p in paths)
    return False


def category(title):
    if 'BREAKING CHANGE' in title or re.match(r'^\w+(?:\([^)]*\))?!:', title):
        return 'Breaking Changes'
    if re.match(r'^fix(?:\([^)]*\))?:', title, re.I):
        return 'Fixed'
    if re.match(r'^feat(?:\([^)]*\))?:', title, re.I):
        return 'Added'
    return 'Changed'


def entries(tag, base, repo):
    machine, _, _ = parse(tag)
    revision = f'{base}..{tag}' if base else tag
    shas = git('rev-list', '--first-parent', '--reverse', revision).splitlines()
    groups, prs_seen = {}, set()
    for sha in shas:
        parents = git('rev-list', '--parents', '-n', '1', sha).split()
        files = (git('diff', '--name-only', parents[1], sha).splitlines()
                 if len(parents) > 1 else
                 git('diff-tree', '--root', '--no-commit-id', '--name-only', '-r', sha).splitlines())
        selected = sorted(set(p for p in files if owned(p, machine)))
        if not selected:
            continue
        subject = git('show', '-s', '--format=%s', sha)
        pr = pr_for_commit(repo, sha)
        if pr:
            number = pr['number']
            if number in prs_seen:
                continue
            prs_seen.add(number)
            title = pr.get('title', '')
            link = f'https://github.com/{repo}/pull/{number}'
        else:
            title = subject
            link = f'https://github.com/{repo}/commit/{sha}'
        # Commit/PR descriptions are the source of truth, in their original
        # language. File paths decide inclusion only; they are never prose.
        titles = [title]
        if not pr and subject.startswith('Merge '):
            titles = []
            if len(parents) > 2:
                for child in git('rev-list', '--reverse', sha, '--not', parents[1]).splitlines():
                    if child == sha:
                        continue
                    paths = git('diff-tree', '--root', '--no-commit-id', '--name-only', '-r', child).splitlines()
                    if any(owned(path, machine) for path in paths):
                        titles.append(git('show', '-s', '--format=%s', child))
            if not titles:
                titles = [subject]
        for description in titles:
            heading = category(description)
            description = re.sub(r'^\w+(?:\([^)]*\))?!?:\s*', '', description).strip()
            if description:
                groups.setdefault(heading, []).append((description[:400], link))
    return groups


def tag_annotation(tag):
    ref = f'refs/tags/{tag}'
    if git('cat-file', '-t', ref) != 'tag':
        return ''
    message = git('for-each-ref', '--format=%(contents)', ref)
    # Signatures authenticate the tag; they are not release prose.
    return re.split(r'(?m)^-----BEGIN (?:PGP SIGNATURE|SSH SIGNATURE)-----', message)[0].strip()


def approved_changelog(tag):
    machine, _, _ = parse(tag)
    version_text = tag[len(machine) + 1:]
    tree = f'refs/tags/{tag}^{{commit}}'
    def read(path):
        return git('show', f'{tree}:{path}')
    def exists(path):
        if path.startswith('/') or path == '..' or path.startswith('../'):
            raise ValueError('Tagged knowledge sources must be inside the project tree')
        try:
            git('cat-file', '-e', f'{tree}:{path}')
            return True
        except subprocess.CalledProcessError:
            return False
    path = project_knowledge_path(machine, 'changelog', read, exists)
    try:
        document = read(path)
    except subprocess.CalledProcessError:
        raise ValueError(f'Changelog is missing in the tagged tree: {path}') from None
    values = re.split(r'^## Value\s*$', document, flags=re.M)
    if len(values) != 2:
        raise ValueError('Changelog must contain exactly one Value section')
    value = re.split(r'^## (?!#)', values[1], maxsplit=1, flags=re.M)[0]
    headings = list(re.finditer(r'^### ([0-9]+\.[0-9]+\.[0-9]+(?:-(?:rc|dev))?) — ([0-9]{4}-[0-9]{2}-[0-9]{2})[ \t]*$', value, re.M))
    matches = [m for m in headings if m.group(1) == version_text]
    if len(matches) != 1:
        raise ValueError(f'Expected exactly one changelog entry for version {version_text}')
    start = matches[0].end()
    date.fromisoformat(matches[0].group(2))
    next_heading = re.search(r'^### ', value[start:], re.M)
    body = value[start:start + next_heading.start() if next_heading else None].strip()
    if not body:
        raise ValueError('Changelog entry is empty')
    if not re.search(r'^- \S', body, re.M):
        raise ValueError('Changelog entry must contain concise change bullets')
    entry = value[matches[0].start():start].strip() + '\n\n' + body
    if tag_annotation(tag) != entry:
        raise ValueError('Annotated tag does not match the changelog entry')
    return entry


def render_approved(tag, entry, repo, run_url=''):
    machine, version, kind = parse(tag)
    header = f'{machine} {".".join(map(str, version))} — {kind}'
    release_url = f'https://github.com/{repo}/releases/tag/{tag}'
    footer = f'<a href="{html.escape(release_url, quote=True)}">Release</a>'
    if run_url:
        footer += f' · <a href="{html.escape(run_url, quote=True)}">Workflow run</a>'
    prefix = f'<b>{html.escape(header)}</b>\n\n'
    suffix = f'\n\n{footer}'
    def build(text, truncated):
        return prefix + html.escape(text) + ('\n\n… See the full release.' if truncated else '') + suffix
    if len(build(entry, False).encode('utf-16-le')) // 2 <= 3600:
        message = build(entry, False)
    else:
        low, high = 0, len(entry)
        while low < high:
            mid = (low + high + 1) // 2
            if len(build(entry[:mid], True).encode('utf-16-le')) // 2 <= 3600:
                low = mid
            else:
                high = mid - 1
        if not low:
            raise ValueError('Telegram metadata exceeds the length budget')
        message = build(entry[:low].rstrip(), True)
    return entry + '\n', message


def render(tag, base, groups, repo, run_url='', annotation=''):
    machine, version, kind = parse(tag)
    release_url = f'https://github.com/{repo}/releases/tag/{tag}'
    full_url = (f'https://github.com/{repo}/compare/{base}...{tag}' if base
                else f'https://github.com/{repo}/commits/{tag}')
    label = 'Initial release' if base is None else f'Changes since {base}'
    header = f'{machine} {".".join(map(str, version))} — {kind}'
    md = [f'# {header}', '', label, '']
    body = [f'<b>{html.escape(header)}</b>', html.escape(label)]
    if annotation:
        md = [annotation, ''] + md
        # Reserve room for release metadata, changes and links even for long
        # annotations; Markdown retains the complete annotation.
        preview = annotation
        while len(html.escape(preview).encode('utf-16-le')) // 2 > 1200:
            preview = preview[:-1]
        if preview != annotation:
            preview += '…'
        body.insert(0, f'<b>{html.escape(preview)}</b>')
    footer = (f'<a href="{html.escape(release_url, quote=True)}">Release</a> · '
              f'<a href="{html.escape(full_url, quote=True)}">Full changelog</a>')
    if run_url:
        footer += f' · <a href="{html.escape(run_url, quote=True)}">Workflow run</a>'
    omitted = False
    for heading in ('Breaking Changes', 'Added', 'Changed', 'Fixed'):
        items = groups.get(heading, [])
        if not items:
            continue
        md.extend([f'## {heading}', ''])
        section = [f'<b>{heading}</b>']
        for title, link in items:
            md.append(f'- {title} ([details]({link}))')
            line = f'• {html.escape(title)} <a href="{html.escape(link, quote=True)}">↗</a>'
            candidate = '\n\n'.join(body + ['\n'.join(section + [line]), footer])
            # Conservative UTF-16 budget including markup; Telegram counts text
            # after entity parsing, so this leaves room for footer/omission note.
            if len(candidate.encode('utf-16-le')) // 2 <= 3600:
                section.append(line)
            else:
                omitted = True
        if len(section) > 1:
            body.append('\n'.join(section))
        md.append('')
    if not groups:
        text = 'No machine working-file changes in this release range.'
        md.append(text)
        body.append(text)
    if omitted:
        body.append('More changes are available in the full changelog.')
    body.append(footer)
    return '\n'.join(md).rstrip() + '\n', '\n\n'.join(body)


def action_message(message):
    # drone-telegram renders Go templates then unescapes HTML once before send.
    # Protect template braces and preserve the renderer's text/entity escaping.
    message = message.replace('{', '&#123;').replace('}', '&#125;')
    return html.escape(message, quote=False)


def output(path, key, value):
    import secrets
    delimiter = 'NOTES_' + secrets.token_hex(16)
    with open(path, 'a') as stream:
        stream.write(f'{key}<<{delimiter}\n{value}\n{delimiter}\n')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--tag', required=True)
    parser.add_argument('--repository', required=True)
    parser.add_argument('--directory', default='dist')
    args = parser.parse_args()
    _, _, kind = parse(args.tag)
    entry = approved_changelog(args.tag)
    run_url = os.environ.get('GITHUB_SERVER_URL', 'https://github.com') + '/' + args.repository + '/actions/runs/' + os.environ.get('GITHUB_RUN_ID', '')
    notes, message = render_approved(args.tag, entry, args.repository,
                                     run_url if os.environ.get('GITHUB_RUN_ID') else '')
    directory = Path(args.directory)
    directory.mkdir(parents=True, exist_ok=True)
    (directory / 'release-notes.md').write_text(notes)
    (directory / 'telegram-message.html').write_text(message)
    if os.environ.get('GITHUB_OUTPUT'):
        output(os.environ['GITHUB_OUTPUT'], 'eligible', str(kind in ('stable', 'rc')).lower())
        output(os.environ['GITHUB_OUTPUT'], 'message', action_message(message))


if __name__ == '__main__':
    try:
        main()
    except Exception as error:
        print(f'::error::Release notes could not be generated: {error}', file=sys.stderr)
        sys.exit(1)
