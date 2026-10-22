---
style: double
submodule: machine-of-goals
id: plan-model-template
kind: template
status: release-candidate
workflow-stage: plan-synthesis
interaction-language: en
artifact-language: en
derived-from:
  - ../../workflows/machine-of-goals/machine-of-goals-workflow.md
  - ../../../ideas/machine-of-goals/machine-of-goals-principles.md
---

# Template: Plan (Planning)

## Model Contract

- Name the generated document `Plan`, with heading
  `# Plan: <Goal Title> / <Branch>`. `plan-model` identifies its technical
  planning role; it does not replace the user-facing artifact name.
- Step 03 creates an editable `plan-model-<branch>.md`, not an execution plan.
  Independent named branches may coexist. Increment `model-revision` whenever
  content changes; this review aid is distinct from an execution plan version.
- Step 04 approves exact file content (actual SHA-256 digest), selected path,
  entry stage and execution boundaries. Retain the explicit decision in the
  conversation; do not add self-referential approval hashes to this model.
- Every model edit invalidates its previous approval for future action. Review
  the new content before executing it. Approval alone creates no execution files.
- Only the authorized start of step 05 freezes the approved model using
  `plan-template` as `realizations/<start>/plan-v1.md` and creates its realization.
  Never create these files or their directory during synthesis or review.
- Stages have stable IDs (`S01`), anchors (`stage-s01`) and short English slugs.
  Identify input/output conditions locally (`I01`, `O01`) and explain checks.
  Exit conditions cover the goal's target and success criteria. Offer documentary
  evidence first, with explicit user statements as an identified fallback.
- The manual/interactive model contains expected transitions only: no execution
  checkboxes, progress, registry, run index or computed automation style.
  Facts and acceptance belong to realization/stage records. Preserve frozen plans
  unchanged when editing the model; changed execution needs an approved successor.
- Omit unused optional fields and sections. Keep metadata in frontmatter.

## Model Shape

````md
---
id: <goal-id>-plan-model-<branch>
kind: plan-model
template-id: plan-model-template
project-id: <stable-project-id>
produced-by: machine-of-goals/plan-synthesis-agent
interaction-language: <interaction-language>
artifact-language: <artifact-language>
goal-id: <goal-id>
branch: <branch-name>
model-revision: <positive-integer>
derived-from:
  - <goal-artifact-path>
---

<a id="<goal-id>-plan-model-<branch>"></a>

# Plan: <Goal Title> / <Branch>

Goal: [<goal-title>](./<goal-id>.md#<goal-id>)

## Model

- Initial state: <expected-starting-state>
- Target state: <desired-result>
- Success criteria: <what-establishes-goal-achievement>

## Selection and Control Boundaries

- Available paths/subplans and material differences: <when-alternatives-exist>
- Entry stages: <eligible-entries>
- Execution boundaries and required stop points: <scope-and-authority>

## Stages

| Stage | Input | Output | Next |
| --- | --- | --- | --- |
| [S01: Prepare Documents](#stage-s01) | <required-state> | <expected-state> | [S02](#stage-s02) |
| [S02: Submit Application](#stage-s02) | <required-state> | <expected-state> | <stage-link-or-end> |

<a id="stage-<stage-id-lowercase>"></a>

## <Stage ID>: <Short English Name>

Stage slug: `<short-english-kebab-case-name>`

### Input Conditions

- I01: <condition-and-how-it-can-be-established>

### Actions

<the-intended-action-dependencies-and-stop-points>

### Output Conditions

- O01: <condition-and-how-it-can-be-established>
````

Repeat stage blocks for actual stages with matching IDs, anchors and slugs.
The sample map rows are examples. Add path/subgoal links in context only when
needed. A model change never rewrites a plan or facts of an earlier realization.

## Existing Shape for Other Execution Modes

The legacy editable model filename is `plan.md`. Its registration/run and
computed-style mechanisms remain available; those bookkeeping fields do not
make it a frozen execution plan. Step 03 emits `plan-model` using this shape.
The universal [execution boundary](../../workflows/machine-of-goals/machine-of-goals-workflow.md#plan-model-execution-boundary)
applies: no registration or executor files until the authorized start of step 05.
The immutable snapshot is created from `plan-template`, not this template.

```md
---
id: <goal-id>-plan
kind: plan-model
template-id: plan-model-template
project-id: <stable-project-id>
produced-by: machine-of-goals/plan-synthesis-agent
interaction-language: <language-code-or-name-used-for-dialogue>
artifact-language: <language-code-or-name-used-for-this-artifact>
goal-id: <goal-id>
goal-artifact: <path-to-goal-artifact>
path-options-artifact: <goal-directory>/path-options.md
plan-model-artifact: <goal-directory>/plan.md
plan-execution-style: <single-pass|multi-pass|not-yet-computed>
parent-goal-id: <parent-goal-id-or-null>
parent-plan-model-artifact: <parent-plan-model-artifact-or-null>
# Keep both fields null until the first realization is registered.
plan-revision: <positive-integer-or-null>
plan-revision-artifact: <plan-revision-artifact-path-or-null>
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

Use this section for stable stage topology. The `Progress` column is a derived
visual projection of one explicitly named run, not the source of execution
state. Detailed status and validation remain in that `plan-run`.

- Displayed run: [<run-label>](./run/<realization-record-id>--<YYYYMMDDTHHMMSSZ>.md#<run-id>) or none
- Displayed plan revision: [Revision <N>](./realizations/plan-revision-<N>.md#<goal-id>-plan) or none
- Progress synchronized at: <YYYY-MM-DDTHH:MM:SSZ-or-never>

Mirror progress by stable stage id only after checking frozen-contract and
dependency compatibility. Revision equality alone is insufficient. Leave new
unstarted stages neutral and clear incompatible projections. Never modify an
immutable plan-revision snapshot to show execution progress.

Legend: `⚪` not started; `🔄` in progress; `🟠` awaiting validation; `✅`
accepted; `🟡` partial; `⛔` blocked; `❌` failed or rejected; `🛠️` needs
revision; `➖` not selected.

| Progress | Stage | Kind | Inputs | Outputs | Possible Next Stages | Required Validation |
| --- | --- | --- | --- | --- | --- | --- |
| ⚪ | [S01: <Stage 1 Name>](#stage-s01) | <stage|choice|subplan|merge|validation> | [<input artifact>](<input-artifact-link>) | [<output artifact>](<output-artifact-link>) | [S02](#stage-s02) | <check-id> |
| ⚪ | [S02: <Stage 2 Name>](#stage-s02) | <stage|choice|subplan|merge|validation> | [S01](#stage-s01) | <state-or-artifact> | [S03](#stage-s03) | <check-id> |

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

- Edit the model for future work; log changes, assess dependencies and obtain renewed review before changed content executes.
- Revise a stage when:
- Return every transition edit to review; freeze a new baseline only at authorized execution start and identify revalidation or rework:
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

Before authorized execution, keep revision fields null and refine only this
model. Review approves exact transition content, selection and boundaries;
never register, freeze or create a realization during planning/review.
Only at the authorized start of step 05, create the immutable execution plan
using `plan-template`, rebase links and exclude mutable registry/progress data.
Then register the selected realization and create its decision and artifact.
Existing snapshots are immutable; a changed model requires renewed review and
a new execution baseline before changed actions, including unstarted stages.
Bookkeeping alone does not revise approved transition content. Preserve runs
and original acceptance; never rebind their baseline.

<a id="plan-change-log"></a>

## 11. Plan Change Log

Append entries for post-baseline plan edits, including those creating a revision.
Keep prior entries and stable stage ids. Do not overwrite a frozen run contract.

<a id="plan-change-<change-id>"></a>

### <Change Id> — <YYYY-MM-DDTHH:MM:SSZ>

- Affected stages and change:
- Reason:
- Frozen obligations affected: <none-or-contract-links>
- Dependency impact and earlier-result applicability:
- Realization compatibility and approval scope:
- Decision: <review-required|approved-for-new-execution>
- Baseline and any new revision:
- Revalidation or rework: <required-work-and-original-evidence-links> or none

## 12. Open Questions

- [ ] <question that affects planning or validation>
```
