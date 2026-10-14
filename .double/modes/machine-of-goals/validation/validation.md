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
- update the validated stage's Plan Map emoji in the run and mirror it in the
  current `plan.md` only after frozen-contract and dependency compatibility checks
- replace latest `running` result with the terminal result in the selected
  realization row in `plan.md` without incrementing run count again
- apply bounded run retention after statistics update
- validate exact revision and evidence links, update terminal run status in the
  realization artifact, and update both it and `run/index.md` when retention
  removes a run
- revise the current plan when needed; create a new snapshot only for
  changes to frozen obligations, before executing them
- do not revise for realization registration against unchanged plan content,
  aggregate statistics, timestamps, or progress projection
- decide whether to continue, branch, revise, reformulate, export, pause, or
  close the goal

## Typical Inputs

- plan-run artifact
- realization artifact
- path-options artifact and plan realization registry
- validation criteria
- goal and plan artifacts
- execution evidence, logs, files, screenshots, user confirmation, or external
  proof

## Expected Outputs

- updated plan-run and plan realization registry
- updated realization artifact when run status or retention changes it
- updated plan artifact when a contract-compatible emoji projection or aggregate
  statistics change, and when revision is required
- new local plan revision snapshot when frozen obligations change
- updated goal progress or closure note when applicable
- revision, branch, continuation, or export decision

## Stop Conditions

Stop before advancing when:

- evidence is missing or contradictory
- the result cannot be compared with the criteria
- the stage outcome changes the plan enough to require review
- changed frozen obligations lack a new snapshot or superseding contract
- the goal itself may need reformulation

## Workflow Fit

Primary mode for `06-plan-validation`. It is also the gate before closing a
goal or packaging a reusable plan. The mode does not create a separate
standalone validation file; it records validation decisions in the active run.

## Stage Contracts and Plan Changes

Follow the [revision rule](../../../workflows/machine-of-goals/machine-of-goals-workflow.md#plan-revision-history-rule) and
[stage contract rule](../../../workflows/machine-of-goals/machine-of-goals-workflow.md#stage-contract-rule):

- Log compatible future-only edits without a new revision; assess dependencies
  and realization fit. Preserve applicable accepted results.
- Freeze each effective stage contract in its run before action; validate
  against captured criteria and evidence. Preserve attempts and baseline links.
- Create a new revision before executing changed frozen obligations; identify
  revalidation or rework. Never rebind completed runs or invent legacy contracts.
