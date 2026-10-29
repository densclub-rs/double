"""Publication uses real packaging and a fake subprocess boundary for gh."""
import os
from pathlib import Path
import subprocess

import pytest
from test_package import cli, git, release, repo, write


@pytest.mark.parametrize('existing', [False, True])
@pytest.mark.parametrize('fail', [False, True])
@pytest.mark.parametrize('suffix', ['', '-rc', '-dev'])
def test_publication_outcomes(repo, monkeypatch, existing, fail, suffix):
    tag = f'machine-of-ideas-1.2.4{suffix}'
    git('tag', tag)
    calls = []
    real_run = subprocess.run

    def fake_run(args, **kwargs):
        if args[0] != 'gh':
            return real_run(args, **kwargs)
        calls.append(args)
        command = args[2]
        code, out = 0, ''
        if command == 'view':
            if '--json' in args:
                out = 'https://github.com/o/r/releases/tag/test\n'
            else:
                code = 0 if existing else 1
        elif command in ('create', 'upload'):
            code = 1 if fail else 0
        return subprocess.CompletedProcess(args, code, out, '')

    monkeypatch.setattr(release.subprocess, 'run', fake_run)
    monkeypatch.setattr(release.shutil, 'which', lambda name: '/fake/gh')
    monkeypatch.setenv('GITHUB_ACTIONS', 'true')
    monkeypatch.setenv('GITHUB_OUTPUT', str(repo/'outputs'))
    monkeypatch.setenv('RELEASE_NOTES_FILE', str(repo/'notes.md'))
    write('notes.md', 'Release highlights')
    assert release.main(['publish','--tag',tag]) == 0
    output = Path('outputs').read_text()
    assert 'published=false' in output
    assert ('published=true' in output) == (not fail)
    operation = 'upload' if existing else 'create'
    publishing = next(c for c in calls if c[2] == operation)
    if existing:
        assert '--clobber' in publishing
        assert any(c[2] == 'edit' for c in calls) == (not fail)
    else:
        assert '--notes-file' in publishing
        assert ('--prerelease' in publishing) == bool(suffix)


@pytest.mark.parametrize('state', ['draft','verification-failure','invalid-url','notes-missing','notes-edit-failure','no-gh','no-match','upload-failure','create-failure'])
def test_warning_paths_do_not_announce_wrong_release(repo, monkeypatch, capsys, state):
    tag = 'machine-of-ideas-1.2.4'
    if state == 'no-match':
        for path in Path('.double/agents/machine-of-ideas').glob('*.md'):
            write(path, '---\nstatus: draft\n---\n')
        git('add','.double'); git('commit','-qm','empty stable selection')
    git('tag',tag)
    calls=[]; real_run=subprocess.run
    def fake_run(args, **kwargs):
        if args[0] != 'gh':
            return real_run(args, **kwargs)
        calls.append(args)
        code, out = 0, ''
        command=args[2]
        if command == 'view' and '--json' in args:
            code = int(state == 'verification-failure')
            out = '' if state == 'draft' else 'http://invalid' if state == 'invalid-url' else 'https://github.com/o/r/releases/tag/test'
        elif command == 'view':
            code = int(state == 'create-failure')
        elif command in ('create','upload'):
            code = int(state in ('upload-failure','create-failure'))
        elif command == 'edit':
            code = int(state == 'notes-edit-failure')
        return subprocess.CompletedProcess(args,code,out,'')
    monkeypatch.setattr(release.subprocess,'run',fake_run)
    monkeypatch.setattr(release.shutil,'which',lambda name: None if state == 'no-gh' else '/fake/gh')
    monkeypatch.setenv('GITHUB_ACTIONS','true')
    monkeypatch.setenv('GITHUB_OUTPUT',str(repo/'output'))
    monkeypatch.setenv('RELEASE_NOTES_FILE',str(repo/'missing-notes'))
    if state == 'notes-edit-failure':
        write('missing-notes','Notes')
    assert release.main(['publish','--tag',tag]) == 0
    assert ('published=true' in Path('output').read_text()) == (state == 'notes-edit-failure')
    assert '::warning::' in capsys.readouterr().err
    if state in ('no-match','no-gh'):
        assert calls == []
