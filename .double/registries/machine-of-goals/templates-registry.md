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
| `plan-run` | `plan-run-template` | `.double/templates/machine-of-goals/plan-run-template.md` |
| `run-index` | `run-index-template` | `.double/templates/machine-of-goals/run-index-template.md` |
| `exported-plan-package` | `exported-plan-package-template` | `.double/templates/machine-of-goals/exported-plan-package-template.md` |

## Usage Rule

- use templates as draft artifact shapes, not final storage contracts
- copy the template's top-level `id` into the generated artifact's
  frontmatter `template-id`; do not replace it with the template path or the
  generated artifact id
- preserve `template-id` when revising an artifact or copying `plan.md` into a
  `realizations/plan-revision-<N>.md` snapshot
- use the workflow file as the canonical source for step order and transition
  conditions
- use agent cards and the agents registry to determine which agent produces
  each artifact
- update this registry when an artifact template is added, renamed, split, or
  removed
