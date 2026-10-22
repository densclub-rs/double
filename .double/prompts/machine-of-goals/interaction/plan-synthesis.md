---
style: double
submodule: machine-of-goals
id: plan-synthesis-interaction-prompt
kind: prompt
status: release-candidate
produced-by: plan-synthesis-agent
mode: shared
derived-from:
  - ../../../roles/machine-of-goals/plan-synthesis-role.md
---

# Interaction Prompt: Plan Synthesis

## Manual and Interactive Route

Use the canonical [Model and Realization Execution Rule](../../../workflows/machine-of-goals/machine-of-goals-workflow.md#model-and-realization-execution-rule)
for this route. It selects the lightweight model/realization/stage templates
and governs steps 03–06 as applicable. Existing authorization, language,
structured-choice, stop-point, and continuation rules remain binding.

### Inputs and Outputs

- Inputs: goal, path options, requested branch/version context, and existing
  models or active realization when revising work.
- Outputs: a branch/version `plan-artifact` using the first `plan-template`
  shape and explicit review selection. The selection is recorded in the
  realization at its actual start; no separate decision or registry is required.

### Execution Rules

- Model required input, action, expected output, and check for each stage.
  Give it a stable ID/anchor and short English name/slug. Exit checks cover
  the goal's success criteria; the model contains no execution progress.
- Distinguish independently maintained named branches from evolution within
  a branch. Keep compatible updates in its model file and preserve the prior
  model for a major change. Do not choose the user's branch or path for them.
- Explain available branches/versions, entry stages, differences, and control
  boundaries at step 04. Wait for explicit selection/start permission unless
  that exact choice and action are already authorized.
- A model change ends an active realization and requires a successor under
  the workflow rule. Do not silently edit its source and continue old work.
- Complete step 03 with review as the eligible next step. Complete step 04
  with authorized start at step 05, which creates the timestamped realization.
  Do not fabricate a start or execute a stage during planning/review.

## Retained Instructions for Other Execution Modes

The remainder is retained for other modes. Its legacy execution-data rules
(run, registry, snapshot, statistics, or progress projection) do not apply to
the manual/interactive route above. Common operating-change routing and user
control boundaries still apply in either route. No collapsing or automatic
behavior is redesigned by this synchronization.

We are going to turn selected path options into a plan project.

Current steps: `03-plan-synthesis` and `04-plan-review-and-decision`.
Default mode: `planning`.
Expected outputs: `plan-artifact`; `plan-revision-snapshot` when the first
executable baseline is frozen or frozen stage obligations change; `realization-decision`; and the persistent `realization-artifact`
created before execution.

The plan should explain how the current state can move toward the target state.

Include:

- stages and dependencies
- checks and stop points
- risks and uncertainties
- resources and constraints
- subgoals when needed
- for each subgoal: its directory inside the main goal directory, its path
  analysis, and its subgoal plan
- entry and exit points between the main plan and every subgoal plan
- selectable path branches and their stable `path-options.md` ids
- first entry point
- compatible registered realization when one exists
- automation boundaries
- validation strategy

Before realization starts, make the selected paths, realization, and control
boundaries explicit through an interactive review:

1. Show the user the selectable paths or subplans, their material trade-offs,
   and compatible registered realizations.
2. Distinguish any recommendation from the user's decision.
3. Ask the user to confirm the selected path or subplan explicitly and wait for
   the response.
4. Only after confirmation, select a compatible realization row or append a
   new row to section 10 of `plan.md`. A different selected path or subplan
   always creates a new row, even when the same mechanism is reused.
5. If this is the first realization, set revision 1 and copy the updated
   `plan.md` to `<goal-directory>/realizations/plan-revision-1.md`. Rebase
   relative links and clear displayed-run metadata and derived progress. If a
   later realization uses unchanged plan content, reuse the current snapshot.
6. Create `realizations/<realization-record-id>.md`, link it from the decision
   and registry row, and only then offer transition to `05-plan-realization`.

Authoritative execution state will be stored in a new `plan-run`. Current
`plan.md` may later mirror only its contract-compatible emoji projection.
Registering a manual or interactive realization does not change single-pass
style.

Before any realization exists, keep both revision fields null and apply all
plan clarification directly to `plan.md` without creating snapshots.

Put Markdown links in plan-map cells, stage details, decision fields, and
subgoal boundaries where their relationships are useful. Do not add a repeated
navigation block. The realization decision must pin resolvable exact plan and
realization revisions.

A VCS permalink may supplement the local plan revision snapshot, but must not
replace it.

After responding, offer the next useful workflow movement. Name the next step,
mode, responsible agent, and expected artifact when known.

Do not select or confirm a path or subplan on the user's behalf. Do not treat
silence, a recommendation, or a request to review the plan as confirmation.

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

While a required asynchronous question is pending, do not send a final message
or end the turn merely to acknowledge the question or say that you are waiting.
Use permitted interruptible waits, each no longer than 60 seconds, and continue
waiting for an explicit submitted response or equivalent direct user instruction.
A timeout does not cancel the question, authorize dependent work, or justify
repeating it. Independent read-only work may continue. If the user reports a
missing or disappearing question, investigate without treating tool acceptance
as proof of visibility. This is an agent waiting rule, not a guarantee about
the client UI lifetime.

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
