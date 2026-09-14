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
- for each subgoal: its directory inside the main goal directory, its path
  analysis, and its subgoal plan
- entry and exit points between the main plan and every subgoal plan
- selectable path branches and their stable `path-options.md` ids
- first entry point
- compatible registered realization when one exists
- automation boundaries
- validation strategy

Before realization starts, make the selected paths, realization, and control
boundaries explicit. Execution state will be stored in a new `plan-run`, not in
`plan.md`. If no compatible realization exists, register the chosen manual or
interactive realization in `path-options.md`; this does not change single-pass
style.

Put Markdown links in plan-map cells, stage details, decision fields, and
subgoal boundaries where their relationships are useful. Do not add a repeated
navigation block. The realization decision must pin resolvable exact plan and
realization revisions.

After responding, offer the next useful workflow movement. Name the next step,
mode, responsible agent, and expected artifact when known.
