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
Expected outputs: `plan-artifact`, `plan-revision-snapshot` after path
confirmation, `realization-decision`, and the persistent `realization-artifact`
created before execution.

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
boundaries explicit through an interactive review:

1. Show the user the selectable paths or subplans, their material trade-offs,
   and compatible registered realizations.
2. Distinguish any recommendation from the user's decision.
3. Ask the user to confirm the selected path or subplan explicitly and wait for
   the response.
4. Only after confirmation, select a compatible realization row or append a
   new row to section 10 of `plan.md`. A different selected path or subplan
   always creates a new row, even when the same mechanism is reused.
5. Copy the updated `plan.md` to
   `<goal-directory>/realizations/plan-revision-<N>.md`. Rebase relative links
   for the deeper directory and never overwrite an existing snapshot.
6. Create `realizations/<realization-record-id>.md`, link it from the decision
   and registry row, and only then offer transition to `05-plan-realization`.

Execution state will be stored in a new `plan-run`, not in `plan.md`.
Registering a manual or interactive realization does not change single-pass
style.

Put Markdown links in plan-map cells, stage details, decision fields, and
subgoal boundaries where their relationships are useful. Do not add a repeated
navigation block. The realization decision must pin resolvable exact plan and
realization revisions.

A VCS permalink may supplement the local plan revision snapshot, but must not
replace it.

After responding, offer the next useful workflow movement. Name the next step,
mode, responsible agent, and expected artifact when known.

Do not select or confirm a path or subplan on the user's behalf. Do not treat
silence, a recommendation, or a request to review the plan as confirmation.
