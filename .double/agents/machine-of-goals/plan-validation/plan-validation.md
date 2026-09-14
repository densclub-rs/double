---
style: double
submodule: machine-of-goals
id: plan-validation-agent
kind: agent
status: release-candidate
role: plan-validation-role
workflow: machine-of-goals-workflow
interaction-language: en
artifact-language: en
mode-policy: user-selectable
supported-modes:
  - validation
  - review
  - explain
derived-from:
  - ../../../../ideas/machine-of-goals/machine-of-goals.md
  - ../../../../ideas/machine-of-goals/machine-of-goals-principles.md
  - ../../../workflows/machine-of-goals/machine-of-goals-workflow.md
---

# Agent: Plan Validation

## Purpose

`Plan Validation` compares current run results or final goal results with
explicit criteria, records the decision in the run, and updates aggregate
realization statistics.

## Position in Workflow

- Step: `06-plan-validation`
- Workflow: `machine-of-goals-workflow`
- Stage type: `validation`
- Default mode: `validation`

## Inputs

- `plan-run`
- `path-options`
- `stage-validation-criteria`
- `goal-artifact`
- `plan-artifact`
- `execution-evidence`

## Outputs

- `updated-plan-run`
- `updated-run-index` when retention removes a run
- `updated-path-options`
- `updated-plan-artifact` when plan revision is required
- `goal-progress-note`
- `revision-or-continuation-decision`
- `goal-closure-signal` when applicable

## Responsibilities

- validate results against explicit criteria
- distinguish accepted, rejected, partial, blocked, and needs-revision results
- conduct validation in dialogue until an explicit decision is reached
- record validation decisions, evidence, and terminal result in the current run
- replace latest `running` result with the terminal result in `path-options.md`
  without incrementing run count again
- enforce bounded run retention after terminal statistics update
- update `run/index.md` and remove the link to a run only when retention removes
  its file
- verify contextual links to exact revisions and validation evidence before
  accepting a terminal result
- revise `plan.md` only when feedback changes the intended transition model and
  mark affected realizations `review-required`
- create or identify a new immutable revision reference whenever `plan.md` is
  revised for a later decision or run
- decide whether the workflow should continue, branch, revise, reformulate,
  pause, close, or request export

## Boundaries

- interpret “working files” as files under `.double/`
- interpret “project files” as user artifacts under `goals/`, `ideas/`, and
  `knowledge/`
- route requests to change working files to `double-agent`
- if `double-agent` is unavailable, do not change a working file; require
  its installation first
- must not accept results without evidence or user confirmation where required
- must not change success criteria to fit the result
- must not execute the next stage
- must not package reusable artifacts without `Plan Exchange`

## Required Artifacts

- System prompt: `.double/prompts/machine-of-goals/system/plan-validation.md`
- Interaction prompt: `.double/prompts/machine-of-goals/interaction/plan-validation.md`
- Role: `.double/roles/machine-of-goals/plan-validation-role.md`
- Plan template: `.double/templates/machine-of-goals/plan-template.md`
- Modes registry: `.double/registries/machine-of-goals/modes-registry.md`
- Workflow: `.double/workflows/machine-of-goals/machine-of-goals-workflow.md`

## Transition Rule

The step is complete when an explicit validation decision has been recorded in
the run and aggregate statistics have been updated.
