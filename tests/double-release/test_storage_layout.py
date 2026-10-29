"""Check the published storage descriptor against its schema and real artifacts."""
import json
from pathlib import Path
import re

from jsonschema import Draft202012Validator, ValidationError
import pytest
import yaml

from release_common import MACHINES, project_knowledge_path

ROOT = Path(__file__).resolve().parents[2]


def published_layout():
    source = ROOT / 'knowledge/machine-version-and-changelog-locations/machine-version-and-changelog-locations.md'
    document = source.read_text()
    value = document.split('\n## Value\n', 1)[1].split('\n## Notes\n', 1)[0]
    descriptor = json.loads(re.search(r'```json\n(.*?)\n```', value, re.S)[1])
    schema_text = document.split('\n## Schema\n', 1)[1]
    schema = json.loads(re.search(r'```json\n(.*?)\n```', schema_text, re.S)[1])
    return descriptor, schema, yaml.safe_load(document.split('---', 2)[1])


def test_published_layout_matches_schema_files_and_source_resolution():
    descriptor, schema, metadata = published_layout()
    assert schema['$schema'] == 'https://json-schema.org/draft/2020-12/schema'
    assert schema['$id'] == f'urn:double:knowledge:{metadata["id"]}'
    Draft202012Validator.check_schema(schema)
    validator = Draft202012Validator(schema)
    validator.validate(descriptor)
    index = (ROOT / '.double-rules/double-rules.md').read_text()
    read = lambda path: (ROOT / path).read_text()
    exists = lambda path: (ROOT / path).exists()
    for machine in MACHINES:
        expanded = json.loads(json.dumps(descriptor).replace('<machine>', machine))
        validator.validate(expanded)
        ids = set()
        for role, artifact in expanded['artifacts'].items():
            assert artifact['id'] == f'{machine}-{role}'
            assert artifact['file'] == f'{machine}-{role}.md'
            path = Path('.double-rules') / expanded['directory'] / artifact['file']
            text = read(path)
            metadata = yaml.safe_load(text.split('---', 2)[1])
            assert metadata['id'] == artifact['id'] == path.stem
            assert metadata['id'] not in ids
            ids.add(metadata['id'])
            assert f'<a id="{metadata["id"]}"></a>' in text
            assert f']({expanded["directory"]}/{artifact["file"]})' in index
            kind = artifact['id'].removeprefix(machine + '-')
            assert project_knowledge_path(machine, kind, read, exists) == path.as_posix()
            assert not (ROOT / '.double-rules' / artifact['id']).exists()


@pytest.mark.parametrize('case', ['no-version', 'no-changelog', 'anonymous-files', 'extra-role', 'swapped-roles'])
def test_schema_requires_version_and_changelog_roles(case):
    descriptor, schema, _ = published_layout()
    artifacts = descriptor['artifacts']
    if case == 'no-version':
        del artifacts['version']
    elif case == 'no-changelog':
        del artifacts['changelog']
    elif case == 'anonymous-files':
        descriptor['artifacts'] = list(artifacts.values())
    elif case == 'extra-role':
        artifacts['other'] = artifacts['version']
    elif case == 'swapped-roles':
        artifacts['version'], artifacts['changelog'] = artifacts['changelog'], artifacts['version']
    with pytest.raises(ValidationError):
        Draft202012Validator(schema).validate(descriptor)
