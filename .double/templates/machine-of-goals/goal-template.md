---
double-repository: https://github.com/densclub-rs/double
style: double
submodule: machine-of-goals
id: goal-template
kind: template
status: stable
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
status: draft
template-id: goal-template
project-id: <stable-project-id>
produced-by: machine-of-goals/goal-formulation-agent
double-repository: https://github.com/densclub-rs/double
  # project-repository: <confirmed-project-repository-address; omit when absent>
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

## 11. Goals Artifacts

Possible paths: [Path options](./path-options.md#<goal-id>-path-options)

| Branch | Review revision | Plan |
| --- | --- | --- |
| <default-branch> | <positive-integer> | [<plan-title>](./plan.md#<plan-id>) |

| Started | Plan | Realization |
| --- | --- | --- |
| <actual-start-with-timezone> | [Plan](./plan.md#<plan-id>) | [<realization-label>](./_realizations/<YYYY-MM-DDTHH-mm-ss>/realization.md#<realization-id>) |

### Available Automatic Realizations

#### <existing-mechanism-label>

- Mechanism: [<label>](<existing-mechanism-path>)
- Plan and assessed revision: [<plan-title>](./plan.md#<plan-id>), <revision>
- Coverage: <specific-stages-transitions-or-operations>
- Boundaries and manual remainder: <uncovered-work-and-compatibility-limits>
- Usage, inputs and dependencies: [<instructions>](<existing-instructions-path>)
- Checks: <initial-required-intermediate-final-checks-and-responsible-actors>
- Authority: <permissions-restrictions-decisions-and-stop-points>
- Evidence: <contextual-links-verified-scope-and-environment-or-explicitly-unknown>
- Gaps: <unchecked-claims-and-runtime-limits>

### Sharing Realizations

| Plan | Type | Realization | Documentation |
| --- | --- | --- | --- |
| [<plan-title>](./plan.md#<plan-id>) | <Manual\|Automatic> | [<label>](<existing-realization-path>) | [<label>](<existing-documentation-path>) or — |

```

## Artifact Navigation Scope

The plan table records every actual plan's `id`, branch, review revision and
file/anchor. The ordinary editable filename is `plan.md`.
Every plan has `id` as its sole plan identifier in frontmatter, generated as one short
human-readable word derived from the plan's context: jointly express its
subject, core meaning and goal in a single word. The root anchor equals `id`.
The sample row links ordinary `plan.md#<plan-id>`; include it only when that file
exists, substituting the actual plan's `id`. Parallel variants use `plan-<id>.md`;
author variants use `plan<owner_id>.md`, without a hyphen after `plan`. Each plan
uses its own generated word as its root anchor regardless of filename. A goal
may start with parallel variants and have no ordinary plan. Preserve every
actual row/file; ordinary revisions keep the same `id`, branch and filename.
Do not add hypothetical rows or infer a new file from branch metadata.

Omit the table only before any plan exists. Plan/realization rows appear
only after authorized step-05 start. The realization owns current stage,
progress and checks. Review revisions are not execution plan versions; no
separate registration, decision, execution index or computed style is required.

To inspect manual progress, open the applicable realization from this table;
its execution-status, current-stage and Stage Map identify completed and remaining work.
Do not mirror stage progress into the goal or plan. Determine activity from the
realization's actual state, not merely the latest timestamp; show no active
realization or multiple candidates explicitly. Link only existing documents.
An invoked collapsed skill/action needs no synthetic realization row or local
execution files. An existing reusable mechanism may be linked in context.

Available Automatic Realizations is optional and records only established
existing mechanisms on an authorized description request. Omit the section when
none exist; omit placeholder entries. Use the workflow's Existing Automatic
Mechanisms contract for coverage, independent evidence claims and authority.
References may supply the entry's details without copying documentation.
An availability entry is not an execution row or a sharing decision. Describing
it requires no invocation, creates no mechanism and does not accept the goal.
When inspecting the goal, show coverage, manual remainder and verification gaps;
recheck compatibility before selection. Never infer full validation from tests.

Sharing Realizations lists only existing manual examples and automatic mechanisms
the user has chosen to share; omit the table when none are selected. Offer to add
an appropriate documented walkthrough or created mechanism, and add it only
with the user's decision, including an unfinished example when explicitly chosen.
Link its plan and existing realization; use — if documentation is absent. Update
or report stale links when related files move or disappear. This list is separate
from the execution-progress table and supplies candidates, not an automatic selection,
for export.
