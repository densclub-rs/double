import importlib.util
from pathlib import Path

import pytest
import yaml

SCRIPT = Path(__file__).resolve().parents[2] / '.double/tools/double-agent/exchange/validate_manifest.py'
spec = importlib.util.spec_from_file_location('validate_manifest', SCRIPT)
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)


@pytest.fixture
def package(tmp_path):
    for name in ('goal.md', 'plan.md', 'script.sh'):
        (tmp_path / name).write_text('example')
    manifest = {
        'schema-version': 1,
        'package': {'id': 'sample', 'version': '1.0.0', 'type': 'goal', 'title': 'Sample', 'summary': 'Example', 'language': 'en'},
        'content': {'goal': {'id': 'sample', 'path': 'goal.md'},
                    'plans': [{'id': 'sample', 'path': 'plan.md', 'revision': 1}],
                    'sharing-realizations': [{'id': 'cli', 'type': 'automatic', 'plan-id': 'sample', 'path': 'script.sh', 'entrypoint': 'script.sh', 'execution': {'kind': 'shell'}}]}}
    return tmp_path, manifest


def write(root, manifest):
    (root / 'manifest.yaml').write_text(yaml.safe_dump(manifest))


def test_valid_goal_package(package):
    root, manifest = package
    write(root, manifest)
    assert module.validate(root)['package']['id'] == 'sample'


@pytest.mark.parametrize('mutation', ['missing', 'escape', 'unknown-plan', 'duplicate-plan', 'bad-regex'])
def test_rejects_inconsistent_package(package, mutation):
    root, manifest = package
    content = manifest['content']
    if mutation == 'missing':
        content['goal']['path'] = 'missing.md'
    elif mutation == 'escape':
        content['goal']['path'] = '../outside.md'
    elif mutation == 'unknown-plan':
        content['sharing-realizations'][0]['plan-id'] = 'other'
    elif mutation == 'duplicate-plan':
        content['plans'].append(dict(content['plans'][0]))
    else:
        content['sharing-realizations'][0]['requires'] = [{'capability': 'python-runtime', 'version': '>=3.11', 'check': {'command': ['python3', '--version'], 'version-pattern': 'no capture'}}]
    write(root, manifest)
    with pytest.raises(Exception):
        module.validate(root)


def test_rejects_symlink_escape(package, tmp_path):
    root, manifest = package
    (root / 'link').symlink_to(tmp_path.parent, target_is_directory=True)
    manifest['content']['goal']['path'] = 'link/outside.md'
    write(root, manifest)
    with pytest.raises(ValueError, match='Symlink'):
        module.validate(root)
