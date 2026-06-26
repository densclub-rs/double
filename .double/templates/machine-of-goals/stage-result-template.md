---
style: double
submodule: machine-of-goals
id: stage-result-template
kind: template
status: draft
workflow-stage: plan-realization
interaction-language: en
artifact-language: en
derived-from:
  - ../../workflows/machine-of-goals/machine-of-goals-workflow.md
---

# Template: Stage Result

```md
---
id: <goal-id>-<stage-id>-result
kind: stage-result
status: draft
produced-by: plan-realization-agent
workflow-version: <workflow-version>
interaction-language: <language-code-or-name-used-for-dialogue>
artifact-language: <language-code-or-name-used-for-this-artifact>
goal-id: <goal-id>
plan-id: <plan-id>
stage-id: <stage-id>
derived-from:
  - <plan-artifact-id-or-path>
  - <realization-decision-id-or-path>
---

# Stage Result: <Stage Name>

## 1. Stage Context

- Goal:
- Plan:
- Stage:
- Input state:
- Expected output state:
- Approved boundaries:

## 2. Actions Performed

- Action:
- Actor:
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

## 8. Workflow State

- Current step: `05-plan-realization`
- Current mode: `<execution|dry-run|explain|planning>`
- Next expected step: `06-plan-validation`
- Transition condition: stage has a result that can be validated, or is blocked and needs plan revision
```
