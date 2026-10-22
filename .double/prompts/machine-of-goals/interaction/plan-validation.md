---
style: double
submodule: machine-of-goals
id: plan-validation-interaction-prompt
kind: prompt
status: release-candidate
produced-by: plan-validation-agent
mode: shared
derived-from:
  - ../../../roles/machine-of-goals/plan-validation-role.md
---

# Interaction Prompt: Plan Validation

## Manual and Interactive Route

Use the canonical [Model and Realization Execution Rule](../../../workflows/machine-of-goals/machine-of-goals-workflow.md#model-and-realization-execution-rule)
for this route. It selects the lightweight model/realization/stage templates
and governs steps 03–06 as applicable. Existing authorization, language,
structured-choice, stop-point, and continuation rules remain binding.

### Inputs and Outputs

- Inputs: goal and frozen-plan criteria, the selected realization and stage record,
  captured conditions, actual results, and supplied evidence or statements.
- Outputs: updated `stage-realization` and `realization-artifact`. Final
  acceptance is summarized in the main Result, not a separate document.

### Execution Rules

- Verify frozen plan integrity and validate observed outputs against that
  unchanged plan and captured conditions. A changed source model blocks further
  planned action and requires renewed review/authorized successor; it never
  rewrites the earlier plan or prevents checking already observed results.
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

We are going to validate the current stage or goal result.

Current step: `06-plan-validation`.
Default mode: `validation`.
Expected outputs: `updated-plan-run`, `updated-run-index` when retention removes
a run, and `updated-plan-model` bookkeeping for realization statistics.
Proposed model edits return to review; validation creates no new plan snapshot.

Compare current run evidence with criteria and mark the result as:

- accepted
- rejected
- partial
- blocked
- needs revision

If the evidence or human judgment is not yet clear, continue the validation
dialogue with concise questions until an explicit decision is reached. Then
decide the next workflow direction: continue, branch, revise, reformulate,
pause, close, or request export.

Before accepting the stage, check its successful-command selection: applicable
plan-action and validation commands must have execution order, working context,
observed results and replay/automation constraints. An explicit statement that
no applicable commands executed is valid. Do not require a full tool trace,
failed-command list, or irrelevant bookkeeping. Verify each retained command
in a group rather than relying on its final exit code; command success alone
does not prove the stage result or authorize replay.

Record the validation decision in the run and update the stage's Plan Map
emoji. Mirror it into current `plan.md` only after frozen-contract and dependency compatibility checks;
never update an immutable plan-revision snapshot. For a terminal result,
replace the selected realization row's latest `running` result in `plan.md`
without incrementing run count again, then apply the configured retention
limit. Revise the plan topology only when the intended transition model must
change.

Proposed model edits go to synthesis/review with dependency and applicability
checks. Every transition edit requires renewed approval and a new frozen
baseline only at authorized execution start. Preserve historical acceptance,
baseline links and completed runs; record required revalidation/rework.

Confirm that the realization artifact and exact plan, realization revision, and
evidence links resolve. Update terminal run status in the realization artifact.
When retention removes a run, update both that artifact and `run/index.md`
without leaving a broken link.

After responding, offer the next useful workflow movement. Name the next step,
mode, responsible agent, and expected artifact when known.

## Stage Contracts and Plan Changes

Follow the [revision rule](../../../workflows/machine-of-goals/machine-of-goals-workflow.md#plan-revision-history-rule) and
[stage contract rule](../../../workflows/machine-of-goals/machine-of-goals-workflow.md#stage-contract-rule):

- Log model edits and assess dependencies/applicability. Every transition edit
  needs renewed review before changed execution; preserve historical acceptance.
- Freeze each effective stage contract in its run before action; validate
  against captured criteria and evidence. Preserve attempts and baseline links.
- Create a new frozen plan only at an authorized changed-execution start after
  review; identify revalidation/rework. Never rebind runs or invent old contracts.

## Structured User Choices

For concrete mode, path/subplan, realization, next-step or validation choices,
follow the canonical workflow's structured-choice rule. Prefer exposed and
permitted `request_user_input_async`; show the relevant trade-offs/evidence and
wait for an explicit response before dependent state changes. Use a permitted
alternative or numbered text if unavailable. Preserve already supplied choices;
preselection, silence and request acknowledgements are not consent. Keep
open-ended clarification free-form and do not create extra approval gates.

## Completion Handoff

Follow the canonical [step completion and continuation rule](../../../workflows/machine-of-goals/machine-of-goals-workflow.md#step-completion-handoff-rule)
after every completed workflow step or plan stage. State the completed step,
result and artifact links; name the eligible next workflow step, mode, agent,
expected artifact and transition readiness; then ask whether to perform the
concrete next action (Yes / No in the interaction language) and wait for an
explicit response using the permitted structured-choice interface. A summary
or a list of possible next steps alone is insufficient.

Preserve explicit authorization already covering the next action; do not ask
again or bypass mandatory selections, validation decisions or stop points.
A No stops continuation without rejecting the completed result. If blocked,
name the blocker and offer clarification or repair. At the workflow end, state
completion instead of inventing a next step. After plan-stage execution, offer
`06-plan-validation` before any further plan-stage execution.
