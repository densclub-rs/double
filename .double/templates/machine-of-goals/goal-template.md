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
owner-id: densclub
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

| Branch | Review revision | Plan |
| --- | --- | --- |
| <default-branch> | <positive-integer> | [<plan-title>](./plan.md#<plan-id>) |

| Started | Frozen plan | Realization |
| --- | --- | --- |
| <actual-start-with-timezone> | [Plan v1](./_realizations/<YYYY-MM-DDTHH-mm-ss>/plan-v1.md#<plan-id>) | [<realization-label>](./_realizations/<YYYY-MM-DDTHH-mm-ss>/realization.md#<realization-id>) |

```

## Artifact Navigation Scope

The plan table records every actual plan's `id`, branch, review revision and
file/anchor. The ordinary editable filename is `plan.md`.
Every plan has only `id` in frontmatter, generated as one short
human-readable word derived from the plan's context: jointly express its
subject, core meaning and goal in a single word. The root anchor equals `id`.
The sample row links ordinary `plan.md#<plan-id>`; include it only when that file
exists, substituting the actual plan's `id`. Parallel variants use `plan-<id>.md`;
author variants use `plan<owner_id>.md`, without a hyphen after `plan`. Each plan
uses its own generated word as its root anchor regardless of filename. A goal
may start with parallel variants and have no ordinary plan. Preserve every
actual row/file; ordinary revisions keep the same `id`, branch and filename.
Do not add hypothetical rows or infer a new file from branch metadata.

Omit the table only before any plan exists. Frozen-plan/realization rows appear
only after authorized step-05 start. The realization owns current stage,
progress and checks. Review revisions are not execution plan versions; no
separate registration, decision, execution index or computed style is required.

To inspect manual progress, open the applicable realization from this table;
its status, current-stage and Stage Map identify completed and remaining work.
Do not mirror stage progress into the goal or plan. Determine activity from the
realization's actual state, not merely the latest timestamp; show no active
realization or multiple candidates explicitly. Link only existing documents.
An invoked collapsed skill/action needs no synthetic realization row or local
execution files. An existing reusable mechanism may be linked in context.
