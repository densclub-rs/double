---
style: double
submodule: machine-of-goals
id: import
kind: mode
status: release-candidate
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

- do not import an authoritative external artifact when a direct reference is
  sufficient; import only when material must be copied or adapted
- preserve contextual Markdown links and exact source revisions

- keep imported material linked to the current goal, current state, target
  state, and success criteria
- adapt rather than copy blindly
- preserve source, assumptions, constraints, and mismatch notes
- import a multi-pass plan by adapting its goal context, `plan.md`,
  `path-options.md` catalog, section 10 realization registry, and validation
  contracts
- append imported realization rows to section 10 of `plan.md` and recompute
  computed style
- exclude bounded working run logs by default
- distinguish reusable plan fragments from full goal plans
- avoid treating an imported plan as valid until it has been reviewed

## Typical Inputs

- current goal artifact or goal draft
- existing analog, plan, runbook, checklist, workflow, spec, or user-provided
  material
- imported path-options catalog and plan realization registry
- registered automatic realization artifacts and their source context
- source context and known limitations

## Expected Outputs

- adapted goal, path, plan, subgoal, or plan fragment
- adapted single plan with selectable paths or subplans
- registered realization rows in section 10 of `plan.md`
- source and provenance note
- fit and mismatch analysis
- review recommendation before execution

## Stop Conditions

Stop before adopting imported material when:

- the source goal context is missing
- success criteria do not match the current goal
- assumptions or constraints conflict with the current state
- imported paths or validation contracts cannot be reconciled with the current
  goal
- user approval is needed to accept the adaptation

## Workflow Fit

Cross-step mode. It can support `01-goal-formulation`, `02-path-discovery`,
`03-plan-synthesis`, and later plan revision.
