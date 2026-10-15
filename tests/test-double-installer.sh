#!/usr/bin/env bash
# Isolated S02 release transport tests. No network or live state/cron changes.
set -euo pipefail
export PYTHONUTF8=1 PYTHONIOENCODING=utf-8
# Native Python must invoke this Git Bash, never Windows' WSL bash.exe.
if command -v cygpath >/dev/null 2>&1; then
  export DOUBLE_TEST_BASH="$(cygpath -w "$(command -v bash)")"
  export DOUBLE_TEST_SH="$(cygpath -w /bin/sh)"
  export DOUBLE_TEST_CYGPATH="$(cygpath -w "$(command -v cygpath)")"
fi
cd "$(dirname "$0")/.."
python3 - <<'PY'
import hashlib,io,json,os,pathlib,subprocess,tarfile,tempfile,shutil,sys,shlex
def posix_path(path):
 if os.name != 'nt': return str(path)
 return subprocess.check_output([os.environ['DOUBLE_TEST_CYGPATH'], '-u', str(path)],text=True,encoding='utf-8').strip()
def native_python_shim(path):
 if os.name != 'nt': return
 payload=path.with_name(path.name+'.py')
 payload.write_bytes(path.read_bytes())
 launcher='#!/usr/bin/env bash\nexec '+shlex.quote(posix_path(sys.executable))+' '+shlex.quote(str(payload))+' "$@"\n'
 path.write_text(launcher,encoding='utf-8',newline='\n')
bash_exe=os.environ.get('DOUBLE_TEST_BASH','bash')
sh_exe=os.environ.get('DOUBLE_TEST_SH','/bin/sh')
def fixture_tool(tool):
 if os.name != 'nt': return shutil.which(tool)
 value=subprocess.check_output([bash_exe,'-c','command -v "$1"','--',tool],text=True,encoding='utf-8').strip()
 return subprocess.check_output([os.environ['DOUBLE_TEST_CYGPATH'],'-w',value],text=True,encoding='utf-8').strip()
script=posix_path(pathlib.Path('scripts/double-installer.sh').resolve())
with tempfile.TemporaryDirectory(prefix="double installer тест % ' ") as tmp:
 root=pathlib.Path(tmp).resolve(); assets=root/'assets';assets.mkdir(); bindir=root/'bin';bindir.mkdir()
 fake=bindir/'curl'
 fake.write_text('''#!/usr/bin/env python3
import os,sys,pathlib,shutil
args=sys.argv[1:]; url=args[-1]; target=args[args.index('--output')+1]; root=pathlib.Path(os.environ['FIXTURE'])
if os.environ.get('HTTP_FAIL'): sys.exit(22)
if 'api.github.com' in url:
 page=url.rsplit('page=',1)[-1]; shutil.copyfile(root/('page'+page+'.json'),target)
else: shutil.copyfile(root/'assets'/url.rsplit('/',1)[-1],target)
''', encoding="utf-8", newline="\n");fake.chmod(0o755);native_python_shim(fake)
 env=dict(os.environ,PATH=str(bindir)+os.pathsep+os.environ['PATH'],FIXTURE=tmp,DOUBLE_STATE_DIR=posix_path(root/'state'))
 def run(*args,code=0,extra=None):
  r=subprocess.run([bash_exe,script,*args],env=dict(env,**(extra or {})),capture_output=True,text=True,encoding='utf-8')
  assert r.returncode==code,(args,r.returncode,r.stdout,r.stderr)
  return r.stdout+r.stderr
 def release(version,channel='',machine='machine-of-ideas',draft=False):
  tag=f'{machine}-{version}'+('-'+channel if channel else '')
  names=[f'double-{tag}.tar.gz','SHA256SUMS.txt']
  return dict(tag_name=tag,draft=draft,prerelease=bool(channel),assets=[dict(name=n,browser_download_url=f'https://github.com/densclub-rs/double/releases/download/{tag}/{n}') for n in names])
 def pages(items):
  (root/'page1.json').write_text(json.dumps(items[:100]), encoding="utf-8", newline="\n");(root/'page2.json').write_text(json.dumps(items[100:]), encoding="utf-8", newline="\n")
 def package(rel,path=None,kind=None):
  name=rel['assets'][0]['name'];data=b'machine content'
  with tarfile.open(assets/name,'w:gz') as t:
   info=tarfile.TarInfo(path or '.double/templates/machine-of-ideas/example.md');info.size=len(data)
   if kind: info.type=kind;info.linkname='/tmp/outside';info.size=0
   t.addfile(info,io.BytesIO(data))
  digest=hashlib.sha256((assets/name).read_bytes()).hexdigest()
  (assets/'SHA256SUMS.txt').write_text(f'{digest}  {name}\n', encoding="utf-8", newline="\n")
 stable=release('1.10.0');older=release('1.9.0');rc=release('2.0.0','rc')
 pages([older,rc,stable,release('9.0.0',draft=True)])
 out=run('releases');assert '1.10.0' in out and '2.0.0' not in out and '9.0.0' not in out
 assert out.index('1.10.0')<out.index('1.9.0')
 assert '2.0.0' in run('releases','--channel','rc')
 # Pagination must find a machine that appears only on page two.
 pages([release('1.0.0',machine='other-machine')]*100+[stable])
 assert '1.10.0' in run('releases','--machine','machine-of-ideas')
 pages([rc]);assert 'No published stable' in run('releases')
 run('download','--machine','machine-of-ideas',code=1)
 assert not (root/'state').exists()
 pages([stable,older]);package(stable)
 run('download','--machine','machine-of-ideas')
 cached=root/'state/installer/releases'/stable['tag_name'];assert (cached/stable['assets'][0]['name']).exists()
 run('download','--machine','machine-of-ideas',code=1)
 package(older);(assets/'SHA256SUMS.txt').write_text('0'*64+'  '+older['assets'][0]['name']+'\n', encoding="utf-8", newline="\n")
 run('download','--machine','machine-of-ideas','--version','1.9.0',code=1)
 assert not (root/'state/installer/releases'/older['tag_name']).exists()
 for path,kind in [('../escape',None),('.double/templates/other-machine/x.md',None),('.double/templates/machine-of-ideas/link',tarfile.SYMTYPE)]:
  package(older,path,kind);run('download','--machine','machine-of-ideas','--version','1.9.0',code=1)
  assert not (root/'state/installer/releases'/older['tag_name']).exists()
 run('releases',code=1,extra={'HTTP_FAIL':'1'})
 (root/'page1.json').write_text('{}', encoding="utf-8", newline="\n");run('releases',code=1)
 run('download',code=2);run('releases','--channel','bad',code=2)
 assert not (root/'escape').exists()

 # S03: actual file and registry lifecycle in two isolated projects.
 pages([stable]);package(stable)
 project1=root/'project one';project2=root/'проект два'
 project1.mkdir();project2.mkdir()
 run('add','--project',posix_path(project1),'--machine','machine-of-ideas')
 run('add','--project',posix_path(project2),'--machine','machine-of-ideas')
 installed=project1/'.double/templates/machine-of-ideas/example.md'
 assert installed.read_bytes()==b'machine content'
 registry=root/'state/installer/registry.json'
 assert len(json.loads(registry.read_text())['installations'])==2
 assert posix_path(project1) in run('list')
 run('add','--project',posix_path(project1),'--machine','machine-of-ideas',code=1)
 sentinel=project1/'ideas/keep.md';sentinel.parent.mkdir();sentinel.write_text('keep', encoding="utf-8", newline="\n")
 other=release('1.0.0',machine='machine-of-goals');pages([other]);package(other,'.double/templates/machine-of-goals/example.md')
 run('add','--project',posix_path(project1),'--machine','machine-of-goals')
 installed.write_text('local edits', encoding="utf-8", newline="\n")
 run('remove','--project',posix_path(project1),'--machine','machine-of-ideas',code=1)
 assert installed.read_text()=='local edits'
 run('remove','--project',posix_path(project1),'--machine','machine-of-ideas','--yes')
 assert not installed.exists() and sentinel.read_text()=='keep'
 assert (project1/'.double/templates/machine-of-goals/example.md').is_file()
 assert len(json.loads(registry.read_text())['installations'])==2
 run('remove','--project',posix_path(project1),'--machine','machine-of-ideas','--yes',code=1)
 # Collision must never adopt unrelated files.
 installed.parent.mkdir(parents=True,exist_ok=True);installed.write_text('unowned', encoding="utf-8", newline="\n")
 pages([stable]);run('add','--project',posix_path(project1),'--machine','machine-of-ideas',code=1)
 assert installed.read_text()=='unowned'
 # Refuse symlink escape before touching the outside target.
 project3=root/'project symlink';project3.mkdir();outside=root/'outside';outside.mkdir()
 (project3/'.double').symlink_to(outside,target_is_directory=True)
 run('add','--project',posix_path(project3),'--machine','machine-of-ideas',code=1)
 assert not list(outside.iterdir())
 # A copy failure must rollback and leave no successful registry entry.
 project4=root/'project failure';project4.mkdir()
 cp=bindir/'cp';cp.write_text('#!/bin/sh\ncase "$*" in *"project failure"*) exit 1;; esac\nexec /bin/cp "$@"\n', encoding="utf-8", newline="\n");cp.chmod(0o755)
 run('add','--project',posix_path(project4),'--machine','machine-of-ideas',code=1)
 assert not (project4/'.double').exists()
 assert not any(x['project']==posix_path(project4) for x in json.loads(registry.read_text())['installations'])
 cp.unlink()
 # Lock and malformed registry failures must precede mutation.
 lock=root/'state/installer/mutation.lock';lock.mkdir()
 run('remove','--project',posix_path(project2),'--machine','machine-of-ideas','--yes',code=1);lock.rmdir()
 saved=registry.read_text();registry.write_text('{}', encoding="utf-8", newline="\n")
 run('remove','--project',posix_path(project2),'--machine','machine-of-ideas','--yes',code=1)
 registry.write_text(saved, encoding="utf-8", newline="\n")
 rm=bindir/'rm';rm.write_text('#!/bin/sh\ncase \"$*\" in *\"проект два\"*) exit 1;; esac\nexec /bin/rm \"$@\"\n', encoding="utf-8", newline="\n");rm.chmod(0o755)
 run('remove','--project',posix_path(project2),'--machine','machine-of-ideas','--yes',code=1)
 assert (project2/'.double/templates/machine-of-ideas/example.md').read_bytes()==b'machine content'
 assert any(x['project']==posix_path(project2) for x in json.loads(registry.read_text())['installations'])
 rm.unlink()
 run('remove','--project',posix_path(project2),'--machine','machine-of-ideas','--yes')
 assert not (project2/'.double').exists()
 run('remove','--project',posix_path(project1),'--machine','machine-of-goals','--yes')
 assert not (project1/'.double/templates/machine-of-goals').exists()

 # S04: updates preserve modifications, remove obsolete files and track versions.
 a=root/'update A';b=root/'update B';a.mkdir();b.mkdir()
 pages([stable]);run('add','--project',posix_path(a),'--machine','machine-of-ideas');run('add','--project',posix_path(b),'--machine','machine-of-ideas')
 oldpath=a/'.double/templates/machine-of-ideas/example.md';oldpath.write_text('local modified', encoding="utf-8", newline="\n")
 newer=release('1.11.0');package(newer,'.double/templates/machine-of-ideas/new.md');pages([newer])
 run('update','--project',posix_path(a),'--machine','machine-of-ideas','--non-interactive')
 assert not oldpath.exists() and (a/'.double/templates/machine-of-ideas/new.md').exists()
 backups=root/'state/installer/backups';entries=list(backups.glob('backup.*'))
 assert len(entries)==1 and (entries[0]/'old/.double/templates/machine-of-ideas/example.md').read_text()=='local modified'
 run('update','--project',posix_path(a),'--machine','machine-of-ideas','--non-interactive')
 assert len(list(backups.glob('backup.*')))==1
 # No downgrade and no implicit prerelease fallback.
 pages([older]);run('update','--project',posix_path(a),'--machine','machine-of-ideas','--non-interactive')
 pages([rc]);run('update','--project',posix_path(b),'--machine','machine-of-ideas','--non-interactive')
 assert next(x for x in json.loads(registry.read_text())['installations'] if x['project']==posix_path(b))['version']=='1.10.0'
 package(rc);run('update','--project',posix_path(b),'--machine','machine-of-ideas','--channel','rc','--non-interactive')
 assert next(x for x in json.loads(registry.read_text())['installations'] if x['project']==posix_path(b))['channel']=='rc'
 # Backup failure must precede project modification.
 newest=release('3.0.0');package(newest,'.double/templates/machine-of-ideas/newer.md');pages([newest])
 cp=bindir/'cp';cp.write_text('#!/bin/sh\ncase "$*" in *backups/backup.*) exit 1;; esac\nexec /bin/cp "$@"\n', encoding="utf-8", newline="\n");cp.chmod(0o755)
 run('update','--project',posix_path(a),'--machine','machine-of-ideas','--non-interactive',code=1)
 assert (a/'.double/templates/machine-of-ideas/new.md').exists()
 cp.unlink()
 # A failed replacement rolls back while bulk update still updates an independent project.
 cp.write_text('#!/bin/sh\ncase "$*" in *unpacked*"update A"*) exit 1;; esac\nexec /bin/cp "$@"\n', encoding="utf-8", newline="\n");cp.chmod(0o755)
 # Explicit stable override lets B leave its selected rc policy only because version is newer.
 run('update-all','--channel','stable','--non-interactive',code=1)
 assert (a/'.double/templates/machine-of-ideas/new.md').exists()
 assert not (a/'.double/templates/machine-of-ideas/newer.md').exists()
 assert next(x for x in json.loads(registry.read_text())['installations'] if x['project']==posix_path(a))['version']=='1.11.0'
 assert next(x for x in json.loads(registry.read_text())['installations'] if x['project']==posix_path(b))['version']=='3.0.0'
 cp.unlink()
 # Explicit backup cleanup filters by canonical project and requires confirmation.
 run('backups-clean','--project',posix_path(a),code=1)
 run('backups-clean','--project',posix_path(a),'--yes')
 assert all(json.loads((x/'installation.json').read_text())['project']!=posix_path(a) for x in backups.glob('backup.*'))
 assert any(json.loads((x/'installation.json').read_text())['project']==posix_path(b) for x in backups.glob('backup.*'))
 run('backups-clean','--yes');assert not list(backups.glob('backup.*'))
 # Equal numeric version may promote rc to stable without downgrading.
 c=root/'channel promotion';c.mkdir();rc4=release('4.0.0','rc');pages([rc4]);package(rc4)
 run('add','--project',posix_path(c),'--machine','machine-of-ideas','--channel','rc')
 stable4=release('4.0.0');pages([stable4]);package(stable4)
 run('update','--project',posix_path(c),'--machine','machine-of-ideas','--channel','stable','--non-interactive')
 assert next(x for x in json.loads(registry.read_text())['installations'] if x['project']==posix_path(c))['tag']=='machine-of-ideas-4.0.0'

 # S05: isolated crontab adapter. Never call the user's real crontab.
 cron=bindir/'crontab';cronfile=root/'fake-crontab'
 cron.write_text("#!/usr/bin/env python3\nimport os,sys,pathlib,shutil\nroot=pathlib.Path(os.environ['FIXTURE']); table=root/'fake-crontab'\nif os.environ.get('CRON_FAIL'): print('permission denied',file=sys.stderr);sys.exit(1)\nif sys.argv[1:] == ['-l']:\n if not table.exists(): print('no crontab for fixture',file=sys.stderr);sys.exit(1)\n print(table.read_text(),end='')\nelse: shutil.copyfile(sys.argv[1],table)\n", encoding="utf-8", newline="\n");cron.chmod(0o755);native_python_shim(cron)
 unrelated='17 9 * * * echo keep\n';cronfile.write_text(unrelated, encoding="utf-8", newline="\n")
 run('cron-add','--schedule','0 3 * * *')
 initial=cronfile.read_text();assert unrelated in initial and initial.count('# double-installer:')==1
 run('cron-add','--schedule','0 3 * * *');assert cronfile.read_text()==initial
 run('cron-add','--schedule','bad',code=2)
 saved=cronfile.read_text();run('cron-remove',code=1,extra={'CRON_FAIL':'1'});assert cronfile.read_text()==saved
 # Execute the generated command through cron's /bin/sh with a minimal environment.
 line=next(x for x in initial.splitlines() if '# double-installer:' in x)
 command=line.split(' ',5)[5].rsplit(' # double-installer:',1)[0]
 # cron removes escaping before passing literal percent characters to its shell.
 command=command.replace('\\%', '%')
 pages([stable4])
 scheduled=subprocess.run([sh_exe,'-c',command],env={'PATH':'/usr/bin:/bin','FIXTURE':tmp},capture_output=True,text=True,encoding='utf-8')
 assert scheduled.returncode==0,(command,scheduled.stdout,scheduled.stderr)
 run('cron-remove');assert cronfile.read_text()==unrelated
 # Simulate Windows-like no-cron PATH without reaching a host crontab.
 nocron=root/'no cron tools';nocron.mkdir()
 tools='bash python3 curl jq tar awk find sort uniq wc cp mv mkdir rm rmdir mktemp dirname tr cmp basename sha256sum'.split()
 if os.name == 'nt': tools.append('cygpath')
 for tool in tools:
  target=str(fake) if tool=='curl' else fixture_tool(tool)
  assert target,tool
  (nocron/tool).symlink_to(target)
 # PE executables reached through fixture symlinks still need MSYS runtime DLLs.
 # Keep the strict no-crontab PATH: provide DLLs, not the whole /usr/bin.
 if os.name == 'nt':
  for dll in pathlib.Path(bash_exe).parent.glob('*.dll'):
   shutil.copy2(dll,nocron/dll.name)
 assert 'unavailable' in run('doctor',extra={'PATH':str(nocron)})
 run('cron-add','--schedule','0 3 * * *',code=1,extra={'PATH':str(nocron)})
 run('cron-remove',extra={'PATH':str(nocron)})
 run('cron-add','--schedule','0 3 * * *')
 # Full removal requires confirmation and refuses concurrent mutation.
 run('uninstall-all',code=1)
 lock=root/'state/installer/mutation.lock';lock.mkdir()
 run('uninstall-all','--yes',code=1);assert '# double-installer:' in cronfile.read_text();lock.rmdir()
 # Partial cleanup keeps registry and backup state for retry.
 rm=bindir/'rm';rm.write_text('#!/bin/sh\ncase "$*" in *"update A"*) exit 1;; esac\nexec /bin/rm "$@"\n', encoding="utf-8", newline="\n");rm.chmod(0o755)
 run('uninstall-all','--yes',code=1);assert registry.exists() and backups.exists()
 assert cronfile.read_text()==unrelated
 rm.unlink()
 shared=root/'state/other-component';shared.mkdir();(shared/'keep').write_text('shared', encoding="utf-8", newline="\n")
 run('uninstall-all','--yes')
 assert not (root/'state/installer').exists()
 assert (shared/'keep').read_text()=='shared' and sentinel.read_text()=='keep'
 assert installed.read_text()=='unowned'
 assert cronfile.read_text()==unrelated
 for pr in (a,b,c,project2):
  assert not (pr/'.double').exists(),list(pr.rglob('*'))
 print('PASS: idempotent isolated cron, cron read errors, minimal-env scheduled command, confirmation, lock contention, partial uninstall retry, full state cleanup and shared-state preservation')
 print('PASS: newer/no-op/no-downgrade, explicit channels, obsolete files, local-edit backups, backup failure, replacement rollback, partial bulk failure and selective cleanup')
 print('PASS: two-project/two-machine registry, persistent listing, removal confirmation, local edits, collisions, symlink escape, write failure rollback, locking, invalid registry')

print('PASS: channels, numeric ordering, pagination, missing releases, verified cache, duplicate cache, checksum/archive failures, HTTP/JSON errors, usage validation')
PY
