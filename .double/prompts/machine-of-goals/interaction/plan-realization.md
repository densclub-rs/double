---
style: double
submodule: machine-of-goals
id: plan-realization-interaction-prompt
kind: prompt
status: release-candidate
produced-by: plan-realization-agent
mode: shared
derived-from:
  - ../../../roles/machine-of-goals/plan-realization-role.md
---

# Interaction Prompt: Plan Realization

We are going to realize the selected plan stage.

Current step: `05-plan-realization`.
Default mode: `execution`.
Expected outputs: `plan-run`, `run-index`, and `updated-plan-artifact` when
registration or run-start statistics change.

Before action, state:

- selected stage
- selected path or subplan
- selected realization record
- selected realization artifact
- selected local plan revision snapshot
- approved boundaries
- required stop points
- validation criteria
- expected evidence

Use dry run when requested or required. Create or resume
`<goal-directory>/run/<realization-record-id>--<YYYYMMDDTHHMMSSZ>.md`. Stop when the
next action would exceed approved boundaries or when the run result is ready
for validation. Keep detailed mutable status and checkboxes in the run. Update
its stage-attempt Plan Map emoji as stage state changes. The current
`plan.md` may mirror that projection only after frozen-contract and dependency compatibility checks
the run; never change an immutable plan-revision snapshot for progress.

Before or when showing the user any command generated for manual execution of
the selected stage, append the same safe-to-share command to the current run.
Preserve all generated commands in order, including corrected or superseded
ones, and use placeholders or protected-input references instead of literal
secrets.

Preserve successful commands for plan actions and validation in the current
run after observing success and before submitting the stage for validation.
Keep execution order, stage, purpose, working context, exact safe command,
observed result, and replay/automation constraints. Failed attempts, redundant
repeats and incidental bookkeeping do not require a full trace. For command
groups verify each retained command, not just the group's final exit code.
Recorded commands are reusable evidence, not permission to replay them. Keep
human-generated instructions and their history in their separate section.

Do not create or resume that run unless
`<goal-directory>/realizations/<realization-record-id>.md` exists. Add every
created run link to that realization artifact.

Before execution, require the exact plan revision link to resolve to
`<goal-directory>/realizations/plan-revision-<N>.md`, and require an exact
resolvable realization revision link. A VCS plan permalink may supplement but
must not replace the local snapshot. Maintain `run/index.md`, and link stages,
outputs, and evidence in their run contexts.

When an automatic realization is registered against unchanged plan content,
reuse the current plan revision; registration alone does not revise the plan.

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
