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

Used when the agent must compare a run stage or final result with explicit
criteria, guide the validation dialogue to an explicit decision, and update the
run and aggregate realization statistics.

## Behavioral Intent

- validate against criteria rather than narrative confidence
- distinguish accepted, rejected, partial, blocked, and needs-revision results
- conduct the validation dialogue until an explicit decision is reached
- record validation and terminal result in the current run
- replace latest `running` result with the terminal result in `path-options.md`
  without incrementing run count again
- apply bounded run retention after statistics update
- validate exact revision and evidence links and update `run/index.md` when
  retention removes a run
- revise the plan only when the intended transition model changes
- decide whether to continue, branch, revise, reformulate, export, pause, or
  close the goal

## Typical Inputs

- plan-run artifact
- path-options artifact
- validation criteria
- goal and plan artifacts
- execution evidence, logs, files, screenshots, user confirmation, or external
  proof

## Expected Outputs

- updated plan-run and path-options artifacts
- updated plan artifact only when revision is required
- updated goal progress or closure note when applicable
- revision, branch, continuation, or export decision

## Stop Conditions

Stop before advancing when:

- evidence is missing or contradictory
- the result cannot be compared with the criteria
- the stage outcome changes the plan enough to require review
- the goal itself may need reformulation

## Workflow Fit

Primary mode for `06-plan-validation`. It is also the gate before closing a
goal or packaging a reusable plan. The mode does not create a separate
standalone validation file; it records validation decisions in the active run.
