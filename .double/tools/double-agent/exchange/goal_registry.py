"""Read installed goal registry without executing a realization."""
import json
import re
from pathlib import Path

from validate_manifest import validate


def search_installed(state_root, capability):
    if not re.fullmatch(r'[a-z0-9]+(?:-[a-z0-9]+)*', capability):
        raise ValueError('Invalid capability identifier')
    state = Path(state_root).expanduser()
    if not state.is_absolute():
        raise ValueError('State root must be absolute')
    registry = state / 'goals' / 'registry.json'
    if not registry.exists():
        raise FileNotFoundError(f'Local goal registry unavailable: {registry}')
    records = json.loads(registry.read_text(encoding='utf-8'))
    if not isinstance(records, dict) or records.get('schema-version') != 1 or not isinstance(records.get('installations'), list):
        raise ValueError('Invalid goal registry')
    matches = []
    for entry in records['installations']:
        if not isinstance(entry, dict) or not isinstance(entry.get('provides'), list):
            raise ValueError('Invalid goal registry entry')
        if any(isinstance(item, dict) and item.get('capability') == capability for item in entry['provides']):
            target = state / 'goals' / 'installed' / entry.get('goal-id', '')
            if not re.fullmatch(r'[a-z0-9]+(?:-[a-z0-9]+)*', entry.get('goal-id', '')):
                raise ValueError('Invalid goal ID in registry')
            if target.is_symlink() or not target.is_dir() or not (target / 'manifest.yaml').is_file():
                raise ValueError(f'Installed goal unavailable: {entry["goal-id"]}')
            manifest = validate(target)
            if (manifest['package']['type'] != 'goal' or manifest['content']['goal']['id'] != entry['goal-id']
                    or manifest['package']['version'] != entry.get('version')
                    or manifest['package']['id'] != entry.get('package-id')):
                raise ValueError(f'Installed goal and registry disagree: {entry["goal-id"]}')
            if not any(item.get('capability') == capability for item in manifest['content'].get('provides', [])):
                raise ValueError(f'Installed capability and registry disagree: {entry["goal-id"]}')
            selected = [x for x in manifest['content'].get('sharing-realizations', []) if x['id'] == entry.get('realization-id') and x['type'] == 'automatic']
            if len(selected) != 1:
                raise ValueError(f'Installed realization and registry disagree: {entry["goal-id"]}')
            matches.append({'goal-id': entry['goal-id'], 'title': manifest['package']['title'], 'summary': manifest['package']['summary'], 'version': entry['version'], 'realization-id': selected[0]['id'], 'entrypoint': str(target / selected[0]['entrypoint']), 'documentation': str(target / selected[0]['documentation']) if selected[0].get('documentation') else None, 'path': str(target), 'public-url': manifest['package'].get('public-url')})
    return matches
