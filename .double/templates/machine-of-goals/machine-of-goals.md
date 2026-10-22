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

`plan-model-template` defines editable branch models. `plan-template` freezes
approved content only at the authorized start of step 05. The Realization and
Stage Realization templates record progress, actions and input/output checks
against that immutable local plan. Documentary evidence is requested first;
explicit user statements remain an identified fallback when unavailable.

After step 03 and deferred step 04, only the model exists. A manual/interactive
start creates `realizations/<start>/plan-v1.md` and `realization.md` before the
first action. Generated files have no mode prefix. No separate decision,
registration, run index, evidence or validation artifact is required on this
route. Other-mode shapes retain their automation/run mechanisms and legacy
filenames subject to the same start boundary. See the
[execution rule](../../workflows/machine-of-goals/machine-of-goals-workflow.md#model-and-realization-execution-rule)
and [all-mode boundary](../../workflows/machine-of-goals/machine-of-goals-workflow.md#plan-model-execution-boundary).
Existing goal migration is a separate authorized operation.
