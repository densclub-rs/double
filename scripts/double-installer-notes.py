#!/usr/bin/env python3
"""Render installer release notes and Telegram text from an annotated Git tag."""
import argparse
import html
import os
from pathlib import Path
import re
import secrets
import subprocess


def git(*args):
    return subprocess.check_output(['git', *args], text=True).strip()


def output(key, value):
    if os.environ.get('GITHUB_OUTPUT'):
        delimiter = 'INSTALLER_' + secrets.token_hex(16)
        with open(os.environ['GITHUB_OUTPUT'], 'a') as stream:
            stream.write(f'{key}<<{delimiter}\n{value}\n{delimiter}\n')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--tag', required=True)
    parser.add_argument('--repository', required=True)
    parser.add_argument('--directory', default='dist')
    args = parser.parse_args()
    if not re.fullmatch(r'double-installer-\d+\.\d+\.\d+(?:-(?:rc|dev))?', args.tag):
        raise ValueError('Invalid installer tag')
    if not re.fullmatch(r'[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+', args.repository):
        raise ValueError('Invalid repository')
    ref = 'refs/tags/' + args.tag
    if git('cat-file', '-t', ref) != 'tag':
        raise ValueError('An annotated tag is required')
    annotation = git('for-each-ref', '--format=%(contents)', ref)
    annotation = re.split(r'(?m)^-----BEGIN (?:PGP SIGNATURE|SSH SIGNATURE)-----', annotation)[0].strip()
    if not annotation or any(c.isalpha() and not ('a' <= c.lower() <= 'z') for c in annotation):
        raise ValueError('A nonempty English annotation is required')
    commit = git('rev-parse', ref + '^{commit}')
    root = 'https://github.com/' + args.repository
    release = root + '/releases/tag/' + args.tag
    instructions = root + '/blob/' + commit + '/knowledge/double-installer/double-installer.md'
    notes = annotation + f'\n\nSource commit: {commit}\n\n[Release]({release}) · [Installation and usage]({instructions})\n'
    message = (html.escape(annotation) + '\n\n' +
               f'<a href="{release}">Release</a> · <a href="{instructions}">Installation and usage</a>')
    # Reject oversized announcements rather than silently change the approved text.
    if len(message.encode('utf-16-le')) // 2 > 3600:
        raise ValueError('Announcement exceeds the safe Telegram length budget')
    directory = Path(args.directory)
    directory.mkdir(parents=True, exist_ok=True)
    (directory / 'release-notes.md').write_text(notes)
    (directory / 'telegram-message.html').write_text(message)
    output('eligible', str(not args.tag.endswith('-dev')).lower())
    # The Telegram action unescapes HTML once after Go template expansion.
    protected = message.replace('{', '&#123;').replace('}', '&#125;')
    output('message', html.escape(protected, quote=False))


if __name__ == '__main__':
    main()
