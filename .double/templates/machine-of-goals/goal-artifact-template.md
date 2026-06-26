---
style: double
submodule: machine-of-goals
id: goal-artifact-template
kind: template
status: draft
workflow-stage: goal-formulation
interaction-language: en
artifact-language: en
derived-from:
  - ../../workflows/machine-of-goals/machine-of-goals-workflow.md
  - ../../../ideas/machine-of-goals/machine-of-goals-principles.md
---

# Template: Goal Artifact

```md
---
id: <goal-id>
kind: goal-artifact
status: draft
produced-by: goal-formulation-agent
workflow-version: <workflow-version>
interaction-language: <language-code-or-name-used-for-dialogue>
artifact-language: <language-code-or-name-used-for-this-artifact>
goal-directory: <double/goals>/<goal-id>
derived-from:
  - <source-conversation-or-artifact>
---

# Goal: <Goal Title>

## 1. Summary

A short description of the goal as a desired verifiable state.

## 2. Subject of the Goal

- Subject: <person, agent, project, system, organization, or other actor>
- Owner / responsible party: <who is responsible for goal decisions>
- Stakeholders: <optional>

## 3. Motivation

- Why does this goal matter?
- What value would achieving it create?
- What happens if it is not pursued?

## 4. Current State

Describe the starting point.

- Known facts:
- Unknowns:
- Relevant environment:
- Existing related goals or artifacts:

## 5. Target State

Describe the state that should exist after successful realization.

- Required result:
- Optional quality improvements:
- Evidence that would show the target state exists:

## 6. Success Criteria

- Minimal success:
- High-quality success:
- Partial success:
- Failure / not achieved:

## 7. Constraints

- Time:
- Attention:
- Money:
- Technical constraints:
- Social / legal / ethical constraints:
- Other:

## 8. Resources

- Available resources:
- Missing resources:
- Tools or systems:
- People or organizations:

## 9. Initial Subgoals

- <subgoal candidate, if already visible>

## 10. Existing Analogs

- Existing goal, plan, runbook, workflow, or external analog:
- Import status: <none|candidate|imported|rejected>

## 11. Open Questions

- [ ] <question that blocks or improves path discovery>

## 12. Boundaries / Non-Goals

- What is outside the goal?
- What should not be optimized or pursued?

## 13. Workflow State

- Current step: `01-goal-formulation`
- Current mode: `<clarification|explain|import>`
- Next expected step: `02-path-discovery`
- Transition condition: goal is sufficiently clear to search for paths
```
