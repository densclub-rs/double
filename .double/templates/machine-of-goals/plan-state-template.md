---
style: double
submodule: machine-of-goals
id: plan-state-template
kind: template
status: draft
workflow-stage: plan-realization
interaction-language: en
artifact-language: en
derived-from:
  - ../../workflows/machine-of-goals/machine-of-goals-workflow.md
---

# Template: Plan State

```md
---
id: <goal-id>-plan-state
kind: plan-state
status: draft
produced-by: <plan-realization-agent|plan-validation-agent>
workflow-version: <workflow-version>
interaction-language: <language-code-or-name-used-for-dialogue>
artifact-language: <language-code-or-name-used-for-this-artifact>
goal-id: <goal-id>
plan-id: <plan-id>
author: <author-or-agent-id>
device: <device-or-runtime-id>
created-at: <YYYY-MM-DDTHH:MM:SS+HH:MM>
updated-at: <YYYY-MM-DDTHH:MM:SS+HH:MM>
exported-artifact-name: <goal-id>-plan-state--author-<author>--device-<device>--time-<YYYYMMDDTHHMMSS>.md
derived-from:
  - <plan-artifact-id-or-path>
  - <stage-attempt-result-or-validation-result-id-or-path>
related-implementations:
  - <imported-or-previous-plan-state-id-or-path>
stage-attempt-artifacts:
  - <stage-attempt-result-id-or-path>
---

# Plan State: <Goal Title>

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

## 3. Stage Attempt Artifacts

- Save attempt artifacts after plan-state update: <ask-user|yes|no>
- Current attempt count:
- Retention threshold: 10
- Cleanup decision when attempts exceed threshold: <ask-user|keep-all|delete-old>

| Attempt | Artifact | Author | Device | Time | Keep |
| --- | --- | --- | --- | --- | --- |
| <attempt-id> | <stage-attempt-result-id-or-path> | <author> | <device> | <YYYY-MM-DDTHH:MM:SS+HH:MM> | <yes|no|ask> |

## 4. Implementation Trace

- Implementation id:
- Author:
- Device / runtime:
- Started at:
- Last updated at:
- Execution context:
- Source plan:
- Imported from:
- Export artifact name:

## 5. Completed Work

- <stage or action completed>

## 6. Pending Work

- <stage or action pending>

## 7. Blockers

- Blocker:
- Owner:
- Needed decision:

## 8. Metrics and Cost

- Time:
- Attention:
- Money:
- Compute:
- Errors:
- Successful stage runs:
- Domain-specific costs:

## 9. Risks and Open Questions

- Risk:
- Open question:

## 10. Revision Notes

- What changed:
- Why:
- Impact on goal:
- Impact on plan:

## 11. Comparison Notes

Use this section when the current plan state is compared with imported or
previous implementations of the same plan.

- Compared with:
- Same stages:
- Different stages:
- Faster / cheaper parts:
- Riskier parts:
- Verification notes:

## 12. Workflow Direction

- Continue:
- Branch:
- Revise:
- Reformulate:
- Pause:
- Close:
- Export:
```
