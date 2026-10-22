"""Fast grouping, failure-isolation and terminal-output regression checks."""
import json
import os
from pathlib import Path
try:
    import pty
except ImportError:
    pty = None
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[2]
SOURCE = (ROOT / 'scripts/double-installer.sh').read_text()
FUNCTIONS = SOURCE[SOURCE.index('action_printf() {'):SOURCE.index('\nfail() {')]


class UpdateAllOutput(unittest.TestCase):
    def run_update(self, *, terminal=False, fail=False, empty=False, prompt=False, no_color=False):
        with tempfile.TemporaryDirectory() as directory:
            registry = Path(directory) / 'registry.json'
            registry.write_text(json.dumps({'installations': [] if empty else [
                {'machine': 'z-machine', 'project': '/project/z'},
                {'machine': 'a-machine', 'project': '/project/b'},
                {'machine': 'a-machine', 'project': '/project/a', 'scope': 'global'},
            ]}))
            harness = FUNCTIONS + r'''
command_name=update-all
action_colors=false
if [ -t 1 ] && [ "${TERM:-}" != dumb ] && [ -z "${NO_COLOR+x}" ];then action_colors=true;fi
registry="$1";work_dir="$2";channel=rc;non_interactive=true;script_path=unused
bash() {
  [ "$DOUBLE_INSTALLER_NESTED_UPDATE" = 1 ] || return 9
  if [ "${CHECK_INPUT:-0}" = 1 ];then read -r answer; [ "$answer" = yes ] || return 7;fi
  [ "$7" = --channel ] && [ "$8" = rc ] && [ "$9" = --non-interactive ] || return 8
  action_indent='    ' action_printf success 'Checked %s at %s\n' "$6" "$4"
  [ "${SIMULATE_FAILURE:-0}" != 1 ] || [ "$4" != /project/a ]
}
update_all
'''
            env = dict(os.environ, TERM='xterm', SIMULATE_FAILURE=str(int(fail)))
            env.pop('NO_COLOR', None)
            env['CHECK_INPUT'] = str(int(prompt))
            if no_color:
                env['NO_COLOR'] = ''
            args = ['bash', '-c', harness, 'test', str(registry), directory]
            if terminal:
                master, slave = pty.openpty()
                process = subprocess.Popen(args, stdout=slave, stderr=slave, env=env)
                os.close(slave)
                chunks = []
                while True:
                    try:
                        chunk = os.read(master, 65536)
                    except OSError:
                        break
                    if not chunk:
                        break
                    chunks.append(chunk)
                os.close(master)
                return process.wait(), b''.join(chunks).decode()
            result = subprocess.run(args, env=env, capture_output=True, text=True, input="yes\nyes\nyes\n")
            return result.returncode, result.stdout + result.stderr

    def test_grouping_and_plain_output(self):
        code, output = self.run_update()
        self.assertEqual(code, 0, output)
        self.assertLess(output.index('a-machine (2'), output.index('z-machine (1'))
        self.assertLess(output.index('Global installation: /project/a'), output.index('Project: /project/b'))
        self.assertIn('    [OK] Checked a-machine at /project/b', output)
        self.assertIn('2 machines, 3 installations checked', output)
        self.assertNotIn('\x1b', output)

    def test_failure_continues(self):
        code, output = self.run_update(fail=True)
        self.assertEqual(code, 1, output)
        self.assertIn('Checked z-machine', output)
        self.assertIn('[ERROR] 1 failed.', output)
        self.assertIn('[OK] 2 completed successfully', output)

    @unittest.skipIf(pty is None, "PTY colors require a POSIX host")
    def test_terminal_accents(self):
        code, output = self.run_update(terminal=True)
        self.assertEqual(code, 0, output)
        self.assertIn('\x1b[1;36ma-machine\x1b[0m', output)
        self.assertIn('  \x1b[1;38;5;110mProject: /project/b\x1b[0m', output)
        self.assertIn('    \x1b[32m[OK]\x1b[0m Checked', output)

    def test_child_keeps_original_stdin(self):
        code, output = self.run_update(prompt=True)
        self.assertEqual(code, 0, output)
        self.assertIn('3 completed successfully', output)

    @unittest.skipIf(pty is None, "PTY colors require a POSIX host")
    def test_no_color_terminal(self):
        code, output = self.run_update(terminal=True, no_color=True)
        self.assertEqual(code, 0, output)
        self.assertNotIn('\x1b', output)

    def test_empty_registry(self):
        code, output = self.run_update(empty=True)
        self.assertEqual(code, 0, output)
        self.assertIn('No registered installations.', output)
        self.assertNotIn('Summary:', output)


if __name__ == '__main__':
    unittest.main()
