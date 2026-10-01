#!/usr/bin/env python3
"""Integration tests using disposable real Git repositories."""
from pathlib import Path
import subprocess
import tempfile
import time
import unittest

SCRIPT = Path(__file__).with_name('git-double').resolve()


class DraftExclusions(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.git('init', '-q')
        self.git('config', 'user.email', 'test@example.invalid')
        self.git('config', 'user.name', 'Test')

    def git(self, *args):
        return subprocess.run(['git', *args], cwd=self.root, text=True,
                              capture_output=True, check=True).stdout

    def cli(self, *args, code=0):
        result = subprocess.run([str(SCRIPT), *args], cwd=self.root,
                                text=True, capture_output=True)
        self.assertEqual(result.returncode, code, result.stdout + result.stderr)
        return result.stdout

    def doc(self, name, state='draft'):
        path = self.root / name
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(f'---\nstatus: {state}\n---\n# Document\n')
        return path

    def test_lifecycle_and_force_add(self):
        path = self.doc('ideas/a.md')
        self.cli('check', code=1)
        self.cli('sync')
        self.assertEqual(self.git('ls-files', '--others', '--exclude-standard'), '')
        self.doc('ideas/a.md', 'release-candidate')
        self.cli('check', code=1)
        self.cli('sync')
        self.assertIn('ideas/a.md', self.git('ls-files', '--others', '--exclude-standard'))
        self.doc('ideas/a.md')
        self.cli('sync')
        self.git('add', '-f', 'ideas/a.md')
        index = self.git('ls-files', '--stage')
        self.assertIn('TRACKED (exempt)', self.cli('check'))
        self.cli('sync')
        self.assertEqual(index, self.git('ls-files', '--stage'))
        self.git('commit', '-qm', 'Forced draft is permitted')
        path.write_text(path.read_text() + 'Edited\n')
        self.cli('sync')
        self.assertIn(' M ideas/a.md', self.git('status', '--short'))

    def test_preserves_other_rules_and_reports_external_conflict(self):
        self.doc('ideas/a.md', 'stable')
        exclude = self.root / '.git/info/exclude'
        exclude.write_text('# My rules\n/ideas/a.md\n')
        self.assertIn('MISMATCH ignored', self.cli('sync', code=1))
        self.assertEqual(exclude.read_text(), '# My rules\n/ideas/a.md\n')
        self.doc('ideas/b.md')
        self.cli('sync', code=1)
        self.assertTrue(exclude.read_text().startswith('# My rules\n/ideas/a.md\n'))

    def test_literal_paths_scope_and_stale_entries(self):
        for name in ('a [x]*?.md', 'a x.md', 'a!.md'):
            self.doc('ideas/' + name)
        self.cli('sync', 'ideas/a [x]*?.md')
        self.assertIn('ideas/a x.md', self.git('ls-files', '--others', '--exclude-standard'))
        self.cli('sync')
        self.assertEqual(self.git('ls-files', '--others', '--exclude-standard'), '')
        (self.root / 'ideas/a!.md').unlink()
        self.cli('sync')
        self.assertNotIn('/ideas/a\\!.md', (self.root / '.git/info/exclude').read_text())

    def test_check_does_not_write_and_sync_is_idempotent(self):
        self.doc('ideas/a.md', "'draft' # comment")
        exclude = self.root / '.git/info/exclude'
        original = exclude.read_bytes()
        self.cli('check', code=1)
        self.assertEqual(original, exclude.read_bytes())
        self.cli('sync')
        timestamp = exclude.stat().st_mtime_ns
        self.cli('sync')
        self.assertEqual(timestamp, exclude.stat().st_mtime_ns)

    def test_only_opening_frontmatter_and_unknown_status(self):
        path = self.doc('ideas/a.md', 'pending')
        path.write_text(path.read_text() + '\n---\nstatus: draft\n---\n')
        self.assertIn('UNMANAGED', self.cli('sync'))
        self.assertIn('ideas/a.md', self.git('ls-files', '--others', '--exclude-standard'))

    def test_malformed_block_fails_without_writes(self):
        self.doc('ideas/a.md')
        exclude = self.root / '.git/info/exclude'
        exclude.write_text('# BEGIN git-double drafts\n')
        self.cli('sync', code=2)
        self.assertEqual(exclude.read_text(), '# BEGIN git-double drafts\n')

    def test_watch_detects_saved_status_change(self):
        self.doc('ideas/a.md')
        process = subprocess.Popen([str(SCRIPT), 'watch', '--interval', '0.05'],
                                   cwd=self.root, stdout=subprocess.DEVNULL,
                                   stderr=subprocess.PIPE)
        try:
            for state, expected in [('draft', True), ('stable', False)]:
                self.doc('ideas/a.md', state)
                deadline = time.monotonic() + 5
                while True:
                    self.assertIsNone(process.poll())
                    ignored = subprocess.run(['git', 'check-ignore', '-q', 'ideas/a.md'],
                                             cwd=self.root).returncode == 0
                    if ignored == expected:
                        break
                    self.assertLess(time.monotonic(), deadline, 'watch did not sync')
                    time.sleep(0.03)
        finally:
            process.terminate()
            process.communicate(timeout=5)

    def test_missing_explicit_scope_is_error(self):
        self.cli('check', 'missing.md', code=2)


if __name__ == '__main__':
    unittest.main()
