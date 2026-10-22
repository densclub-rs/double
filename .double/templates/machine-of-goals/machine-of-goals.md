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
- [Plan Template](./plan-template.md)
- [Realization Decision Template](./realization-decision-template.md)
- [Realization Artifact Template](./realization-template.md)
- [Stage Realization Template](./stage-realization-template.md)
- [Plan Run Template](./plan-run-template.md)
- [Run Index Template](./run-index-template.md)
- [Exported Plan Package Template](./exported-plan-package-template.md)

## Draft Interpretation

These templates define the first draft artifact shapes for Machine of Goals
workflow outputs. They are process templates, not final storage formats. Every
generated artifact records the source template's stable top-level `id` in its
frontmatter `template-id`.

## Model and Realization Contract Scope

The first shapes in the Plan and Realization templates, together with the
Stage Realization template, define concise manual/interactive documents:
one branch/version model, one timestamped realization with its current stage
and map, and three-part stage records with input/output checks and evidence.
Documentary evidence is requested first; an explicit user statement is an
identified fallback when documents cannot be provided.

Generated documents use Markdown frontmatter and readable names without a
mode prefix. They do not require separate decision, registration, run-index,
evidence, or validation artifacts. Existing other-mode shapes remain in the
relevant templates. Manual and interactive routing is defined by the
[Model and Realization Execution Rule](../../workflows/machine-of-goals/machine-of-goals-workflow.md#model-and-realization-execution-rule).
Collapsing, skills, automatic actions, and migration of existing goal artifacts
are outside this route synchronization.
