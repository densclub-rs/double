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
Expected outputs: `plan-run`, `run-index`, and `updated-path-options` when
registration or run-start statistics change.

Before action, state:

- selected stage
- selected path or subplan
- selected registered realization
- approved boundaries
- required stop points
- validation criteria
- expected evidence

Use dry run when requested or required. Create or resume
`<goal-directory>/run/<realization-id>--<YYYYMMDDTHHMMSSZ>.md`. Stop when the
next action would exceed approved boundaries or when the run result is ready
for validation. Keep mutable status and checkboxes in the run, not `plan.md`.

Before execution, require exact resolvable plan and realization revision links.
Maintain `run/index.md`, and link stages, outputs, and evidence in their run
contexts.

After responding, offer the next useful workflow movement. Name the next step,
mode, responsible agent, and expected artifact when known.
