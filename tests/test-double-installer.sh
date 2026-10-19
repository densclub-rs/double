#!/usr/bin/env bash
# Isolated S02 release transport tests. No network or live state/cron changes.
set -euo pipefail
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/test-log.sh"
phase_started=$SECONDS
test_log "START installer fixtures"
export PYTHONUTF8=1 PYTHONIOENCODING=utf-8
# Native Python must invoke this Git Bash, never Windows' WSL bash.exe.
if command -v cygpath >/dev/null 2>&1; then
  export DOUBLE_TEST_BASH="$(cygpath -w "$(command -v bash)")"
  export DOUBLE_TEST_SH="$(cygpath -w /bin/sh)"
  export DOUBLE_TEST_CYGPATH="$(cygpath -w "$(command -v cygpath)")"
fi
cd "$(dirname "$0")/.."
python3 - <<'PY'
import hashlib,io,json,os,pathlib,subprocess,tarfile,tempfile,shutil,sys,shlex,time
from datetime import datetime,timezone
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
 case_number=0
 def run(*args,code=0,extra=None):
  global case_number
  case_number+=1
  stamp=lambda: datetime.now(timezone.utc).isoformat(timespec='seconds').replace('+00:00','Z')
  started=time.monotonic()
  print(f'[{stamp()}] START fixture {case_number}: {args[0]} expected_exit={code}',flush=True)
  r=subprocess.run([bash_exe,script,*args],env=dict(env,**(extra or {})),capture_output=True,text=True,encoding='utf-8',timeout=180)
  print(f'[{stamp()}] END fixture {case_number}: {args[0]} exit={r.returncode} elapsed={time.monotonic()-started:.3f}s',flush=True)
  if r.returncode!=code:
   inventory=root/'state/installer/registry.json'
   if inventory.exists(): print(inventory.read_text(),flush=True)
  assert r.returncode==code,(args,r.returncode,r.stdout,r.stderr)
  return r.stdout+r.stderr
 def run_tty(*args,answer='y',code=0):
  import pty
  global case_number
  case_number+=1
  print(f'[{datetime.now(timezone.utc).isoformat(timespec="seconds")}] START interactive fixture {case_number}: {args[0]}',flush=True)
  master,slave=pty.openpty()
  process=subprocess.Popen([bash_exe,script,*args],stdin=slave,stdout=subprocess.PIPE,stderr=subprocess.PIPE,env=env,text=True,encoding='utf-8')
  os.close(slave)
  try:
   os.write(master,(answer+'\n').encode())
   out,err=process.communicate(timeout=180)
  finally:
   os.close(master)
   if process.poll() is None: process.kill();process.wait()
  assert process.returncode==code,(args,process.returncode,out,err)
  print(f'[{datetime.now(timezone.utc).isoformat(timespec="seconds")}] END interactive fixture {case_number}: exit={process.returncode}',flush=True)
  return out+err
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
   import re
   machine_id=re.match(r'(.+)-[0-9]+\.[0-9]+\.[0-9]+',rel['tag_name'])[1]
   skill_path=f'.double/skills/{machine_id}/SKILL.md'
   if info.name!=skill_path and not kind:
    skill=tarfile.TarInfo(skill_path);skill.size=len(data);t.addfile(skill,io.BytesIO(data))
  digest=hashlib.sha256((assets/name).read_bytes()).hexdigest()
  (assets/'SHA256SUMS.txt').write_text(f'{digest}  {name}\n', encoding="utf-8", newline="\n")
 # Informational requests must not invoke network/state-changing command bodies.
 commands=('help','explain','doctor','releases','download','install','add','remove','status','update','update-all','backups-clean','cron-add','cron-remove','uninstall-all')
 guide=run('explain',extra={'HTTP_FAIL':'1'})
 assert 'Double Installer — detailed guide' in guide
 for command in commands:
  assert '\n'+command+'\n' in guide
  help_text=run(command,'--help',extra={'HTTP_FAIL':'1'})
  assert help_text.startswith(command+'\n') and 'Usage:' in help_text
  assert run(command,'--explain',extra={'HTTP_FAIL':'1'})==help_text
  assert '\nDouble Installer' not in help_text
 assert not (root/'state').exists()
 run('unknown','--help',code=2)
 run('explain','unexpected',code=2)
 assert run('uninstall-all','--yes','--help').startswith('uninstall-all\n')
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
 assert 'No downloaded machine archives.' in run('status')
 assert json.loads(run('status','--json'))=={'archives':[],'installations':[]}
 pages([stable,older]);package(stable)
 run('download','--machine','machine-of-ideas')
 cached=root/'state/installer/releases'/stable['tag_name'];assert (cached/stable['assets'][0]['name']).exists()
 status=run('status')
 assert 'Downloaded machine archives:' in status and stable['assets'][0]['name'] in status
 assert '\x1b[' not in status  # Redirected output must remain plain text.
 assert '1.10.0' in status and 'stable' in status and 'No registered installations.' in status
 inventory=json.loads(run('status','--json'))
 assert inventory['installations']==[] and len(inventory['archives'])==1
 assert inventory['archives'][0]=={'machine':'machine-of-ideas','version':'1.10.0','channel':'stable','archive':posix_path(cached/stable['assets'][0]['name'])}


 run('download','--machine','machine-of-ideas',code=1)
 package(older);(assets/'SHA256SUMS.txt').write_text('0'*64+'  '+older['assets'][0]['name']+'\n', encoding="utf-8", newline="\n")
 run('download','--machine','machine-of-ideas','--version','1.9.0',code=1)
 assert not (root/'state/installer/releases'/older['tag_name']).exists()
 for path,kind in [('../escape',None),('.double/templates/other-machine/x.md',None),('.double/templates/machine-of-ideas/link',tarfile.SYMTYPE)]:
  package(older,path,kind);run('download','--machine','machine-of-ideas','--version','1.9.0',code=1)
  assert not (root/'state/installer/releases'/older['tag_name']).exists()
 run('releases',code=1,extra={'HTTP_FAIL':'1'})
 (root/'page1.json').write_text('{}', encoding="utf-8", newline="\n");run('releases',code=1)
 run('list',code=2);run('status','--all',code=2)
 run('download','--version','1.0.0',code=2);run('releases','--channel','bad',code=2)
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
 human_status=run('status')
 assert posix_path(project1) in human_status and posix_path(project2) in human_status
 registered_output=human_status.split('Registered installations:',1)[1]
 assert registered_output.count('    - machine-of-ideas  1.10.0  (stable)')==2
 assert '"files"' not in registered_output and '"project"' not in registered_output and '"integrations"' not in registered_output
 assert '\x1b[' not in human_status

 assert json.loads(run('status','--json'))['installations']==json.loads(registry.read_text())['installations']
 run('status','--json','--json',code=2)
 run('add','--project',posix_path(project1),'--machine','machine-of-ideas')
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
 rm=bindir/'rm';rm.write_text('#!/bin/sh\ncase \"$*\" in -f*\"проект два\"*) exit 1;; esac\nexec /bin/rm \"$@\"\n', encoding="utf-8", newline="\n");rm.chmod(0o755)
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
 extra=a/'.double/templates/machine-of-ideas/local/nested.txt';extra.parent.mkdir();extra.write_text('extra nested')
 oldpath=a/'.double/templates/machine-of-ideas/example.md';oldpath.write_text('local modified', encoding="utf-8", newline="\n")
 newer=release('1.11.0');package(newer,'.double/templates/machine-of-ideas/new.md');pages([newer])
 run('update','--project',posix_path(a),'--machine','machine-of-ideas','--non-interactive')
 assert not oldpath.exists() and (a/'.double/templates/machine-of-ideas/new.md').exists()
 backups=root/'state/installer/backups';entries=list(backups.glob('backup.*'))
 assert len(entries)==1 and (entries[0]/'old/.double/templates/machine-of-ideas/example.md').read_text()=='local modified'
 assert (entries[0]/'old/.double/templates/machine-of-ideas/local/nested.txt').read_text()=='extra nested'
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
 run('add','--yes','--project',posix_path(c),'--machine','machine-of-ideas','--channel','rc')
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
 tools='cat bash python3 curl jq tar awk find sort uniq wc cp mv mkdir rm rmdir mktemp dirname tr cmp basename sha256sum'.split()
 if os.name == 'nt': tools.append('cygpath')
 for tool in tools:
  target=str(fake) if tool=='curl' else fixture_tool(tool)
  assert target,tool
  if os.name == 'nt' and tool == 'jq':
   # Chocolatey shim launchers resolve companion metadata relative to argv[0].
   # Invoke the original launcher path instead of relocating it via a symlink.
   (nocron/tool).write_text('#!/bin/sh\nexec '+shlex.quote(posix_path(target))+' "$@"\n',encoding='utf-8',newline='\n')
   (nocron/tool).chmod(0o755)
  else:
   (nocron/tool).symlink_to(target)
 # PE executables reached through fixture symlinks still need MSYS runtime DLLs.
 # Keep the strict no-crontab PATH: provide DLLs, not the whole /usr/bin.
 if os.name == 'nt':
  for dll in pathlib.Path(bash_exe).parent.glob('*.dll'):
   shutil.copy2(dll,nocron/dll.name)
 if os.name == 'nt':
  probe=subprocess.run([bash_exe,'-c','set -e; jq --version; cygpath -w "$1"','--',env['DOUBLE_STATE_DIR']],env=dict(env,PATH=str(nocron)),capture_output=True,text=True,encoding='utf-8')
  assert probe.returncode==0,('native no-cron fixture startup',probe.stdout,probe.stderr)
 assert 'unavailable' in run('doctor',extra={'PATH':str(nocron)})
 run('cron-add','--schedule','0 3 * * *',code=1,extra={'PATH':str(nocron)})
 run('cron-remove',extra={'PATH':str(nocron)})
 run('cron-add','--schedule','0 3 * * *')
 # Full removal requires confirmation and refuses concurrent mutation.
 run('uninstall-all',code=1)
 lock=root/'state/installer/mutation.lock';lock.mkdir()
 run('uninstall-all','--yes',code=1);assert '# double-installer:' in cronfile.read_text();lock.rmdir()
 # Partial cleanup keeps registry and backup state for retry.
 rm=bindir/'rm';rm.write_text('#!/bin/sh\ncase "$*" in -f*"update A"*) exit 1;; esac\nexec /bin/rm "$@"\n', encoding="utf-8", newline="\n");rm.chmod(0o755)
 run('uninstall-all','--yes',code=1);assert registry.exists() and backups.exists()
 assert cronfile.read_text()==unrelated
 rm.unlink()
 shared=root/'state/other-component';shared.mkdir();(shared/'keep').write_text('shared', encoding="utf-8", newline="\n")
 run('uninstall-all','--yes')
 assert not (root/'state/installer').exists()
 assert (shared/'keep').read_text()=='shared' and sentinel.read_text()=='keep'
 assert installed.read_text()=='unowned'
 assert cronfile.read_text()==unrelated
 assert extra.read_text()=='extra nested' # Removal preserves uninventoried files.
 for pr in (b,c,project2):
  assert not (pr/'.double').exists(),list(pr.rglob('*'))
 print('PASS: idempotent isolated cron, cron read errors, minimal-env scheduled command, confirmation, lock contention, partial uninstall retry, full state cleanup and shared-state preservation')
 print('PASS: newer/no-op/no-downgrade, explicit channels, obsolete files, local-edit backups, backup failure, replacement rollback, partial bulk failure and selective cleanup')
 print('PASS: two-project/two-machine registry, persistent listing, removal confirmation, local edits, collisions, symlink escape, write failure rollback, locking, invalid registry')

 # Approved extension: alias, all-channel priority and global integrations.
 home=root/'isolated home';home.mkdir()
 env.update(HOME=posix_path(home),CODEX_HOME=posix_path(home/'.codex'),CLAUDE_CONFIG_DIR=posix_path(home/'.claude'),PATH=str(nocron))
 # Doctor inventories eight agents using evidence only; never launch their CLIs.
 agent_ids=('codex','claude','cursor','copilot','gemini','opencode','cascade','pi')
 def agent_line(output,identifier):
  return next(line.strip() for line in output.splitlines() if line.strip().startswith(identifier+' '))
 empty_doctor=run('doctor')
 for identifier in agent_ids: assert agent_line(empty_doctor,identifier)
 assert 'NOT FOUND' in agent_line(empty_doctor,'gemini')
 assert 'NOT FOUND' in agent_line(empty_doctor,'pi')
 custom=root/'doctor config spaces'
 settings={'CODEX_HOME':posix_path(custom/'codex'),'CLAUDE_CONFIG_DIR':posix_path(custom/'claude'),'COPILOT_HOME':posix_path(custom/'copilot'),'XDG_CONFIG_HOME':posix_path(custom/'xdg'),'PI_CODING_AGENT_DIR':posix_path(custom/'pi')}
 config_dirs=[custom/'codex',custom/'claude',custom/'copilot',custom/'xdg/opencode',custom/'xdg/devin',custom/'pi',home/'.cursor',home/'.gemini']
 for directory in config_dirs: directory.mkdir(parents=True)
 (custom/'copilot/token').write_text('DOCTOR_MUST_NOT_READ_CREDENTIALS')
 config_doctor=run('doctor',extra=settings)
 for identifier in agent_ids:
  line=agent_line(config_doctor,identifier)
  assert 'DETECTED' in line and 'config:' in line,(identifier,line)
 assert 'DOCTOR_MUST_NOT_READ_CREDENTIALS' not in config_doctor
 for directory in (custom,home/'.cursor',home/'.gemini'): shutil.rmtree(directory)
 binaries=('codex','claude','cursor-agent','copilot','gemini','opencode','windsurf','pi')
 for name in binaries:
  tool=nocron/name
  tool.write_text('#!/bin/sh\nprintf called >> "$DOCTOR_AGENT_MARKER"\nexit 99\n',encoding='utf-8',newline='\n');tool.chmod(0o755)
 marker=root/'doctor agent executed'
 cli_doctor=run('doctor',extra={'DOCTOR_AGENT_MARKER':posix_path(marker)})
 for identifier in agent_ids: assert 'CLI:' in agent_line(cli_doctor,identifier)
 assert not marker.exists()
 for name in binaries: (nocron/name).unlink()
 extension=home/'.vscode/extensions/github.copilot-chat-1.0.0';extension.mkdir(parents=True)
 extension_doctor=run('doctor')
 assert 'extension:' in agent_line(extension_doctor,'copilot')
 shutil.rmtree(home/'.vscode')
 assert not (root/'state/installer').exists(), 'doctor must not create installer state'

 def fixtures(items):
  pages(items)
  for rel in items:
   if rel['assets'][0]['name'].endswith('.tar.gz'):
    machine=rel['tag_name'].rsplit('-',1)[0] if not rel['prerelease'] else rel['tag_name'].rsplit('-',2)[0]
    # Machine identifier is known from the version separator, not channel text.
    import re
    machine=re.match(r'(.+)-[0-9]+\.[0-9]+\.[0-9]+',rel['tag_name'])[1]
    package(rel,f'.double/skills/{machine}/SKILL.md')
  sums=[]
  for archive in assets.glob('*.tar.gz'):
   sums.append(hashlib.sha256(archive.read_bytes()).hexdigest()+'  '+archive.name)
  (assets/'SHA256SUMS.txt').write_text('\n'.join(sums)+'\n',encoding='utf-8',newline='\n')
 stable=release('10.2.0');older=release('10.1.0');rc=release('20.0.0','rc')
 goals=release('2.0.0','rc','machine-of-goals');goalsdev=release('9.0.0','dev','machine-of-goals')
 know=release('1.0.0','dev','machine-of-knowledge')
 installer=release('0.1.1','rc','double-installer');installer['assets'][0]['name']='double-installer.sh'
 fixtures([stable,older,rc,goals,goalsdev,know,installer])
 run('install')
 run('download','--machine','machine-of-ideas',code=1)
 run('download');run('download','--all');run('install','--all')
 status=run('status')
 for release_item in (stable,goals,know):
  assert release_item['assets'][0]['name'] in status
 assert 'CHANNEL' in status and 'ARCHIVE' in status
 assert any('machine-of-goals' in line and 'rc' in line for line in status.splitlines())
 assert any('machine-of-knowledge' in line and 'dev' in line for line in status.splitlines())
 assert 'double-installer.sh' not in status

 cached_archive=root/'state/installer/releases'/stable['tag_name']/stable['assets'][0]['name']
 original_archive=cached_archive.read_bytes();cached_archive.write_bytes(b'corrupt')
 run('download','--all',code=1);assert cached_archive.read_bytes()==b'corrupt'
 cached_archive.write_bytes(original_archive)
 cache=root/'state/installer/releases'
 assert {x.name for x in cache.iterdir()}=={stable['tag_name'],goals['tag_name'],know['tag_name']}
 run('download','--all','--channel','rc',code=2)
 run('download','--all','--machine','machine-of-ideas',code=2)
 run('releases','--all',code=2)
 run('add','--yes','--global') # Shared registration needs no installed CLI/config.
 assert all([i['agent'] for i in row['integrations']]==['shared'] for row in json.loads(registry.read_text())['installations'])
 assert not (home/'.claude').exists()
 # Explicit Codex and shared registration may own the same physical file.
 run('add','--yes','--global','--agent','codex','--machine','machine-of-ideas')
 common=home/'.agents/skills/machine-of-ideas/SKILL.md'
 run('remove','--global','--agent','codex','--machine','machine-of-ideas','--yes')
 assert common.exists()
 commonrow=next(x for x in json.loads(registry.read_text())['installations'] if x['machine']=='machine-of-ideas')
 assert [i['agent'] for i in commonrow['integrations']]==['shared']
 run('uninstall-all','--yes')
 (home/'.codex').mkdir();(home/'.claude').mkdir()
 if os.name!='nt':
  # A real terminal input exercises consent instead of assuming piped text is consent.
  declined=root/'interactive declined';declined.mkdir()
  output=run_tty('add','--project',posix_path(declined),'--machine','machine-of-ideas',answer='n')
  assert 'Add integrations for all detected agents?' in output and 'Claude Code' in output
  assert (declined/'.agents/skills/machine-of-ideas/SKILL.md').exists() and not (declined/'.claude').exists()
  run('remove','--project',posix_path(declined),'--machine','machine-of-ideas','--yes')
  accepted=root/'interactive accepted';accepted.mkdir()
  output=run_tty('add','--project',posix_path(accepted),'--machine','machine-of-ideas')
  assert (accepted/'.agents/skills/machine-of-ideas/SKILL.md').exists() and (accepted/'.claude/skills/machine-of-ideas/SKILL.md').exists()
  accepted_row=next(x for x in json.loads(registry.read_text())['installations'] if x['project']==posix_path(accepted))
  assert {i['agent'] for i in accepted_row['integrations']}=={'shared','claude'}
  run('remove','--project',posix_path(accepted),'--machine','machine-of-ideas','--yes')
  explicit=root/'interactive explicit';explicit.mkdir()
  output=run_tty('add','--project',posix_path(explicit),'--machine','machine-of-ideas','--agent','claude')
  assert 'Add integrations for all detected agents?' not in output
  assert not (explicit/'.agents').exists() and (explicit/'.claude/skills/machine-of-ideas/SKILL.md').exists()
  run('remove','--project',posix_path(explicit),'--machine','machine-of-ideas','--yes')
  output=run_tty('add','--global','--machine','machine-of-ideas')
  assert output.count('Add integrations for all detected agents?')==1
  assert (home/'.agents/skills/machine-of-ideas/SKILL.md').exists() and (home/'.claude/skills/machine-of-ideas/SKILL.md').exists()
  run('remove','--global','--machine','machine-of-ideas','--yes')

 # Project-local agent installation, explicit targeting and scope isolation.
 local1=root/'agent project one';local2=root/'agent project two'
 local1.mkdir();local2.mkdir()
 run('add','--project',posix_path(local1),'--machine','machine-of-ideas')
 assert (local1/'.agents/skills/machine-of-ideas/SKILL.md').exists()
 assert not (local1/'.claude').exists()
 run('add','--project',posix_path(local1),'--machine','machine-of-ideas','--agent','claude')
 assert not (home/'.agents/skills/machine-of-ideas/SKILL.md').exists()
 localrow=json.loads(registry.read_text())['installations'][0]
 assert localrow['scope']=='project' and {i['agent'] for i in localrow['integrations']}=={'shared','claude'}
 run('add','--project',posix_path(local1),'--machine','machine-of-ideas','--agent','codex')
 assert len(json.loads(registry.read_text())['installations'][0]['integrations'])==3
 run('add','--project',posix_path(local2),'--machine','machine-of-ideas','--agent','codex')
 assert (local2/'.agents/skills/machine-of-ideas/SKILL.md').exists()
 assert not (local2/'.claude').exists()
 sentinel=local1/'.agents/skills/foreign';sentinel.mkdir();(sentinel/'SKILL.md').write_text('keep')
 run('remove','--project',posix_path(local1),'--machine','machine-of-ideas','--yes')
 assert not (local1/'.claude').exists() and (sentinel/'SKILL.md').read_text()=='keep'
 assert (local2/'.agents/skills/machine-of-ideas/SKILL.md').exists()
 run('remove','--project',posix_path(local2),'--machine','machine-of-ideas','--yes')
 assert not (local2/'.agents').exists()
 # Foreign local skills are rejected before payload installation.
 collision=local2/'.claude/skills/machine-of-ideas';collision.mkdir(parents=True)
 (collision/'SKILL.md').write_text('foreign')
 run('add','--project',posix_path(local2),'--machine','machine-of-ideas','--agent','claude',code=1)
 assert (local2/'.double').exists() and (collision/'SKILL.md').read_text()=='foreign'
 run('remove','--project',posix_path(local2),'--machine','machine-of-ideas','--yes')
 shutil.rmtree(local2/'.claude')
 run('update','--global',code=1) # Global update cannot perform first installation.
 # Failure on the second agent preserves payload and first successful registration.
 local3=root/'rollback project';local3.mkdir();before_registry=registry.read_bytes()
 cptool=nocron/'cp';cptarget=cptool.readlink();cptool.unlink()
 cptool.write_text('#!/bin/sh\nfor target do :; done\ncase "$target" in *"rollback project/.claude/skills/"*) printf damaged > "$target";exit 1;; esac\nexec /bin/cp "$@"\n',encoding='utf-8',newline='\n');cptool.chmod(0o755)
 if os.name!='nt':
  run_tty('add','--project',posix_path(local3),'--machine','machine-of-ideas',code=1)
 else:
  run('add','--project',posix_path(local3),'--machine','machine-of-ideas')
  run('add','--project',posix_path(local3),'--machine','machine-of-ideas','--agent','claude',code=1)
 assert (local3/'.agents/skills/machine-of-ideas/SKILL.md').exists()
 assert not (local3/'.claude').exists() and (local3/'.double').exists()
 partial=next(x for x in json.loads(registry.read_text())['installations'] if x['project']==posix_path(local3))
 assert [x['agent'] for x in partial['integrations']]==['shared']
 cptool.unlink();cptool.symlink_to(cptarget)
 run('add','--project',posix_path(local3),'--machine','machine-of-ideas','--agent','claude')
 assert (local3/'.claude/skills/machine-of-ideas/SKILL.md').exists()
 run('remove','--project',posix_path(local3),'--machine','machine-of-ideas','--yes')
 # A first-agent failure must not prevent registering the following agent.
 local4=root/'continue project';local4.mkdir()
 cptool.unlink()
 cptool.write_text('#!/bin/sh\nfor target do :; done\ncase "$target" in *"continue project/.agents/skills/"*) printf damaged > "$target";exit 1;; esac\nexec /bin/cp "$@"\n',encoding='utf-8',newline='\n');cptool.chmod(0o755)
 run('add','--project',posix_path(local4),'--machine','machine-of-ideas',code=1)
 assert not (local4/'.agents').exists()
 run('add','--project',posix_path(local4),'--machine','machine-of-ideas','--agent','claude')
 assert (local4/'.claude/skills/machine-of-ideas/SKILL.md').exists()
 cptool.unlink();cptool.symlink_to(cptarget)
 run('remove','--project',posix_path(local4),'--machine','machine-of-ideas','--yes')



 run('add','--yes','--global','--agent','codex')
 run('add','--yes','--global','--agent','claude')
 data=json.loads(registry.read_text())['installations']
 assert len(data)==3 and all(x['scope']=='global' for x in data)
 assert all({a['agent'] for a in x['integrations']}=={'codex','claude'} for x in data)
 skills=[home/d/'skills'/m/'SKILL.md' for d in ('.agents','.claude') for m in ('machine-of-ideas','machine-of-goals','machine-of-knowledge')]
 assert all(p.exists() and 'active project' in p.read_text() for p in skills)
 run('add','--yes','--global','--agent','codex')
 run('add','--yes','--global','--agent','claude')
 run('update','--global')
 assert not backups.exists(), 'No-op global update must not generate backups'
 skill_extra=home/'.agents/skills/machine-of-ideas/local/nested.txt';skill_extra.parent.mkdir();skill_extra.write_text('extra skill contents')
 edited=home/'.agents/skills/machine-of-ideas/SKILL.md';edited.write_text('local skill edit',encoding='utf-8',newline='\n')
 run('add','--yes','--global','--agent','codex','--machine','machine-of-ideas')
 assert any((x/'old/skills/machine-of-ideas/SKILL.md').exists() and (x/'old/skills/machine-of-ideas/SKILL.md').read_text()=='local skill edit' for x in backups.glob('backup.*'))
 assert any((x/'old/skills/machine-of-ideas/local/nested.txt').exists() and (x/'old/skills/machine-of-ideas/local/nested.txt').read_text()=='extra skill contents' for x in backups.glob('backup.*'))
 shutil.rmtree(skill_extra.parent)
 assert all(len(x['integrations'])==2 for x in json.loads(registry.read_text())['installations'])
 # Global records use priority again when bulk update runs; no downgrade.
 newer=release('10.3.0');goals_stable=release('2.0.0',machine='machine-of-goals');know_rc=release('1.0.0','rc','machine-of-knowledge')
 fixtures([newer,goals_stable,know_rc])
 run('update-all','--non-interactive')
 assert next(x for x in json.loads(registry.read_text())['installations'] if x['machine']=='machine-of-ideas')['version']=='10.3.0'
 assert next(x for x in json.loads(registry.read_text())['installations'] if x['machine']=='machine-of-goals')['tag']==goals_stable['tag_name']
 assert next(x for x in json.loads(registry.read_text())['installations'] if x['machine']=='machine-of-knowledge')['tag']==know_rc['tag_name']
 run('remove','--global','--agent','codex','--machine','machine-of-ideas',code=1)
 assert edited.exists()
 run('remove','--global','--agent','codex','--machine','machine-of-ideas','--yes')
 assert not edited.exists() and (home/'.claude/skills/machine-of-ideas/SKILL.md').exists()
 assert next(x for x in json.loads(registry.read_text())['installations'] if x['machine']=='machine-of-ideas')['integrations'][0]['agent']=='claude'
 run('remove','--global','--machine','machine-of-ideas','--yes')
 assert not (home/'.claude/skills/machine-of-ideas').exists()
 foreign=home/'.agents/skills/foreign';foreign.mkdir();(foreign/'SKILL.md').write_text('keep',encoding='utf-8',newline='\n')
 run('uninstall-all','--yes')
 assert not (root/'state/installer').exists()
 assert (foreign/'SKILL.md').read_text()=='keep'
 assert not (home/'.claude/skills').exists()
 assert not any(p.exists() for p in skills)
 # Explicit agent doesn't discover/install the other one; foreign collision fails safely.
 collision=home/'.agents/skills/machine-of-ideas';collision.mkdir();(collision/'SKILL.md').write_text('foreign',encoding='utf-8',newline='\n')
 run('add','--global','--agent','codex','--machine','machine-of-ideas',code=1)
 assert (collision/'SKILL.md').read_text()=='foreign'
 assert registry.exists()  # Payload is retained despite the agent collision.
 run('remove','--global','--machine','machine-of-ideas','--yes')
 shutil.rmtree(collision)
 outside=root/'outside agent';outside.mkdir();(outside/'SKILL.md').write_text('outside',encoding='utf-8',newline='\n')
 collision.symlink_to(outside,target_is_directory=True)
 run('add','--global','--agent','codex','--machine','machine-of-ideas',code=1)
 assert (outside/'SKILL.md').read_text()=='outside' and registry.exists()
 run('remove','--global','--machine','machine-of-ideas','--yes')
 collision.unlink()
 run('add','--yes','--global','--agent','claude','--machine','machine-of-ideas')
 assert not (home/'.agents/skills/machine-of-ideas').exists()
 run('uninstall-all','--yes')
 # Shared default ignores CLI presence; explicit adapters never execute agents.
 shutil.rmtree(home/'.codex');shutil.rmtree(home/'.claude')
 for name in ('codex','claude'):
  exe=nocron/name;exe.write_text('#!/bin/sh\nexit 99\n',encoding='utf-8',newline='\n');exe.chmod(0o755)
 run('add','--yes','--global','--agent','codex','--machine','machine-of-ideas')
 run('add','--yes','--global','--agent','claude','--machine','machine-of-ideas')
 assert {x['agent'] for x in json.loads(registry.read_text())['installations'][0]['integrations']}=={'codex','claude'}
 # Agent entry-point write failure restores exact user edits and registry.
 saved=registry.read_bytes()
 skill=home/'.agents/skills/machine-of-ideas/SKILL.md'
 skill.write_text('preserve this skill edit',encoding='utf-8',newline='\n')
 cattool=nocron/'cat';cattarget=cattool.readlink();cattool.unlink()
 cattool.write_text('#!/bin/sh\nprintf damaged\nexit 1\n',encoding='utf-8',newline='\n');cattool.chmod(0o755)
 run('add','--global','--agent','codex','--machine','machine-of-ideas',code=1)
 assert skill.read_text()=='preserve this skill edit' and registry.read_bytes()==saved
 cattool.unlink();cattool.symlink_to(cattarget)
 # A partial destination write must be rolled back, not merely rejected early.
 cptool=nocron/'cp';cptarget=cptool.readlink();cptool.unlink()
 cptool.write_text('#!/bin/sh\nfor target do :; done\ncase "$target" in *"/.agents/skills/machine-of-ideas/SKILL.md")\n if [ ! -f "$DOUBLE_STATE_DIR/installer/copy-fault" ];then : > "$DOUBLE_STATE_DIR/installer/copy-fault";printf damaged > "$target";exit 1;fi;; esac\nexec /bin/cp "$@"\n',encoding='utf-8',newline='\n');cptool.chmod(0o755)
 run('add','--global','--agent','codex','--machine','machine-of-ideas',code=1)
 assert skill.read_text()=='preserve this skill edit' and registry.read_bytes()==saved
 cptool.unlink();cptool.symlink_to(cptarget)
 # Failure removing a later agent retains the earlier successful detach.
 rmtool=nocron/'rm';rmtarget=rmtool.readlink();rmtool.unlink()
 rmtool.write_text('#!/bin/sh\ncase "$*" in -f*".claude/skills/"*) exit 1;; esac\nexec /bin/rm "$@"\n',encoding='utf-8',newline='\n');rmtool.chmod(0o755)
 run('remove','--global','--machine','machine-of-ideas','--yes',code=1)
 assert not skill.exists()
 assert [i['agent'] for i in json.loads(registry.read_text())['installations'][0]['integrations']]==['claude']
 assert (home/'.claude/skills/machine-of-ideas/SKILL.md').exists()
 rmtool.unlink();rmtool.symlink_to(rmtarget)
 run('add','--yes','--global','--agent','codex','--machine','machine-of-ideas')
 saved=registry.read_bytes()
 # Tampered external inventory cannot escape into unrelated files.
 corrupt=json.loads(saved);corrupt['installations'][0]['integrations'][0]['file']='../keep'
 registry.write_text(json.dumps(corrupt),encoding='utf-8',newline='\n')
 run('uninstall-all','--yes',code=1)
 assert skill.exists() and (foreign/'SKILL.md').read_text()=='keep'
 registry.write_bytes(saved)
 run('uninstall-all','--yes')
 assert not (root/'state/installer').exists()
 # Default add fallback and manual adoption are explicit, directory-scoped actions.
 run('uninstall-all','--yes')
 onlyrc=release('3.0.0','rc','machine-of-goals')
 onlydev=release('99.0.0','dev','machine-of-goals')
 fixtures([onlyrc,onlydev])
 manual=root/'manual adoption';manual.mkdir()
 manualfile=manual/'.double/templates/machine-of-goals/custom/nested.txt'
 manualfile.parent.mkdir(parents=True);manualfile.write_text('manual nested')
 obsolete=manual/'.double/obsolete/machine-of-goals/extra.txt';obsolete.parent.mkdir(parents=True);obsolete.write_text('obsolete manual')
 other=manual/'.double/templates/other-machine/keep.txt';other.parent.mkdir(parents=True);other.write_text('keep other')
 run('add','--project',posix_path(manual),'--machine','machine-of-goals','--agent','codex',code=1)
 assert manualfile.read_text()=='manual nested'
 if os.name!='nt':
  output=run_tty('add','--project',posix_path(manual),'--machine','machine-of-goals','--agent','codex',answer='n',code=1)
  assert 'Selected prerelease:' in output and manualfile.exists()
  output=run_tty('add','--project',posix_path(manual),'--machine','machine-of-goals','--agent','codex',answer='y\nn',code=1)
  assert 'Unregistered machine found:' in output and manualfile.exists()
  output=run_tty('add','--project',posix_path(manual),'--machine','machine-of-goals','--agent','codex',answer='y\ny\nn')
 else:
  output=run('add','--project',posix_path(manual),'--machine','machine-of-goals','--agent','codex','--yes')
 assert not manualfile.exists() and not obsolete.exists() and other.read_text()=='keep other'
 adopted=next(x for x in json.loads(registry.read_text())['installations'] if x['project']==posix_path(manual))
 assert adopted['channel']=='rc' and adopted['version']=='3.0.0'
 adoptedbackup=next(x for x in backups.glob('backup.*') if json.loads((x/'installation.json').read_text()).get('source')=='manual')
 assert (adoptedbackup/'old/.double/templates/machine-of-goals/custom/nested.txt').read_text()=='manual nested'
 assert (adoptedbackup/'old/.double/obsolete/machine-of-goals/extra.txt').read_text()=='obsolete manual'
 # Rollback after a replacement copy fails restores complete manual directories.
 failed=root/'manual failed';failed.mkdir()
 original=failed/'.double/skills/machine-of-goals/local/nested.txt';original.parent.mkdir(parents=True);original.write_text('restore all')
 cptool=nocron/'cp'
 if cptool.exists() or cptool.is_symlink():cptool.unlink()
 cptool.write_text('#!/bin/sh\ncase "$*" in *unpacked*"manual failed"*) exit 1;; esac\nexec /bin/cp "$@"\n',encoding='utf-8',newline='\n');cptool.chmod(0o755)
 run('add','--project',posix_path(failed),'--machine','machine-of-goals','--agent','codex','--yes',code=1)
 assert original.read_text()=='restore all'
 assert not any(x['project']==posix_path(failed) for x in json.loads(registry.read_text())['installations'])
 cptool.unlink();cptool.symlink_to(cptarget)
 run('uninstall-all','--yes')
 fixtures([onlydev])
 devproject=root/'dev fallback';devproject.mkdir()
 run('add','--project',posix_path(devproject),'--machine','machine-of-goals','--yes')
 assert json.loads(registry.read_text())['installations'][0]['channel']=='dev'
 run('uninstall-all','--yes')
 print('PASS: prerelease consent, rc-before-dev fallback, manual adoption consent, whole-directory backup and rollback')
 print('PASS: install alias, priority bulk downloads, verified cache, global agent discovery, registry, backup, updates, explicit targeting and clean removal')

print('PASS: channels, numeric ordering, pagination, missing releases, verified cache, duplicate cache, checksum/archive failures, HTTP/JSON errors, usage validation')
PY

test_log "END installer fixtures; elapsed=$((SECONDS-phase_started))s"
