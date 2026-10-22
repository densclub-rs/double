---
style: double
submodule: machine-of-goals
id: templates-registry
kind: registry
status: release-candidate
---

# Templates Registry

## Purpose

This registry lists draft artifact templates used by Machine of Goals workflow
outputs and their stable template identifiers.

## Templates

| Artifact Kind | Template ID | Template |
| --- | --- | --- |
| `goal-artifact` | `goal-template` | `.double/templates/machine-of-goals/goal-template.md` |
| `path-options` | `path-options-template` | `.double/templates/machine-of-goals/path-options-template.md` |
| `plan-artifact` | `plan-template` | `.double/templates/machine-of-goals/plan-template.md` |
| `realization-decision` | `realization-decision-template` | `.double/templates/machine-of-goals/realization-decision-template.md` |
| `realization-artifact` | `realization-template` | `.double/templates/machine-of-goals/realization-template.md` |
| `stage-realization` | `stage-realization-template` | `.double/templates/machine-of-goals/stage-realization-template.md` |
| `plan-run` | `plan-run-template` | `.double/templates/machine-of-goals/plan-run-template.md` |
| `run-index` | `run-index-template` | `.double/templates/machine-of-goals/run-index-template.md` |
| `exported-plan-package` | `exported-plan-package-template` | `.double/templates/machine-of-goals/exported-plan-package-template.md` |

## Usage Rule

- use templates as draft artifact shapes, not final storage contracts
- copy the template's top-level `id` into the generated artifact's
  frontmatter `template-id`; do not replace it with the template path or the
  generated artifact id
- update this registry when an artifact template is added, renamed, split, or
  removed

## Model and Realization Shape

For manual and interactive execution, use the model and realization shapes
at the beginning of `plan-template` and `realization-template`, and use
`stage-realization-template` for stage documents. Their generated artifact
names do not include an execution-mode prefix.

- Model: `plan-<branch>-v<major>.md`, with `branch` and `plan-version` in
  Markdown frontmatter, stable stage anchors, and short English stage names.
  Independent branches may coexist; compatible updates stay in one file,
  while a major model change preserves the earlier model in another file.
- Realization: `realizations/<YYYY-MM-DDTHH-mm-ss>/realization.md`, with
  actual start, timezone, model identity/content digest, current stage, and
  a compact progress map. Selection context is included here when needed.
- Stage: `<stage-id-lowercase>-<stage-slug>.md` in that same directory, with
  three main parts: input state, actions, and output state. Capture effective
  conditions and intended action before execution and retain factual results.
- Request suitable documentary evidence for input and output checks. If it
  cannot be provided, an explicit user statement can support acceptance;
  preserve that basis without claiming independent documentary verification.
  Silence and unrelated evidence do not establish acceptance.
- Keep progress only in the realization. Accept input conditions before stage
  action and output conditions before completion. Model changes end the
  realization and require a linked successor; inherit results only after an
  applicability check and retain their original factual context.
- Do not require a separate realization decision, registration wrapper, run,
  run index, evidence manifest, or validation document for this shape.
- Keep generated documents concise; omit unused optional fields and sections.

The [Model and Realization Execution Rule](../../workflows/machine-of-goals/machine-of-goals-workflow.md#model-and-realization-execution-rule)
routes manual and interactive steps 03–06 to these shapes. Existing other-mode
shapes and rules below remain separately scoped; they must not be added as
mandatory layers to this route. No skill, collapsing, or automatic-action
behavior is changed here.

## Existing Rules for Other Execution Modes

- preserve `template-id` when revising an artifact or copying `plan.md` into a
  `realizations/plan-revision-<N>.md` snapshot
- keep the plan template's revision fields null before the first realization;
  freeze revision 1 for the first executable baseline and revise thereafter
  only when frozen stage obligations change; log compatible future-only edits
  without a revision
- capture each effective stage contract in the run before action; use captured
  criteria and evidence for validation, preserving historical baseline links
- use the workflow file as the canonical source for step order and transition
  conditions
- use agent cards and the agents registry to determine which agent produces
  each artifact
