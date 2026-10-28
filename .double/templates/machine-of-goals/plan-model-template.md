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
- Generate one short human-readable word as `id` for every new plan and
  always write it as `id: <id>` in frontmatter, including ordinary
  `plan.md` and author variants. The word must be derived from the plan's context
  and must jointly express the plan's subject, core meaning and goal. Synthesize
  these three concepts into a single meaningful word, emphasizing what
  distinguishes this plan from other variants for the same goal. A readable
  coined word is allowed. A word reflecting only one of the three is insufficient.
  Use lowercase English letters only (`^[a-z]+$`), with no spaces or hyphens;
  no digits, hashes or opaque codes. Do not turn the concepts into a multiword
  subject-action-goal name. Do not choose a random word or an unrelated dictionary word.
  Check uniqueness within the goal directory across all plan filenames before
  writing; regenerate on collision by choosing another word derived from the
  plan's context that still combines all three concepts, never adding digits.
  Keep this sole plan ID across revisions and frozen execution copies.
  Each independent new plan receives its own ID. The root anchor equals `id`.
  Do not add a duplicate `plan-id` field to a plan; neither a filename nor
  `owner-id` replaces the mandatory `id`.
- Step 03 creates an editable ordinary plan as `<goal-directory>/plan.md`,
  with its generated word as `id` and root anchor. An independent parallel variant
  uses `plan-<id>.md` and the same word as its ID/anchor. Check ID/filename
  collisions before creating the variant.
- An author's own variant uses `plan<owner_id>.md`, `owner-id: <owner_id>` and
  its own generated word as `id` and root anchor. Use the actual author's safe ID,
  without a hyphen after `plan`; do not infer it from the goal owner. Omit the
  optional `owner-id` when it does not apply; `id` is always required.
  Do not invent combined suffixes.
- Discovery can identify the need for independent parallel variants before
  synthesis. Create each actual variant directly in step 03, without requiring
  a prior ordinary plan or major divergence. Preserve existing files; never
  overwrite another variant. Follow the workflow's collision rule.
- `branch` identifies the logical lineage of each plan's revisions. Record its
  actual file/anchor, branch and review revision in the goal's plan table.
  Ordinary edits increment `plan-revision` in the same file with the same `id`
  and branch. A revision is not a new variant or execution
  plan version. Selectable paths/subplans may remain inside one plan; parallel
  stages and different realization media alone do not create separate plans.
- Step 04 shows a Markdown link to the actual current plan file and requests
  approval of its current contents, selected path, entry and boundaries. Do not
  put a checksum in the approval question, title, choices or normal summary.
  Compute SHA-256 internally before the request and retain that baseline with
  the decision in existing recoverable context for the pre-start change check.
  Do not add a checksum file or self-referential approval hash to this model.
- Every model edit invalidates its previous approval for future action. Review
  the new content before executing it. Approval alone creates no execution files.
- Only the authorized start of step 05 freezes the approved model using
  `plan-template` as `_realizations/<start>/plan-v1.md` and creates its realization.
  Never create these files or their directory during synthesis or review.
- Stages have stable IDs (`S01`), anchors (`stage-s01`) and short English slugs.
  Identify each input/output condition as `<stage-id>-I<condition-number>` or
  `<stage-id>-O<condition-number>`, for example `S01-I01`, `S01-I02`, `S01-O01`
  and `S02-I01`, `S02-O01`. Number inputs and outputs independently within
  each stage, starting at `01` with at least two digits, and explain checks.
  Keep these IDs when freezing the plan and recording or validating conditions.
  Exit conditions cover the goal's target and success criteria. Offer documentary
  evidence first, with explicit user statements as an identified fallback.
- Every plan model contains expected transitions only: no execution
  checkboxes, progress, acceptance, execution registry, index or computed automation style.
  Facts and acceptance belong to realization/stage records. Preserve frozen plans
  unchanged when editing the model; changed execution needs an approved successor.
- Omit unused optional fields and sections. Keep metadata in frontmatter.

## Model Shape

````md
---
id: <id>
kind: plan-model
template-id: plan-model-template
project-id: <stable-project-id>
produced-by: machine-of-goals/plan-synthesis-agent
interaction-language: <interaction-language>
artifact-language: <artifact-language>
goal-id: <goal-id>
branch: <branch-name>
plan-revision: <positive-integer>
derived-from:
  - <goal-artifact-path>
---

<a id="<id>"></a>

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

- <stage-id>-I01: <condition-and-how-it-can-be-established>

### Actions

<the-intended-action-dependencies-and-stop-points>

### Output Conditions

- <stage-id>-O01: <condition-and-how-it-can-be-established>
````

The shape above is the default `plan.md`. For `plan-<id>.md` or
`plan<owner_id>.md`, use the plan's generated `id` as its root anchor and
adapt optional `owner-id` and actual goal-table links under the contract above.
Retain the same `id` and logical branch across revisions. Every review,
frozen-plan provenance and realization source link identifies the actual
selected file and anchor, rather than assuming every variant uses `plan.md`.

Repeat stage blocks for actual stages with matching IDs, anchors and slugs.
The sample map rows are examples. Add path/subgoal links in context only when
needed. A model change never rewrites a plan or facts of an earlier realization.
