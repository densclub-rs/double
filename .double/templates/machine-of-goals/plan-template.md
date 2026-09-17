---
style: double
submodule: machine-of-goals
id: plan-template
kind: template
status: release-candidate
workflow-stage: plan-synthesis
interaction-language: en
artifact-language: en
derived-from:
  - ../../workflows/machine-of-goals/machine-of-goals-workflow.md
  - ../../../ideas/machine-of-goals/machine-of-goals-principles.md
---

# Template: Plan

```md
---
id: <goal-id>-plan
kind: plan-artifact
template-id: plan-template
project-id: <stable-project-id>
produced-by: plan-synthesis-agent
interaction-language: <language-code-or-name-used-for-dialogue>
artifact-language: <language-code-or-name-used-for-this-artifact>
goal-id: <goal-id>
goal-artifact: <path-to-goal-artifact>
path-options-artifact: <goal-directory>/path-options.md
plan-artifact: <goal-directory>/plan.md
goal-scope: <main-goal|subgoal>
plan-execution-style: <single-pass|multi-pass|not-yet-computed>
parent-goal-id: <parent-goal-id-or-null>
parent-plan-artifact: <parent-plan-artifact-or-null>
plan-revision: <positive-integer>
# Use null before the execution commit point.
plan-revision-artifact: <goal-directory>/realizations/plan-revision-<N>.md
created-at: <YYYY-MM-DDTHH:MM:SSZ>
updated-at: <YYYY-MM-DDTHH:MM:SSZ>
derived-from:
  - <goal-artifact-id-or-path>
  - <path-options-id-or-path>
---

<a id="<goal-id>-plan"></a>

# Plan: <Goal Title>

## 1. Plan Summary

Briefly describe the plan as one transition model from the current state to the
target state. Alternative achievement choices belong inside the model as paths,
branches, or subplans.

- Source goal: [<goal-title>](./<goal-id>.md#<goal-id>)
- Source paths: [Path options](./path-options.md#<goal-id>-path-options)
- Parent plan for a subgoal: [<parent-plan-title>](../plan.md#<parent-goal-id>-plan) or none

### Current State

<summary of the starting state>

### Target State

<summary of the desired state>

### Success Criteria

<summary of the conditions that establish success>

## 2. State Validation Contract

- Initial state checks:
- Required intermediate state checks:
- Final state checks:
- Evidence requirements:
- Stop when validation cannot be completed:

## 3. Plan Map

Use this section for stable stage topology. Execution status and checkboxes do
not belong here; they are instantiated in the selected `plan-run`.

| Stage | Kind | Inputs | Outputs | Possible Next Stages | Required Validation |
| --- | --- | --- | --- | --- | --- |
| [S01: <Stage 1 Name>](#stage-s01) | <stage|choice|subplan|merge|validation> | [<input artifact>](<input-artifact-link>) | [<output artifact>](<output-artifact-link>) | [S02](#stage-s02) | <check-id> |
| [S02: <Stage 2 Name>](#stage-s02) | <stage|choice|subplan|merge|validation> | [S01](#stage-s01) | <state-or-artifact> | [S03](#stage-s03) | <check-id> |

## 4. Stage Details

<a id="stage-<stage-id>"></a>

### Stage: <Stage Name>

- Stage id: `<stage-id>`
- Kind: <stage|choice|subplan|merge|validation>
- Purpose:
- Input state:
- Output state:
- Preconditions:
- Actions:
- Required resources:
- Possible input stages:
  - [<Input Stage Name>](#stage-<input-stage-id>)
- Possible output stages:
  - [<Output Stage Name>](#stage-<output-stage-id>)
- Related paths or subplans:
  - [<path-or-subplan-label>](./path-options.md#<path-or-subplan-id>)
- Referenced goal, plan, realization, or artifact:
  - [<artifact-label>](<artifact-or-anchor-link>)
  - Relation: <local|parent|child|direct-reference|imported>
  - Source project: <project-id-or-current>
  - Source artifact: <artifact-id>
  - Revision: <current|exact-revision-or-vcs-ref>
  - Link scope: <project|workspace|remote>
- Validation criteria:
- Evidence expected:
- Risks:
- Stop points:

## 5. Shared Dependencies

- Internal dependencies:
- External dependencies:
- Decision dependencies:

## 6. Shared Risks and Controls

- Risk:
- Impact:
- Mitigation:
- Stop condition:

## 7. Automation Boundaries

- Allowed automatic actions:
- Actions requiring confirmation:
- Actions not allowed:
- Dry-run required before:

## 8. Revision and Alignment Conditions

- Revise a stage when:
- Revise the plan when:
- Reformulate the goal when:
- Mark realizations `review-required` when:

## 9. Subgoal Integration Boundaries

Add one row for every delegated subgoal plan.

| Subgoal | Subgoal Plan | Entry Stage | Input Artifact | Output Artifact | Exit Stage | Parent Continuation |
| --- | --- | --- | --- | --- | --- | --- |
| [<subgoal-title>](./<subgoal-id>/<subgoal-id>.md#<subgoal-id>) | [<subgoal-plan-title>](./<subgoal-id>/plan.md#<subgoal-id>-plan) | [<stage-label>](#stage-<stage-id>) | [<artifact-label>](<artifact-link>) | [<artifact-label>](<artifact-link>) | [<subgoal-stage-label>](./<subgoal-id>/plan.md#stage-<stage-id>) | [<stage-label>](#stage-<stage-id>) |

<a id="realization-registry"></a>

## 10. Realization Registry

Add a new row whenever a realization is registered. Selecting another path or
subplan always creates a new row, even when it reuses the same realization
mechanism or implementation. Preserve earlier rows as realization history.

| Record | Realization Artifact | Realization | Kind | Selected Path or Subplan | Decision | Plan Revision | Realization Revision | Registration | Readiness | Alignment | Runs | Last Run | Last Result |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---: | --- | --- |
| <a id="<realization-record-id>"></a>`<realization-record-id>` | [<realization-label>](./realizations/<realization-record-id>.md#<realization-record-id>) | [<realization-label>](<definition-or-implementation-link>) | <manual|shell|python|workflow|agentic|external> | [<path-or-subplan-label>](./path-options.md#<path-or-subplan-id>) | [<decision-label>](./realization-decision.md#<goal-id>-realization-decision) | [Revision <N>](./realizations/plan-revision-<N>.md#<goal-id>-plan) | [Revision <R>](./realizations/<realization-record-id>.md#<realization-record-id>-revision-<R>) | <registered|retired> at <YYYY-MM-DDTHH:MM:SSZ> | <draft|ready|unvalidated|failed> | <aligned|review-required|incompatible> | <count> | <YYYY-MM-DDTHH:MM:SSZ-or-never> | <running|succeeded|partial|failed|blocked|cancelled|precondition-failed|never> |

`plan-execution-style` is computed from active rows: it is `multi-pass` when
at least one automatic realization is registered and `single-pass` otherwise.
Registration is the transition point.

Statistics are cumulative and remain after bounded run files are removed.
Individual retained runs are linked from each realization artifact and the
shared [run index](./run/index.md#<goal-id>-run-index), not from this registry.
Retain three to five terminal runs per realization record, with five as the
default.

After path confirmation and registry update, copy this `plan.md` to
`./realizations/plan-revision-<N>.md`, rebase relative links for the deeper
directory, and never overwrite an existing snapshot. A VCS permalink may be
recorded as additional evidence. A new realization row or topology change
creates the next plan revision; aggregate-only updates to an existing row do
not.

After the decision is committed, create the linked
`./realizations/<realization-record-id>.md` before any run is created.

## 11. Open Questions

- [ ] <question that affects planning or validation>
```
