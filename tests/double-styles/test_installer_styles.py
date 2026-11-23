"""Real installer CLI against isolated source trees and fake release transport."""
import hashlib
import io
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tarfile
import tempfile
import unittest

sys.path.insert(0, str(Path(__file__).parent))
from test_library_release import ROOT, release, write_library


@unittest.skipIf(os.name == "nt", "POSIX transport fixtures; existing installer platform tests cover Windows")
@unittest.skipUnless(shutil.which('jq') and shutil.which('bash'), 'installer requires bash and jq')
class InstallerStylesTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix='double-styles-')
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name).resolve()
        self.source = self.root / 'source'
        self.project = self.root / 'project'; self.project.mkdir()
        self.state = self.root / 'state'
        self.machine = 'machine-of-ideas'
        folder = self.source / f'.double/skills/{self.machine}'; folder.mkdir(parents=True)
        (folder / 'SKILL.md').write_text('# Fixture skill\n')
        wf = self.source / f'.double/workflows/{self.machine}'; wf.mkdir(parents=True)
        (wf / f'{self.machine}-workflow.md').write_text('## Style Application Protocol\n')
        self.style = write_library(self.source)
        self.env = dict(os.environ, DOUBLE_STATE_DIR=str(self.state), NO_COLOR='1')
        self.installer = str(ROOT / 'scripts/double-installer.sh')

    def run_cli(self, *args, okay=True):
        result = subprocess.run(['bash',self.installer,*args],env=self.env,text=True,capture_output=True,timeout=90)
        if okay: self.assertEqual(result.returncode,0,result.stdout+result.stderr)
        else: self.assertNotEqual(result.returncode,0,result.stdout+result.stderr)
        return result

    def dev(self, okay=True):
        return self.run_cli('dev','--source',str(self.source),'--project',str(self.project),'--machine',self.machine,'--yes',okay=okay)

    def version(self):
        return json.loads((self.state/'styles/manifest.json').read_text())['version']

    def test_dev_install_update_rollback_protection_custom_and_obsolete_files(self):
        write_library(self.source,extra={'obsolete.md':'# Old\n'})
        self.dev(); self.assertEqual(self.version(),'0.1.0')
        self.custom=self.state/'styles/custom'; self.custom.mkdir()
        (self.custom/'mine.md').write_text('private')
        write_library(self.source,'0.2.0','# New\n')
        self.dev(); self.assertEqual(self.version(),'0.2.0')
        self.assertFalse((self.state/'styles/obsolete.md').exists())
        self.assertEqual((self.custom/'mine.md').read_text(),'private')
        write_library(self.source,'0.1.0','# Older\n')
        self.dev(); self.assertEqual(self.version(),'0.2.0')

    def test_same_version_same_content_is_idempotent_and_missing_file_is_repaired(self):
        self.dev(); self.dev()
        (self.state/'styles/double.md').unlink()
        self.dev()
        self.assertEqual((self.state/'styles/double.md').read_text(),(self.style/'double.md').read_text())

    def test_same_version_different_content_rejected_and_machine_registry_restored(self):
        self.dev()
        registry=self.state/'installer/registry.json'; before=registry.read_bytes()
        write_library(self.source,text='# Different\n')
        result=self.dev(okay=False)
        self.assertIn('Same style version',result.stderr)
        self.assertEqual(registry.read_bytes(),before)
        self.assertIn('Clear explanations',(self.state/'styles/double.md').read_text())

    def test_modified_official_and_unmanaged_collisions_are_preserved(self):
        self.dev()
        target=self.state/'styles/double.md'; target.write_text('local change')
        self.dev(okay=False);self.assertEqual(target.read_text(),'local change')

    def test_first_install_write_failure_restores_machine_and_style_state(self):
        bindir=self.root/'bin';bindir.mkdir()
        real_cp=shutil.which('cp')
        shim=bindir/'cp'
        shim.write_text('#!/usr/bin/env bash\ncase "${*: -1}" in "'+str(self.state)+'/styles/double.md")\n case "$*" in *"/source/styles/"*) exit 1 ;; esac ;; esac\nexec "'+real_cp+'" "$@"\n')
        shim.chmod(0o755);self.env['PATH']=str(bindir)+os.pathsep+os.environ['PATH']
        self.dev(okay=False)
        self.assertFalse((self.project/f'.double/skills/{self.machine}').exists())
        self.assertFalse((self.state/'styles/manifest.json').exists())
        self.assertEqual(json.loads((self.state/'installer/registry.json').read_text())['installations'],[])
        self.assertFalse(list((self.state/'installer/transactions').iterdir()))

    def test_update_write_failure_restores_previous_library(self):
        self.dev()
        write_library(self.source,'0.2.0','# New\n',{'another.md':'# Another\n'})
        bindir=self.root/'bin';bindir.mkdir();real_cp=shutil.which('cp')
        shim=bindir/'cp'
        shim.write_text('#!/usr/bin/env bash\ncase "$*" in *"/source/styles/double.md"*) exit 1 ;; esac\nexec "'+real_cp+'" "$@"\n')
        shim.chmod(0o755);self.env['PATH']=str(bindir)+os.pathsep+os.environ['PATH']
        self.dev(okay=False)
        self.assertEqual(self.version(),'0.1.0')
        self.assertFalse((self.state/'styles/another.md').exists())

    def transport(self, styles=True, bad_checksum=False, prerelease=False):
        assets=self.root/'assets';assets.mkdir(exist_ok=True)
        tag=self.machine+'-1.0.0';folder=assets/tag;folder.mkdir(exist_ok=True)
        archive=folder/f'double-{tag}.tar.gz'
        with tarfile.open(archive,'w:gz') as stream:
            for path in (self.source/'.double').rglob('*'):
                if path.is_file(): stream.add(path,arcname=path.relative_to(self.source))
        (folder/'SHA256SUMS.txt').write_text(f'{hashlib.sha256(archive.read_bytes()).hexdigest()}  {archive.name}\n')
        def row(tag,name,pre=False):
            return {'tag_name':tag,'draft':False,'prerelease':pre,'assets':[
                {'name':n,'browser_download_url':f'https://github.com/densclub-rs/double/releases/download/{tag}/{n}'}
                for n in [name,'SHA256SUMS.txt']]}
        rows=[row(tag,archive.name)]
        if styles:
            version,archive,checksum=release.package(self.source,assets/'styles-0.1.0')
            if bad_checksum: checksum.write_text('0'*64+'  '+archive.name+'\n')
            rows.append(row('styles-'+version,archive.name,prerelease))
        (self.root/'releases.json').write_text(json.dumps(rows))
        bindir=self.root/'bin';bindir.mkdir(exist_ok=True)
        curl=bindir/'curl';curl.write_text('''#!/usr/bin/env python3
import os,pathlib,shutil,sys
args=sys.argv[1:];url=args[-1];out=args[args.index('--output')+1];root=pathlib.Path(os.environ['STYLE_FIXTURE'])
if os.environ.get('STYLE_HTTP_FAIL'):sys.exit(22)
if 'api.github.com' in url:src=root/'releases.json'
else:
 parts=url.split('/');src=root/'assets'/parts[-2]/parts[-1]
shutil.copyfile(src,out)
''');curl.chmod(0o755)
        self.env.update(PATH=str(bindir)+os.pathsep+os.environ['PATH'],STYLE_FIXTURE=str(self.root))

    def add(self,okay=True):
        return self.run_cli('add','--project',str(self.project),'--machine',self.machine,'--yes',okay=okay)

    def test_published_install_downloads_stable_library_and_repeated_add_refreshes(self):
        self.transport();self.add();self.assertEqual(self.version(),'0.1.0')
        (self.state/'styles/double.md').unlink()
        self.add();self.assertTrue((self.state/'styles/double.md').is_file())
        self.run_cli('update','--project',str(self.project),'--machine',self.machine,'--non-interactive')

    def test_no_style_release_or_rc_only_blocks_modern_first_install(self):
        for styles,pre in [(False,False),(True,True)]:
            with self.subTest(styles=styles,pre=pre):
                self.transport(styles=styles,prerelease=pre)
                self.add(okay=False)
                self.assertFalse((self.project/f'.double/skills/{self.machine}').exists())

    def test_invalid_checksum_never_changes_machine_or_library(self):
        self.transport(bad_checksum=True)
        result=self.add(okay=False)
        self.assertIn('Style archive checksum mismatch',result.stderr)
        self.assertFalse((self.state/'styles/manifest.json').exists())
        self.assertFalse((self.project/f'.double/skills/{self.machine}').exists())

    def test_style_releases_are_not_offered_as_machines(self):
        self.transport()
        result=self.run_cli('releases')
        self.assertIn(self.machine,result.stdout)
        self.assertNotIn('styles-',result.stdout)

    def test_foreign_official_destination_is_never_overwritten(self):
        folder=self.state/'styles';folder.mkdir(parents=True)
        (folder/'double.md').write_text('foreign')
        self.dev(okay=False)
        self.assertEqual((folder/'double.md').read_text(),'foreign')
        self.assertFalse((folder/'manifest.json').exists())

    def test_valid_archive_checksum_does_not_allow_unsafe_members(self):
        self.transport()
        folder=self.root/'assets/styles-0.1.0'
        archive=folder/'double-styles-0.1.0.tar.gz'
        with tarfile.open(archive) as stream:
            members=[(m,stream.extractfile(m).read()) for m in stream.getmembers()]
        with tarfile.open(archive,'w:gz') as stream:
            for m,data in members:stream.addfile(m,io.BytesIO(data))
            m=tarfile.TarInfo('styles/custom/overwrite.md');m.size=4
            stream.addfile(m,io.BytesIO(b'evil'))
        (folder/'SHA256SUMS.txt').write_text(hashlib.sha256(archive.read_bytes()).hexdigest()+'  '+archive.name+'\n')
        result=self.add(okay=False)
        self.assertIn('Unsafe or foreign style archive path',result.stderr)
        self.assertFalse((self.state/'styles/manifest.json').exists())

    def test_network_failure_retains_verified_library(self):
        self.transport();self.add()
        self.env['STYLE_HTTP_FAIL']='1'
        self.add()
        self.assertEqual(self.version(),'0.1.0')


if __name__=='__main__':unittest.main()
