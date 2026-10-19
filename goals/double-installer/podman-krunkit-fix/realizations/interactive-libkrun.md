---
id: interactive-libkrun
kind: realization-artifact
template-id: realization-template
produced-by: machine-of-goals/plan-synthesis-agent
project-id: double
interaction-language: ru
artifact-language: en
goal-id: podman-krunkit-fix
plan-id: podman-krunkit-fix-plan
plan-revision: 1
artifact-path: ./realizations/interactive-libkrun.md
plan-revision-artifact: ./plan-revision-1.md
realization-decision-id: podman-krunkit-fix-realization-decision
realization-record-id: interactive-libkrun
realization-id: interactive-libkrun-procedure
realization-kind: manual
realization-revision: 1
implementation-revision: null
realization-mode: interactive
selected-paths:
  - path-restore-libkrun
status: blocked
alignment: aligned
derived-from:
  - ../plan.md
  - ./plan-revision-1.md
  - ./decision-interactive-libkrun.md
---

<a id="interactive-libkrun"></a>

# Realization: Reusable Interactive libkrun Procedure

## 1. Realization Context

[Goal](../podman-krunkit-fix.md#podman-krunkit-fix), [registry](../plan.md#interactive-libkrun),
[decision](./decision-interactive-libkrun.md#podman-krunkit-fix-realization-decision),
[baseline](./plan-revision-1.md#podman-krunkit-fix-plan), [current plan](../plan.md#podman-krunkit-fix-plan),
[selected path](../path-options.md#path-restore-libkrun).
No post-baseline changes; stages/dependencies/procedure are aligned.

<a id="interactive-libkrun-revision-1"></a>

## 2. Realization Revision 1

### Procedure or Entry Point

Start [S01](../plan.md#stage-s01): inspect the supplied host, installed Podman,
selected VM, provider, helper paths and existing data/configuration scope.
Proceed through S02A/S03/S04 after their boundaries and stage results are reviewed.
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

| Run | Started | Finished | Result | Pinned |
| --- | --- | --- | --- | --- |
| [First application](../run/interactive-libkrun--20261014T142033Z.md#podman-krunkit-fix-run-interactive-libkrun-20261014T142033Z) | 2026-10-14T14:20:33Z | 2026-10-14T16:00:28Z | failed | no |

See [Run index](../run/index.md#podman-krunkit-fix-run-index).

## 6. Revision and Retirement

Revise for procedure/boundary/check changes; reconfirm path or authority changes.
Keep prior revisions and runs. No replacement or retirement currently exists.

Current invocation unsuccessful at S03; user selected applehv. Readiness blocked
pending a reviewed resolution of the startup issue. Original revision 1 and
accepted runtime-installation evidence are retained. No provider-wide verdict.
