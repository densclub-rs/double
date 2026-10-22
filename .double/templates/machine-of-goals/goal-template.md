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
template-id: goal-template
project-id: <stable-project-id>
produced-by: machine-of-goals/goal-formulation-agent
owner-id: double-project
interaction-language: <language-code-or-name-used-for-dialogue>
artifact-language: <language-code-or-name-used-for-this-artifact>
# Optional relationship field: parent-goal-id: <parent-goal-id>
derived-from:
  - <source-conversation-or-artifact>
---

<a id="<goal-id>"></a>

# Goal: <Goal Title>

Artifact naming rule: the main goal artifact uses the same base name as the
goal directory.

## 1. Summary

A short description of the goal as a desired verifiable state.

When linked to a parent goal: Parent goal: [<parent-goal-title>](../<parent-goal-id>.md#<parent-goal-id>)

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

Possible paths: [Path options](./path-options.md#<goal-id>-path-options)

| Branch | Version | Model |
| --- | --- | --- |
| <branch> | <MAJOR.MINOR.PATCH> | [<model-title>](./plan-<branch>-v<major>.md#<plan-id>) |

| Started | Model | Realization |
| --- | --- | --- |
| <actual-start-with-timezone> | <branch> / <version> | [<realization-label>](./realizations/<YYYY-MM-DDTHH-mm-ss>/realization.md#<realization-id>) |

```

## Artifact Navigation Scope

For manual and interactive execution, section 11 above links real branch
models and timestamped realizations directly. Add only existing useful rows;
omit a table until its artifacts exist. The realization owns current stage,
progress, and checks, so this goal navigation does not duplicate that state.
No separate registration, decision artifact, run index, or computed automation
style is required for the manual/interactive shape. Parallel branches may
coexist; retained major versions in one branch describe evolution.

## Existing Navigation for Other Execution Modes

The pre-existing section below is retained unchanged for other modes. It is
not an additional navigation block required in a manual/interactive goal.

```md
## 11. Machine of Goals Artifacts

- Possible realization paths: [Path options](./path-options.md#<goal-id>-path-options)
- Plan: [Current plan](./plan.md#<goal-id>-plan)
- Plan realization registry: [Realizations](./plan.md#realization-registry)
- Current plan revision used by realization: [Plan revision <N>](./realizations/plan-revision-<N>.md#<goal-id>-plan) or not yet created
- Realization decision: [Current decision](./realization-decision.md#<goal-id>-realization-decision)
- Current realization: [<realization-label>](./realizations/<realization-record-id>.md#<realization-record-id>) or not yet created
- Retained execution attempts: [Run index](./run/index.md#<goal-id>-run-index)
- Computed plan style: <single-pass|multi-pass|not-yet-computed>

```
