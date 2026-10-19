---
id: podman-krunkit-fix-plan
kind: plan-artifact
template-id: plan-template
project-id: double
produced-by: machine-of-goals/plan-synthesis-agent
interaction-language: ru
artifact-language: en
goal-id: podman-krunkit-fix
goal-artifact: ./podman-krunkit-fix.md
path-options-artifact: ./path-options.md
plan-artifact: ./plan.md
goal-scope: subgoal
parent-goal-id: double-installer
parent-plan-artifact: ../plan.md
plan-execution-style: single-pass
plan-revision: 1
plan-revision-artifact: ./realizations/plan-revision-1.md
created-at: 2026-10-14T14:16:53Z
updated-at: 2026-10-14T16:00:28Z
derived-from:
  - ./podman-krunkit-fix.md
  - ./path-options.md
---

<a id="podman-krunkit-fix-plan"></a>

# Plan: Reusable Podman VM Startup

## 1. Plan Summary

Transform an installed Podman into a verified startable VM through invocation
inspection, one reviewed provider/runtime path, startup validation, and a
portable result handoff. Reuse the same plan independently or as a subplan.

- Goal: [Podman krunkit Fix](./podman-krunkit-fix.md#podman-krunkit-fix).
- Paths: [Path options](./path-options.md#podman-krunkit-fix-path-options).
- First parent: [Double Installer](../plan.md#double-installer-plan), entering
  at [S05R](../plan.md#stage-s05r) and returning to [S06](../plan.md#stage-s06).
- User selected applehv after the libkrun run failed at startup. Existing VMs
  and disks remain preserved; no deletion or global default change authorized.

### Current State

Input contract: Podman is installed. Machine/provider, host, data ownership,
and current running state are invocation context, checked for each run.
An existing VM is optional. The first observed case is Podman 6.1.0 on macOS
with a stopped libkrun VM and unavailable `krunkit`; recheck before action.

### Target State

The selected VM can start and is observed running. Return its machine name,
provider, host, startup invocation, and evidence. An already-running suitable
machine is a successful no-repair outcome without a forced restart.

### Success Criteria

- Installed Podman is verified; startup succeeds or a suitable running VM is
  confirmed; the result identifies exactly which VM satisfies the contract.
- Existing VM data/configuration and unrelated workloads remain preserved.
- The procedure accepts a new host/machine context on each application and
  does not depend on Double Installer, one default machine name, or old success.
- Caller-specific tools and workload tests are outside the required output.

## 2. State Validation Contract

- Initial checks V01: executable/version, OS/architecture, machine inventory,
  selected machine/provider, running state, helper resolution and data scope.
  Missing Podman is a precondition failure, not an instruction to install it.
- Intermediate checks V02: chosen provider's helper/runtime is usable; existing
  VM/configuration preserved; any new machine is identified and caller approved.
- Final checks V03: startup exit status and machine running-state evidence from
  the current run; optionally a Linux identity command for stronger evidence.
- Handoff V04: machine/provider/start invocation, changes, restrictions and
  evidence are recorded; caller accepts the result before continuing.
- Freeze effective stage contracts in the run before action; record observed
  commands, versions, outcomes and validation decisions without secrets.
- Stop for unavailable required evidence, unsafe data disposition, unsupported
  provider, failed startup, or a change beyond approved scope. A helper installed
  or configuration edited is not a successful final result.

## 3. Plan Map

- Displayed run: [applehv application](./run/interactive-applehv--20261014T160319Z.md#podman-krunkit-fix-run-interactive-applehv--20261014T160319Z).
- Displayed plan revision: [Revision 1](./realizations/plan-revision-1.md#podman-krunkit-fix-plan).
- Progress synchronized at: 2026-10-14T14:20:33Z.
- Applehv run: S01 refreshed; S02B/S03 accepted for macOS 26.6.2 (25G83) on this host.
- Previous libkrun run remains failed; S02A is not selected in this run.

| Progress | Stage | Kind | Inputs | Outputs | Possible Next Stages | Required Validation |
| --- | --- | --- | --- | --- | --- | --- |
| ✅ | [S01: Inspect invocation](#stage-s01) | choice | Installed Podman, caller context | Verified host/machine/provider and preservation scope | S02A, S02B, or S03 if already usable | V01 |
| ⚪ | [S02A: Restore libkrun](#stage-s02a) | stage | S01 and reviewed libkrun path | Usable runtime; existing machine preserved | S03 | V02 |
| ✅ | [S02B: Prepare applehv](#stage-s02b) | stage | S01 and reviewed applehv path | Identified compatible existing or new VM | S03 | V02 |
| ✅ | [S03: Verify startup](#stage-s03) | merge | Usable selected VM/runtime | VM running and startup evidence | S04 | V03 |
| ✅ | [S04: Record reusable result](#stage-s04) | validation | S03 evidence | Accepted caller-independent result/handoff | Caller continuation or end | V04 |

### Selectable Paths and Subplans

| Path | Branch | Trade-off | Registered compatible realizations |
| --- | --- | --- | --- |
| [Restore libkrun](./path-options.md#path-restore-libkrun) | S01 → S02A → S03 → S04 | Preserve existing VM; may require krunkit/libkrun installation and compatibility checks | See registry |
| [Use applehv](./path-options.md#path-applehv) | S01 → S02B → S03 → S04 | Alternative provider; potentially a new named VM, helper/image download and storage | See registry |

S01 may skip repair only when the selected machine already satisfies readiness
checks. It cannot switch the user-selected repair path silently. If the chosen
path is unsuitable, return to review. The article's destructive replacement
sequence is not an implicit third branch or fallback.

## 4. Stage Details

<a id="stage-s01"></a>

### S01: Inspect the Invocation and Preserve Its Context

- Kind: choice; entry: installed Podman and caller-supplied target context.
- Actions: inspect host, CLI, machine inventory/provider, helper paths and
  existing configuration/data. Resolve machine name and required resource
  bounds with the caller; do not assume `podman-machine-default` on reuse.
- Output: run context identifying the selected machine, current state, missing
  component if any, existing data scope, and approved path's applicability.
- V01: executable is present; host/provider supported; read-only diagnosis
  sufficient to distinguish missing helper, already-usable VM, or missing VM.
- Resources: Podman CLI, local configuration and filesystem inspection.
- Risks/stops: unknown ownership/data, unavailable read access, missing Podman,
  or path incompatible with this host. No VM deletion or host mutation here.
- Next: selected [S02A](#stage-s02a) or [S02B](#stage-s02b); [S03](#stage-s03)
  directly when repair is unnecessary.

<a id="stage-s02a"></a>

### S02A: Restore the Existing libkrun Runtime

- Path: [Restore libkrun](./path-options.md#path-restore-libkrun).
- Input: S01 diagnosis and approved installation/configuration boundaries.
- Actions: resolve an existing krunkit/helper location first. If absent, identify
  supported package source, dependencies and exact changes before installation;
  apply only the authorized package/PATH changes. Preserve existing VM data.
  If no VM exists, propose its name/resources and initialization before action.
- Output: selected libkrun VM has usable runtime/helper prerequisites.
- V02: executable resolution and runtime/provider compatibility checked;
  no existing machine deleted and no silent global provider/default change.
- Resources: selected package manager/source and network if needed.
- Risks/stops: package incompatibility, install failure, additional unapproved
  dependencies or unsupported runtime. Do not infer VM success from install.
- Next: [S03](#stage-s03); return to review if this path cannot proceed.

<a id="stage-s02b"></a>

### S02B: Prepare an applehv Machine

- Path: [Use applehv](./path-options.md#path-applehv).
- Input: S01 diagnosis and approved VM/provider scope.
- Actions: verify applehv helper availability. Reuse a suitable caller-selected
  applehv VM, or prepare a separately named VM with reviewed resources and
  image source. Use explicit per-invocation provider selection; changing global
  defaults or replacing the old VM requires a separate decision.
- Output: identified applehv VM with required prerequisites, old VM preserved.
- V02: intended name/provider/resources match the reviewed context; existing
  machine data/default connection remain intact unless explicitly changed.
- Resources: provider helper, image download, disk/memory and host VM authority.
- Risks/stops: name collision, missing helper, initialization failure, unavailable
  resources or need to delete/recreate an existing machine. The
  [supplied article](https://thomasuebel.de/blog/podman-desktop-on-macos/)
  is a research reference, not permission to delete its default-machine target.
- Next: [S03](#stage-s03).

<a id="stage-s03"></a>

### S03: Start and Validate the Selected VM

- Input: selected VM/provider and runtime readiness from S01/S02.
- Actions: start the selected stopped VM, capture outcome, and inspect its
  running state. If already running and usable, record that state without an
  unnecessary restart. Optionally execute a Linux identity command; no workload
  tools or container images are required by the minimal contract.
- Output: selected VM running, or explicit failure with preserved diagnostics.
- V03: successful start plus observed running state, or verified already-running
  outcome; record machine/provider and actual command/output. Failed startup
  cannot become success merely because a helper or provider was configured.
- Resources: Podman machine runtime; optional SSH identity probe.
- Risks/stops: startup failure, wrong machine, competing workload or unexpected
  configuration effect. Keep diagnostics and review next action; do not delete
  a VM or switch providers automatically.
- Next: [S04](#stage-s04).

<a id="stage-s04"></a>

### S04: Record the Result and Return to the Caller

- Input: V01–V03 evidence; output: accepted reusable invocation result.
- Actions: record host/Podman version, machine/provider, startup entry point,
  actual changes and evidence in the run. Preserve component setup/repair
  knowledge through Machine of Knowledge when producing reusable documentation;
  distinguish tested results from source recommendations and resolve its TTL.
- V04: result meets the goal's input/output contract and caller accepts it.
  No claim that Linux installer tests have run as part of VM readiness alone.
- Standalone exit: return the running VM/result to the caller.
- First integration: supply accepted result to parent
  [S05R](../plan.md#stage-s05r), enabling [S06](../plan.md#stage-s06).
- Stop: missing startup evidence or unaccepted result. Do not stop the VM at
  handoff by default; later shutdown policy belongs to the caller.

## 5. Shared Dependencies

- Internal: reusable goal contract, selected path and invocation context;
  no runtime dependency on Double Installer or its project directories.
- External: installed Podman, supported machine provider, host access and
  any authorized runtime/helper packages. Network only when installation or
  image initialization requires it.
- Decision: explicit path and realization selection; exact host-change scope
  reviewed after inspection where it cannot be known safely in advance.

## 6. Shared Risks and Controls

| Risk | Control | Stop condition |
| --- | --- | --- |
| Existing VM data loss | Preserve machine; use separately named alternative | Deletion/recreation needs a separate data decision |
| Wrong machine/default changed | Resolve identity and explicit provider per invocation | Ambiguous identity or unapproved default mutation |
| Package install mistaken for completion | Verify actual startup and running state | Startup fails or evidence unavailable |
| Reuse relies on old host state | New context and input/output checks each run | Current precondition fails |
| Article procedure mismatches host | Inspect actual CLI/provider and validate source compatibility | Unreviewed/destructive step required |

## 7. Automation Boundaries

- After review: read-only diagnosis and repository run/evidence artifacts.
  Approved host actions are recorded precisely in the realization and run.
- Runtime installation, VM creation/startup, persistent PATH/provider settings,
  and default-connection changes must be within the explicit approved scope;
  sandbox escalations remain applicable. No silent package upgrades.
- VM deletion, replacement, data discard, unrelated workloads, Docker migration,
  and installer test execution are not authorized by this draft.
- Before mutation: show the target machine, package/configuration changes and
  preservation strategy. A reusable automatic realization, if later selected,
  must enforce the same boundaries and input/output validation.

## 8. Revision and Alignment Conditions

- Before registration: keep both revision fields null; refine this plan directly.
- Freeze revision 1 only after path/realization confirmation. Each run captures
  effective stage contracts before action; previous runs keep their baselines.
- Log compatible future-only changes without a new revision. Changing frozen
  inputs, outputs, actions, dependencies or authority requires a new snapshot
  before execution and explicit revalidation/rework identification.
- Mark only affected realizations `review-required` when provider/procedure or
  control scope changes; never reinterpret an earlier host's result as current.
- Reformulate if the caller needs Podman installation, data migration, or a
  workload environment beyond the startable-VM contract.

## 9. Subgoal Integration Boundaries

No further delegated subgoals. This plan itself provides a reusable interface:

| Caller | Entry | Input | Exit | Output | Continuation |
| --- | --- | --- | --- | --- | --- |
| Standalone or another plan | [S01](#stage-s01) | Installed Podman and invocation context | [S04](#stage-s04) | Accepted VM startup result | Caller-defined |
| [Double Installer](../plan.md#double-installer-plan) | Parent [S05R](../plan.md#stage-s05r) → S01 | Installed Podman and observed startup blocker | S04 → accepted S05R | Startable VM/provider/entry point and evidence | Parent [S06](../plan.md#stage-s06) |

Other plans may directly reference project `double`, artifact
`podman-krunkit-fix-plan`, with current or pinned revision and contextual links.
Copy/adaptation/export uses Plan Exchange when requested. The original parent
relationship provides provenance without making standalone invocation dependent
on that parent. Each invocation gets its own realization-bound run.

<a id="realization-registry"></a>

## 10. Realization Registry

The user initially selected libkrun, then explicitly selected applehv after
the unsuccessful libkrun run on 2026-10-14. The first entry point is S01; host mutation requires reviewed scope. An automatic
Shell realization is an optional later choice, not assumed from reusability.

| Record | Realization Artifact | Realization | Kind | Selected Path or Subplan | Decision | Plan Revision | Realization Revision | Registration | Readiness | Alignment | Runs | Last Run | Last Result |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---: | --- | --- |
| <a id="interactive-libkrun"></a>`interactive-libkrun` | [Interactive libkrun](./realizations/interactive-libkrun.md#interactive-libkrun) | Reusable interactive procedure | manual | [Restore libkrun](./path-options.md#path-restore-libkrun) | [Retained decision](./realizations/decision-interactive-libkrun.md#podman-krunkit-fix-realization-decision) | [Revision 1](./realizations/plan-revision-1.md#podman-krunkit-fix-plan) | [Revision 1](./realizations/interactive-libkrun.md#interactive-libkrun-revision-1) | registered at 2026-10-14T14:20:33Z | blocked | aligned | 1 | 2026-10-14T14:20:33Z | failed |

| <a id="interactive-applehv"></a>`interactive-applehv` | [Interactive applehv](./realizations/interactive-applehv.md#interactive-applehv) | Reusable interactive procedure | manual | [Use applehv](./path-options.md#path-applehv) | [Decision](./realization-decision.md#podman-krunkit-fix-realization-decision) | [Revision 1](./realizations/plan-revision-1.md#podman-krunkit-fix-plan) | [Revision 1](./realizations/interactive-applehv.md#interactive-applehv-revision-1) | registered at 2026-10-14T16:00:28Z | ready | aligned | 1 | 2026-10-14T16:03:19Z | succeeded |

Computed style is currently `single-pass` (no automatic realization registered).
Reusable intent remains explicit; registration of an automatic realization
would change computed style to `multi-pass`. Preserve cumulative statistics
and retain five terminal runs per future realization unless configured otherwise.
Do not create snapshots, decisions or execution runs before review confirmation.

<a id="plan-change-log"></a>

## 11. Plan Change Log

- 2026-10-14T16:00:28Z: user ended libkrun invocation as failed at S03 and selected
  existing applehv branch. Retained revision 1, old decision and run; registered
  separate manual realization interactive-applehv. No frozen obligations changed,
  therefore no new plan revision. S01/S02A acceptance remains historical evidence;
  applehv must recheck current processes, machine inventory, helper and defaults.
- Next: read-only context refresh, resolve pending start/stop processes using a
  reviewed controlled procedure, then S02B with separately named applehv VM.
  Never reuse stale PIDs or delete either libkrun VM. New startup evidence is
  required; parent S06 remains gated by S03/S04 acceptance.

## 12. Open Questions

None blocking review. User must choose the path and realization before action.
Machine identity, exact packages/provider resources and current data scope are
S01 outputs; stop before mutation if those cannot be safely resolved.

Current applehv context refresh: 2026-10-14T16:03:19Z; user reports old processes stopped.
Machine/connection inventories empty; disk preservation unknown. S02B instructions
recorded in the new run; initialization and startup not yet evidenced.

User evidence: applehv initialization and startup completed; inspect running with
2 CPUs/2048 MiB/20 GiB. S02B/S03 technical pass awaiting acceptance, S04 pending.

User accepted S02B/S03 with verified applicability limited to macOS 26.6.2
(build 25G83), Podman 6.1.0 and vfkit v0.6.4 on this host. Other versions
require a new invocation and validation. S04 reusable handoff remains pending.

S04 in progress: version-scoped knowledge draft and caller handoff prepared;
TTL and final V04 acceptance pending. No parent S06 execution authorized here.

2026-10-14T16:14:03Z: S04/V04 accepted by user; knowledge completed with TTL one year.
Applehv run succeeded, invocation result handed to parent S05R; S06 not run.
