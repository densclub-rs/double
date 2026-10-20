#!/usr/bin/env python3
"""Isolated Git and publication fixtures; never contact GitHub or Telegram."""
import importlib.util
import os
from pathlib import Path
import subprocess
import tempfile
import unittest
from unittest.mock import patch

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location('notes', ROOT / 'scripts/double-release-notes.py')
notes = importlib.util.module_from_spec(spec)
spec.loader.exec_module(notes)
MACHINE = 'machine-of-goals'
FILE = f'.double/workflows/{MACHINE}/flow.md'


class NotesTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.cwd = os.getcwd()
        os.chdir(self.tmp.name)
        self.env = patch.dict(os.environ, {'GH_TOKEN': '', 'GITHUB_ACTIONS': 'false'})
        self.env.start()
        notes.git('init', '-q')
        notes.git('config', 'user.email', 'fixture@example.invalid')
        notes.git('config', 'user.name', 'Fixture')
        self.commit('initial', {FILE: 'first'})
        notes.git('tag', f'{MACHINE}-1.0.0')

    def tearDown(self):
        self.env.stop()
        os.chdir(self.cwd)
        self.tmp.cleanup()

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
        self.assertEqual(notes.baseline(rc), f'{MACHINE}-1.0.0')
        self.commit('fix: refine', {FILE: 'third'})
        stable = self.tag()
        self.assertEqual(notes.baseline(stable), f'{MACHINE}-1.0.0')
        self.assertEqual(notes.baseline(stable), notes.baseline(stable))

    def test_only_owned_working_files_and_mixed_scope(self):
        self.commit('fix: unrelated secret feature', {'knowledge/version.md': 'v2'})
        self.commit('feat: another machine', {'.double/workflows/machine-of-ideas/a.md': 'a'})
        self.commit('fix: shared infrastructure', {'scripts/shared.sh': 'x'})
        self.commit('feat: foreign feature plus own flow', {FILE: 'second', 'knowledge/a.md': 'x'})
        tag = self.tag()
        groups = notes.entries(tag, notes.baseline(tag), 'owner/repo')
        all_titles = ' '.join(title for items in groups.values() for title, _ in items)
        self.assertIn('Updated machine working files:', all_titles)
        self.assertNotIn('foreign feature', all_titles)
        self.assertNotIn('unrelated', all_titles)
        self.assertNotIn('another machine', all_titles)
        self.assertNotIn('knowledge/', all_titles)
        self.assertEqual(sum(map(len, groups.values())), 1)

    def test_initial_release(self):
        tag = f'{MACHINE}-1.0.0'
        self.assertIsNone(notes.baseline(tag))
        md, message = notes.render(tag, None, {}, 'owner/repo')
        self.assertIn('Initial release', md)
        self.assertIn('Initial release', message)

    def test_merge_is_one_change_not_branch_plus_merge_duplicates(self):
        initial_branch = notes.git('branch', '--show-current')
        notes.git('checkout', '-qb', 'feature')
        self.commit('feat: branch flow', {FILE: 'branch'})
        notes.git('checkout', '-q', initial_branch)
        self.commit('chore: unrelated', {'outside.txt': 'outside'})
        notes.git('merge', '--no-ff', '-qm', 'Merge pull request feature', 'feature')
        tag = self.tag()
        groups = notes.entries(tag, notes.baseline(tag), 'o/r')
        self.assertEqual(sum(map(len, groups.values())), 1)

    def test_non_english_title_falls_back_to_english(self):
        self.commit('Исправлены ошибки', {FILE: 'second'})
        tag = self.tag()
        groups = notes.entries(tag, notes.baseline(tag), 'owner/repo')
        self.assertTrue(groups['Changed'][0][0].startswith('Updated machine working files:'))

    def test_html_escaping_length_and_footer(self):
        groups = {'Fixed': [('<unsafe>&' + 'a' * 300, 'https://example.invalid/x') for _ in range(100)]}
        _, message = notes.render(f'{MACHINE}-1.1.0-rc', f'{MACHINE}-1.0.0', groups, 'owner/repo')
        self.assertNotIn('<unsafe>', message)
        self.assertIn('&lt;unsafe&gt;&amp;', message)
        self.assertLess(len(message.encode('utf-16-le')) // 2, 4096)
        self.assertIn('Full changelog', message)
        self.assertIn('More changes', message)
        self.assertIn('— rc', message)

    def test_pr_dedup_and_mixed_pr_scope(self):
        self.commit('feat: first', {FILE: 'second'})
        self.commit('fix: followup', {FILE: 'third'})
        tag = self.tag()
        pr = {'number': 12, 'title': 'feat: unrelated PR headline'}
        with patch.object(notes, 'pr_for_commit', return_value=pr), patch.object(notes, 'pr_is_scoped', return_value=False):
            groups = notes.entries(tag, notes.baseline(tag), 'owner/repo')
        self.assertEqual(sum(map(len, groups.values())), 1)
        item = next(iter(groups.values()))[0]
        self.assertNotIn('unrelated', item[0])
        self.assertTrue(item[1].endswith('/pull/12'))

    def test_categories_and_empty_sections(self):
        self.assertEqual(notes.category('feat!: incompatible'), 'Breaking Changes')
        _, msg = notes.render(f'{MACHINE}-1.1.0', 'old', {'Fixed': [('Repair flow', 'https://example.invalid')]}, 'o/r')
        self.assertIn('<b>Fixed</b>', msg)
        self.assertNotIn('<b>Added</b>', msg)

    def test_dev_is_ineligible(self):
        self.commit('feat: draft flow', {FILE: 'second'})
        tag = self.tag(suffix='-dev')
        output = str(Path('outputs').resolve())
        with patch.dict(os.environ, {'GITHUB_OUTPUT': output}), patch('sys.argv', ['notes', '--tag', tag, '--repository', 'o/r']):
            notes.main()
        self.assertIn('eligible<<', Path(output).read_text())
        self.assertIn('\nfalse\n', Path(output).read_text())

    def test_action_transport_preserves_safe_html_and_blocks_templates(self):
        import html
        message = '<b>Release</b> &lt;unsafe&gt; {{ .Config.Token }}'
        transport = notes.action_message(message)
        self.assertNotIn('{{', transport)
        delivered_html = html.unescape(transport)
        self.assertIn('<b>Release</b>', delivered_html)
        self.assertIn('&lt;unsafe&gt;', delivered_html)
        self.assertIn('&#123;&#123;', delivered_html)

    def test_workflow_notification_boundaries(self):
        import json
        raw = subprocess.check_output(['ruby', '-ryaml', '-rjson', '-e',
            'puts JSON.generate(YAML.load_file(ARGV[0]))',
            str(ROOT / '.github/workflows/release.yml')], text=True)
        workflow = json.loads(raw)
        telegram = workflow['jobs']['telegram']
        self.assertEqual(telegram['permissions'], {})
        self.assertEqual(telegram['needs'], 'release')
        self.assertIn("outputs.published == 'true'", telegram['if'])
        self.assertIn("outputs.eligible == 'true'", telegram['if'])
        self.assertFalse(any('checkout' in step.get('uses', '') for step in telegram['steps']))
        release_steps = workflow['jobs']['release']['steps']
        self.assertIn('bash .release-tools/tests/test-double-release.sh',
                      next(step['run'] for step in release_steps if step['name'] == 'Test release possibility'))
        send = next(step for step in telegram['steps'] if step.get('id') == 'send')
        self.assertRegex(send['uses'], r'^appleboy/telegram-action@[a-f0-9]{40}$')
        self.assertTrue(send['continue-on-error'])
        self.assertEqual(send['with']['format'], 'html')
        self.assertEqual(send['with']['message_thread_id'], '${{ vars.TELEGRAM_THREAD_ID }}')
        check = next(step for step in telegram['steps'] if step.get('id') == 'config')['run']
        for token, dest, topic, ready in [('x', '-1002983024983', '8', True),
                                          ('', '-1002983024983', '8', False),
                                          ('x', '-100999', '8', False),
                                          ('x', '-1002983024983', '', False),
                                          ('x', '-1002983024983', '9', False)]:
            path = Path('config-output'); path.write_text('')
            env = dict(os.environ, TELEGRAM_TOKEN=token, TELEGRAM_TO=dest,
                       TELEGRAM_THREAD_ID=topic, GITHUB_OUTPUT=str(path.resolve()))
            result = subprocess.run(['bash', '-c', check], env=env, text=True, capture_output=True, check=True)
            self.assertEqual('ready=true' in path.read_text(), ready)
            if not ready:
                self.assertIn('::warning::', result.stdout)

    def test_publication_outcomes(self):
        Path(FILE).write_text('---\nstatus: stable\n---\nflow\n')
        version_path = Path(f'knowledge/{MACHINE}-version/{MACHINE}-version.md')
        version_path.parent.mkdir(parents=True, exist_ok=True)
        version_path.write_text('## Value\n\n`1.1.0`\n')
        self.commit('fixture package', {FILE: Path(FILE).read_text(), str(version_path): version_path.read_text()})
        tag = self.tag()
        bin_dir = Path('bin'); bin_dir.mkdir()
        stub = bin_dir / 'gh'
        stub.write_text('''#!/bin/sh
printf '%s\\n' "$*" >> "$GH_CALLS"
case "$1 $2" in
 'release view')
   if [ "$#" -gt 3 ]; then
     if [ "${DRAFT:-0}" = 1 ]; then exit 0; fi
     printf 'https://github.com/o/r/releases/tag/test\\n'; exit 0;
   fi
   [ "${EXISTING:-0}" = 1 ]; exit $? ;;
 'release create'|'release upload') [ "${PUBLISH_FAIL:-0}" = 0 ]; exit $? ;;
 'release edit') exit 0 ;;
esac
exit 1
''')
        stub.chmod(0o755)
        env = dict(os.environ, PATH=str(bin_dir.resolve()) + os.pathsep + os.environ['PATH'], GITHUB_ACTIONS='true', GITHUB_OUTPUT=str(Path('out').resolve()), GH_CALLS=str(Path('calls').resolve()))
        for existing in ('0', '1'):
            for fail in ('0', '1'):
                Path('out').write_text('')
                env.update(EXISTING=existing, PUBLISH_FAIL=fail, RELEASE_NOTES_FILE=str(Path('notes.md').resolve()))
                Path('notes.md').write_text('Release highlights')
                subprocess.run(['bash', str(ROOT / 'scripts/double-release.sh'), 'publish', '--tag', tag], env=env, check=True, capture_output=True)
                output = Path('out').read_text()
                self.assertIn('published=false', output)
                self.assertEqual('published=true' in output, fail == '0')
                if fail == '0':
                    self.assertIn('--notes-file', Path('calls').read_text())
        env.update(EXISTING='1', PUBLISH_FAIL='0', DRAFT='1')
        Path('out').write_text('')
        subprocess.run(['bash', str(ROOT / 'scripts/double-release.sh'), 'publish', '--tag', tag], env=env, check=True, capture_output=True)
        self.assertNotIn('published=true', Path('out').read_text())
        # A successful old release must not turn a no-match run into an announcement.
        self.commit('empty selection', {FILE: '---\nstatus: draft\n---\nflow\n'})
        skip_tag = self.tag(suffix='-rc')
        Path('out').write_text(''); Path('calls').write_text('')
        subprocess.run(['bash', str(ROOT / 'scripts/double-release.sh'), 'publish', '--tag', skip_tag], env=env, check=True, capture_output=True)
        self.assertNotIn('published=true', Path('out').read_text())
        self.assertEqual(Path('calls').read_text(), '')


if __name__ == '__main__':
    unittest.main()
