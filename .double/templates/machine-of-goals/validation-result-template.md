---
style: double
submodule: machine-of-goals
id: validation-result-template
kind: template
status: draft
workflow-stage: plan-validation
interaction-language: en
artifact-language: en
derived-from:
  - ../../workflows/machine-of-goals/machine-of-goals-workflow.md
---

# Template: Validation Result

```md
---
id: stage-<stage-id>-validation
kind: validation-result
status: draft
produced-by: plan-validation-agent
workflow-version: <workflow-version>
interaction-language: <language-code-or-name-used-for-dialogue>
artifact-language: <language-code-or-name-used-for-this-artifact>
current-step: 06-plan-validation
current-mode: <validation|review|explain>
next-expected-step: <05-plan-realization|07-plan-packaging-export|01-goal-formulation|03-plan-synthesis>
transition-condition: result accepted, rejected, partial, blocked, or requiring revision
goal-id: <goal-id>
plan-id: <plan-id>
stage-id: <stage-id>
derived-from:
  - <stage-attempt-result-id-or-path>
  - <plan-artifact-id-or-path>
---

# Validation Result: <Stage or Goal>

## 1. Validation Scope

- Goal:
- Plan:
- Stage:
- Validation type: <stage|goal|package|handoff>
- Criteria source:

## 2. Criteria Checked

| Criterion | Evidence | Result | Notes |
| --- | --- | --- | --- |
| <criterion> | <evidence> | <accepted|rejected|partial|blocked|needs-revision> | <notes> |

## 3. Evidence Review

- Evidence:
- Source:
- Reliability:
- Gaps:

## 4. Validation Decision

- Result: <accepted|rejected|partial|blocked|needs-revision>
- Rationale:
- Human confirmation required: <yes|no>
- Confirmation status: <pending|confirmed|rejected|not-needed>

## 5. Plan State Update

- Stage status after validation:
- Goal progress:
- Metrics / cost update:
- Risk update:
- Open questions update:

## 6. Next Workflow Direction

- Continue to: <next-stage-id>
- Branch to:
- Revise:
- Reformulate goal:
- Pause:
- Close:
- Request export:
```
