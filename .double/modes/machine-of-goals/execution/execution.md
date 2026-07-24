---
style: double
submodule: machine-of-goals
id: execution
kind: mode
status: release-candidate
user-selectable: true
class: action
default-for:
  - 05-plan-realization
derived-from:
  - ../../../workflows/machine-of-goals/machine-of-goals-workflow.md
  - ../../../../ideas/machine-of-goals/machine-of-goals-principles.md
---

# Mode: Execution

## Purpose

Used when the agent must realize a selected plan stage through action,
delegation, automation, handoff, or creation of implementation artifacts.

## Behavioral Intent

- act only within the selected plan stage and approved boundaries
- explain the stage before irreversible, external, or automated work
- refine the stage when execution reveals missing detail
- create scripts, workflows, checklists, specs, or handoff artifacts only when
  they serve the current stage
- update the active plan artifact with what was attempted, changed, completed,
  or blocked
- store working and intermediate execution artifacts under
  `<goal-directory>/results/`

## Typical Inputs

- realization decision
- selected plan stage
- automation boundaries and stop points
- validation criteria for the stage
- relevant working directory or external context

## Expected Outputs

- stage-attempt-result artifact
- updated plan artifact
- implementation artifact, handoff artifact, or execution note when applicable
- discovered risks, blockers, or revision needs

## Stop Conditions

Stop before continuing when:

- the next action exceeds approved boundaries
- validation criteria are missing
- the stage requires a new decision, subgoal, dry run, or external authority
- the result is ready for validation

## Workflow Fit

Primary mode for `05-plan-realization`. It normally hands off to
`validation` after producing a stage attempt result.
