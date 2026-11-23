#!/usr/bin/env python3
"""Package a stable style library; publish only from an authorized main-branch CI job."""
import argparse
import gzip
import hashlib
import io
import json
import os
from pathlib import Path
import subprocess
import tarfile

from style_library import MANIFEST, library_assets


def package(source, output):
    source, output = Path(source), Path(output)
    def regular(path):
        return not source.is_symlink() and not (source / 'styles').is_symlink() and (source / path).is_file() and not (source / path).is_symlink()
    assets = library_assets(lambda p: (source / p).read_bytes().decode('utf-8'),
                            lambda p: (source / p).exists(), regular)
    if not assets:
        raise ValueError('Style release requires styles/manifest.json.')
    manifest = json.loads(assets[0][1])
    output.mkdir(parents=True, exist_ok=True)
    archive = output / f'double-styles-{manifest["version"]}.tar.gz'
    # Identical contents reproduce identical archives regardless of build time.
    with archive.open('wb') as target, gzip.GzipFile(fileobj=target, mode='wb', filename='', mtime=0) as zipped:
        with tarfile.open(fileobj=zipped, mode='w') as stream:
            for path, data, mode in assets:
                info = tarfile.TarInfo(path)
                info.size, info.mode, info.mtime = len(data), mode, 0
                stream.addfile(info, io.BytesIO(data))
    digest = hashlib.sha256(archive.read_bytes()).hexdigest()
    checksum = output / 'SHA256SUMS.txt'
    checksum.write_text(f'{digest}  {archive.name}\n', encoding='utf-8')
    return manifest['version'], archive, checksum


def publish(version, archive, checksum):
    if os.environ.get('GITHUB_ACTIONS') != 'true' or os.environ.get('GITHUB_REF') != 'refs/heads/main':
        raise ValueError('Style publication requires the main-branch GitHub Actions job.')
    repository, commit = os.environ['GITHUB_REPOSITORY'], os.environ['GITHUB_SHA']
    tag = 'styles-' + version
    def gh(*args, check=True):
        return subprocess.run(['gh', *map(str, args)], text=True, capture_output=True, check=check)
    existing = gh('api', f'repos/{repository}/releases/tags/{tag}', check=False)
    if existing.returncode:
        if 'HTTP 404' not in existing.stderr:
            raise ValueError(f'Cannot inspect style release: {existing.stderr.strip()}')
        # A pre-existing tag without a release is not adopted or moved.
        tags = gh('api', f'repos/{repository}/git/ref/tags/{tag}', check=False)
        if tags.returncode == 0 or 'HTTP 404' not in tags.stderr:
            raise ValueError('Style tag exists without a release, or tag lookup failed; inspect before retrying.')
        gh('release', 'create', tag, archive, checksum, '--repo', repository,
           '--target', commit, '--title', f'Double Styles {version}',
           '--notes', f'Official Double style library {version}.', '--latest=false')
        return
    release = json.loads(existing.stdout)
    if release.get('draft') or release.get('prerelease'):
        raise ValueError('Existing style release is not stable and public.')
    # Never overwrite a released version, including on retries or concurrent jobs.
    for path in (archive, checksum):
        assets = [a for a in release['assets'] if a['name'] == path.name]
        if len(assets) != 1:
            raise ValueError('Existing style release has missing or ambiguous assets; manual recovery required.')
        # Binary asset bodies must not be decoded by a text subprocess.
        downloaded = subprocess.run(['gh', 'api', f'repos/{repository}/releases/assets/{assets[0]["id"]}',
                                     '-H', 'Accept: application/octet-stream'], capture_output=True, check=True)
        if downloaded.stdout != path.read_bytes():
            raise ValueError('Existing style version has different content; increment styles/manifest.json version.')
    print(f'Style release {tag} already contains identical assets; unchanged.')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--source', default='.')
    parser.add_argument('--output', default='dist/styles')
    parser.add_argument('--publish', action='store_true')
    args = parser.parse_args()
    try:
        version, archive, checksum = package(args.source, args.output)
        print(f'Created {archive}')
        if args.publish:
            publish(version, archive, checksum)
    except (ValueError, OSError, KeyError, subprocess.CalledProcessError) as exc:
        parser.exit(1, f'Error: {exc}\n')


if __name__ == '__main__':
    main()
