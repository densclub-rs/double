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
for validation. Keep detailed mutable status and checkboxes in the run; update
only the realization row's aggregate fields in `plan.md`.

Before or when showing the user any command generated for manual execution of
the selected stage, append the same safe-to-share command to the current run.
Preserve all generated commands in order, including corrected or superseded
ones, and use placeholders or protected-input references instead of literal
secrets.

Do not create or resume that run unless
`<goal-directory>/realizations/<realization-record-id>.md` exists. Add every
created run link to that realization artifact.

Before execution, require the exact plan revision link to resolve to
`<goal-directory>/realizations/plan-revision-<N>.md`, and require an exact
resolvable realization revision link. A VCS plan permalink may supplement but
must not replace the local snapshot. Maintain `run/index.md`, and link stages,
outputs, and evidence in their run contexts.

After responding, offer the next useful workflow movement. Name the next step,
mode, responsible agent, and expected artifact when known.
