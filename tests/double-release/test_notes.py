"""Scoped changelog regressions, migrated from the old unittest scenarios."""
import importlib.util
import os
from pathlib import Path
from unittest.mock import patch
import pytest

ROOT = Path(__file__).resolve().parents[2]
spec = importlib.util.spec_from_file_location('notes', ROOT / 'scripts/double-release/double-release-notes.py')
notes = importlib.util.module_from_spec(spec)
spec.loader.exec_module(notes)
MACHINE = 'machine-of-goals'
FILE = f'.double/workflows/{MACHINE}/flow.md'

class TestNotes:

    @pytest.fixture(autouse=True)
    def workspace(self, tmp_path, monkeypatch):
        monkeypatch.chdir(tmp_path)
        monkeypatch.setenv('GH_TOKEN', '')
        monkeypatch.setenv('GITHUB_ACTIONS', 'false')
        notes.git('init', '-q')
        notes.git('config', 'user.email', 'fixture@example.invalid')
        notes.git('config', 'user.name', 'Fixture')
        self.commit('initial', {FILE: 'first'})
        notes.git('tag', f'{MACHINE}-1.0.0')

    def commit(self, title, files):
        for name, text in files.items():
            path = Path(name)
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_text(text)
        notes.git('add', '.')
        notes.git('commit', '-qm', title)
        return notes.git('rev-parse', 'HEAD')

    def tag(self, version='1.1.0', suffix=''):
        tag = f'{MACHINE}-{version}{suffix}'
        notes.git('tag', tag)
        return tag

    def test_stable_and_rc_baselines_and_rerun(self):
        self.commit('feat: new flow', {FILE: 'second'})
        rc = self.tag(suffix='-rc')
        assert notes.baseline(rc) == f'{MACHINE}-1.0.0'
        self.commit('fix: refine', {FILE: 'third'})
        stable = self.tag()
        assert notes.baseline(stable) == rc
        assert notes.baseline(stable) == notes.baseline(stable)

    def test_rc_to_rc_range(self):
        self.commit('feat: already announced', {FILE: 'second'})
        previous = self.tag(suffix='-rc')
        self.commit('fix: new correction', {FILE: 'third'})
        current = self.tag(version='1.1.1', suffix='-rc')
        assert notes.baseline(current) == previous
        groups = notes.entries(current, previous, 'o/r')
        assert list(groups) == ['Fixed']
        assert groups['Fixed'][0][0] == 'new correction'

    def test_only_owned_working_files_and_mixed_scope(self):
        self.commit('fix: unrelated secret feature', {'knowledge/version.md': 'v2'})
        self.commit('feat: another machine', {'.double/workflows/machine-of-ideas/a.md': 'a'})
        self.commit('fix: shared infrastructure', {'scripts/shared.sh': 'x'})
        self.commit('feat: foreign feature plus own flow', {FILE: 'second', 'knowledge/a.md': 'x'})
        tag = self.tag()
        groups = notes.entries(tag, notes.baseline(tag), 'owner/repo')
        all_titles = ' '.join((title for items in groups.values() for title, _ in items))
        assert 'foreign feature plus own flow' in all_titles
        assert FILE not in all_titles
        assert 'unrelated' not in all_titles
        assert 'another machine' not in all_titles
        assert 'knowledge/' not in all_titles
        assert sum(map(len, groups.values())) == 1

    def test_initial_release(self):
        tag = f'{MACHINE}-1.0.0'
        assert notes.baseline(tag) is None
        md, message = notes.render(tag, None, {}, 'owner/repo')
        assert 'Initial release' in md
        assert 'Initial release' in message

    def test_merge_is_one_change_not_branch_plus_merge_duplicates(self):
        initial_branch = notes.git('branch', '--show-current')
        notes.git('checkout', '-qb', 'feature')
        self.commit('feat: branch flow', {FILE: 'branch'})
        notes.git('checkout', '-q', initial_branch)
        self.commit('chore: unrelated', {'outside.txt': 'outside'})
        notes.git('merge', '--no-ff', '-qm', 'Merge pull request feature', 'feature')
        tag = self.tag()
        groups = notes.entries(tag, notes.baseline(tag), 'o/r')
        assert sum(map(len, groups.values())) == 1
        assert groups['Added'][0][0] == 'branch flow'

    def test_non_english_description_is_preserved(self):
        self.commit('Исправлены ошибки', {FILE: 'second'})
        tag = self.tag()
        groups = notes.entries(tag, notes.baseline(tag), 'owner/repo')
        assert groups['Changed'][0][0] == 'Исправлены ошибки'

    def test_html_escaping_length_and_footer(self):
        groups = {'Fixed': [('<unsafe>&' + 'a' * 300, 'https://example.invalid/x') for _ in range(100)]}
        _, message = notes.render(f'{MACHINE}-1.1.0-rc', f'{MACHINE}-1.0.0', groups, 'owner/repo')
        assert '<unsafe>' not in message
        assert '&lt;unsafe&gt;&amp;' in message
        assert len(message.encode('utf-16-le')) // 2 < 4096
        assert 'Full changelog' in message
        assert 'More changes' in message
        assert '— rc' in message

    def test_pr_dedup_and_mixed_pr_scope(self):
        self.commit('feat: first', {FILE: 'second'})
        self.commit('fix: followup', {FILE: 'third'})
        tag = self.tag()
        pr = {'number': 12, 'title': 'feat: unrelated PR headline'}
        with patch.object(notes, 'pr_for_commit', return_value=pr), patch.object(notes, 'pr_is_scoped', return_value=False):
            groups = notes.entries(tag, notes.baseline(tag), 'owner/repo')
        assert sum(map(len, groups.values())) == 1
        item = next(iter(groups.values()))[0]
        assert item[0] == 'unrelated PR headline'
        assert item[1].endswith('/pull/12')

    def test_categories_and_empty_sections(self):
        assert notes.category('feat!: incompatible') == 'Breaking Changes'
        _, msg = notes.render(f'{MACHINE}-1.1.0', 'old', {'Fixed': [('Repair flow', 'https://example.invalid')]}, 'o/r')
        assert '<b>Fixed</b>' in msg
        assert '<b>Added</b>' not in msg

    def test_dev_is_ineligible(self):
        self.commit('feat: draft flow', {FILE: 'second'})
        tag = self.tag(suffix='-dev')
        output = str(Path('outputs').resolve())
        with patch.dict(os.environ, {'GITHUB_OUTPUT': output}), patch('sys.argv', ['notes', '--tag', tag, '--repository', 'o/r']):
            notes.main()
        assert 'eligible<<' in Path(output).read_text()
        assert '\nfalse\n' in Path(output).read_text()

    def test_tag_annotation_heads_message(self):
        self.commit('fix: flow', {FILE: 'second'})
        tag = f'{MACHINE}-1.1.0'
        annotation = 'Новый релиз <goals> & планы\n\nОписание изменений.'
        notes.git('tag', '-a', tag, '-m', annotation)
        assert notes.tag_annotation(tag) == annotation
        md, message = notes.render(tag, None, {}, 'o/r', annotation=notes.tag_annotation(tag))
        assert md.startswith(annotation)
        assert message.startswith('<b>Новый релиз &lt;goals&gt; &amp; планы')
        assert notes.tag_annotation(f'{MACHINE}-1.0.0') == ''

    def test_long_annotation_fits_telegram_budget(self):
        annotation = '<🚀>' * 5000
        md, message = notes.render(f'{MACHINE}-1.1.0', None, {}, 'o/r', annotation=annotation)
        assert annotation in md
        assert len(message.encode('utf-16-le')) // 2 < 4096
        assert '…</b>' in message
        assert 'Full changelog' in message

    def test_action_transport_preserves_safe_html_and_blocks_templates(self):
        import html
        message = '<b>Release</b> &lt;unsafe&gt; {{ .Config.Token }}'
        transport = notes.action_message(message)
        assert '{{' not in transport
        delivered_html = html.unescape(transport)
        assert '<b>Release</b>' in delivered_html
        assert '&lt;unsafe&gt;' in delivered_html
        assert '&#123;&#123;' in delivered_html


@pytest.mark.parametrize('failure', [OSError('missing gh'), __import__('subprocess').TimeoutExpired('gh',15)])
def test_api_failure_degrades_to_git(failure):
    with patch.object(notes.subprocess, 'run', side_effect=failure):
        assert notes.api('repos/o/r/pulls/1') is None


def test_api_invalid_json_and_incomplete_pr_scope():
    import subprocess
    with patch.object(notes.subprocess, 'run', return_value=subprocess.CompletedProcess([],0,'not json','')):
        assert notes.api('repos/o/r/pulls/1') is None
    with patch.object(notes, 'api', return_value=None):
        assert not notes.pr_is_scoped('o/r',1,MACHINE)
    with patch.object(notes, 'api', return_value=[{'filename': FILE, 'previous_filename': 'knowledge/old.md'}]):
        assert not notes.pr_is_scoped('o/r',1,MACHINE)
