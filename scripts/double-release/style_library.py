"""Validate a versioned official style snapshot from the selected source tree."""
import hashlib
import json
import re

MANIFEST = 'styles/manifest.json'
VERSION = re.compile(r'(0|[1-9][0-9]{0,8})\.(0|[1-9][0-9]{0,8})\.(0|[1-9][0-9]{0,8})\Z')
NAME = re.compile(r'[a-z0-9][a-z0-9-]*\.md\Z')


def library_assets(read, exists, regular):
    """Return immutable bytes; custom content is never an official package asset."""
    if not exists(MANIFEST):
        return []
    if not regular(MANIFEST):
        raise ValueError('Style manifest must be a regular file.')
    try:
        raw = read(MANIFEST)
        manifest = json.loads(raw)
        version, files = manifest['version'], manifest['files']
    except (KeyError, TypeError, ValueError) as exc:
        raise ValueError('Invalid style manifest.') from exc
    if not isinstance(version, str) or not VERSION.fullmatch(version):
        raise ValueError('Invalid style library version.')
    if not isinstance(files, dict) or 'double.md' not in files:
        raise ValueError('Style manifest must include double.md.')
    assets = [(MANIFEST, raw.encode('utf-8'), 0o644)]
    for name, digest in sorted(files.items()):
        if not NAME.fullmatch(name) or not isinstance(digest, str) or not re.fullmatch('[a-f0-9]{64}', digest):
            raise ValueError('Invalid style manifest inventory.')
        path = 'styles/' + name
        if not exists(path) or not regular(path):
            raise ValueError(f'Missing or non-regular style: {path}')
        data = read(path).encode('utf-8')
        if not data.strip() or hashlib.sha256(data).hexdigest() != digest:
            raise ValueError(f'Style content/checksum mismatch: {path}')
        assets.append((path, data, 0o644))
    return assets
