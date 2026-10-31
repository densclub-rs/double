#!/usr/bin/env python3
"""Offline contract checks for the system bootstrap."""
import hashlib
import json
import os
import select
from pathlib import Path
import subprocess
import tempfile
import unittest

SCRIPT = Path(__file__).resolve().parents[2] / 'scripts/install.sh'
PAYLOAD = b'#!/bin/bash\necho launched > "$HOME/was-launched"\n'

class BootstrapTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.root = Path(self.tmp.name)
        self.bin = self.root / 'bin'
        self.bin.mkdir()
        self.dest = self.root / 'dest'
        self.dest.mkdir()
        self.release('1.0.0', '1.1.0-rc')
        curl = self.bin / 'curl'
        curl.write_text('''#!/bin/bash
url= out=
while [ "$#" -gt 0 ]; do
 case $1 in -o) out=$2; shift 2;; -H) shift 2;; -*) shift;; *) url=$1; shift;; esac
done
case "$url" in *releases?*) cp "$FIXTURE/releases.json" "$out";; */installer) cp "$FIXTURE/payload" "$out";; */sums) cp "$FIXTURE/sums" "$out";; *) exit 1;; esac
''')
        curl.chmod(0o755)
        (self.root / 'payload').write_bytes(PAYLOAD)
        (self.root / 'sums').write_text(hashlib.sha256(PAYLOAD).hexdigest() + '  double-installer.sh\n')
        self.env = dict(os.environ, HOME=str(self.root), FIXTURE=str(self.root), PATH=str(self.dest) + ':' + str(self.bin) + ':' + os.environ['PATH'])

    def tearDown(self): self.tmp.cleanup()

    def release(self, *versions):
        rows = []
        for version in versions:
            rows.append({'draft': False, 'tag_name': 'double-installer-' + version, 'assets': [{'name': 'double-installer.sh', 'browser_download_url': 'https://fixture/installer'}, {'name': 'SHA256SUMS.txt', 'browser_download_url': 'https://fixture/sums'}]})
        (self.root / 'releases.json').write_text(json.dumps(rows))

    def run_bootstrap(self, *args):
        return subprocess.run(['bash', str(SCRIPT), '--install-dir', str(self.dest), *args], env=self.env, stdin=subprocess.DEVNULL, capture_output=True, text=True)

    def test_stable_selected_without_tty_and_never_launched(self):
        result = self.run_bootstrap()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn('double-installer-1.0.0', result.stdout)
        self.assertIn('Current installer version: not installed', result.stdout)
        self.assertIn('Latest stable version: 1.0.0', result.stdout)
        self.assertIn('Selected installer version: 1.0.0', result.stdout)
        self.assertEqual((self.dest / 'double-installer').read_bytes(), PAYLOAD)
        self.assertFalse((self.root / 'was-launched').exists())

    def test_explicit_rc_consent(self):
        result = self.run_bootstrap('--accept-rc')
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn('double-installer-1.1.0-rc', result.stdout)
        self.assertIn('Available release candidate: 1.1.0-rc', result.stdout)
        self.assertIn('Selected installer version: 1.1.0-rc', result.stdout)

    def test_existing_version_identified_from_release_checksum(self):
        self.release('1.0.0')
        (self.dest / 'double-installer').write_bytes(PAYLOAD)
        result = self.run_bootstrap()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn('Current installer version: 1.0.0', result.stdout)

    def test_modified_installer_version_is_unknown(self):
        (self.dest / 'double-installer').write_bytes(b'modified')
        result = self.run_bootstrap('--accept-rc')
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn('Current installer version: unknown', result.stdout)

    def test_identical_release_bytes_show_all_matching_versions(self):
        (self.dest / 'double-installer').write_bytes(PAYLOAD)
        result = self.run_bootstrap('--accept-rc')
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn('Current installer version: 1.0.0, 1.1.0-rc', result.stdout)

    @unittest.skipUnless(hasattr(os, 'forkpty'), 'requires a POSIX terminal')
    def test_rc_prompt_includes_current_and_candidate_versions(self):
        self.release('1.1.0-rc')
        (self.dest / 'double-installer').write_bytes(PAYLOAD)
        pid, fd = os.forkpty()
        if pid == 0:
            if not os.access('/dev/tty', os.R_OK | os.W_OK):
                os._exit(77)
            os.execve('/bin/bash', ['bash', str(SCRIPT), '--install-dir', str(self.dest)], self.env)
        transcript = b''
        answered = False
        try:
            while True:
                ready, _, _ = select.select([fd], [], [], 15)
                self.assertTrue(ready, 'bootstrap prompt timed out')
                try:
                    chunk = os.read(fd, 4096)
                except OSError:
                    break
                if not chunk:
                    break
                transcript += chunk
                if b'Install it? [y/N]' in transcript and not answered:
                    os.write(fd, b'n\n')
                    answered = True
            _, status = os.waitpid(pid, 0)
        finally:
            os.close(fd)
        code = os.waitstatus_to_exitcode(status)
        if code == 77:
            self.skipTest('controlling terminal is not accessible in this environment')
        self.assertNotEqual(code, 0)
        self.assertIn(b'Current installer version: 1.1.0-rc', transcript)
        self.assertIn(b'Release candidate 1.1.0-rc is available. Install it?', transcript)
        self.assertEqual((self.dest / 'double-installer').read_bytes(), PAYLOAD)

    def test_rc_only_needs_consent(self):
        self.release('1.1.0-rc')
        result = self.run_bootstrap()
        self.assertNotEqual(result.returncode, 0)
        self.assertIn('Available release candidate: 1.1.0-rc', result.stdout)
        self.assertFalse((self.dest / 'double-installer').exists())

    def test_bad_checksum_preserves_existing_target(self):
        target = self.dest / 'double-installer'
        target.write_text('existing')
        (self.root / 'sums').write_text('0' * 64 + '  double-installer.sh\n')
        result = self.run_bootstrap('--accept-rc')
        self.assertNotEqual(result.returncode, 0)
        self.assertEqual(target.read_text(), 'existing')

    def test_noninteractive_path_absence_fails(self):
        self.env['PATH'] = str(self.bin) + ':' + os.environ['PATH']
        result = self.run_bootstrap('--accept-rc')
        self.assertNotEqual(result.returncode, 0)
        self.assertFalse((self.dest / 'double-installer').exists())

    def test_symlink_target_is_refused(self):
        target = self.dest / 'double-installer'
        target.symlink_to(self.root / 'foreign')
        result = self.run_bootstrap('--accept-rc')
        self.assertNotEqual(result.returncode, 0)
        self.assertTrue(target.is_symlink())

    def test_system_scope_in_isolated_directory(self):
        result = self.run_bootstrap('--system', '--accept-rc')
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertTrue((self.dest / 'double-installer').is_file())

    def test_absent_assets_preserve_existing_target(self):
        target = self.dest / 'double-installer'
        target.write_text('existing')
        (self.root / 'releases.json').write_text(json.dumps([
            {'draft': False, 'tag_name': 'double-installer-1.0.0', 'assets': []}
        ]))
        result = self.run_bootstrap()
        self.assertNotEqual(result.returncode, 0)
        self.assertEqual(target.read_text(), 'existing')

    def test_older_rc_does_not_override_stable(self):
        self.release('1.2.0', '1.1.9-rc')
        result = self.run_bootstrap('--accept-rc')
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn('double-installer-1.2.0', result.stdout)

    def test_verified_download_replaces_existing_installer(self):
        target = self.dest / 'double-installer'
        target.write_text('old installer')
        result = self.run_bootstrap('--accept-rc')
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(target.read_bytes(), PAYLOAD)

    def test_only_dev_release_is_rejected(self):
        self.release('2.0.0-dev')
        result = self.run_bootstrap('--accept-rc')
        self.assertNotEqual(result.returncode, 0)
        self.assertFalse((self.dest / 'double-installer').exists())

    def test_invalid_release_response_fails(self):
        (self.root / 'releases.json').write_text('{"message": "rate limited"}')
        result = self.run_bootstrap('--accept-rc')
        self.assertNotEqual(result.returncode, 0)
        self.assertFalse((self.dest / 'double-installer').exists())

    def test_install_real_local_script_and_invoke_it_separately(self):
        payload = (SCRIPT.parent / 'double-installer.sh').read_bytes()
        (self.root / 'payload').write_bytes(payload)
        (self.root / 'sums').write_text(hashlib.sha256(payload).hexdigest() + '  double-installer.sh\n')
        result = self.run_bootstrap('--accept-rc')
        self.assertEqual(result.returncode, 0, result.stderr)
        invoke = subprocess.run([str(self.dest / 'double-installer'), '--help'], env=self.env, capture_output=True, text=True)
        self.assertEqual(invoke.returncode, 0, invoke.stderr)
        self.assertIn('Double', invoke.stdout)

    @unittest.skipUnless(hasattr(os, 'forkpty'), 'requires a POSIX terminal')
    def test_confirmed_path_change_in_controlling_terminal(self):
        self.env['PATH'] = str(self.bin) + ':' + os.environ['PATH']
        self.env['SHELL'] = '/bin/bash'
        pid, fd = os.forkpty()
        if pid == 0:
            if not os.access('/dev/tty', os.R_OK | os.W_OK):
                os._exit(77)
            os.execve('/bin/bash', ['bash', str(SCRIPT), '--install-dir', str(self.dest), '--accept-rc'], self.env)
        transcript = b''
        answered_add = answered_file = False
        try:
            while True:
                ready, _, _ = select.select([fd], [], [], 15)
                self.assertTrue(ready, 'bootstrap prompt timed out')
                try:
                    chunk = os.read(fd, 4096)
                except OSError:
                    break
                if not chunk: break
                transcript += chunk
                if b'Add ' in transcript and b'to PATH? [y/N]' in transcript and not answered_add:
                    os.write(fd, b'y\n'); answered_add = True
                if b'Update this file? [y/N]' in transcript and not answered_file:
                    os.write(fd, b'y\n'); answered_file = True
            _, status = os.waitpid(pid, 0)
        finally:
            os.close(fd)
        code = os.waitstatus_to_exitcode(status)
        if code == 77:
            self.skipTest('controlling terminal is not accessible in this environment')
        self.assertEqual(code, 0, transcript.decode(errors='replace'))
        self.assertTrue(answered_add and answered_file)
        self.assertIn(str(self.dest), (self.root / '.bash_profile').read_text())
        self.assertTrue((self.dest / 'double-installer').is_file())

if __name__ == '__main__': unittest.main()
