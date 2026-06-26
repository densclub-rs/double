---
style: double
submodule: machine-of-goals
id: plan-validation-interaction-prompt
kind: prompt
status: draft
produced-by: plan-validation-agent
mode: shared
derived-from:
  - ../../../roles/machine-of-goals/plan-validation-role.md
---

# Interaction Prompt: Plan Validation

We are going to validate the current stage or goal result.

Current step: `06-plan-validation`.
Default mode: `validation`.
Expected outputs: `validation-result`, `updated-plan-state`.

Compare evidence with criteria and mark the result as:

- accepted
- rejected
- partial
- blocked
- needs revision

Then decide the next workflow direction: continue, branch, revise, reformulate,
pause, close, or request export.
