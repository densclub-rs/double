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
outputs.

## Templates

- `goal-artifact` -> `.double/templates/machine-of-goals/goal-template.md`
- `path-options` -> `.double/templates/machine-of-goals/path-options-template.md`
- `plan-artifact` -> `.double/templates/machine-of-goals/plan-template.md`
- `realization-decision` -> `.double/templates/machine-of-goals/realization-decision-template.md`
- `stage-attempt-result` -> `.double/templates/machine-of-goals/stage-attempt-result-template.md`
- `exported-plan-package` -> `.double/templates/machine-of-goals/exported-plan-package-template.md`

## Usage Rule

- use templates as draft artifact shapes, not final storage contracts
- use the workflow file as the canonical source for step order and transition
  conditions
- use agent cards and the agents registry to determine which agent produces
  each artifact
- update this registry when an artifact template is added, renamed, split, or
  removed
