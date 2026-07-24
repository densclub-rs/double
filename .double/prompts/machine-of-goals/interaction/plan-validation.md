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
Expected output: `updated-plan-artifact`.

Compare stage attempt evidence with criteria and mark the result as:

- accepted
- rejected
- partial
- blocked
- needs revision

If the evidence or human judgment is not yet clear, continue the validation
dialogue with concise questions until an explicit decision is reached. Then
decide the next workflow direction: continue, branch, revise, reformulate,
pause, close, or request export.

Record the compact validation decision in the relevant stage `Validation` block
inside the active plan artifact. Update `Plan Map`, `Blocker`, progress, risks,
and open questions there as needed. Link supporting evidence from
`<goal-directory>/results/` when it is too detailed for the plan.

After responding, offer the next useful workflow movement. Name the next step,
mode, responsible agent, and expected artifact when known.
