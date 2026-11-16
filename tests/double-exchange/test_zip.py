import importlib.util
import sys
import zipfile
from pathlib import Path

import pytest
import yaml

SCRIPTS = Path(__file__).resolve().parents[2] / '.double/tools/double-agent/exchange'
sys.path.insert(0, str(SCRIPTS))
spec = importlib.util.spec_from_file_location('double_exchange', SCRIPTS / 'double_exchange.py')
pkg = importlib.util.module_from_spec(spec)
spec.loader.exec_module(pkg)


@pytest.fixture
def source(tmp_path):
    root = tmp_path / 'source'
    root.mkdir()
    (root / 'goal.md').write_text('goal')
    (root / 'plan.md').write_text('plan')
    (root / 'manifest.yaml').write_text(yaml.safe_dump({
        'schema-version': 1,
        'package': {'id': 'demo', 'version': '1', 'type': 'goal', 'title': 'Demo', 'summary': 'Example', 'language': 'en'},
        'content': {'goal': {'id': 'demo', 'path': 'goal.md'}, 'plans': [{'id': 'plan', 'path': 'plan.md', 'revision': 1}]}}))
    return root


def test_build_and_verify(source, tmp_path):
    output = tmp_path / 'demo.double.zip'
    pkg.build(source, output)
    assert pkg.verify(output)['package']['id'] == 'demo'
    assert not (source / 'SHA256SUMS').exists()


def test_export_idea_with_concepts_and_principles(tmp_path):
    root = tmp_path / 'idea-source'
    root.mkdir()
    for name in ('idea.md', 'concepts.md', 'principles.md'):
        (root / name).write_text('# ' + name + '\n')
    manifest = {
        'schema-version': 1,
        'package': {'id': 'sample-idea', 'version': '1.0', 'type': 'idea', 'title': 'Idea', 'summary': 'An idea', 'language': 'en'},
        'content': {'idea': {'id': 'sample-idea', 'path': 'idea.md'}, 'related-artifacts': [{'id': 'sample-concepts', 'path': 'concepts.md'}, {'id': 'sample-principles', 'path': 'principles.md'}]}}
    (root / 'manifest.yaml').write_text(yaml.safe_dump(manifest))
    output = tmp_path / 'idea.double.zip'
    pkg.build(root, output)
    assert pkg.verify(output)['content'] == manifest['content']
    with zipfile.ZipFile(output) as archive:
        assert set(archive.namelist()) == {'manifest.yaml', 'SHA256SUMS', 'idea.md', 'concepts.md', 'principles.md'}
        assert archive.read('idea.md') == (root / 'idea.md').read_bytes()


@pytest.mark.parametrize('kind', ['changed', 'missing', 'extra', 'duplicate', 'traversal'])
def test_reject_tampered_archive(source, tmp_path, kind):
    output = tmp_path / 'demo.double.zip'
    pkg.build(source, output)
    with zipfile.ZipFile(output) as archive:
        entries = {n: archive.read(n) for n in archive.namelist()}
    if kind == 'changed':
        entries['goal.md'] = b'tampered'
    elif kind == 'missing':
        del entries['goal.md']
    elif kind == 'extra':
        entries['extra'] = b'extra'
    elif kind == 'traversal':
        entries['../escape'] = b'bad'
    with zipfile.ZipFile(output, 'w') as archive:
        for name, data in entries.items():
            archive.writestr(name, data)
        if kind == 'duplicate':
            with pytest.warns(UserWarning):
                archive.writestr('goal.md', b'other')
    with pytest.raises(ValueError):
        pkg.verify(output)


def test_refuses_existing_output(source, tmp_path):
    output = tmp_path / 'existing.zip'
    output.write_bytes(b'keep')
    with pytest.raises(ValueError):
        pkg.build(source, output)
    assert output.read_bytes() == b'keep'


def test_explain_does_not_execute_checks_and_shows_url(source, tmp_path, monkeypatch, capsys):
    manifest = yaml.safe_load((source / 'manifest.yaml').read_text())
    manifest['package']['public-url'] = 'https://example.org/goals/demo'
    (source / 'run.sh').write_text('#!/bin/sh\n')
    manifest['content']['sharing-realizations'] = [{'id': 'run', 'type': 'automatic', 'plan-id': 'plan', 'path': 'run.sh', 'entrypoint': 'run.sh', 'execution': {'kind': 'shell'}, 'requires': [{'capability': 'python-runtime', 'version': '>=3.11', 'check': {'command': ['python3', '--version'], 'version-pattern': r'Python ([0-9]+(?:\.[0-9]+)*)'}}]}]
    (source / 'manifest.yaml').write_text(yaml.safe_dump(manifest))
    output = tmp_path / 'demo.zip'
    pkg.build(source, output)
    monkeypatch.setattr(pkg.subprocess, 'run', lambda *a, **k: pytest.fail('Explain executed a command'))
    pkg.explain(output)
    text = capsys.readouterr().out
    assert 'https://example.org/goals/demo' in text
    assert 'check' in text and '--realization run' in text


@pytest.mark.parametrize(('observed', 'expected'), [('Python 3.11.0', True), ('Python 3.10.9', False), ('unknown', False)])
def test_check_evaluates_versions(source, tmp_path, monkeypatch, observed, expected, capsys):
    from types import SimpleNamespace
    manifest = yaml.safe_load((source / 'manifest.yaml').read_text())
    (source / 'run.sh').write_text('#!/bin/sh\n')
    manifest['content']['sharing-realizations'] = [{'id': 'run', 'type': 'automatic', 'plan-id': 'plan', 'path': 'run.sh', 'entrypoint': 'run.sh', 'execution': {'kind': 'shell'}, 'requires': [{'capability': 'python-runtime', 'version': '>=3.11', 'check': {'command': ['python3', '--version'], 'version-pattern': r'Python ([0-9]+(?:\.[0-9]+)*)'}}]}]
    (source / 'manifest.yaml').write_text(yaml.safe_dump(manifest))
    output = tmp_path / 'demo.zip'
    pkg.build(source, output)
    monkeypatch.setattr(pkg.subprocess, 'run', lambda *a, **k: SimpleNamespace(returncode=0, stdout=observed, stderr=''))
    assert pkg.check(output, 'run') is expected
    assert 'python3 --version' in capsys.readouterr().out


def test_install_dry_run_and_update(source, tmp_path):
    import json
    manifest = yaml.safe_load((source / 'manifest.yaml').read_text())
    (source / 'run.sh').write_text('#!/bin/sh\n')
    manifest['content']['sharing-realizations'] = [{'id': 'run', 'type': 'automatic', 'plan-id': 'plan', 'path': 'run.sh', 'entrypoint': 'run.sh', 'execution': {'kind': 'shell'}}]
    manifest['content']['provides'] = [{'capability': 'python-runtime'}]
    (source / 'manifest.yaml').write_text(yaml.safe_dump(manifest))
    archive = tmp_path / 'demo.zip'
    pkg.build(source, archive)
    state = tmp_path / 'state'
    pkg.install(archive, 'run', state, dry_run=True)
    assert not state.exists()
    installer = state / 'installer'
    installer.mkdir(parents=True)
    (installer / 'registry.json').write_text('keep')
    pkg.install(archive, 'run', state)
    registry = json.loads((state / 'goals/registry.json').read_text())
    assert registry['installations'][0]['provides'][0]['capability'] == 'python-runtime'
    assert (state / 'goals/installed/demo/run.sh').is_file()
    assert pkg.search_installed(state, 'python-runtime')[0]['goal-id'] == 'demo'
    assert pkg.search_installed(state, 'python-runtime')[0]['entrypoint'] == str(state / 'goals/installed/demo/run.sh')
    assert pkg.search_installed(state, 'rust-runtime') == []
    manifest['package']['version'] = '2'
    (source / 'manifest.yaml').write_text(yaml.safe_dump(manifest))
    second = tmp_path / 'second.zip'
    pkg.build(source, second)
    pkg.install(second, 'run', state)
    assert json.loads((state / 'goals/registry.json').read_text())['installations'][0]['version'] == '2'
    assert (installer / 'registry.json').read_text() == 'keep'


def test_search_reports_missing_registry_and_broken_installation(source, tmp_path):
    import json
    state = tmp_path / 'state'
    with pytest.raises(FileNotFoundError):
        pkg.search_installed(state, 'python-runtime')
    (state / 'goals').mkdir(parents=True)
    (state / 'goals/registry.json').write_text(json.dumps({'schema-version': 1, 'installations': [{'goal-id': 'missing', 'provides': [{'capability': 'python-runtime'}]}]}))
    with pytest.raises(ValueError, match='unavailable'):
        pkg.search_installed(state, 'python-runtime')


def test_cli_groups_show_package_and_goal(monkeypatch, capsys):
    monkeypatch.setattr(sys, 'argv', ['double_exchange.py', '--help'])
    with pytest.raises(SystemExit) as exc:
        pkg.main()
    assert exc.value.code == 0
    output = capsys.readouterr().out
    assert 'package' in output and 'goal' in output


def test_install_does_not_replace_unregistered_directory(source, tmp_path):
    manifest = yaml.safe_load((source / 'manifest.yaml').read_text())
    (source / 'run.sh').write_text('hello')
    manifest['content']['sharing-realizations'] = [{'id': 'run', 'type': 'automatic', 'plan-id': 'plan', 'path': 'run.sh', 'entrypoint': 'run.sh', 'execution': {'kind': 'shell'}}]
    (source / 'manifest.yaml').write_text(yaml.safe_dump(manifest))
    archive = tmp_path / 'demo.zip'
    pkg.build(source, archive)
    target = tmp_path / 'state/goals/installed/demo'
    target.mkdir(parents=True)
    (target / 'keep').write_text('keep')
    with pytest.raises(ValueError, match='inconsistent'):
        pkg.install(archive, 'run', tmp_path / 'state')
    assert (target / 'keep').read_text() == 'keep'
