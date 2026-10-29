---
style: double
submodule: machine-of-goals
id: validation
kind: mode
status: release-candidate
user-selectable: true
class: control
default-for:
  - 06-plan-validation
derived-from:
  - ../../../workflows/machine-of-goals/machine-of-goals-workflow.md
  - ../../../../ideas/machine-of-goals/machine-of-goals-principles.md
---

# Mode: Validation

## Purpose

Compare actual results with applicable conditions; success requires evidence,
not confidence or merely taking an action. Never update the plan with progress.

## Documented Manual Validation

- Inputs: goal criteria, realization, unchanged frozen plan, captured stage
  conditions and actual outputs/evidence.
- Recheck frozen-plan integrity and check outputs against their original
  requirements. Offer documentary evidence first; identify condition-specific
  user statements explicitly when they provide the confirmation basis.
- Record each condition's actual state, confirmation and acceptance decision in
  the stage document. Unconfirmed outputs cannot complete a stage.
- Update the realization's Stage Map/current-stage and Result only. Use the
  canonical emoji meanings; ✅ requires accepted required outputs.
- Preserve applicable inherited facts and their sources; recheck dependencies.
- Check exit conditions and goal criteria before overall completion. Offer the
  eligible next stage, review, reformulation, pause or closure through existing
  continuation rules; export and cleanup remain optional.
- A changed source model blocks further action and needs renewed review and a
  successor, but observed outputs remain verifiable against their original plan.

## Collapsed Automatic Validation

Check the skill/action's actual result against its covered initial, required
intermediate and final conditions. Report accepted results or explicit failures,
missing confirmation and blockers through its normal interface. Create no
Machine of Goals execution or validation document for the invocation.

## Stop Conditions

Do not act on the next stage during validation, weaken criteria, invent
confirmation, rewrite old facts or modify either plan to show execution state.

Canonical workflow: [Machine of Goals](../../../workflows/machine-of-goals/machine-of-goals-workflow.md).
