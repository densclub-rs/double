"""Validate a prepared Double exchange package manifest without executing it."""
import argparse
import json
import re
from pathlib import Path, PurePosixPath

import jsonschema
import yaml

SCHEMA = Path(__file__).resolve().parents[3] / 'templates/double-agent/exchange-package-manifest.schema.json'


def validate(root):
    root = Path(root).resolve(strict=True)
    manifest = yaml.safe_load((root / 'manifest.yaml').read_text(encoding='utf-8'))
    schema = json.loads(SCHEMA.read_text(encoding='utf-8'))
    jsonschema.Draft202012Validator(schema, format_checker=jsonschema.FormatChecker()).validate(manifest)
    content = manifest['content']

    def check_path(value, directory_ok=False):
        relative = PurePosixPath(value)
        if relative.is_absolute() or any(x in ('.', '..') for x in relative.parts) or '\\' in value:
            raise ValueError(f'Unsafe package path: {value}')
        path = root.joinpath(*relative.parts)
        if any(p.is_symlink() for p in [path, *list(path.parents)[:len(relative.parts)-1]]):
            raise ValueError(f'Symlink in package path: {value}')
        resolved = path.resolve(strict=True)
        if not resolved.is_relative_to(root) or not (resolved.is_file() or directory_ok and resolved.is_dir()):
            raise ValueError(f'Invalid package path: {value}')

    if manifest['package']['type'] == 'idea':
        for item in [content['idea'], *content.get('related-artifacts', [])]:
            check_path(item['path'])
        return manifest
    check_path(content['goal']['path'])
    plans = content['plans']
    plan_ids = [p['id'] for p in plans]
    if len(plan_ids) != len(set(plan_ids)):
        raise ValueError('Duplicate plan ID')
    for plan in plans:
        check_path(plan['path'])
    ids = set()
    for item in content.get('sharing-realizations', []):
        if item['id'] in ids or item['plan-id'] not in plan_ids:
            raise ValueError(f'Invalid realization identity or plan: {item["id"]}')
        ids.add(item['id'])
        check_path(item['path'], directory_ok=True)
        for field in ('entrypoint', 'documentation'):
            if field in item:
                check_path(item[field])
        for requirement in item.get('requires', []):
            try:
                compiled = re.compile(requirement['check']['version-pattern'])
            except re.error as exc:
                raise ValueError(f'Invalid version pattern: {exc}') from exc
            if compiled.groups < 1:
                raise ValueError('Version pattern must have a capture group')
    return manifest


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('directory', help='prepared package directory')
    args = parser.parse_args()
    try:
        validate(args.directory)
    except (OSError, ValueError, yaml.YAMLError, jsonschema.ValidationError) as exc:
        parser.exit(1, f'Invalid package manifest: {exc}\n')
    print('Manifest and referenced paths are valid')


if __name__ == '__main__':
    main()
