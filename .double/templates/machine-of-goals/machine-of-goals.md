---
style: double
submodule: machine-of-goals
mindmap-plugin: basic
status: release-candidate
---

# [Machine of Goals](../../.double.md)

## [Templates](../templates.md)

- [Goal Template](./goal-template.md)
- [Path Options Template](./path-options-template.md)
- [Plan Template (Planning)](./plan-model-template.md)
- [Plan Template (Realization)](./plan-template.md)
- [Realization Artifact Template](./realization-template.md)
- [Stage Realization Template](./stage-realization-template.md)
- [Exported Plan Package Template](./exported-plan-package-template.md)

## Draft Interpretation

These templates define the first draft artifact shapes for Machine of Goals
workflow outputs. They are process templates, not final storage formats. Every
generated artifact records the source template's stable top-level `id` in its
frontmatter `template-id`.

## Model and Realization Contract Scope

`plan-model-template` defines the editable `plan.md` by default. Every plan
has only `id`, a generated short human-readable word derived from the plan's
context: jointly express its subject, core meaning and goal in a single word.
Always write it in frontmatter and use it as the root anchor. Revisions and
frozen copies retain this `id`; exact paths, revisions/versions and digests
identify copies. Parallel variants use `plan-<id>.md`; author variants use
`plan<owner_id>.md`, without a hyphen after `plan`. Other artifacts may reference
this `id` using `plan-id`; the plan itself has no duplicate identity field.
Each actual plan has a goal-table row, including variants formed directly at
synthesis after discovery. Source links identify the selected file and anchor.
`plan-template` freezes
approved content only at the authorized manual start of step 05. The Realization and
Stage Realization templates record progress, actions and input/output checks
against that immutable local plan. Documentary evidence is requested first;
explicit user statements remain an identified fallback when unavailable.

After step 03 and deferred step 04, only the model exists. A manual/interactive
start creates `_realizations/<start>/plan-v1.md` and `realization.md` before the
first action. Generated files have no mode prefix. The realization and its
stage records own all progress and evidence; plans contain expected transitions
only. No additional registration, execution journal or index is required.
A collapsed skill/action creates no Machine of Goals execution records when
invoked. See the
[execution rule](../../workflows/machine-of-goals/machine-of-goals-workflow.md#model-and-realization-execution-rule)
and [execution boundary](../../workflows/machine-of-goals/machine-of-goals-workflow.md#plan-model-execution-boundary).
Existing goal migration is a separate authorized operation.
