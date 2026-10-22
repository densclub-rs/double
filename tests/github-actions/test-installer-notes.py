"""Offline checks for the exact installer announcement source and escaping."""
import html
import os
from pathlib import Path
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[2]


class InstallerNotes(unittest.TestCase):
    def test_annotation_preview_and_actions_message_match(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            def git(*args):
                return subprocess.check_output(['git', '-C', tmp, *args], text=True).strip()
            git('init', '-q')
            git('config', 'user.name', 'Fixture')
            git('config', 'user.email', 'fixture@example.invalid')
            (root / 'payload').write_text('fixture')
            git('add', 'payload')
            git('commit', '-qm', 'fixture')
            annotation = 'Double Installer 0.1.6 - release candidate\n\nGroup machines & projects; preserve {input}.'
            git('tag', '-a', 'double-installer-0.1.6-rc', '-m', annotation)
            env = dict(os.environ, GITHUB_OUTPUT=str(root / 'output'))
            command = ['python3', str(ROOT / 'scripts/double-installer-notes.py'), '--tag',
                       'double-installer-0.1.6-rc', '--repository', 'fixture/repo']
            subprocess.run(command, cwd=tmp, env=env, check=True)
            message = (root / 'dist/telegram-message.html').read_text()
            self.assertTrue(message.startswith(html.escape(annotation)))
            self.assertIn(git('rev-parse', 'HEAD'), message)
            action = (root / 'output').read_text().split('message<<')[1].split('\n', 1)[1].rsplit('\n', 2)[0]
            self.assertEqual(html.unescape(action), message.replace('{', '&#123;').replace('}', '&#125;'))
            subprocess.run(command, cwd=tmp, env=env, check=True)
            self.assertEqual(message, (root / 'dist/telegram-message.html').read_text())
            git('tag', 'double-installer-0.1.7-rc')
            command[3] = 'double-installer-0.1.7-rc'
            result = subprocess.run(command, cwd=tmp, env=env, capture_output=True)
            self.assertNotEqual(result.returncode, 0)


if __name__ == '__main__':
    unittest.main()
