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
project-id: <stable-project-id>
produced-by: goal-formulation-agent
owner-id: double-project
interaction-language: <language-code-or-name-used-for-dialogue>
artifact-language: <language-code-or-name-used-for-this-artifact>
goal-scope: <main-goal|subgoal>
# Subgoal-only field: parent-goal-id: <parent-goal-id>
derived-from:
  - <source-conversation-or-artifact>
---

<a id="<goal-id>"></a>

# Goal: <Goal Title>

Artifact naming rule: the main goal artifact uses the same base name as the
goal directory.

## 1. Summary

A short description of the goal as a desired verifiable state.

For a subgoal only: Parent goal: [<parent-goal-title>](../<parent-goal-id>.md#<parent-goal-id>)

## 2. Subject of the Goal

### Subject

* <person>
* <agent, project, system>
* <organization, or other actor>

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

<list of linked goals or subgoals with relation: [none|candidate|direct-reference|imported|rejected], source project, artifact id, revision, and link scope when external>

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

## 11. Machine of Goals Artifacts

- Path and realization registry: [Path options](./path-options.md#<goal-id>-path-options)
- Plan: [Current plan](./plan.md#<goal-id>-plan)
- Realization decision: [Current decision](./realization-decision.md#<goal-id>-realization-decision)
- Retained execution attempts: [Run index](./run/index.md#<goal-id>-run-index)
- Computed plan style: <single-pass|multi-pass|not-yet-computed>

```
