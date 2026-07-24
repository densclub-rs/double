---
style: double
submodule: machine-of-goals
id: modes-registry
kind: registry
status: release-candidate
---

# Modes Registry

## Purpose

This registry lists user-selectable modes of operation for Machine of Goals.

## Workflow Scope

- workflow: `machine-of-goals-workflow` -> `.double/workflows/machine-of-goals/machine-of-goals-workflow.md`
- workflow registry: `.double/registries/machine-of-goals/workflows-registry.md`

## Available Modes

- `clarification` -> `.double/modes/machine-of-goals/clarification/clarification.md`
- `research` -> `.double/modes/machine-of-goals/research/research.md`
- `planning` -> `.double/modes/machine-of-goals/planning/planning.md`
- `review` -> `.double/modes/machine-of-goals/review/review.md`
- `execution` -> `.double/modes/machine-of-goals/execution/execution.md`
- `validation` -> `.double/modes/machine-of-goals/validation/validation.md`
- `explain` -> `.double/modes/machine-of-goals/explain/explain.md`
- `dry-run` -> `.double/modes/machine-of-goals/dry-run/dry-run.md`
- `import` -> `.double/modes/machine-of-goals/import/import.md`
- `export` -> `.double/modes/machine-of-goals/export/export.md`

## Usage Rule

- mode is selected for a specific workflow step or support action
- mode changes how an agent works, but does not replace the current workflow step
- the same agent may support multiple modes
- `import` and `export` are normally handled by the optional `plan-exchange-agent`
- `dry-run` must not cause real-world effects
- `execution` must respect approved automation boundaries
