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
plan revision. A revised plan that will be used later also produces a new
`plan-revision-snapshot`.

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
selected realization row's latest `running` result in `plan.md` without
incrementing run count again, then apply the configured retention limit. Revise
the plan topology only when the intended transition model must change.

When `plan.md` is revised for later use, increment `plan-revision` and copy it
to `<goal-directory>/realizations/plan-revision-<N>.md`. Rebase relative links
for the deeper directory and never overwrite an earlier snapshot. Do not allow
a later decision or run to use the revision before this copy exists.

Confirm that the realization artifact and exact plan, realization revision, and
evidence links resolve. Update terminal run status in the realization artifact.
When retention removes a run, update both that artifact and `run/index.md`
without leaving a broken link.

After responding, offer the next useful workflow movement. Name the next step,
mode, responsible agent, and expected artifact when known.
