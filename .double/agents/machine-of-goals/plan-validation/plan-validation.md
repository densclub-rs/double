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

## Manual and Interactive Route

Use the canonical [Model and Realization Execution Rule](../../../workflows/machine-of-goals/machine-of-goals-workflow.md#model-and-realization-execution-rule)
for this route. It selects the lightweight model/realization/stage templates
and governs steps 03–06 as applicable. Existing authorization, language,
structured-choice, stop-point, and continuation rules remain binding.

### Inputs and Outputs

- Inputs: goal/model criteria, the selected realization and stage record,
  captured conditions, actual results, and supplied evidence or statements.
- Outputs: updated `stage-realization` and `realization-artifact`. Final
  acceptance is summarized in the main Result, not a separate document.

### Execution Rules

- Recheck source model identity/content before output acceptance. A changed
  model ends the realization; preserve facts against captured criteria and
  route to revision/review and an authorized successor.
- Compare actual outputs with the captured conditions. Offer relevant
  documentary evidence and inspect its applicability. When documents cannot
  be supplied, preserve the explicit user statement as the acceptance basis;
  do not describe it as independent documentary verification.
- Keep each condition accepted, not met, or unconfirmed in Output State.
  Missing or ambiguous confirmation cannot complete the stage. Record the
  decision through the existing dialogue/structured-choice rules where a user
  decision is needed; preserve decisions already explicitly supplied.
- Update only the realization map after output acceptance. Its summary must
  distinguish documentary and user-statement confirmation. Check applicable
  exit and goal success criteria before completing the realization.
- For inherited results, recheck inputs/dependencies/current applicability
  and preserve their original source version and factual basis.
- Recommend only eligible next stages and use the existing continuation rule.
  Model revision, branch selection, pause, or closure are distinct routes;
  do not force export or bounded-log retention on documented walkthroughs.
- Do not execute the next stage, weaken a criterion to fit a result, or write
  authoritative execution state into the model.

## Retained Instructions for Other Execution Modes

The remainder is retained for other modes. Its legacy execution-data rules
(run, registry, snapshot, statistics, or progress projection) do not apply to
the manual/interactive route above. Common operating-change routing and user
control boundaries still apply in either route. No collapsing or automatic
behavior is redesigned by this synchronization.

## Purpose

`Plan Validation` compares current run results or final goal results with
explicit criteria, records the decision in the run, and updates aggregate
statistics in the selected plan realization row.

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
- `selected-realization-record`
- `realization-artifact`
- `execution-evidence`

## Outputs

- `updated-plan-run`
- `updated-realization-artifact` when run status or retention changes it
- `updated-run-index` when retention removes a run
- `updated-plan-artifact` for realization statistics and when plan revision is required
- `plan-revision-snapshot` when frozen obligations change
- `goal-progress-note`
- `revision-or-continuation-decision`
- `goal-closure-signal` when applicable

## Responsibilities

- validate results against explicit criteria
- before accepting a stage, check that applicable successful plan-action and
  validation commands are captured in execution order with context, observed
  result and replay/automation constraints, or that no applicable commands
  executed. Do not require a full trace or failed-command list; for command
  groups do not infer earlier success from the last exit code alone
- distinguish accepted, rejected, partial, blocked, and needs-revision results
- conduct validation in dialogue until an explicit decision is reached
- record validation decisions, evidence, and terminal result in the current run
- update the run's Plan Map emoji after the validation decision and mirror it
  into current `plan.md` only after frozen-contract and dependency compatibility checks
- replace latest `running` result with the terminal result in the selected
  realization row in `plan.md` without incrementing run count again
- enforce bounded run retention after terminal statistics update
- update the realization artifact and `run/index.md`; remove their links to a
  run only when retention removes its file
- verify contextual links to exact revisions and validation evidence before
  accepting a terminal result
- revise `plan.md` only when feedback changes the intended transition model and
  mark affected realizations `review-required`
- do not create a revision for realization registration against unchanged plan
  content, aggregate statistics, timestamps, or progress projection
- create a new snapshot only when frozen obligations change; follow the
  linked Stage Contract and Plan Revision History rules
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
- must not execute changed frozen obligations before their new local
  revision snapshot and superseding contract exist
- must not update an immutable plan-revision snapshot with execution progress
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
the run, aggregate statistics have been updated, and changes to frozen
obligations have their required new snapshot; future-only changes have a
logged compatibility decision.

## Stage Contracts and Plan Changes

Follow the [revision rule](../../../workflows/machine-of-goals/machine-of-goals-workflow.md#plan-revision-history-rule) and
[stage contract rule](../../../workflows/machine-of-goals/machine-of-goals-workflow.md#stage-contract-rule):

- Log compatible future-only edits without a new revision; assess dependencies
  and realization fit. Preserve applicable accepted results.
- Freeze each effective stage contract in its run before action; validate
  against captured criteria and evidence. Preserve attempts and baseline links.
- Create a new revision before executing changed frozen obligations; identify
  revalidation or rework. Never rebind completed runs or invent legacy contracts.
