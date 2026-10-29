"""Independent CLI fixtures cover each legacy packaging scenario."""
import hashlib
import importlib.util
import os
from pathlib import Path
import subprocess
import sys
import tarfile

import pytest
from release_common import MACHINES

ROOT = Path(__file__).resolve().parents[2]
CLI = ROOT / 'scripts/double-release/double-release.py'
spec = importlib.util.spec_from_file_location('release', CLI)
release = importlib.util.module_from_spec(spec)
spec.loader.exec_module(release)


def git(*args):
    return subprocess.check_output(['git', *args], text=True, stderr=subprocess.PIPE).strip()


def write(path, text):
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(text, encoding='utf-8')


def version(machine, value='1.2.4'):
    write(f'knowledge/{machine}-version/{machine}-version.md', f'## Value\n\n`{value}`\n')


def cli(*args, env=None, script=CLI):
    isolated = dict(os.environ, GITHUB_ACTIONS='', GITHUB_OUTPUT='')
    isolated.update(env or {})
    return subprocess.run([sys.executable, str(script), *args], env=isolated,
                          capture_output=True, text=True)


def archive_files(archive):
    with tarfile.open(archive) as stream:
        return {m.name.removeprefix('./'): stream.extractfile(m).read()
                for m in stream.getmembers() if m.isfile()}


def assert_checksum(archive):
    assert Path('dist/SHA256SUMS.txt').read_text() == f'{hashlib.sha256(archive.read_bytes()).hexdigest()}  {archive.name}\n'


@pytest.fixture
def repo(tmp_path, monkeypatch):
    monkeypatch.chdir(tmp_path)
    monkeypatch.setenv('GH_TOKEN', '')
    monkeypatch.delenv('GITHUB_OUTPUT', raising=False)
    git('init', '-q')
    git('config', 'user.email', 'fixture@example.invalid')
    git('config', 'user.name', 'Fixture')
    for machine in MACHINES:
        version(machine)
        for name, status in [('stable', 'stable'), ('draft', 'draft'), ('rc', 'release-candidate'), ('missing', '')]:
            write(f'.double/agents/{machine}/{name}.md', f'---\n'+(f'status: {status}\n' if status else '')+'---\n\n# Fixture\n')
    git('add', '.')
    git('commit', '-qm', 'fixture')
    return tmp_path


@pytest.mark.parametrize('machine', MACHINES)
@pytest.mark.parametrize('suffix,selected', [('', 'stable'), ('-dev', 'draft'), ('-rc', 'rc')])
def test_tagged_status_version_checksum_and_scope(repo, machine, suffix, selected):
    tag = f'{machine}-1.2.4{suffix}'
    git('tag', tag)
    result = cli('package', '--tag', tag)
    assert result.returncode == 0, result.stderr
    archive = Path(f'dist/double-{tag}.tar.gz')
    files = archive_files(archive)
    assert set(files) == {f'.double/agents/{machine}/{selected}.md'}
    assert b'version: 1.2.4\n' in next(iter(files.values()))
    assert 'missing.md' in result.stderr
    assert 'version:' not in Path(f'.double/agents/{machine}/{selected}.md').read_text()
    assert_checksum(archive)


@pytest.mark.parametrize('machine', MACHINES)
def test_version_mismatch_fails_without_package(repo, machine):
    tag = f'{machine}-1.2.5'
    git('tag', tag)
    result = cli('package', '--tag', tag)
    assert result.returncode == 1
    assert 'Machine version mismatch' in result.stderr
    assert not Path('dist').exists()


def test_no_match_is_warning_without_package(repo):
    version('custom-machine')
    git('add', 'knowledge')
    git('commit', '-qm', 'empty machine')
    git('tag', 'custom-machine-1.2.4')
    result = cli('package', '--tag', 'custom-machine-1.2.4')
    assert result.returncode == 0
    assert 'No stable files matched machine' in result.stderr
    assert not Path('dist').exists()


@pytest.mark.parametrize('machine', MACHINES)
def test_local_includes_working_and_untracked_files_all_statuses(repo, machine):
    version(machine, '2.0.0')
    path = f'.double/agents/{machine}/stable.md'
    write(path, Path(path).read_text() + '\nLocal edit\n')
    write(f'.double/agents/{machine}/new file.md', '---\nstatus: draft\n---\nNew\n')
    result = cli('package', '--machine', machine)
    assert result.returncode == 0, result.stderr
    archive = Path(f'dist/double-{machine}-2.0.0-local.tar.gz')
    files = archive_files(archive)
    assert set(files) == {f'.double/agents/{machine}/{n}.md' for n in ('stable','draft','rc','missing','new file')}
    assert b'Local edit' in files[path]
    assert all(b'version: 2.0.0' in content for content in files.values())
    assert 'version:' not in Path(path).read_text()
    assert_checksum(archive)
    tag = f'{machine}-1.2.4'
    git('tag', tag)
    assert cli('package', '--tag', tag).returncode == 0
    tagged = archive_files(Path(f'dist/double-{tag}.tar.gz'))
    assert b'Local edit' not in tagged[path]
    assert f'.double/agents/{machine}/new file.md' not in tagged


@pytest.mark.parametrize('machine', MACHINES)
def test_local_packaging_does_not_call_git(tmp_path, monkeypatch, machine):
    monkeypatch.chdir(tmp_path)
    version(machine, '3.2.1')
    write(f'.double/templates/{machine}/example.md', '---\nstatus: draft\n---\nExample\n')
    monkeypatch.setattr(release, 'git', lambda *args: pytest.fail('local package called git'))
    assert release.main(['package', '--machine', machine]) == 0
    assert_checksum(Path(f'dist/double-{machine}-3.2.1-local.tar.gz'))


def project_version(machine, value='9.8.7', path=None, status='stable'):
    path = path or f'.double-rules/{machine}-version/{machine}-version.md'
    write(path, f'---\nid: {machine}-version\nkind: knowledge-artifact\nstatus: {status}\n---\n\n## Value\n\n`{value}`\n')
    return path


@pytest.mark.parametrize('machine', MACHINES)
@pytest.mark.parametrize('grouped', [False, True])
def test_project_version_overrides_default_locally_and_in_tagged_tree(repo, machine, grouped):
    path = f'.double-rules/{machine}/{machine}-version.md' if grouped else None
    source = project_version(machine, path=path)
    index = '.double-rules/double-rules.md'
    link = source.removeprefix('.double-rules/')
    write(index, f'# Project knowledge\n\n## {machine}\n\n- [Version]({link})\n')
    result = cli('package', '--machine', machine)
    assert result.returncode == 0, result.stderr
    assert Path(f'dist/double-{machine}-9.8.7-local.tar.gz').exists()
    assert '`1.2.4`' in Path(f'knowledge/{machine}-version/{machine}-version.md').read_text()
    git('add', '.double-rules')
    git('commit', '-qm', 'project version override')
    tag = f'{machine}-9.8.7'
    git('tag', tag)
    project_version(machine, '10.0.0', path=source)
    write(index, 'broken working index')
    result = cli('package', '--tag', tag)
    assert result.returncode == 0, result.stderr
    files = archive_files(Path(f'dist/double-{tag}.tar.gz'))
    assert all(b'version: 9.8.7\n' in data for data in files.values())
    assert source not in files


def test_project_setting_can_link_to_version_source(repo):
    machine = 'machine-of-ideas'
    project_version(machine, path='project-context/version.md')
    write('.double-rules/double-rules.md', '# Project context\n\n## Common Rules\n\n- [Locations](locations/locations.md)\n')
    write('.double-rules/locations/locations.md', '## Description\n\n[Old source](missing.md)\n\n## Value\n\n[Current version](../../project-context/version.md)\n')
    result = cli('package', '--machine', machine)
    assert result.returncode == 0, result.stderr
    assert Path(f'dist/double-{machine}-9.8.7-local.tar.gz').exists()


@pytest.mark.parametrize('problem', ['index-missing', 'broken-link', 'conflicting', 'draft', 'incorrect-id', 'invalid-value'])
def test_broken_project_version_does_not_fall_back(repo, problem):
    machine = 'machine-of-ideas'
    source = project_version(machine, status='draft' if problem == 'draft' else 'stable')
    index = '.double-rules/double-rules.md'
    links = f'- [Version]({machine}-version/{machine}-version.md)\n'
    if problem == 'conflicting':
        project_version(machine, path='.double-rules/other/version.md')
        links += '- [Other](other/version.md)\n'
    if problem != 'index-missing':
        write(index, '# Context\n\n## double-agent\n\n' + links)
    if problem == 'broken-link':
        Path(source).unlink()
    elif problem == 'incorrect-id':
        write(source, Path(source).read_text().replace(f'id: {machine}-version', 'id: unrelated'))
    elif problem == 'invalid-value':
        write(source, Path(source).read_text().replace('9.8.7', 'unknown'))
    result = cli('package', '--machine', machine)
    assert result.returncode == 1, result.stderr
    assert not Path('dist').exists()


def test_project_context_without_version_source_uses_default(repo):
    write('.double-rules/double-rules.md', '# Context\n\n## Common Rules\n\n- [Setting](setting.md)\n')
    write('.double-rules/setting.md', '## Value\n\nUse English.\n')
    result = cli('package', '--machine', 'machine-of-ideas')
    assert result.returncode == 0, result.stderr
    assert Path('dist/double-machine-of-ideas-1.2.4-local.tar.gz').exists()


@pytest.mark.parametrize('args,warning', [
    (['package'], 'Select --machine'),
    (['package','--machine','../invalid'], 'Select --machine'),
    (['package','--machine','machine-of-ideas','--tag','machine-of-ideas-1.2.4'], 'Use either'),
    (['publish','--machine','machine-of-ideas'], 'required for publish'),
    (['package','--tag'], 'Missing value'),
    (['package','--other'], 'Unknown argument'),
    (['package','--tag','invalid'], 'Invalid release tag'),
    (['package','--tag','machine-of-ideas-9.9.9'], 'Git tag does not exist'),
])
def test_warning_arguments_do_not_create_packages(repo, args, warning):
    result = cli(*args)
    assert result.returncode == 0
    assert warning in result.stderr
    assert not Path('dist').exists()


def test_empty_local_selection(repo):
    for p in Path('.double/agents/machine-of-ideas').glob('*.md'):
        p.unlink()
    result = cli('package', '--machine', 'machine-of-ideas')
    assert result.returncode == 0
    assert 'No local files matched' in result.stderr
    assert not Path('dist').exists()


@pytest.mark.parametrize('value', [None, 'invalid'])
def test_local_missing_or_invalid_version(repo, value):
    path = Path('knowledge/machine-of-goals-version/machine-of-goals-version.md')
    if value is None:
        path.unlink()
    else:
        version('machine-of-goals', value)
    result = cli('package', '--machine', 'machine-of-goals')
    assert result.returncode == 1
    assert ('Machine version knowledge is missing' if value is None else 'Invalid local machine version') in result.stderr


def test_list_machines_tracks_catalog_and_missing_directory(tmp_path, monkeypatch):
    monkeypatch.chdir(tmp_path)
    for path in ['agents/custom-machine','workflows/custom-machine','skills/double-agent/nested','templates/machine-of-knowledge']:
        Path('.double',path).mkdir(parents=True)
    write('.double/agents/not-a-machine.md', '')
    result = cli('list-machines')
    assert result.stdout.splitlines()[1:] == ['custom-machine','double-agent','machine-of-knowledge']
    Path('.double/agents/custom-machine').rename('.double/agents/renamed-machine')
    assert 'renamed-machine' in cli('list-machines').stdout
    empty = tmp_path/'empty'; (empty/'.double').mkdir(parents=True)
    monkeypatch.chdir(empty)
    assert len(cli('list-machines').stdout.splitlines()) == 1
    missing = tmp_path/'missing'; missing.mkdir(); monkeypatch.chdir(missing)
    assert 'Working catalog .double was not found' in cli('list-machines').stderr


def test_publish_restricted_outside_actions(repo):
    git('tag','machine-of-ideas-1.2.4')
    result = cli('publish','--tag','machine-of-ideas-1.2.4')
    assert result.returncode == 0
    assert 'Publish is restricted to GitHub Actions' in result.stderr


def test_selected_release_tag(request):
    tag = request.config.getoption('--release-tag')
    if not tag:
        pytest.skip('no selected release tag supplied')
    checkout = request.config.release_checkout
    env = dict(os.environ, GITHUB_ACTIONS='', GITHUB_OUTPUT='')
    result = subprocess.run([sys.executable,str(CLI),'package','--tag',tag], cwd=checkout,
                            env=env, text=True, capture_output=True)
    assert result.returncode == 0, result.stderr
    archive = checkout/'dist'/f'double-{tag}.tar.gz'
    assert archive.is_file(), result.stderr
    checksum = (checkout/'dist/SHA256SUMS.txt').read_text()
    assert checksum == f'{hashlib.sha256(archive.read_bytes()).hexdigest()}  {archive.name}\n'


def test_export_replaces_version_and_preserves_body_newlines():
    source = '---\nstatus: stable\nversion: obsolete\n---\n\nContent\n\n\n'
    assert release.with_export_version(source, '1.2.3') == source.replace('version: obsolete','version: 1.2.3')


def test_local_empty_file_stays_empty():
    assert release.with_export_version('', '1.2.3') == ''


def test_installer_tags_use_the_independent_workflow(repo):
    result = cli('package', '--tag', 'double-installer-1.2.3')
    assert result.returncode == 1
    assert 'independent installer release workflow' in result.stderr
    assert not Path('dist').exists()


@pytest.mark.parametrize('machine', MACHINES)
def test_project_rule_protocol_ships_without_publishing_project_rules(repo, machine):
    """Each independently installed machine carries entry instructions, not policy."""
    workflow = f'.double/workflows/{machine}/{machine}-workflow.md'
    write(workflow, (ROOT / workflow).read_text())
    write('.double-rules/double-rules.md', '# Project rules\n\n## Common Rules\n\n- [Private rule](private/private.md)\n')
    write('.double-rules/private/private.md', '# Private project policy\n')
    git('add', '.')
    git('commit', '-qm', 'project rules fixture')
    channel = '-rc' if 'status: release-candidate\n' in (ROOT / workflow).read_text().split('---', 2)[1] else ''
    tag = f'{machine}-1.2.4{channel}'
    git('tag', tag)
    result = cli('package', '--tag', tag)
    assert result.returncode == 0, result.stderr
    files = archive_files(Path(f'dist/double-{tag}.tar.gz'))
    assert workflow in files
    assert b'Project Rules Loading Protocol' in files[workflow]
    assert b'Common Rules' in files[workflow]
    assert b'`' + machine.encode() + b'`' in files[workflow]
    assert not any(path.startswith('.double-rules/') for path in files)
    assert all(path.startswith('.double/') and f'/{machine}/' in path for path in files)
    assert Path('.double-rules/private/private.md').read_text() == '# Private project policy\n'
