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

Used when the agent must compare a stage attempt result or goal result with
explicit criteria, guide the validation dialogue to an explicit decision, and
decide what the active plan artifact should become.

## Behavioral Intent

- validate against criteria rather than narrative confidence
- distinguish accepted, rejected, partial, blocked, and needs-revision results
- conduct the validation dialogue until an explicit decision is reached
- record the compact validation decision in the relevant stage detail of the
  active plan artifact
- link evidence, checks, errors, elapsed cost, and relevant observations from
  `results/` when they are too detailed for the plan
- update metrics and risks where the plan tracks them
- decide whether to continue, branch, revise, reformulate, export, pause, or
  close the goal

## Typical Inputs

- stage-attempt-result artifact
- validation criteria
- goal and plan artifacts
- execution evidence, logs, files, screenshots, user confirmation, or external
  proof

## Expected Outputs

- updated plan artifact
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
standalone validation file; it records validation decisions in the active plan.
