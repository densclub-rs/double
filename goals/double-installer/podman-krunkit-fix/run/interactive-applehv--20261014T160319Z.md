---
id: podman-krunkit-fix-run-interactive-applehv--20261014T160319Z
kind: plan-run
template-id: plan-run-template
produced-by: machine-of-goals/plan-realization-agent
project-id: double
interaction-language: ru
artifact-language: en
goal-id: podman-krunkit-fix
plan-id: podman-krunkit-fix-plan
plan-revision: 1
plan-revision-artifact: ../realizations/plan-revision-1.md
realization-id: interactive-applehv-procedure
realization-record-id: interactive-applehv
realization-artifact: ../realizations/interactive-applehv.md
realization-revision: 1
selected-paths:
  - path-applehv
started-at: 2026-10-14T16:03:19Z
finished-at: 2026-10-14T16:14:03Z
result: succeeded
pinned: no
---

<a id="podman-krunkit-fix-run-interactive-applehv--20261014T160319Z"></a>

# Plan Run: Interactive applehv

[Baseline](../realizations/plan-revision-1.md#podman-krunkit-fix-plan),
[realization revision 1](../realizations/interactive-applehv.md#interactive-applehv-revision-1),
[decision](../realization-decision.md#podman-krunkit-fix-realization-decision).

## Invocation Context and S01 Evidence

Retrospective context refresh supplied by the user before this record was
created; no claim of a contemporaneously frozen S01 contract. macOS host,
Podman 6.1.0 from previous inspection; user selected applehv and human execution.
User reports previous machine processes stopped. Latest machine and connection
inventories contain headers only (zero registered entries); vfkit v0.6.4 usable.
Earlier VM registration is absent; cause and on-disk preservation are unknown.
Do not infer deletion of raw disks or attempt recovery/reuse without inspection.
V01 technical refresh complete; user continued by initializing the selected VM.

## Successful Commands for Reuse and Automation — S01

User-reported successful commands, execution times unknown, current macOS cwd
not material (no relative paths); presented and observed in this order:

```bash
podman machine list
/opt/homebrew/opt/podman/libexec/podman/vfkit --version
podman system connection list
```

Results: empty registered-machine inventory; vfkit v0.6.4; empty connection
inventory. Read-only checks, not startup proof. Helper path is host-specific.

## S02B Effective Contract — Attempt 1

Frozen before presenting initialization instructions. Input: installed Podman,
usable vfkit, user-reported stopped old processes, no registered machines or
connections, explicitly selected applehv path. Output: separate VM
`double-applehv`, provider applehv, 2 CPUs, 2048 MiB memory, 20 GiB virtual disk,
default Podman machine-os image source. Download/storage creation permitted
by selected separate-VM path; no old disk/configuration deletion or migration,
package removal, global provider change or explicit default-connection switch.
An initially empty connection registry may acquire its first default as a
Podman initialization effect; inspect and report rather than promise no change.
Stop on init failure, name collision or unexpected existing data overwrite.
V02: successful init plus inspect identity/provider/resources and connections.
Do not start before reviewing S02B result; S03 gets a separate frozen contract.

## Generated Commands for Manual Stage Execution

S02B, generation order 1–3; presented for human execution; subsequent results recorded below.
Run checks 2–3 only after initialization succeeds. Commands require local host
VM/configuration write authority; do not repeat init if the name already exists.

```bash
podman machine init --provider applehv --cpus 2 --memory 2048 --disk-size 20 double-applehv
podman machine inspect double-applehv
podman system connection list
```

## Progress

| Stage | Status | Validation |
| --- | --- | --- |
| S01 | done | accepted by user continuation |
| S02B | done | accepted by user with macOS version scope |
| S03 | done | accepted by user with macOS version scope |
| S04 | done | accepted by user |


## S02B/S03 Observed Results — User-Supplied Evidence

The user independently started the VM after successful initialization, before
S02B review and without a newly frozen S03 contract. Preserve that sequencing
exception explicitly; do not invent a prior stage contract or approval.
Evaluate the result against unchanged baseline S03/V03 requirements.

Successful commands for reuse, actual reported order, shell context macOS
(user home directory for subsequent checks; absolute machine identifiers):

1. Initialize the approved separate VM:
```bash
podman machine init --provider applehv --cpus 2 --memory 2048 --disk-size 20 double-applehv
```
Result: image quay.io/podman/machine-os:6.1 extracted; Machine init complete.
Image blob reported: d92af11c2980615ad1645fd36999f5abb53e4118a7a19fc981fbaccf57de1737.
Replay: new named VM and storage creation; no repeat against an existing name.

2. Start the selected VM (user executed, not previously presented for this run):
```bash
podman machine start double-applehv
```
Result: command returned with Machine "double-applehv" started successfully;
rootless API forwarding socket available. No hanging start reported.
Replay: inspect current state first; do not start/restart an already-running VM.

3. Verify VM identity/state/resources:
```bash
podman machine inspect double-applehv
```
Result: Name double-applehv, State running, configuration directory applehv,
2 CPUs, Memory 2048 MiB, DiskSize 20 GiB, Rootful false, user-mode networking true.
Created 2026-10-14T18:04:56.379878+02:00. LastUp remains zero timestamp in the
supplied output; it is not used as startup evidence. No exact command exit codes
were supplied; success is based on completion messages and supplied outputs.
Replay: read-only inspection; identity paths are references, not key contents.

4. Inspect connection registration:
```bash
podman system connection list
```
Result: double-applehv (core, port 63244) default true; double-applehv-root
(root, same port) default false. Initial registry was empty; first rootless
connection became default. No previous default was observed to be displaced.
Replay: connection ports and socket paths vary by invocation.

V02/V03 technical requirements satisfied by user evidence and accepted by the
user with the macOS version restriction below. Run remains running until S04
handoff and validation. No SSH/container
probe needed for the minimal startup contract. Docker helper installation,
rootful mode, DOCKER_HOST export, and helper-suggested restarts were not needed
or reported as executed. Old libkrun disk preservation remains unverified.


## Accepted Platform Scope

User accepted S02B/S03 and requested version-specific applicability.
Agent-executed successful validation command, current macOS host:
```bash
sw_vers
```
Result (exit 0): macOS 26.6.2, build 25G83. Read-only; on reuse execute on
that invocation's host rather than assuming this result remains applicable.

Verified solution scope: this observed macOS 26.6.2 (25G83) host with Podman
6.1.0, vfkit v0.6.4 and machine-os:6.1. Explicit applehv initialization followed
by completed startup and observed running state succeeded for double-applehv.
No compatibility claim for other macOS versions/builds or other hosts. The
plan remains reusable through fresh inspection and validation; this result
cannot be reused as proof of another invocation's success.


## S04 Effective Contract — Attempt 1

Captured before S04 extraction. User accepted S02B/S03 with OS-version scope
and authorized S04. Input: accepted evidence from this run. Actions: preserve
version-scoped reusable knowledge through Machine of Knowledge, resolve TTL,
record standalone/parent handoff. Output: knowledge and invocation summary with
exact VM/provider/start entry point and evidence; no host mutation. V04: bounded
scope, no unsupported compatibility/workload claims, complete temporal metadata,
and user acceptance. Stop for missing TTL or unaccepted handoff.

## S04 Prepared Handoff

- Input satisfied: installed Podman 6.1.0; no Podman installation needed.
- Output: double-applehv, applehv, rootless, 2 CPUs/2048 MiB/20 GiB,
  completed start and running inspect. Start entry: podman machine start
  double-applehv only when stopped; inspect first on reuse.
- Verified scope: current host, macOS 26.6.2 (25G83), vfkit v0.6.4, machine-os:6.1.
- No caller dependency: another plan can invoke the same procedure with fresh
  context checks; this run's success cannot establish readiness on another host.
- First caller: parent S05R receives startup evidence; S06 owns container/tool
  setup and Linux installer tests, still not executed here.
- Changes: separate VM and initial rootless default connection. Old disk state
  unknown. No Docker helper/rootful change, deletion or migration reported here.
- [Knowledge draft](../../../../knowledge/podman-applehv-macos-26-6-2/podman-applehv-macos-26-6-2.md#podman-applehv-macos-26-6-2)
  is complete with user-selected TTL one year. The VM was not stopped by the
  agent at handoff.


## Final Validation and Closure

User explicitly requested completion of S04 and supplied TTL one year.
V04 accepted: reusable knowledge complete, tested platform scope explicit,
standalone and parent handoff recorded. Run result succeeded; S01/S02B/S03/S04
complete. Finished-at records artifact closure, not a fresh VM state probe.
Knowledge trust horizon: 2026-10-14 through 2027-10-14. Parent S05R receives
accepted startable-VM evidence; S06 Linux installer validation remains pending.
Old VM disk preservation remains unverified; no claim of migration/recovery.
The prior libkrun run remains failed and is not overwritten or reinterpreted.
