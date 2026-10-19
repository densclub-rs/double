---
id: podman-krunkit-fix-run-interactive-libkrun-20261014T142033Z
kind: plan-run
template-id: plan-run-template
produced-by: machine-of-goals/plan-realization-agent
project-id: double
interaction-language: ru
artifact-language: en
goal-id: podman-krunkit-fix
plan-id: podman-krunkit-fix-plan
plan-revision: 1
artifact-path: ./run/interactive-libkrun--20261014T142033Z.md
plan-revision-artifact: ../realizations/plan-revision-1.md
realization-id: interactive-libkrun-procedure
realization-record-id: interactive-libkrun
realization-artifact: ../realizations/interactive-libkrun.md
realization-revision: 1
selected-paths:
  - path-restore-libkrun
started-at: 2026-10-14T14:20:33Z
finished-at: 2026-10-14T16:00:28Z
result: failed
pinned: no
derived-from:
  - ../realizations/plan-revision-1.md
  - ../realizations/interactive-libkrun.md
---

<a id="podman-krunkit-fix-run-interactive-libkrun-20261014T142033Z"></a>

# Plan Run: libkrun Diagnosis on the Current macOS Host

## 1. Run Context

[Goal](../podman-krunkit-fix.md#podman-krunkit-fix),
[decision](../realizations/decision-interactive-libkrun.md#podman-krunkit-fix-realization-decision),
[baseline](../realizations/plan-revision-1.md#podman-krunkit-fix-plan),
[realization revision 1](../realizations/interactive-libkrun.md#interactive-libkrun-revision-1),
[registry](../plan.md#interactive-libkrun), [path](../path-options.md#path-restore-libkrun).
Actor: Codex. Target: local macOS, existing default libkrun VM; recheck identity.
Approved current scope: read-only diagnosis and repository artifacts only.

## 2. Initial State Validation

Podman 6.1.0 is invocable; no helper install or VM changes performed.

## 3. Plan Map

| Progress | Stage | Status | Validation |
| --- | --- | --- | --- |
| ✅ | [S01](../plan.md#stage-s01) | done | accepted |
| ✅ | [S02A](../plan.md#stage-s02a) | done | accepted |
| ❌ | [S03](../plan.md#stage-s03) | failed | rejected |
| ⚪ | [S04](../plan.md#stage-s04) | not-started | pending |

## 4. Working Log

### Generated Commands for Manual Stage Execution

No commands were delegated for manual human execution. Agent-executed S02A commands are recorded below.


### Executed Commands — S02A — 2026-10-14

Retrospective record transcribed from this chat's tool calls at the user's
request. Only successful commands are included, in actual invocation order; exact per-command
wall-clock timestamps were not retained and are not invented. Working directory:
`/Users/oliver/src/my/de-ns-club/double`. Commands were executed by Codex, not
merely proposed. Web source reads are listed separately after the shell commands.

#### S02A — Command 1: Initial tap/package inventory

```bash
brew tap
brew list --formula --versions krunkit libkrun
rg -n 'S02A|contract-s01' goals/double-installer/podman-krunkit-fix/run/interactive-libkrun--20261014T142033Z.md
```

- Result: no installed tap/formula entries printed; run context found.

#### S02A — Command 2: Add upstream tap

```bash
HOMEBREW_NO_AUTO_UPDATE=1 brew tap slp/krun
```

- Authorization: explicit sandbox approval.
- Result: succeeded; eight formulae tapped. Clone completed before dependency resolution.

#### S02A — Command 3: Capture VM preservation baseline

```bash
python3 - <<'PYCODE'
from pathlib import Path
import hashlib,json
c=Path.home()/'.config/containers/podman/machine/libkrun/podman-machine-default.json';disk=Path(json.loads(c.read_text())['ImagePath']['Path']);st=disk.stat()
data={'machine_config_sha256':hashlib.sha256(c.read_bytes()).hexdigest(),'disk_path':str(disk),'disk_size':st.st_size,'disk_inode':st.st_ino,'disk_mtime_ns':st.st_mtime_ns}
Path('/tmp/double-libkrun-before-install.json').write_text(json.dumps(data))
print('VM configuration hash and disk identity recorded for post-install comparison.')
PYCODE
```

- Result: succeeded; saved configuration hash and disk metadata, not a disk-content backup.

#### S02A — Command 4: Inspect local formulae and trust interface

```bash
rg -n 'class |url |sha256|depends_on|def install|system |post_install|caveats|def caveats|root_url' /opt/homebrew/Library/Taps/slp/homebrew-krun/Formula
brew trust --help
```

- Result: inspected dependency/source declarations and formula-scoped trust support.

#### S02A — Command 5: Grant narrowly scoped formula trust

```bash
brew trust --formula slp/krun/krunkit slp/krun/gvproxy slp/krun/libkrun slp/krun/libkrunfw slp/krun/virglrenderer-krun
```

- Authorization: explicit sandbox approval.
- Result: all five formulae trusted; entire tap was not granted trust.

#### S02A — Command 6: Successful dependency dry-run

```bash
HOMEBREW_NO_AUTO_UPDATE=1 brew install --dry-run slp/krun/krunkit
```

- Authorization: explicit sandbox approval for Homebrew access.
- Result: krunkit 1.3.2 and eight dependencies listed: gvproxy, libyaml, dtc,
  libepoxy, libkrunfw, molten-vk, virglrenderer-krun and libkrun.

#### S02A — Command 7: Install ready-made runtime packages

```bash
HOMEBREW_NO_AUTO_UPDATE=1 HOMEBREW_NO_INSTALL_CLEANUP=1 HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1 brew install --force-bottle slp/krun/krunkit
```

- Authorization: explicit sandbox approval for the calculated installation set.
- Result: succeeded. Installed krunkit 1.3.2 and the eight dependencies; no source
  compilation, Homebrew auto-update or cleanup. Versions recorded in V02 evidence.

#### S02A — Command 8: Verify executable, linkage and VM preservation

```bash
command -v krunkit
krunkit --version
otool -L /opt/homebrew/bin/krunkit
brew list --formula --versions krunkit libkrun gvproxy libkrunfw virglrenderer-krun
python3 - <<'PYCODE'
from pathlib import Path
import hashlib,json
before=json.loads(Path('/tmp/double-libkrun-before-install.json').read_text());c=Path.home()/'.config/containers/podman/machine/libkrun/podman-machine-default.json';d=Path(before['disk_path']);st=d.stat()
after={'machine_config_sha256':hashlib.sha256(c.read_bytes()).hexdigest(),'disk_path':str(d),'disk_size':st.st_size,'disk_inode':st.st_ino,'disk_mtime_ns':st.st_mtime_ns}
assert before==after,(before,after)
print('VM configuration hash and disk identity/size/mtime: unchanged')
PYCODE
```

- Result: `/opt/homebrew/bin/krunkit`, version 1.3.2, libkrun linkage resolved,
  and pre/post configuration hash plus disk inode/size/mtime matched exactly.
- No VM startup, deletion or provider change executed in S02A.

#### S02A — Source retrievals

Read through the web tool during source/dependency inspection:

- [Upstream installation instructions](https://github.com/libkrun/krunkit#installation).
- [krunkit formula](https://raw.githubusercontent.com/slp/homebrew-krun/main/Formula/krunkit.rb).
- [libkrun formula](https://raw.githubusercontent.com/slp/homebrew-krun/main/Formula/libkrun.rb).

Repository artifact edits and diff checks accompanied the stage; they did not
perform additional host installation or VM operations.

### Concise Execution Notes

Registered selected realization and froze baseline before VM diagnosis.

## 5. Stage Contracts and Intermediate Validation

<a id="contract-s01-attempt-1"></a>

### S01 effective contract — attempt 1

- Captured from current S01, baseline revision 1; no change-log adjustments.
- Input: installed Podman; caller's local macOS host and existing VM context.
- Actions: read-only CLI/host/machine/provider/helper/configuration diagnosis.
- Output: target identity, observed running state, missing component and
  existing data/configuration preservation scope.
- Acceptance: V01 from baseline; enough evidence to distinguish missing helper
  from missing VM/already-usable VM. Do not claim data inventory from startup failure.
- Authority: read-only; no installation, startup, deletion or configuration writes.
- Stop: inaccessible evidence, ambiguous identity, or completed stage ready for validation.
- Evidence: versions, machine inspection/listing, helper lookup and configuration paths.
- Result: V01 technical checks passed; awaiting user acceptance.

## 6. Blockers and Deviations

None yet; no prior success reused as current host readiness evidence.

## 7. Final State Validation

Not reached. No VM startup claimed.

## 8. Run Result

Running; registry run count 1, no terminal result yet.

### S01 observed evidence

- Podman 6.1.0 installed via Homebrew; executable `/opt/homebrew/bin/podman`.
- `krunkit` absent from PATH and installed Homebrew formula inventory; `libkrun`
  formula is also absent from that inventory.
- Existing machine configuration identifies `podman-machine-default` in the
  libkrun provider directory. Configured disk exists as a regular non-symlink
  `.raw` file, logical size 107374182400 bytes; this is not evidence that its
  contents are disposable or that the file occupies that amount physically.
- Homebrew Podman bundles gvproxy and vfkit (vfkit v0.6.4); neither is krunkit.
- User `containers.conf` is absent. Existing machine configuration and disk
  must be preserved; no private key contents or disk payload were read.
- Authorized CLI inspection confirms `podman-machine-default` is stopped; 9 CPUs, 2048 MiB memory, 100 GiB disk.
- S01 diagnosis supports S02A: resolve/install krunkit runtime for the existing libkrun VM, preserving configuration and disk. Package installation scope is not yet approved.
- No host changes, package installs, VM start/stop or deletion performed.

<a id="contract-s02a-attempt-1"></a>

### S02A effective contract — attempt 1

- Input: accepted S01; existing stopped libkrun VM with preserved disk/configuration.
- Action: verify upstream package source/dependencies, add the official krunkit
  Homebrew tap if authorized, install the runtime and required dependencies,
  check binary resolution/linked libraries and preserve machine data/configuration.
- Output: usable krunkit/libkrun prerequisites for the selected existing VM.
- Acceptance: V02; executable and dependencies resolve, existing VM is not
  deleted/recreated and provider/default configuration is not silently changed.
- Authority: user accepted S02A preparation. Actual Homebrew writes require
  sandbox approval; no VM startup in this stage, no unrelated upgrades/cleanup.
- Stop: new incompatible dependencies, failed install or output ready for validation.
- Evidence: upstream source, dependency inventory, install result, version/link
  checks, disk/configuration identity before/after.
- Status: dependency/source inspection in progress.

### S02A preparation evidence

- Rechecked upstream installation guidance: `slp/krun` is the recommended tap.
- Authorized tap addition succeeded. No runtime packages installed yet.
- Formula inspection: krunkit 1.3.2 depends on gvproxy and libkrun; libkrun
  1.19.6 additionally references libkrunfw and virglrenderer-krun in this tap.
  Core dependencies and the actual install set still require Homebrew resolution.
- `brew deps` refused untrusted tap formula loading; dry-run also attempted to
  write a Homebrew trust lock outside the sandbox. No bypass was attempted.
- Requested explicit sandbox authorization to trust only the five relevant tap
  formulae, not all tap formulae. Dependency dry-run follows successful trust.
- Saved pre-install machine configuration SHA-256 and disk identity/size/mtime
  under `/tmp/double-libkrun-before-install.json` for preservation comparison.
- VM remains stopped; no startup, deletion, provider or default changes.

- Explicit trust succeeded for krunkit, gvproxy, libkrun, libkrunfw and
  virglrenderer-krun only. Homebrew trust state is a host change.
- Authorized dry-run succeeded: krunkit 1.3.2 plus gvproxy, libyaml, dtc,
  libepoxy, libkrunfw, molten-vk, virglrenderer-krun and libkrun; no existing
  package upgrades listed.
- Requested installation of bottles with Homebrew auto-update, install cleanup
  and installed-dependent checks disabled. No source-build fallback authorized.
  Actual installation result and preservation checks are pending.

### S02A installation and V02 evidence

User authorized the tap, narrowly scoped formula trust, dependency dry-run and
actual bottle installation through sandbox approvals. Installation succeeded
with auto-update, install cleanup and installed-dependent checks disabled.
Installed: krunkit 1.3.2, libkrun 1.19.6, gvproxy 0.8.9, libkrunfw 5.6.2,
virglrenderer-krun 0.10.4e, libyaml 0.2.5, dtc 1.8.1, libepoxy 1.5.10,
molten-vk 1.4.2. No source compilation or unrelated package upgrades reported.

- `command -v krunkit`: `/opt/homebrew/bin/krunkit`.
- `krunkit --version`: `krunkit 1.3.2`, exit 0.
- Dynamic link inspection resolves `/opt/homebrew/opt/libkrun/lib/libkrun.1.dylib`.
- VM configuration SHA-256 and disk inode, logical size and mtime exactly match
  the captured pre-install values. Disk data was not read or changed by checks.
- No VM creation, deletion, provider/default change or startup was performed.
- V02 technical checks passed; S02A awaiting user acceptance. S03 will test
  actual VM startup; installed packages alone do not establish goal success.

<a id="contract-s03-attempt-1"></a>

### S03 effective contract — attempt 1

- Input: user-accepted S02A; installed krunkit/libkrun; existing default libkrun VM.
- Actions: start `podman-machine-default`, inspect its running state and perform
  a non-mutating Linux identity probe if startup succeeds.
- Output/acceptance V03: successful VM startup and observed running state;
  record exact machine/provider and startup result. Linux identity is extra evidence.
- Authority: user explicitly accepted continuation to this startup stage;
  sandbox approval still applies. No recreation, deletion, provider/default change
  or workload/tool installation. Leave a successfully started VM running for caller handoff.
- Stop: startup fails, unexpected identity/scope, or result ready for validation.
- Evidence: actual successful commands, exit status, machine running state and
  optional Linux identity. No success inferred merely from installed packages.
- Status: starting.

### Successful Commands for Reuse and Automation — S03

#### S03 — Successful Command 1: Start the Selected Existing VM

- Purpose: establish a running VM using the repaired libkrun runtime.
- Working context: local macOS host; Podman 6.1.0; existing
  `podman-machine-default`; krunkit 1.3.2/libkrun 1.19.6 installed.

```bash
podman machine start podman-machine-default
```

- Result: exit 0; `Machine "podman-machine-default" started successfully`.
- Replay constraints: host VM-start permission required; resolve the caller's
  actual machine name on reuse, inspect current state, and do not restart an
  already-running VM unnecessarily. No provider change or recreation.
- Execution time: not separately recorded; command order preserved.
- Podman reports rootless mode and its API forwarding socket. Docker default
  socket helper/rootful changes are not required by this goal and were not applied.

#### S03 — Successful Command 2: Inspect State After Initial Startup

- Purpose: independently verify whether the selected machine remained running.
- Working context: local host, same existing VM; read-only Podman inspection.

```bash
podman machine inspect podman-machine-default --format '{{.Name}} {{.State}}'
```

- Result: inspection succeeded and reported `podman-machine-default stopped`.
  This is successful diagnosis, not successful VM readiness. The subsequent
  Linux probe could not execute because the machine was not running.
- Replay constraints: match the invocation's machine name; never equate a
  successful inspection command with a successful running-state criterion.

#### S03 — Successful Command 3: Read Boot Error Diagnostics

- Purpose: identify the reason the subsequent startup did not reach readiness.
- Working context: read-only host log inspection; Python 3 is diagnostic tooling,
  not a Podman VM runtime prerequisite.

```bash
python3 - <<'PY'
from pathlib import Path
import tempfile,re
s=(Path(tempfile.gettempdir())/'podman/podman-machine-default.log').read_text(errors='replace');s=re.sub(r'\x1b\[[0-?]*[ -/]*[@-~]','',s)
lines=[x for x in s.splitlines() if any(w in x.lower() for w in ['error','failed','refusing','already','unique boot','emergency'])]
print('\n'.join(lines[-35:]))
PY
```

- Result: read succeeded; CoreOS Ignition reported failure to create user
  `core`, with `useradd: cannot lock /etc/group; try again later`, then emergency
  mode. This is a new guest initialization blocker, not the missing executable.
- Replay constraints: temporary log location and selected machine vary by host;
  inspect only relevant diagnostics and avoid exposing protected guest data.

### S03 Failure and Validation Status

- Initial startup returned success, but independent verification found the VM
  stopped. Cause of that transition is not established.
- A subsequent same-VM startup with immediate verification did not finish;
  boot logs show the Ignition group-lock failure and emergency mode.
- No guest repair, deletion/recreation, provider switch or rootful/helper change
  was performed. S03/V03 is not passed; package installation does not establish
  the reusable goal's output condition.
- Requested controlled stop of the failed startup before further diagnosis;
  stop result is pending. Failed attempts are summarized here, not retained
  as reusable successful commands.


### Terminal Decision: libkrun Path Unsuccessful for This Invocation

The user explicitly ended this path and selected applehv. S01 and S02A remain
accepted; S03/V03 failed and S04 was not reached. Runtime installation succeeded,
but it did not produce an accepted startable VM. This is an invocation result,
not proof that libkrun cannot work on other hosts.

User-reported follow-up evidence:
- Existing VM: inspect reports running, but start remains pending; boot log
  confirms Ignition cannot create core because useradd cannot lock /etc/group.
- A separately named diagnostic VM, double-libkrun-diag, initialized successfully
  from quay.io/podman/machine-os:6.1 with libkrun, 2 CPUs, 2048 MiB and 20 GiB disk.
- Diagnostic start did not finish; inspect reported stopped, and the supplied
  process inventory contained no krunkit process for this diagnostic VM.
  Therefore the same guest failure was not reproduced or established there.
- Last supplied process inventory: start PID 93319, krunkit PID 93325,
  stop PID 96091, diagnostic start PID 17846. These are historical identifiers,
  not authority to terminate processes without checking their current identity.
- Manual diagnostic and interruption commands were presented in conversation;
  their complete generation history was not captured contemporaneously here.
  No claim is made that suggested interruption commands were executed.

Successful manual action confirmed by output (retrospective):
```bash
podman machine init --provider libkrun --cpus 2 --memory 2048 --disk-size 20 double-libkrun-diag
```
Context: current macOS host, installed Podman. Result: Machine init complete.
Replay: creates persistent VM/storage; do not repeat against an existing name;
requires separately authorized resources. This does not prove startup success.

Run closed at 2026-10-14T16:00:28Z. Process shutdown is NOT confirmed. Closing
this evidence record does not stop the VM or pending commands. Preserve both
VMs, their disks/configuration, and installed packages during the applehv switch.
