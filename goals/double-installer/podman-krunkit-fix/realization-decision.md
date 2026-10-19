---
id: podman-krunkit-fix-realization-decision
kind: realization-decision
template-id: realization-decision-template
produced-by: machine-of-goals/plan-synthesis-agent
project-id: double
interaction-language: ru
artifact-language: en
goal-id: podman-krunkit-fix
plan-id: podman-krunkit-fix-plan
plan-revision: 1
plan-revision-artifact: ./realizations/plan-revision-1.md
selected-paths:
  - path-applehv
realization-record-id: interactive-applehv
selected-realization-id: interactive-applehv-procedure
realization-artifact: ./realizations/interactive-applehv.md
path-selection-confirmed-by: user
path-selection-confirmed-at: 2026-10-14T16:00:28Z
---

<a id="podman-krunkit-fix-realization-decision"></a>

# Realization Decision: Use applehv

The user explicitly selected the alternative after the libkrun invocation failed.
[Plan registry](./plan.md#interactive-applehv),
[unchanged baseline 1](./realizations/plan-revision-1.md#podman-krunkit-fix-plan),
[applehv path](./path-options.md#path-applehv),
[realization revision 1](./realizations/interactive-applehv.md#interactive-applehv-revision-1).

Retain the [previous decision](./realizations/decision-interactive-libkrun.md#podman-krunkit-fix-realization-decision)
and failed run. Entry: refresh S01 context, then S02B → S03 → S04.
Use a separate named VM; preserve existing disks and defaults. No deletion,
global provider/default connection change or package removal authorized.
Human executes host commands; agent records instructions/evidence. Check and
resolve pending operations before another startup; review exact name/resources
before initialization. Each stage contract is frozen in a new run before action.
Success requires completed startup and running-state evidence; running alone
while start hangs is insufficient. S06 remains blocked until accepted handoff.
