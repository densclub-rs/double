#!/usr/bin/env python3
"""Package local or tagged Double machine files; publish only in GitHub Actions."""
import hashlib
import io
import os
from pathlib import Path
import re
import shutil
import subprocess
import sys
import tarfile

from release_common import MACHINES, STATUSES, owned, parse, version_knowledge_path


def warning(message):
    print(f'::warning::{message}', file=sys.stderr)


def action_output(key, value):
    if os.environ.get('GITHUB_OUTPUT'):
        with open(os.environ['GITHUB_OUTPUT'], 'a', encoding='utf-8') as stream:
            stream.write(f'{key}={value}\n')


def git(*args):
    return subprocess.check_output(['git', *args], stderr=subprocess.PIPE)


def frontmatter_value(text, key):
    lines = text.splitlines()
    if not lines or lines[0] != '---':
        return ''
    for line in lines[1:]:
        if line == '---':
            break
        match = re.match(rf'^\s*{re.escape(key)}\s*:\s*(.*)', line)
        if match:
            return match[1].strip("'\"")
    return ''


def knowledge_value(text):
    match = re.search(r'^## Value\s*$\n(?:\s*\n)*([^\n]+)', text, re.M)
    return match[1].strip().strip('`').rstrip() if match else ''


def with_export_version(text, version):
    if not text:
        return ''
    lines = text.splitlines()
    if lines and lines[0] == '---':
        for index in range(1, len(lines)):
            if lines[index] == '---':
                fields = [line for line in lines[1:index] if not re.match(r'^\s*version\s*:', line)]
                lines = ['---', *fields, f'version: {version}', *lines[index:]]
                break
    return '\n'.join(lines) + '\n'


def usage():
    print('Usage: python3 scripts/double-release/double-release.py list-machines\n'
          '       python3 scripts/double-release/double-release.py package --tag <machine>-X.Y.Z[-dev|-rc]\n'
          '       python3 scripts/double-release/double-release.py package --machine <machine>\n'
          '       python3 scripts/double-release/double-release.py publish --tag <machine>-X.Y.Z[-dev|-rc]')


def package(tag, machine):
    """Return archive path and release class, or None for warning/no-match."""
    kind = 'local'
    commit = None
    if tag:
        try:
            machine, _, kind = parse(tag)
        except ValueError:
            warning(f'Invalid release tag: {tag}; no package was created.')
            return None
        # Keep the exact version spelling, including numeric leading zeroes.
        version = re.fullmatch(r'.*-([0-9]+\.[0-9]+\.[0-9]+)(?:-(?:dev|rc))?', tag)[1]
        try:
            commit = git('rev-parse', '--verify', '--end-of-options', f'refs/tags/{tag}^{{commit}}').decode().strip()
        except subprocess.CalledProcessError:
            warning(f'Git tag does not exist: {tag}; no package was created.')
            return None

    def read(path):
        return (git('show', f'{commit}:{path}').decode('utf-8') if commit
                else Path(path).read_text(encoding='utf-8'))

    def exists(path):
        if not commit:
            return Path(path).exists()
        if Path(path).is_absolute() or path == '..' or path.startswith('../'):
            raise ValueError('Tagged version sources must be inside the project tree.')
        try:
            git('cat-file', '-e', f'{commit}:{path}')
            return True
        except subprocess.SubprocessError:
            return False

    knowledge_path = version_knowledge_path(machine, read, exists)
    try:
        value = knowledge_value(read(knowledge_path))
    except (OSError, subprocess.SubprocessError):
        raise ValueError(f'Machine version knowledge is missing: {knowledge_path}.') from None
    if not tag:
        if not re.fullmatch(r'[0-9]+\.[0-9]+\.[0-9]+', value):
            raise ValueError(f"Invalid local machine version: '{value or 'missing'}'.")
        version = value
    elif value != version:
        raise ValueError(f"Machine version mismatch: tag is '{version}', knowledge value is '{value or 'missing'}'.")
    candidates = (git('ls-tree', '-rz', '--name-only', commit, '--', '.double').decode().split('\0') if commit
                  else (p.as_posix() for p in Path('.double').rglob('*.md') if p.is_file()))
    selected = []
    for path in sorted(p for p in candidates if owned(p, machine)):
        try:
            text = read(path)
        except (OSError, subprocess.SubprocessError):
            warning(f'Could not read {path}; candidate was excluded.')
            continue
        status = frontmatter_value(text, 'status')
        if tag and status != STATUSES[kind]:
            warning(f"Excluded {path}: status '{status or 'missing'}' does not match '{STATUSES[kind]}'.")
            continue
        selected.append((path, with_export_version(text, version).encode('utf-8')))
    if not selected:
        warning(f"No {STATUSES.get(kind, 'local')} files matched machine '{machine}'; no package or GitHub Release was created.")
        return None
    directory = Path('dist')
    directory.mkdir(exist_ok=True)
    archive = directory / f'double-{tag or f"{machine}-{version}-local"}.tar.gz'
    with tarfile.open(archive, 'w:gz') as stream:
        for path, content in selected:
            info = tarfile.TarInfo(path)
            info.size = len(content)
            info.mode = 0o644
            stream.addfile(info, io.BytesIO(content))
    digest = hashlib.sha256(archive.read_bytes()).hexdigest()
    (directory / 'SHA256SUMS.txt').write_text(f'{digest}  {archive.name}\n', encoding='utf-8')
    print(f'Created package: {archive}\nCreated checksums: dist/SHA256SUMS.txt')
    return archive, kind


def publish(tag, archive, kind):
    if os.environ.get('GITHUB_ACTIONS') != 'true':
        warning('Publish is restricted to GitHub Actions; package was created locally but not published.')
        return
    if not shutil.which('gh'):
        warning('GitHub CLI is unavailable; package was not published.')
        return

    def gh(*args):
        return subprocess.run(['gh', 'release', *map(str, args)], capture_output=True, text=True)

    notes = os.environ.get('RELEASE_NOTES_FILE', '')
    if not notes or not Path(notes).is_file() or not Path(notes).read_text().strip():
        warning('Approved release notes are unavailable; publication stopped.')
        return
    if gh('view', tag).returncode == 0:
        if gh('upload', tag, archive, 'dist/SHA256SUMS.txt', '--clobber').returncode:
            warning(f'GitHub Release upload failed for {tag}.')
            return
        if notes and gh('edit', tag, '--notes-file', notes).returncode:
            warning(f'Release assets published but generated notes could not be updated for {tag}.')
    else:
        flags = ['--prerelease'] if kind in ('dev', 'rc') else []
        if notes:
            flags += ['--notes-file', notes]
        if gh('create', tag, archive, 'dist/SHA256SUMS.txt', '--title', f'double-{tag}', *flags).returncode:
            warning(f'GitHub Release creation failed for {tag}.')
            return
    result = gh('view', tag, '--json', 'url,isDraft', '--jq', 'select(.isDraft == false) | .url')
    if result.returncode:
        warning('Publication completed but release URL could not be verified; announcement skipped.')
        return
    url = result.stdout.strip()
    if not url.startswith('https://') or '\n' in url or '\r' in url:
        warning('Release URL is unavailable; announcement skipped.')
        return
    action_output('published', 'true')
    action_output('release_url', url)


def main(argv=None):
    argv = list(sys.argv[1:] if argv is None else argv)
    action_output('published', 'false')
    # Installer releases use their own entry point and workflow.
    if len(argv) >= 3 and argv[1] == '--tag' and argv[2].startswith('double-installer-'):
        warning('Use the independent installer release workflow for installer tags.')
        return 1
    print('Implementation of subplan: github-actions-maintenance')
    operation = argv.pop(0) if argv else ''
    options = {'--tag': '', '--machine': ''}
    while argv:
        key = argv.pop(0)
        if key in ('--help', '-h'):
            usage()
            return 0
        if key not in options:
            warning(f'Unknown argument: {key}; no package was created.')
            return 0
        if not argv:
            warning(f'Missing value for {key}; no package was created.')
            return 0
        options[key] = argv.pop(0)
    tag, machine = options.values()
    if operation == 'list-machines':
        if not Path('.double').is_dir():
            warning('Working catalog .double was not found in the current directory.')
        else:
            names = {p.name for p in Path('.double').glob('*/*') if p.is_dir()}
            for name in sorted(names):
                print(name)
        return 0
    if operation not in ('package', 'publish'):
        usage()
        return 0
    if not tag:
        if operation == 'publish':
            warning('A release tag is required for publish; no package was created.')
            return 0
        if machine not in MACHINES:
            warning('Select --machine ' + ', '.join(MACHINES) + '; no package was created.')
            return 0
    elif machine:
        warning('Use either --tag or --machine; no package was created.')
        return 0
    try:
        result = package(tag, machine)
        if result and operation == 'publish':
            publish(tag, *result)
    except ValueError as exc:
        print(f'::error::{exc}', file=sys.stderr)
        return 1
    return 0


if __name__ == '__main__':
    sys.exit(main())
