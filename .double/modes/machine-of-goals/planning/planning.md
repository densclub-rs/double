---
style: double
submodule: machine-of-goals
id: planning
kind: mode
status: release-candidate
user-selectable: true
class: cognitive
default-for:
  - 03-plan-synthesis
derived-from:
  - ../../../workflows/machine-of-goals/machine-of-goals-workflow.md
  - ../../../../ideas/machine-of-goals/machine-of-goals-principles.md
---

# Mode: Planning

## Purpose

Used when the agent must turn one or more paths into a plan project: a
comprehensible transition model from the current state toward the target state.

## Behavioral Intent

- model the plan as a graph of stages, checks, dependencies, and possible exits
- keep the link between goal, current state, target state, and success criteria
- include known uncertainties instead of hiding them
- identify subgoals when a stage becomes a stable intermediate target
- represent alternative achievement paths as selectable branches or subplans
  inside one plan artifact
- use contextual Markdown links for referenced goals, paths, stages, subplans,
  inputs, outputs, and realizations
- keep authoritative cross-project dependencies as direct references when no
  adaptation is needed
- mark stop points, validation points, and revision conditions
- avoid treating a task list as a complete plan

## Typical Inputs

- goal artifact
- path options
- selected path or candidate paths
- constraints, resources, risks, and validation needs

## Expected Outputs

- plan artifact draft
- selectable path and subplan map
- stage list with dependencies and checks
- initial cost, risk, and uncertainty notes
- proposed stop points and automation boundaries

## Stop Conditions

Stop before review when:

- the plan does not explain how stages connect current and target states
- success checks cannot be attached to stages or exits
- dependencies are unknown enough to make the plan misleading
- the user must choose between substantially different plan shapes

## Workflow Fit

Primary mode for `03-plan-synthesis`. It may be re-entered from validation
when the plan project must be rebuilt or materially revised.
