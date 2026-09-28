---
style: double
submodule: machine-of-goals
id: realization-template
kind: template
status: release-candidate
workflow-stage: plan-review-and-decision
interaction-language: en
artifact-language: en
derived-from:
  - ../../workflows/machine-of-goals/machine-of-goals-workflow.md
  - ../../../ideas/machine-of-goals/machine-of-goals-principles.md
---

# Template: Realization Artifact

```md
---
id: <realization-record-id>
kind: realization-artifact
template-id: realization-template
project-id: <stable-project-id>
produced-by: machine-of-goals/plan-synthesis-agent
artifact-path: ./realizations/<realization-record-id>.md
interaction-language: <language-code-or-name-used-for-dialogue>
artifact-language: <language-code-or-name-used-for-this-artifact>
goal-id: <goal-id>
plan-id: <plan-id>
plan-revision: <positive-integer>
plan-revision-artifact: <goal-directory>/realizations/plan-revision-<N>.md
realization-decision-id: <realization-decision-id>
realization-record-id: <unique-realization-record-id>
realization-id: <registered-realization-id>
realization-kind: <manual|shell|python|workflow|agentic|external>
realization-revision: <positive-integer>
implementation-revision: <exact-revision-or-null>
realization-mode: <manual|interactive|partial-automation|automatic|external-handoff>
selected-paths:
  - <path-or-subplan-id>
status: <draft|ready|unvalidated|failed|retired>
alignment: <aligned|review-required|incompatible>
derived-from:
  - <goal-artifact-id-or-path>
  - <plan-artifact-id-or-path>
  - <plan-revision-artifact-path>
  - <path-options-id-or-path>
  - <realization-decision-id-or-path>
---

<a id="<realization-record-id>"></a>

# Realization: <Goal Title> / <Realization Label>

## 1. Realization Context

- Source goal: [<goal-title>](../<goal-id>.md#<goal-id>)
- Realization registry record: [<realization-label>](../plan.md#<realization-record-id>)
- Realization decision: [<decision-label>](../realization-decision.md#<goal-id>-realization-decision)
- Selected plan revision: [Revision <N>](./plan-revision-<N>.md#<goal-id>-plan)
- Selected paths or subplans: [<path-or-subplan-label>](../path-options.md#<path-or-subplan-id>)
- Realization definition or implementation: [<realization-label>](<definition-or-implementation-link>)
- Current realization revision: [Revision <R>](#<realization-record-id>-revision-<R>)
- Exact implementation revision: [<exact-implementation-revision>](<immutable-implementation-revision-link>) or not applicable for a self-contained manual procedure
- Mode: <manual|interactive|partial-automation|automatic|external-handoff>
- Readiness:
- Alignment:

<a id="<realization-record-id>-revision-<R>"></a>

## 2. Realization Revision <R>

Preserve every earlier revision section. Increment `realization-revision` only
when the procedure, implementation reference, boundaries, or validation
contract changes. Run-link and status updates do not create a new revision.

### Procedure or Entry Point

- First plan stage: [<stage-label>](../plan.md#stage-<stage-id>)
- Invocation or first manual action:
- Required inputs:
- Expected outputs:
- Runtime or environment:

### Automation and Control Boundaries

- Allowed without confirmation:
- Requires confirmation:
- Not allowed:
- External effects:
- Required stop points:

### Validation Contract

- Initial-state checks:
- Intermediate checks:
- Final-state checks:
- Evidence expected:
- Validator:

## 5. Runs

This table links every active, pinned, or retained run created from this
realization artifact. Remove a row only when retention removes its unpinned run
file, after aggregate statistics have been updated in the plan registry.

| Run | Started | Finished | Result | Pinned |
| --- | --- | --- | --- | --- |
| [<run-label>](../run/<realization-record-id>--<YYYYMMDDTHHMMSSZ>.md#<run-id>) | <YYYY-MM-DDTHH:MM:SSZ> | <YYYY-MM-DDTHH:MM:SSZ-or-null> | <result> | <yes|no> |

The goal-wide retained-run view is the [run index](../run/index.md#<goal-id>-run-index).

## 6. Revision and Retirement

- Revise the realization when:
- Reconfirm the decision when:
- Retire when:
- Replacement realization artifact: [<realization-label>](./<replacement-realization-record-id>.md#<replacement-realization-record-id>) or none
```
