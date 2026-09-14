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
project-id: <stable-project-id>
produced-by: plan-realization-agent
artifact-path: ./run/index.md
goal-id: <goal-id>
derived-from:
  - <goal-artifact-id-or-path>
  - <plan-artifact-id-or-path>
  - <path-options-id-or-path>
---

<a id="<goal-id>-run-index"></a>

# Run Index: <Goal Title>

This index lists active, pinned, and retained working runs. Aggregate history
remains in the [path and realization registry](../path-options.md#<goal-id>-path-options).

| Run | Realization | Plan Revision | Realization Revision | Started | Result |
| --- | --- | --- | --- | --- | --- |
| [<run-label>](./<realization-id>--<YYYYMMDDTHHMMSSZ>.md#<run-id>) | [<realization-label>](../path-options.md#<realization-id>) | [<exact-plan-revision>](<immutable-plan-revision-link>) | [<exact-realization-revision>](<immutable-realization-revision-link>) | <YYYY-MM-DDTHH:MM:SSZ> | <result> |

Remove a row when its unpinned run file is removed by retention. Never leave a
link to a removed run. Cumulative counts are not reconstructed from this index.
```
