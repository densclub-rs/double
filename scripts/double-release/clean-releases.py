#!/usr/bin/env python3
"""Keep the most recently published GitHub release of each Double component."""
import argparse
from datetime import datetime
import json
import re
import subprocess
import sys

COMPONENTS = ('double-installer', 'double-agent', 'machine-of-knowledge',
              'machine-of-ideas', 'machine-of-goals')
TAG = re.compile(r'^(double-installer|double-agent|machine-of-knowledge|machine-of-ideas|machine-of-goals)-\d+\.\d+\.\d+(?:-(?:rc|dev))?$')


def inventory(repo):
    result = subprocess.run(
        ['gh', 'api', '--paginate', '--slurp', f'repos/{repo}/releases?per_page=100'],
        check=True, capture_output=True, text=True,
    )
    pages = json.loads(result.stdout)
    if not isinstance(pages, list) or any(not isinstance(page, list) for page in pages):
        raise ValueError('Unexpected GitHub release inventory')
    groups = {name: [] for name in COMPONENTS}
    for page in pages:
        for release in page:
            tag = release.get('tag_name', '')
            match = TAG.fullmatch(tag)
            if not match or release.get('draft'):
                continue
            published = release.get('published_at')
            if not isinstance(published, str):
                raise ValueError(f'Missing publication date for {tag}')
            try:
                timestamp = datetime.fromisoformat(published.replace('Z', '+00:00'))
            except ValueError as error:
                raise ValueError(f'Invalid publication date for {tag}') from error
            if timestamp.tzinfo is None:
                raise ValueError(f'Publication date has no timezone: {tag}')
            groups[match.group(1)].append((timestamp, tag))
    return groups


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--repo', default='densclub-rs/double', help='GitHub repository OWNER/REPO')
    parser.add_argument('--apply', action='store_true', help='Delete listed releases; Git tags remain')
    args = parser.parse_args()
    if not re.fullmatch(r'[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+', args.repo):
        parser.error('--repo must have the form OWNER/REPO')
    groups = inventory(args.repo)
    remove = []
    for component, entries in groups.items():
        entries.sort(reverse=True)
        if not entries:
            print(f'{component}: no published releases')
            continue
        print(f'{component}: keep {entries[0][1]}')
        for _, tag in entries[1:]:
            print(f'  delete {tag}')
            remove.append(tag)
    if not args.apply:
        print(f'Preview only: {len(remove)} releases selected. Use --apply to delete them.')
        return
    for tag in remove:
        print(f'Deleting {tag}', flush=True)
        subprocess.run(['gh', 'release', 'delete', tag, '--repo', args.repo, '--yes'], check=True)
    print(f'Deleted {len(remove)} releases; Git tags were retained.')


if __name__ == '__main__':
    try:
        main()
    except (subprocess.CalledProcessError, OSError, ValueError, json.JSONDecodeError) as error:
        print(f'Error: {error}', file=sys.stderr)
        sys.exit(1)
