"""Offline tests for immutable stable library assets and CI publication."""
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import subprocess
import sys
import tarfile
import tempfile
import unittest
from unittest.mock import patch

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'scripts/double-release'))
spec = importlib.util.spec_from_file_location('style_release', ROOT / 'scripts/double-release/style-release.py')
release = importlib.util.module_from_spec(spec)
spec.loader.exec_module(release)


def write_library(root, version='0.1.0', text='# Double\n\nClear explanations.\n', extra=None):
    folder = Path(root) / 'styles'
    folder.mkdir(parents=True, exist_ok=True)
    (folder / 'double.md').write_text(text)
    files = {'double.md': hashlib.sha256((folder / 'double.md').read_bytes()).hexdigest()}
    for name, body in (extra or {}).items():
        (folder / name).write_text(body)
        files[name] = hashlib.sha256((folder / name).read_bytes()).hexdigest()
    (folder / 'manifest.json').write_text(json.dumps({'version': version, 'files': files}, indent=2)+'\n')
    return folder


class LibraryReleaseTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.folder = write_library(self.root)

    def package(self):
        return release.package(self.root, self.root / 'dist')

    def test_deterministic_archive_contains_only_manifested_official_files(self):
        (self.folder / 'custom').mkdir()
        (self.folder / 'custom/private.md').write_text('private')
        version, archive, checksum = self.package()
        before = archive.read_bytes()
        os.utime(self.folder / 'double.md', (123, 123))
        self.package()
        self.assertEqual(archive.read_bytes(), before)
        self.assertEqual(version, '0.1.0')
        with tarfile.open(archive) as stream:
            self.assertEqual(set(stream.getnames()), {'styles/manifest.json', 'styles/double.md'})
        self.assertIn(hashlib.sha256(before).hexdigest(), checksum.read_text())

    def test_stable_versions_only(self):
        for version in ['0.1.0-rc', '0.1.0-dev', '01.0.0', 'bad']:
            write_library(self.root, version)
            with self.subTest(version=version), self.assertRaises(ValueError):
                self.package()

    def test_changed_content_requires_new_manifest_checksum(self):
        (self.folder / 'double.md').write_text('changed')
        with self.assertRaisesRegex(ValueError, 'checksum'):
            self.package()

    def test_missing_empty_or_whitespace_default_is_rejected(self):
        for body in ['', ' \n\t']:
            write_library(self.root, text=body)
            with self.assertRaises(ValueError): self.package()
        (self.folder / 'double.md').unlink()
        with self.assertRaises(ValueError): self.package()

    def test_custom_and_traversal_entries_are_rejected(self):
        for name in ['custom/private.md', '../escape.md', 'manifest.json']:
            data = json.loads((self.folder / 'manifest.json').read_text())
            data['files'][name] = 'a'*64
            (self.folder / 'manifest.json').write_text(json.dumps(data))
            with self.subTest(name=name), self.assertRaises(ValueError): self.package()
            write_library(self.root)

    def test_symlink_default_is_rejected(self):
        target = self.root / 'outside.md'; target.write_text('outside')
        (self.folder / 'double.md').unlink()
        try: (self.folder / 'double.md').symlink_to(target)
        except OSError: self.skipTest('symlinks unavailable')
        with self.assertRaises(ValueError): self.package()

    def test_publication_is_main_ci_only(self):
        version, archive, checksum = self.package()
        for env in [{'GITHUB_ACTIONS': ''}, {'GITHUB_ACTIONS':'true', 'GITHUB_REF':'refs/heads/feature'}]:
            with patch.dict(os.environ, env), self.assertRaises(ValueError):
                release.publish(version, archive, checksum)

    def test_existing_release_is_never_overwritten(self):
        version, archive, checksum = self.package()
        calls = []
        env = {'GITHUB_ACTIONS':'true','GITHUB_REF':'refs/heads/main','GITHUB_REPOSITORY':'owner/repo','GITHUB_SHA':'a'*40}
        def run(args, **kwargs):
            calls.append(args)
            if 'releases/tags/styles-0.1.0' in args[2]:
                return subprocess.CompletedProcess(args, 0, json.dumps({'draft':False,'prerelease':False,
                    'assets':[{'id':1,'name':archive.name},{'id':2,'name':checksum.name}]}), '')
            data = archive.read_bytes() if args[2].endswith('/1') else checksum.read_bytes()
            return subprocess.CompletedProcess(args, 0, data, b'')
        with patch.dict(os.environ, env), patch.object(release.subprocess, 'run', run):
            release.publish(version, archive, checksum)
        self.assertFalse(any('create' in c or 'upload' in c for c in calls))

    def test_existing_release_different_content_requires_version_bump(self):
        version, archive, checksum = self.package()
        env = {'GITHUB_ACTIONS':'true','GITHUB_REF':'refs/heads/main','GITHUB_REPOSITORY':'owner/repo','GITHUB_SHA':'a'*40}
        responses = [subprocess.CompletedProcess([],0,json.dumps({'draft':False,'prerelease':False,
                     'assets':[{'id':1,'name':archive.name},{'id':2,'name':checksum.name}]}),''),
                     subprocess.CompletedProcess([],0,b'different',b'')]
        with patch.dict(os.environ,env), patch.object(release.subprocess,'run',side_effect=responses):
            with self.assertRaisesRegex(ValueError, 'increment'): release.publish(version,archive,checksum)

    def test_new_release_is_stable_without_notifications(self):
        version, archive, checksum = self.package()
        env = {'GITHUB_ACTIONS':'true','GITHUB_REF':'refs/heads/main','GITHUB_REPOSITORY':'owner/repo','GITHUB_SHA':'a'*40}
        responses = [subprocess.CompletedProcess([],1,'','HTTP 404'),subprocess.CompletedProcess([],1,'','HTTP 404'),subprocess.CompletedProcess([],0,'','')]
        with patch.dict(os.environ,env), patch.object(release.subprocess,'run',side_effect=responses) as run:
            release.publish(version,archive,checksum)
        args = run.call_args[0][0]
        self.assertEqual(args[:3], ['gh','release','create'])
        self.assertNotIn('--prerelease',args)
        self.assertIn('--latest=false',args)
        self.assertIn('a'*40,args)


if __name__ == '__main__': unittest.main()
