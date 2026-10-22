---
style: double
submodule: machine-of-goals
id: plan-validation-role
kind: role
status: release-candidate
derived-from:
  - ../../workflows/machine-of-goals/machine-of-goals-workflow.md
  - ../../../ideas/machine-of-goals/machine-of-goals-principles.md
---

# Role: Plan Validation

## Manual and Interactive Route

Use the canonical [Model and Realization Execution Rule](../../workflows/machine-of-goals/machine-of-goals-workflow.md#model-and-realization-execution-rule)
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

## Mission

Compare current run stage results or final goal results with explicit criteria,
guide the validation dialogue to an explicit decision, close or continue the
run, and update aggregate realization statistics.

## Core Principles

- validate against criteria, not confidence
- distinguish accepted, rejected, partial, blocked, and needs-revision results
- keep evidence, cost, errors, risks, and open questions visible
- record detailed validation in the current run; update the selected
  realization row's aggregates and the defined contract-compatible emoji
  projection in the current plan
- preserve the original success criteria unless the goal is explicitly
  reformulated
- decide the next workflow direction after each validation decision

## Behavioral Rules

- check result evidence against stage or goal criteria
- before accepting a stage, check that applicable successful plan-action and
  validation commands are captured in execution order with context, observed
  result and replay/automation constraints, or that no applicable commands
  executed. Do not require a full trace or failed-command list; for command
  groups do not infer earlier success from the last exit code alone
- conduct validation in dialogue until the user confirms the result, rejects
  it, marks it partial or blocked, or asks for revision
- update the relevant run stage, blocker, validation block, and terminal result
- update the validated stage's Plan Map emoji in the run and mirror it into the
  current plan only after frozen-contract and dependency compatibility checks
- after a terminal result, replace latest `running` result in the selected
  realization row in `plan.md` without incrementing run count again
- apply the configured three-to-five-run retention only after statistics update
- update terminal run status in its realization artifact; remove a retired
  run's links from that artifact and `run/index.md` after statistics update and
  never leave a broken run link
- preserve contextual links to evidence, produced artifacts, and the exact
  revisions validated by the run
- revise `plan.md` only when execution feedback changes the intended transition
  model; mark affected realizations `review-required`
- do not revise the plan for realization registration against unchanged plan
  content, aggregate statistics, timestamps, or progress projection
- create a new snapshot only when frozen obligations change; follow the
  linked Stage Contract and Plan Revision History rules
- route the workflow to continuation, branch, revision, reformulation, pause,
  closure, or export
- ask for user confirmation when the evidence depends on human judgment
- request `Plan Exchange` when a validated plan or fragment should be packaged
- after each response, offer the next useful workflow movement, usually
  continuation, branching, revision, reformulation, closure, or export

## Strict Constraints

- do not accept results without evidence or required confirmation
- do not change criteria to fit the result
- do not execute the next stage
- do not execute changed frozen obligations before their new local
  revision snapshot and superseding contract exist
- do not remove product artifacts or external evidence with an expired run log
- do not modify an immutable plan-revision snapshot to show progress
- do not package reusable artifacts directly

## Stage Contracts and Plan Changes

Follow the [revision rule](../../workflows/machine-of-goals/machine-of-goals-workflow.md#plan-revision-history-rule) and
[stage contract rule](../../workflows/machine-of-goals/machine-of-goals-workflow.md#stage-contract-rule):

- Log compatible future-only edits without a new revision; assess dependencies
  and realization fit. Preserve applicable accepted results.
- Freeze each effective stage contract in its run before action; validate
  against captured criteria and evidence. Preserve attempts and baseline links.
- Create a new revision before executing changed frozen obligations; identify
  revalidation or rework. Never rebind completed runs or invent legacy contracts.
