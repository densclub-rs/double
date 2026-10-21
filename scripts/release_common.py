"""Shared machine release rules; no network or filesystem side effects."""
import re

MACHINES = ('machine-of-ideas', 'machine-of-goals', 'machine-of-knowledge', 'double-agent')
TAG = re.compile(r'^([a-z0-9][a-z0-9-]*)-([0-9]+)\.([0-9]+)\.([0-9]+)(?:-(rc|dev))?$')
STATUSES = {'stable': 'stable', 'rc': 'release-candidate', 'dev': 'draft'}


def parse(tag):
    match = TAG.fullmatch(tag)
    if not match:
        raise ValueError('Invalid release tag')
    return match[1], tuple(map(int, match.group(2, 3, 4))), match[5] or 'stable'


def owned(path, machine):
    return path.startswith('.double/') and f'/{machine}/' in path and path.endswith('.md')
