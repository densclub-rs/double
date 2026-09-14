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
- create or resume
  `<goal-directory>/run/<realization-id>--<YYYYMMDDTHHMMSSZ>.md`
- require exact plan and realization revision links and maintain
  `<goal-directory>/run/index.md`
- on creation, increment run count and set latest run time and result `running`
  in `path-options.md`
- update the run with selected paths, checkboxes, concise work, produced
  artifacts, validation evidence, and blockers
- link stages, produced artifacts, and evidence in their execution context
- register an automatic realization in `path-options.md` when it is made
  available and immediately recompute style

## Typical Inputs

- realization decision
- path and realization registry
- selected registered realization
- selected plan stage
- automation boundaries and stop points
- validation criteria for the stage
- relevant working directory or external context

## Expected Outputs

- plan-run artifact
- updated path-options artifact when registration or run start changes it
- implementation artifact, handoff artifact, or execution note when applicable
- discovered risks, blockers, or revision needs

## Stop Conditions

Stop before continuing when:

- the next action exceeds approved boundaries
- validation criteria are missing
- the stage requires a new decision, subgoal, dry run, or external authority
- the result is ready for validation

## Workflow Fit

Primary mode for `05-plan-realization`. It normally hands off to `validation`
after the run produces a stage or final result.
