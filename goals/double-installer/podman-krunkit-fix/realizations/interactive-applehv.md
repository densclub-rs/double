---
id: interactive-applehv
kind: realization-artifact
template-id: realization-template
produced-by: machine-of-goals/plan-synthesis-agent
project-id: double
interaction-language: ru
artifact-language: en
goal-id: podman-krunkit-fix
plan-id: podman-krunkit-fix-plan
plan-revision: 1
artifact-path: ./realizations/interactive-applehv.md
plan-revision-artifact: ./plan-revision-1.md
realization-decision-id: podman-krunkit-fix-realization-decision
realization-record-id: interactive-applehv
realization-id: interactive-applehv-procedure
realization-kind: manual
realization-revision: 1
implementation-revision: null
realization-mode: interactive
selected-paths:
  - path-applehv
status: ready
alignment: aligned
derived-from:
  - ../plan.md
  - ./plan-revision-1.md
  - ../realization-decision.md
---

<a id="interactive-applehv"></a>

# Realization: Reusable Interactive applehv Procedure

## 1. Realization Context

[Goal](../podman-krunkit-fix.md#podman-krunkit-fix), [registry](../plan.md#interactive-applehv),
[decision](../realization-decision.md#podman-krunkit-fix-realization-decision),
[baseline](./plan-revision-1.md#podman-krunkit-fix-plan), [current plan](../plan.md#podman-krunkit-fix-plan),
[selected path](../path-options.md#path-applehv).
No post-baseline changes; stages/dependencies/procedure are aligned.

<a id="interactive-applehv-revision-1"></a>

## 2. Realization Revision 1

### Procedure or Entry Point

Start [S01](../plan.md#stage-s01): inspect the supplied host, installed Podman,
selected VM, provider, helper paths and existing data/configuration scope.
Proceed through S02B/S03/S04 after their boundaries and stage results are reviewed.
The procedure is self-contained; no executable implementation revision applies.
Every reuse supplies a new invocation context and creates a new run.

### Automation and Control Boundaries

Read-only diagnosis and repository evidence allowed. Installation/PATH/provider
changes or VM startup require exact reviewed scope and sandbox permissions.
No VM deletion/recreation, data discard, automatic applehv fallback, unrelated
workload changes, or installer test execution.

### Validation Contract

Freeze effective stage contracts before action. Prove V01–V04 and record
observed evidence. Stop for user stage validation and incompatible authority.
Existing success is not evidence of readiness for another invocation.

## 5. Runs

[Current run](../run/interactive-applehv--20261014T160319Z.md#podman-krunkit-fix-run-interactive-applehv--20261014T160319Z), started 2026-10-14T16:03:19Z, result succeeded. See [Run index](../run/index.md#podman-krunkit-fix-run-index).

## 6. Boundaries for This Invocation

Refresh current machine/process/helper/default-connection state before S02B.
Preserve podman-machine-default and double-libkrun-diag, all their disks and
installed packages. Review controlled cancellation/shutdown of pending libkrun
operations before applehv startup; stale PIDs are not executable instructions.
Prepare a separate named applehv VM with explicit provider, reviewed resources,
and no --update-connection. Verify defaults after initialization. No automatic
fallback, VM deletion, disk migration or caller workload tests.


### Verified Platform Scope — Current applehv Result

Successful initialization/startup was observed and user-accepted specifically
on macOS 26.6.2 (build 25G83), Podman 6.1.0, vfkit v0.6.4, machine-os:6.1,
on the current host. Other macOS versions/builds and hosts remain unverified;
reuse requires fresh invocation checks and startup validation. This scope
restricts the observed result, not the reusable plan input contract.

Current run closed 2026-10-14T16:14:03Z; V04 user-accepted, knowledge TTL one year.
