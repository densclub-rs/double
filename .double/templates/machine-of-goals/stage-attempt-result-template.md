---
style: double
submodule: machine-of-goals
id: stage-attempt-result-template
kind: template
status: release-candidate
workflow-stage: plan-realization
interaction-language: en
artifact-language: en
derived-from:
  - ../../workflows/machine-of-goals/machine-of-goals-workflow.md
---

# Template: Stage Attempt Result

```md
---
id: <goal-id>-<stage-id>-attempt-<attempt-id>
kind: stage-attempt-result
produced-by: plan-realization-agent
artifact-path: ./results/<goal-id>-<stage-id>-attempt-<attempt-id>.md
interaction-language: <language-code-or-name-used-for-dialogue>
artifact-language: <language-code-or-name-used-for-this-artifact>
goal-id: <goal-id>
plan-id: <plan-id>
stage-id: <stage-id>
attempt-id: <attempt-id>
author: <author-or-agent-id>
device: <device-or-runtime-id>
attempted-at: <YYYY-MM-DDTHH:MM:SS+HH:MM>
derived-from:
  - <plan-artifact-id-or-path>
  - <realization-decision-id-or-path>
---

# Stage Attempt Result: <Stage Name>

Save this artifact under `<goal-directory>/results/`. After the attempt is
recorded, update the active plan artifact, especially `Plan Map`, `Stage
Attempts`, `Blocker`, and the relevant `Stage Details`.

## 1. Stage Context

- Goal:
- Plan:
- Stage:
- Input state:
- Expected output state:
- Approved boundaries:

## 2. Actions Performed

- Attempt id:
- Action:
- Actor:
- Author:
- Device / runtime:
- Attempted at:
- Mode: <manual|interactive|partial-automation|automatic|external-handoff>
- Time / cost:
- Notes:

## 3. Produced Outputs

- Files:
- Decisions:
- External results:
- Handoff artifacts:
- Other:

## 4. Evidence Collected

- Evidence item:
- Source:
- Location:
- Reliability:

## 5. Deviations

- Planned:
- Actual:
- Reason:
- Impact:

## 6. Blockers and Risks

- Blocker:
- Risk:
- Required decision:

## 7. Result Summary

- Result status: <ready-for-validation|blocked|partial|failed|needs-plan-revision>
- Summary:
- Recommended next step:
- Plan update needed: <yes|no>
- Plan sections to update: <Plan Map|Stage Attempts|Blocker|Stage Details|other>
```
