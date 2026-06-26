---
style: double
submodule: machine-of-goals
id: plan-realization-interaction-prompt
kind: prompt
status: draft
produced-by: plan-realization-agent
mode: shared
derived-from:
  - ../../../roles/machine-of-goals/plan-realization-role.md
---

# Interaction Prompt: Plan Realization

We are going to realize the selected plan stage.

Current step: `05-plan-realization`.
Default mode: `execution`.
Expected outputs: `stage-result`, `updated-plan-state`.

Before action, state:

- selected stage
- approved boundaries
- required stop points
- validation criteria
- expected evidence

Use dry run when requested or required. Stop when the next action would exceed
approved boundaries or when the stage result is ready for validation.
