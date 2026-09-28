---
style: double
submodule: machine-of-goals
id: run-index-template
kind: template
status: release-candidate
workflow-stage: plan-realization
interaction-language: en
artifact-language: en
derived-from:
  - ../../workflows/machine-of-goals/machine-of-goals-workflow.md
  - ../../../ideas/machine-of-goals/machine-of-goals-principles.md
---

# Template: Run Index

```md
---
id: <goal-id>-run-index
kind: run-index
template-id: run-index-template
project-id: <stable-project-id>
produced-by: machine-of-goals/plan-realization-agent
artifact-path: ./run/index.md
goal-id: <goal-id>
derived-from:
  - <goal-artifact-id-or-path>
  - <plan-artifact-id-or-path>
  - <path-options-id-or-path>
  - <realization-artifact-id-or-path>
---

<a id="<goal-id>-run-index"></a>

# Run Index: <Goal Title>

This index lists active, pinned, and retained working runs. Aggregate history
remains in the [plan realization registry](../plan.md#realization-registry).

| Run | Realization Artifact | Plan Revision | Realization Revision | Started | Result |
| --- | --- | --- | --- | --- | --- |
| [<run-label>](./<realization-record-id>--<YYYYMMDDTHHMMSSZ>.md#<run-id>) | [<realization-label>](../realizations/<realization-record-id>.md#<realization-record-id>) | [Revision <N>](../realizations/plan-revision-<N>.md#<goal-id>-plan) | [Revision <R>](../realizations/<realization-record-id>.md#<realization-record-id>-revision-<R>) | <YYYY-MM-DDTHH:MM:SSZ> | <result> |

Remove a row when its unpinned run file is removed by retention, and remove the
same link from its realization artifact. Never leave a link to a removed run.
Cumulative counts are not reconstructed from this index.
```
