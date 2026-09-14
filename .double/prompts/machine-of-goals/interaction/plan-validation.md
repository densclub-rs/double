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
a run, `updated-path-options`, and an updated plan only when explicit plan
revision is required.

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

Record the validation decision in the run. For a terminal result, replace the
realization's latest `running` result in `path-options.md` without incrementing
run count again, then apply the configured retention limit. Revise `plan.md`
only when the intended transition model must change.

Confirm that exact plan and realization revision links and evidence links
resolve. When retention removes a run, update `run/index.md` without leaving a
broken link.

After responding, offer the next useful workflow movement. Name the next step,
mode, responsible agent, and expected artifact when known.
