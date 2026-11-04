"""Automation policies must work even when stdin is a terminal."""
import os
from pathlib import Path
import subprocess
import tempfile
import unittest

TERMINAL = '''
[() { if builtin [ \"$1\" = -t ]; then return 0; fi; builtin [ \"$@\"; }
'''

SCRIPT = Path(__file__).resolve().parents[2] / 'scripts/double-installer.sh'
SOURCE = SCRIPT.read_text()

def function(name):
    start = SOURCE.index(name + '() {')
    return SOURCE[start:SOURCE.index('\n}\n', start) + 3]

class Automation(unittest.TestCase):
    def shell(self, code):
        return subprocess.run([os.environ.get('DOUBLE_TEST_BASH', 'bash'), '-c', TERMINAL + code],
                              capture_output=True, text=True, timeout=10)

    def test_common_options_and_invalid_policies(self):
        for args, expected in [
            (['--non-interactive'], 0),
            (['help', '--non-interactive'], 0),
            (['update-all', '--non-interactive', '--backup-policy', 'ask'], 2),
            (['update-all', '--backup-policy', 'invalid'], 2),
            (['status', '--backup-policy', 'delete'], 2),
        ]:
            with self.subTest(args=args):
                result = subprocess.run(
                    [os.environ.get('DOUBLE_TEST_BASH', 'bash'), SCRIPT.as_posix(), *args],
                    capture_output=True, text=True, timeout=10)
                self.assertEqual(result.returncode, expected, result.stderr)

    def test_cleanup_policies_on_terminal(self):
        for policy, non_interactive, yes, retained in [
            ('delete', 'true', 'false', False),
            ('keep', 'false', 'false', True),
            ('ask', 'true', 'false', True),
            ('ask', 'false', 'true', True),
        ]:
            with self.subTest(policy=policy, non_interactive=non_interactive, yes=yes):
                with tempfile.TemporaryDirectory() as directory:
                    backup = Path(directory) / 'backup'
                    backup.mkdir()
                    code = function('offer_backup_cleanup') + r"""
read() { echo 'UNEXPECTED PROMPT' >&2; return 99; }
action_printf() { printf "$@"; }
fail() { echo "$*" >&2; exit 1; }
""" + f"\nbackup_policy={policy};non_interactive={non_interactive};yes={yes}\n" + \
                        'offer_backup_cleanup ' + "'" + backup.as_posix() + "'"
                    result = self.shell(code)
                    self.assertEqual(result.returncode, 0, result.stderr)
                    self.assertNotIn('UNEXPECTED PROMPT', result.stderr)
                    self.assertEqual(backup.exists(), retained)

    def test_agent_selection_never_prompts_in_automation(self):
        for non_interactive, yes in [('true', 'false'), ('false', 'true')]:
            code = function('select_agents') + r"""
read() { echo 'UNEXPECTED PROMPT' >&2; exit 99; }
action_printf() { :; }
doctor_agents() { detected_agents=(codex claude); }
project=/unused;agent='';selected_agents=()
""" + f'non_interactive={non_interactive};yes={yes}\n' + r"""
select_agents
[[ "${selected_agents[*]}" == shared ]]
"""
            result = self.shell(code)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertNotIn('UNEXPECTED PROMPT', result.stderr)

    def test_non_interactive_consent_fails_without_reading(self):
        for name in ['installation_consent', 'confirm_action']:
            for yes in ['false', 'true']:
                result = self.shell(function(name) + r"""
read() { echo 'UNEXPECTED PROMPT' >&2; exit 99; }
action_printf() { :; }
fail() { echo "$*" >&2; exit 1; }
non_interactive=true
""" + f'yes={yes}\n{name} scope')
                self.assertEqual(result.returncode, 0 if yes == 'true' else 1, result.stderr)
                self.assertNotIn('UNEXPECTED PROMPT', result.stderr)

if __name__ == '__main__':
    unittest.main()
