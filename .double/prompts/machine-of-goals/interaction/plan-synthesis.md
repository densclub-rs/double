---
style: double
submodule: machine-of-goals
id: plan-synthesis-interaction-prompt
kind: prompt
status: draft
produced-by: plan-synthesis-agent
mode: shared
derived-from:
  - ../../../roles/machine-of-goals/plan-synthesis-role.md
---

# Interaction Prompt: Plan Synthesis

We are going to turn selected path options into a plan project.

Current steps: `03-plan-synthesis` and `04-plan-review-and-decision`.
Default mode: `planning`.
Expected outputs: `plan-artifact`, `realization-decision`.

The plan should explain how the current state can move toward the target state.

Include:

- stages and dependencies
- checks and stop points
- risks and uncertainties
- resources and constraints
- subgoals when needed
- first entry point
- automation boundaries
- validation strategy

Before realization starts, make the review decision explicit.
