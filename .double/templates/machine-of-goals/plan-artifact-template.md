---
style: double
submodule: machine-of-goals
id: plan-artifact-template
kind: template
status: draft
workflow-stage: plan-synthesis
interaction-language: en
artifact-language: en
derived-from:
  - ../../workflows/machine-of-goals/machine-of-goals-workflow.md
  - ../../../ideas/machine-of-goals/machine-of-goals-principles.md
---

# Template: Plan Artifact

```md
---
id: <goal-id>-plan
kind: plan-artifact
status: draft
produced-by: plan-synthesis-agent
workflow-version: <workflow-version>
interaction-language: <language-code-or-name-used-for-dialogue>
artifact-language: <language-code-or-name-used-for-this-artifact>
goal-id: <goal-id>
goal-artifact: <path-to-goal-artifact>
selected-paths:
  - <path-id>
derived-from:
  - <goal-artifact-id-or-path>
  - <path-options-id-or-path>
---

# Plan: <Goal Title>

## 1. Plan Summary

Describe the selected plan as a transition from current state to target state.

## 2. Source Goal and Path

- Goal:
- Current state:
- Target state:
- Success criteria:
- Selected path or hybrid:
- Why this path was selected:

## 3. Plan Graph

Describe the movement through the plan.

Plan graph:

    <stage-1> -> <stage-2> -> <stage-3>

## 4. Stages

### Stage: <Stage Name>

- Stage id: `<stage-id>`
- Purpose:
- Input state:
- Output state:
- Dependencies:
- Actions:
- Required resources:
- Validation criteria:
- Evidence expected:
- Risks:
- Stop points:
- Automation level: <manual|interactive|partial|automatic|external>
- Status: <not-started|ready|in-progress|blocked|done|rejected>

## 5. Subgoals

- <subgoal-id>: <purpose, input, output, own artifact path if created>

## 6. Dependencies

- Internal dependencies:
- External dependencies:
- Decision dependencies:

## 7. Risks and Controls

- Risk:
- Impact:
- Mitigation:
- Stop condition:

## 8. Automation Boundaries

- Allowed automatic actions:
- Actions requiring confirmation:
- Actions not allowed:
- Dry-run required before:

## 9. Revision Conditions

- Revise stage when:
- Rebuild plan when:
- Reformulate goal when:

## 10. Open Questions

- [ ] <question that affects realization or validation>

## 11. Workflow State

- Current step: `03-plan-synthesis`
- Current mode: `<planning|review|explain|dry-run>`
- Next expected step: `04-plan-review-and-decision`
- Transition condition: plan project is understandable enough to review and choose realization strategy
```
