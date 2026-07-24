---
style: double
submodule: machine-of-goals
id: goal-template
kind: template
status: release-candidate
workflow-stage: goal-formulation
interaction-language: en
artifact-language: en
derived-from:
  - ../../workflows/machine-of-goals/machine-of-goals-workflow.md
  - ../../../ideas/machine-of-goals/machine-of-goals-principles.md
---

# Template: Goal

```md
---
id: <goal-id>
kind: goal-artifact
produced-by: goal-formulation-agent
interaction-language: <language-code-or-name-used-for-dialogue>
artifact-language: <language-code-or-name-used-for-this-artifact>
goal-catalog: <selected-goal-catalog-or-./goals>
goal-directory: <goal-catalog>/<goal-id> or <parent-goal-directory>/<subgoal-id>
goal-artifact: <goal-directory>/<goal-id>.md or <subgoal-directory>/<subgoal-id>.md
goal-scope: <main-goal|subgoal>
parent-goal-id: <parent-goal-id-or-null>
parent-goal-directory: <parent-goal-directory-or-null>
subgoal-directory: <subgoal-directory-or-null>
derived-from:
  - <source-conversation-or-artifact>
---

# Goal: <Goal Title>

Artifact naming rule: the main goal artifact uses the same base name as the
goal directory.

## 1. Summary

A short description of the goal as a desired verifiable state.

## 2. Subject of the Goal

### Subject

* <person>
* <agent, project, system>
* <organization, or other actor>

### Owner 

<who is responsible for goal decisions>

### Stakeholders

<optional>

## 3. Motivation

- Why does this goal matter?
- What value would achieving it create?
- What happens if it is not pursued?

## 4. Current State

Describe the starting point.

### Known facts

<list of known facts>

### Relevant environment

<social group or environment, local computing, cloud computing, or something else>

### Existing related goals or subgoals

<list of existing goals or subgoals with their import statuses: [none|candidate|imported|rejected]>

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
- Cost:
- Technical constraints:
- Social / legal / ethical constraints:
- Other:

## 8. Resources

- Available resources:
- Missing resources:
- Tools or systems:
- People or organizations:

## 9. Open Questions

- [ ] <question that must be resolved before path discovery>

## 10. Boundaries / Non-Goals

- What is outside the goal?
- What should not be optimized or pursued?

## 11. Related Plan Variants

<Use this section when the goal has one or multiple plan variants.>

| Variant | Artifact | Role | Author | Device | Time | Selection Status | Use |
| --- | --- | --- | --- | --- | --- | --- | --- |
| <variant-id> | <plan-artifact-id-or-path> | <canonical-community|personal-variant|imported-variant|experimental-variant|hybrid-variant> | <author> | <device> | <YYYY-MM-DDTHH:MM:SS+HH:MM> | <candidate|selected|superseded|rejected|promoted-to-canonical> | <compare|active|reference|promote|archive> |


## 12. Existing Plan Implementations

<Use this section only when importing existing implementations of a plan for this
goal, for reference, comparison, or verification. Link to the imported plan or
package that contains its own execution state and result artifacts.>

| Implementation | Artifact or Package | Author | Device | Time | Use |
| --- | --- | --- | --- | --- | --- |
| <implementation-id> | <plan-artifact-or-package-id-or-path> | <author> | <device> | <YYYY-MM-DDTHH:MM:SS+HH:MM> | <reference|comparison|verification> |

```
