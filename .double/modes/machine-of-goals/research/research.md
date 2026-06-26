---
style: double
submodule: machine-of-goals
id: research
kind: mode
status: draft
user-selectable: true
class: cognitive
default-for:
  - 02-path-discovery
derived-from:
  - ../../../workflows/machine-of-goals/machine-of-goals-workflow.md
  - ../../../../ideas/machine-of-goals/machine-of-goals-principles.md
---

# Mode: Research

## Purpose

Used when the agent must discover possible ways to reach a formulated goal
before committing to a concrete plan.

## Behavioral Intent

- search for direct, minimal, exploratory, delegated, automated, external, and
  reusable-plan paths
- inspect local context before inventing a new route
- compare paths by fit, cost, risk, uncertainty, and expected value
- preserve plausible alternatives until the goal is closed or the user chooses
  to discard them
- distinguish evidence from speculation

## Typical Inputs

- goal artifact
- current state and target state
- success criteria
- local project files, prior artifacts, reusable plans, or user-provided
  references
- known constraints and resources

## Expected Outputs

- path options
- preliminary comparison of paths
- assumptions and unknowns per path
- blocked, infeasible, or reformulation signals when no plausible path exists

## Stop Conditions

Stop before planning when:

- no plausible path has been found
- all discovered paths require goal reformulation
- required external evidence cannot be obtained
- the user must choose between incompatible strategic directions

## Workflow Fit

Primary mode for `02-path-discovery`. It may be used inside later steps when
execution reveals that a new path or external analog is needed.
