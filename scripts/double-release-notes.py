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

from release_common import owned, parse


def git(*args):
    return subprocess.check_output(['git', *args], text=True).strip()


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
        if kind == 'rc' and ok == 'rc' and ov == version:
            rc.append((ov, other))
    candidates = rc or stable
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


def english_title(title):
    return bool(title) and all(not c.isalpha() or 'a' <= c.lower() <= 'z' for c in title)


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
            scoped = pr_is_scoped(repo, number, machine)
            link = f'https://github.com/{repo}/pull/{number}'
        else:
            title, scoped = subject, all(owned(p, machine) for p in files)
            link = f'https://github.com/{repo}/commit/{sha}'
        # Mixed-scope/non-English titles cannot reliably describe scoped changes.
        # Use English path-based wording rather than claim automatic translation.
        if not scoped or not english_title(title):
            title = 'Updated machine working files: ' + ', '.join(selected[:3])
            if len(selected) > 3:
                title += f' (+{len(selected) - 3} more)'
        else:
            title = re.sub(r'^\w+(?:\([^)]*\))?!?:\s*', '', title).strip()
        groups.setdefault(category(pr.get('title', subject) if pr else subject), []).append((title[:400], link))
    return groups


def render(tag, base, groups, repo, run_url=''):
    machine, version, kind = parse(tag)
    release_url = f'https://github.com/{repo}/releases/tag/{tag}'
    full_url = (f'https://github.com/{repo}/compare/{base}...{tag}' if base
                else f'https://github.com/{repo}/commits/{tag}')
    label = 'Initial release' if base is None else f'Changes since {base}'
    header = f'{machine} {".".join(map(str, version))} — {kind}'
    md = [f'# {header}', '', label, '']
    body = [f'<b>{html.escape(header)}</b>', html.escape(label)]
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
    base = baseline(args.tag)
    groups = entries(args.tag, base, args.repository)
    run_url = os.environ.get('GITHUB_SERVER_URL', 'https://github.com') + '/' + args.repository + '/actions/runs/' + os.environ.get('GITHUB_RUN_ID', '')
    notes, message = render(args.tag, base, groups, args.repository,
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
    except Exception:
        print('::warning::Release notes could not be generated; notification skipped.', file=sys.stderr)
        sys.exit(1)
