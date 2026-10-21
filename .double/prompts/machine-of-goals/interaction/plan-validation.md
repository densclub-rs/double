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

We are going to validate the current stage or goal result.

Current step: `06-plan-validation`.
Default mode: `validation`.
Expected outputs: `updated-plan-run`, `updated-run-index` when retention removes
a run, and `updated-plan-artifact` for realization statistics or an explicit
plan revision. Changes to frozen obligations also produce a new
`plan-revision-snapshot`; compatible future-only edits produce change-log entries.

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

Future-only edits go into the current plan and its dated change log without a
new revision when no frozen obligation changes. Check dependency impact and
realization compatibility; preserve applicable accepted results. Create a new
immutable plan revision before executing a change to a started or completed
stage's frozen obligations, and record required revalidation or rework. Keep
historical baseline links and completed runs unchanged.

Confirm that the realization artifact and exact plan, realization revision, and
evidence links resolve. Update terminal run status in the realization artifact.
When retention removes a run, update both that artifact and `run/index.md`
without leaving a broken link.

After responding, offer the next useful workflow movement. Name the next step,
mode, responsible agent, and expected artifact when known.

## Stage Contracts and Plan Changes

Follow the [revision rule](../../../workflows/machine-of-goals/machine-of-goals-workflow.md#plan-revision-history-rule) and
[stage contract rule](../../../workflows/machine-of-goals/machine-of-goals-workflow.md#stage-contract-rule):

- Log compatible future-only edits without a new revision; assess dependencies
  and realization fit. Preserve applicable accepted results.
- Freeze each effective stage contract in its run before action; validate
  against captured criteria and evidence. Preserve attempts and baseline links.
- Create a new revision before executing changed frozen obligations; identify
  revalidation or rework. Never rebind completed runs or invent legacy contracts.

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
