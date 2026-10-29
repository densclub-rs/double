"""Shared machine release rules; no network or filesystem side effects."""
import re
import posixpath
from urllib.parse import unquote, urlsplit

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


def field(text, name):
    """Read an existing scalar frontmatter field without a new config schema."""
    parts = text.split('---', 2)
    if len(parts) != 3 or parts[0].strip():
        return ''
    match = re.search(rf'^{re.escape(name)}:[ \t]*(.*)$', parts[1], re.M)
    return match[1].strip().strip('\"\'') if match else ''


def version_knowledge_path(machine, read, exists):
    return project_knowledge_path(machine, 'version', read, exists)


def project_knowledge_path(machine, kind, read, exists):
    """Resolve indexed project version knowledge, then the historical default.

    Callbacks read one consistent source tree (working files or tagged Git).
    Trust/TTL review of project context remains part of the agent workflow.
    """
    default = f'knowledge/{machine}-{kind}/{machine}-{kind}.md'
    directory = '.double-rules'
    index = f'{directory}/double-rules.md'
    if not exists(directory):
        return default
    if not exists(index):
        raise ValueError(f'Project knowledge index is missing: {index}')
    scopes = {'Common Rules', 'double-agent', machine}
    active, selected = False, []
    clean = re.sub(r'(?ms)^```.*?^```[^\n]*', '', read(index))
    for line in clean.splitlines():
        heading = re.match(r'^#{1,2}\s+(.+?)\s*#*$', line)
        if heading:
            active = heading[1] in scopes
        elif active:
            selected.append(line)

    def links(document, origin):
        document = re.sub(r'(?ms)^```.*?^```[^\n]*', '', document)
        for match in re.finditer(r'(?<!!)\[([^\]]*)\]\(\s*(<[^>]+>|[^\s)]+)(?:\s+"[^"]*")?\s*\)', document):
            target = match[2].strip('<>')
            url = urlsplit(target)
            if url.scheme or url.netloc or not url.path:
                continue
            path = posixpath.normpath(posixpath.join(posixpath.dirname(origin), unquote(url.path)))
            if path.endswith('.md'):
                yield match[1], path

    wanted = f'{machine}-{kind}'
    candidates = set()
    seen = set()

    def inspect(label, path):
        if not exists(path):
            raise ValueError(f'Broken project knowledge link: {path}')
        document = read(path)
        identity = field(document, 'id')
        intended = wanted in label or posixpath.basename(path) == f'{wanted}.md'
        if intended and identity != wanted:
            raise ValueError(f'Incorrect {kind} knowledge id: {path}')
        if identity == wanted:
            if field(document, 'status') not in ('stable', 'release-candidate'):
                raise ValueError(f'Project {kind} knowledge is not ready: {path}')
            candidates.add(path)
        return document, identity

    for label, path in links('\n'.join(selected), index):
        if path in seen:
            continue
        seen.add(path)
        document, identity = inspect(label, path)
        if identity == wanted:
            continue
        # A project setting may point to the version source using an ordinary
        # Markdown link in Value; other sections may contain historical sources.
        values = re.split(r'^## Value[ \t]*$', document, flags=re.M)
        if len(values) != 2:
            continue
        value = re.split(r'^## (?!#)', values[1], maxsplit=1, flags=re.M)[0]
        for nested_label, nested_path in links(value, path):
            inspect(nested_label, nested_path)
    if len(candidates) > 1:
        raise ValueError(f'Conflicting project {kind} sources: ' + ', '.join(sorted(candidates)))
    return next(iter(candidates)) if candidates else default
