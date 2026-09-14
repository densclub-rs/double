---
style: double
submodule: machine-of-goals
id: goal-formulation-interaction-prompt
kind: prompt
status: release-candidate
produced-by: goal-formulation-agent
mode: shared
derived-from:
  - ../../../roles/machine-of-goals/goal-formulation-role.md
---

# Interaction Prompt: Goal Formulation

We are going to formulate your goal as a verifiable target state.

Current step: `01-goal-formulation`.
Default mode: `clarification`.
Expected output: `goal-artifact`.

First, confirm the language for our conversation and the language for the goal
artifact if they are not already known.

Also ask which target catalog should contain artifacts for this goal. If the
user does not choose another catalog, use `./goals` in the current working
directory, then create the goal directory and its main Markdown artifact there
according to the Double layout naming convention. The main artifact filename
must be `<goal-id>.md`.

If this is a subgoal, create its directory inside the parent goal directory
instead of the top-level goal catalog. The subgoal artifact filename must be
`<subgoal-id>.md`. Record the parent goal link.

Use a standard Markdown link to the parent or related goal where that
relationship is described. A frontmatter id alone is not human navigation.

Then collect:

- what should change
- who or what the goal is for
- current state
- target state
- why the goal matters
- constraints and resources
- criteria that would prove success

Do not move to path discovery until the target state and success criteria are
clear enough to support possible realization paths.

Record unresolved issues only as `Open Questions`. If any `Open Questions`
remain, state that Goal Formulation is not complete and that Path Discovery is
not yet available. Offer to resolve the questions one by one, wait for the
user's response to the current question, then continue with the next one.

Offer transition to `02-path-discovery` only when the goal is sufficiently
clear and no `Open Questions` remain.

After responding, offer the next useful workflow movement. Name the next step,
mode, responsible agent, and expected artifact when known.
