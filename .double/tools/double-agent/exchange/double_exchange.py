"""Build and verify ZIP containers for prepared Double exchange packages."""
import argparse
import hashlib
import json
import os
import re
import shlex
import shutil
import stat
import subprocess
import sys
import tempfile
import uuid
import zipfile
from pathlib import Path, PurePosixPath

import jsonschema
import yaml

from validate_manifest import validate
from goal_registry import search_installed

LIMIT = 100 * 1024 * 1024


def safe_name(name):
    p = PurePosixPath(name)
    if (not name or name.startswith('/') or '\\' in name or '\n' in name or '\r' in name
            or any(x in ('', '.', '..') for x in name.split('/')) or ':' in p.parts[0]):
        raise ValueError(f'Unsafe archive path: {name!r}')
    return name


def digest(data):
    return hashlib.sha256(data).hexdigest()


def build(source, output):
    source = Path(source).resolve(strict=True)
    output = Path(output).absolute()
    if output.exists() or output.resolve().is_relative_to(source):
        raise ValueError('Output must be a new file outside the source directory')
    validate(source)
    entries = {}
    modes = {}
    for path in sorted(source.rglob('*')):
        if path.is_symlink():
            raise ValueError(f'Symlink in package: {path}')
        if path.is_dir():
            continue
        if not path.is_file():
            raise ValueError(f'Unsupported file type: {path}')
        name = safe_name(path.relative_to(source).as_posix())
        if name == 'SHA256SUMS':
            raise ValueError('Source must not contain SHA256SUMS; it is generated during export')
        entries[name] = path.read_bytes()
        modes[name] = 0o755 if path.stat().st_mode & 0o111 else 0o644
        if sum(map(len, entries.values())) > LIMIT:
            raise ValueError('Package exceeds size limit')
    checksums = ''.join(f'{digest(data)}  {name}\n' for name, data in entries.items()).encode()
    entries['SHA256SUMS'] = checksums
    modes['SHA256SUMS'] = 0o644
    output.parent.mkdir(parents=True, exist_ok=True)
    created = False
    try:
        with output.open('xb') as f:
            created = True
            with zipfile.ZipFile(f, 'w', zipfile.ZIP_DEFLATED) as archive:
                for name, data in entries.items():
                    info = zipfile.ZipInfo(name)
                    info.create_system = 3
                    info.external_attr = (stat.S_IFREG | modes[name]) << 16
                    info.compress_type = zipfile.ZIP_DEFLATED
                    archive.writestr(info, data)
        verify(output)
    except BaseException:
        if created:
            output.unlink(missing_ok=True)
        raise


def verify(archive_path):
    with zipfile.ZipFile(archive_path) as archive:
        entries = {}
        size = 0
        for item in archive.infolist():
            name = safe_name(item.filename)
            if item.is_dir() or name in entries or stat.S_ISLNK(item.external_attr >> 16):
                raise ValueError(f'Unsupported or duplicate archive entry: {name}')
            size += item.file_size
            if size > LIMIT:
                raise ValueError('Package exceeds size limit')
            entries[name] = archive.read(item)
    if 'SHA256SUMS' not in entries:
        raise ValueError('Missing SHA256SUMS')
    lines = entries.pop('SHA256SUMS').decode('utf-8').splitlines()
    expected = {}
    for line in lines:
        match = re.fullmatch(r'([0-9a-f]{64})  (.+)', line)
        if not match:
            raise ValueError('Malformed SHA256SUMS')
        name = safe_name(match.group(2))
        if name == 'SHA256SUMS' or name in expected:
            raise ValueError('Duplicate or recursive checksum entry')
        expected[name] = match.group(1)
    if set(expected) != set(entries):
        raise ValueError('Checksum inventory does not match archive')
    for name, data in entries.items():
        if digest(data) != expected[name]:
            raise ValueError(f'Checksum mismatch: {name}')
    with tempfile.TemporaryDirectory(prefix='double-verify-') as directory:
        root = Path(directory)
        for name, data in entries.items():
            target = root / name
            target.parent.mkdir(parents=True, exist_ok=True)
            target.write_bytes(data)
        return validate(root)


def explain(archive_path):
    manifest = verify(archive_path)
    package = manifest['package']
    print(f'{package["title"]} ({package["type"]}, {package["version"]})')
    print(package['summary'])
    if package.get('public-url'):
        print(f'Public URL: {package["public-url"]}')
    for item in manifest['content'].get('sharing-realizations', []):
        print(f'\nRealization: {item["id"]} ({item["type"]})')
        print(f'  Plan: {item["plan-id"]}; path: {item["path"]}')
        if item.get('documentation'):
            print(f'  Documentation: {item["documentation"]}')
        for req in item.get('requires', []):
            print(f'  Requires: {req["capability"]} {req["version"]}')
        if item['type'] == 'automatic':
            command = [sys.executable, str(Path(__file__).with_name('double-exchange').resolve()), 'package', 'check', str(archive_path), '--realization', item['id']]
            print('  Check current requirements: ' + shlex.join(command))
    print('\nInstallation: select an automatic realization and use install --dry-run to inspect paths')


def check(archive_path, realization_id):
    manifest = verify(archive_path)
    matches = [item for item in manifest['content'].get('sharing-realizations', []) if item['id'] == realization_id]
    if not matches or matches[0]['type'] != 'automatic':
        raise ValueError('Automatic realization not found')
    requirements = matches[0].get('requires', [])
    if not requirements:
        print('No requirements declared')
        return True
    all_met = True
    for req in requirements:
        args = req['check']['command']
        print(f'Check {req["capability"]}: {shlex.join(args)}', flush=True)
        status, detail = 'unknown', ''
        try:
            result = subprocess.run(args, capture_output=True, text=True, errors='replace', timeout=10, check=False)
            if result.returncode:
                detail = f'exit code {result.returncode}'
            else:
                match = re.search(req['check']['version-pattern'], result.stdout + '\n' + result.stderr)
                found = match.group(1) if match else ''
                if re.fullmatch(r'[0-9]+(?:\.[0-9]+)*', found):
                    actual = tuple(map(int, found.split('.')))
                    minimum = tuple(map(int, req['version'][2:].split('.')))
                    length = max(len(actual), len(minimum))
                    status = 'met' if actual + (0,) * (length - len(actual)) >= minimum + (0,) * (length - len(minimum)) else 'unmet'
                    detail = f'version {found}'
                else:
                    detail = 'version not recognized'
        except FileNotFoundError:
            status, detail = 'unmet', 'executable not found'
        except (OSError, subprocess.TimeoutExpired) as exc:
            detail = str(exc)
        print(f'  {status}: {detail}')
        all_met &= status == 'met'
    return all_met


def install(archive_path, realization_id, state_root, dry_run=False):
    state = Path(state_root).expanduser()
    if not state.is_absolute():
        raise ValueError('State root must be absolute')
    manifest = verify(archive_path)
    if manifest['package']['type'] != 'goal':
        raise ValueError('Only goal installation is supported')
    matches = [x for x in manifest['content'].get('sharing-realizations', []) if x['id'] == realization_id]
    if len(matches) != 1 or matches[0]['type'] != 'automatic':
        raise ValueError('Automatic realization not found')
    goal_id = manifest['content']['goal']['id']
    goal_root = state / 'goals'
    target = goal_root / 'installed' / goal_id
    registry = goal_root / 'registry.json'
    print(f'Package: {manifest["package"]["id"]} {manifest["package"]["version"]}')
    print(f'Extract to: {target}')
    print(f'Cache verified archive under: {goal_root / "packages"}')
    print(f'Update registry: {registry}')
    print(f'Selected realization: {realization_id}')
    if dry_run:
        print('Dry run: no files changed and no requirements executed')
        return
    for path in (state, goal_root, goal_root / 'installed', registry, target):
        if path.is_symlink():
            raise ValueError(f'Symlink refused: {path}')
    goal_root.mkdir(parents=True, exist_ok=True)
    lock = goal_root / '.install-lock'
    try:
        lock.mkdir()
    except FileExistsError as exc:
        raise ValueError('Another goal installation is in progress') from exc
    backup = None
    placed = False
    try:
        records = json.loads(registry.read_text()) if registry.exists() else {'schema-version': 1, 'installations': []}
        if not isinstance(records, dict) or records.get('schema-version') != 1 or not isinstance(records.get('installations'), list):
            raise ValueError('Invalid goal registry')
        old = [r for r in records['installations'] if r.get('goal-id') == goal_id]
        if len(old) > 1 or (target.exists() and not old) or (old and not target.is_dir()):
            raise ValueError('Installed files and registry are inconsistent')
        if old and old[0].get('package-id') != manifest['package']['id']:
            raise ValueError('Existing goal belongs to another package')
        with tempfile.TemporaryDirectory(prefix='.install-', dir=goal_root) as temp:
            temp = Path(temp)
            snapshot = temp / 'package.zip'
            shutil.copyfile(archive_path, snapshot)
            if verify(snapshot) != manifest:
                raise ValueError('Package changed during installation')
            if not check(snapshot, realization_id):
                raise ValueError('Requirements are unmet or unknown')
            cache = goal_root / 'packages'
            if cache.is_symlink():
                raise ValueError('Package cache is a symlink')
            cache.mkdir(exist_ok=True)
            cached = cache / (digest(snapshot.read_bytes()) + '.double.zip')
            if cached.is_symlink():
                raise ValueError('Cached package is a symlink')
            if cached.exists():
                if digest(cached.read_bytes()) != cached.name.removesuffix('.double.zip'):
                    raise ValueError('Cached package does not match its digest')
            else:
                shutil.copyfile(snapshot, temp / 'cached.zip')
                os.replace(temp / 'cached.zip', cached)
            staged = temp / 'content'
            staged.mkdir()
            with zipfile.ZipFile(snapshot) as archive:
                for entry in archive.infolist():
                    name = safe_name(entry.filename)
                    dest = staged / name
                    dest.parent.mkdir(parents=True, exist_ok=True)
                    dest.write_bytes(archive.read(entry))
                    dest.chmod(0o755 if (entry.external_attr >> 16) & 0o111 else 0o644)
            validate(staged)
            target.parent.mkdir(parents=True, exist_ok=True)
            if target.exists():
                backup = goal_root / ('.backup-' + uuid.uuid4().hex)
                os.replace(target, backup)
            try:
                os.replace(staged, target)
                placed = True
                records['installations'] = [r for r in records['installations'] if r.get('goal-id') != goal_id]
                records['installations'].append({'goal-id': goal_id, 'package-id': manifest['package']['id'], 'version': manifest['package']['version'], 'path': str(target), 'archive': str(cached), 'realization-id': realization_id, 'provides': manifest['content'].get('provides', [])})
                updated = temp / 'registry.json'
                updated.write_text(json.dumps(records, indent=2) + '\n')
                os.replace(updated, registry)
            except BaseException:
                if placed:
                    shutil.rmtree(target)
                if backup is not None and backup.exists():
                    os.replace(backup, target)
                raise
            if backup is not None:
                shutil.rmtree(backup)
    finally:
        lock.rmdir()
    print(f'Installed: {goal_id} ({manifest["package"]["version"]})')




def main():
    parser = argparse.ArgumentParser(description=__doc__)
    groups = parser.add_subparsers(dest='group', required=True)
    package_cmd = groups.add_parser('package')
    commands = package_cmd.add_subparsers(dest='command', required=True)
    create = commands.add_parser('build')
    create.add_argument('source')
    create.add_argument('output')
    inspect = commands.add_parser('verify')
    inspect.add_argument('archive')
    explain_cmd = commands.add_parser('explain')
    explain_cmd.add_argument('archive')
    check_cmd = commands.add_parser('check')
    check_cmd.add_argument('archive')
    check_cmd.add_argument('--realization', required=True)
    goal_cmd = groups.add_parser('goal')
    goal_commands = goal_cmd.add_subparsers(dest='command', required=True)
    install_cmd = goal_commands.add_parser('install')
    install_cmd.add_argument('archive')
    install_cmd.add_argument('--realization', required=True)
    install_cmd.add_argument('--state-root', default=os.environ.get('DOUBLE_STATE_DIR', str(Path.home() / '.local/state/double')))
    install_cmd.add_argument('--dry-run', action='store_true')
    search_cmd = goal_commands.add_parser('search')
    search_cmd.add_argument('--capability', required=True)
    search_cmd.add_argument('--state-root', default=os.environ.get('DOUBLE_STATE_DIR', str(Path.home() / '.local/state/double')))
    args = parser.parse_args()
    try:
        if args.command == 'build':
            build(args.source, args.output)
            print(f'Built and verified: {args.output}')
        elif args.command == 'verify':
            manifest = verify(args.archive)
            print(f'Verified: {manifest["package"]["id"]}')
        elif args.command == 'explain':
            explain(args.archive)
        elif args.command == 'check':
            if not check(args.archive, args.realization):
                return 1
        elif args.command == 'install':
            install(args.archive, args.realization, args.state_root, args.dry_run)
        else:
            results = search_installed(args.state_root, args.capability)
            print(json.dumps({'capability': args.capability, 'matches': results}, ensure_ascii=False, indent=2))
    except (OSError, ValueError, zipfile.BadZipFile, UnicodeError, yaml.YAMLError, jsonschema.ValidationError) as exc:
        parser.exit(1, f'Package error: {exc}\n')


if __name__ == '__main__':
    raise SystemExit(main())
