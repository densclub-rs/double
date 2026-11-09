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
At authorized start the realization and stage records link the approved main
plan. No local plan copy is created. The records own progress and evidence;
plans contain expected transitions only. Before an incompatible edit, follow the
workflow's preservation decision. Documentary evidence is requested first;
explicit user statements are an identified fallback when unavailable.
A collapsed skill/action creates no Machine of Goals execution records when
invoked. See the
[execution rule](../../workflows/machine-of-goals/machine-of-goals-workflow.md#model-and-realization-execution-rule)
and [execution boundary](../../workflows/machine-of-goals/machine-of-goals-workflow.md#plan-model-execution-boundary).
Existing goal migration is a separate authorized operation.
