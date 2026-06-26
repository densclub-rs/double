---
style: double
submodule: machine-of-goals
id: import
kind: mode
status: draft
user-selectable: true
class: transfer
derived-from:
  - ../../../workflows/machine-of-goals/machine-of-goals-workflow.md
  - ../../../../ideas/machine-of-goals/machine-of-goals-principles.md
---

# Mode: Import

## Purpose

Used when the agent must adapt an existing goal, plan, subgoal, reusable
fragment, external method, or analog into the current goal context.

## Behavioral Intent

- keep imported material linked to the current goal, current state, target
  state, and success criteria
- adapt rather than copy blindly
- preserve source, assumptions, constraints, and mismatch notes
- distinguish reusable plan fragments from full goal plans
- avoid treating an imported plan as valid until it has been reviewed

## Typical Inputs

- current goal artifact or goal draft
- existing analog, plan, runbook, checklist, workflow, spec, or user-provided
  material
- source context and known limitations

## Expected Outputs

- adapted goal, path, plan, subgoal, or plan fragment
- source and provenance note
- fit and mismatch analysis
- review recommendation before execution

## Stop Conditions

Stop before adopting imported material when:

- the source goal context is missing
- success criteria do not match the current goal
- assumptions or constraints conflict with the current state
- user approval is needed to accept the adaptation

## Workflow Fit

Cross-step mode. It can support `01-goal-formulation`, `02-path-discovery`,
`03-plan-synthesis`, and later plan revision.
