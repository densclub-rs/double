---
style: double
submodule: machine-of-goals
id: plan-run-template
kind: template
status: release-candidate
workflow-stage: plan-realization
interaction-language: en
artifact-language: en
derived-from:
  - ../../workflows/machine-of-goals/machine-of-goals-workflow.md
  - ../../../ideas/machine-of-goals/machine-of-goals-principles.md
---

# Template: Plan Run

```md
---
id: <goal-id>-run-<realization-id>-<YYYYMMDDTHHMMSSZ>
kind: plan-run
project-id: <stable-project-id>
produced-by: plan-realization-agent
artifact-path: ./run/<realization-id>--<YYYYMMDDTHHMMSSZ>.md
interaction-language: <language-code-or-name-used-for-dialogue>
artifact-language: <language-code-or-name-used-for-this-artifact>
goal-id: <goal-id>
plan-id: <plan-id>
plan-revision: <positive-integer>
realization-id: <registered-realization-id>
realization-revision: <revision-or-null>
selected-paths:
  - <path-or-subplan-id>
started-at: <YYYY-MM-DDTHH:MM:SSZ>
finished-at: <YYYY-MM-DDTHH:MM:SSZ-or-null>
result: <running|succeeded|partial|failed|blocked|cancelled|precondition-failed>
pinned: <yes|no>
derived-from:
  - <plan-artifact-id-or-path>
  - <path-options-id-or-path>
  - <realization-decision-id-or-path>
---

<a id="<goal-id>-run-<realization-id>-<YYYYMMDDTHHMMSSZ>"></a>

# Plan Run: <Goal Title> / <Realization Id>

## 1. Run Context

- Source goal: [<goal-title>](../<goal-id>.md#<goal-id>)
- Realization decision: [<decision-label>](../realization-decision.md#<goal-id>-realization-decision)
- Plan revision: [<exact-plan-revision>](<immutable-plan-revision-link>)
- Realization: [<realization-label>](../path-options.md#<realization-id>)
- Realization revision: [<exact-realization-revision>](<immutable-realization-revision-link>)
- Selected paths or subplans: [<path-or-subplan-label>](../path-options.md#<path-or-subplan-id>)
- Actor:
- Runtime or environment:
- Approved boundaries:
- Required stop points:

## 2. Initial State Validation

- [ ] Initial state checked
- Expected state:
- Observed state:
- Evidence:
- Decision: <accepted|rejected|partial|blocked|needs-revision>

## 3. Run Plan

Instantiate only the stages and path branches selected for this run.

| Stage | Status | Validation | Started | Finished | Result |
| --- | --- | --- | --- | --- | --- |
| [<stage-id>](../plan.md#stage-<stage-id>) | <not-started|in-progress|done|partial|blocked|failed|needs-revision> | <not-validated|accepted|partial|blocked|rejected|needs-revision> | <time-or-null> | <time-or-null> | <summary> |

## 4. Working Log

Keep concise notes that explain the current realization effort, not command-by-command logs.

### <YYYY-MM-DDTHH:MM:SSZ> — <Stage Id>

- Attempted:
- Changed or produced: [<artifact-label>](<artifact-link>)
- Observed:
- Decision or next action:

## 5. Intermediate State Validation

- Stage:
- Expected state:
- Observed state:
- Evidence: [<evidence-label>](<evidence-link>)
- Decision:

## 6. Blockers and Deviations

- Blocker:
- Planned:
- Actual:
- Reason:
- Impact:
- Required decision:

## 7. Final State Validation

- [ ] Final state checked
- Expected state:
- Observed state:
- Evidence: [<evidence-label>](<evidence-link>)
- Decision: <accepted|rejected|partial|blocked|needs-revision>

## 8. Run Result

- Result: <succeeded|partial|failed|blocked|cancelled|precondition-failed>
- Summary:
- Plan revision needed: <yes|no>
- Realization revision needed: <yes|no>
- Path review needed: <yes|no>
- Recommended next step:
- Statistics updated in [Path and realization registry](../path-options.md#<goal-id>-path-options): <yes|no>
- Next decision, revision, or run: [<artifact-label>](<artifact-link>) or none
```
