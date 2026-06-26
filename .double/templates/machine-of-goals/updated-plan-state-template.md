---
style: double
submodule: machine-of-goals
id: updated-plan-state-template
kind: template
status: draft
workflow-stage: plan-realization
interaction-language: en
artifact-language: en
derived-from:
  - ../../workflows/machine-of-goals/machine-of-goals-workflow.md
---

# Template: Updated Plan State

```md
---
id: <goal-id>-plan-state
kind: updated-plan-state
status: draft
produced-by: <plan-realization-agent|plan-validation-agent>
workflow-version: <workflow-version>
interaction-language: <language-code-or-name-used-for-dialogue>
artifact-language: <language-code-or-name-used-for-this-artifact>
goal-id: <goal-id>
plan-id: <plan-id>
derived-from:
  - <plan-artifact-id-or-path>
  - <stage-result-or-validation-result-id-or-path>
---

# Updated Plan State: <Goal Title>

## 1. State Summary

- Goal status: <draft|active|paused|blocked|achieved|not-achieved|closed>
- Plan status: <draft|selected|active|revising|blocked|completed|exported>
- Current step:
- Current mode:
- Current stage:
- Next stage:

## 2. Stage Status Table

| Stage | Status | Last Result | Last Validation | Notes |
| --- | --- | --- | --- | --- |
| <stage-id> | <not-started|ready|in-progress|blocked|done|rejected|revising> | <result-ref> | <validation-ref> | <notes> |

## 3. Completed Work

- <stage or action completed>

## 4. Pending Work

- <stage or action pending>

## 5. Blockers

- Blocker:
- Owner:
- Needed decision:

## 6. Metrics and Cost

- Time:
- Attention:
- Money:
- Compute:
- Errors:
- Successful stage runs:
- Domain-specific costs:

## 7. Risks and Open Questions

- Risk:
- Open question:

## 8. Revision Notes

- What changed:
- Why:
- Impact on goal:
- Impact on plan:

## 9. Workflow Direction

- Continue:
- Branch:
- Revise:
- Reformulate:
- Pause:
- Close:
- Export:
```
