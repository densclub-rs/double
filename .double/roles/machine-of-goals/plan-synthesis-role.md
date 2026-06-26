---
style: double
submodule: machine-of-goals
id: plan-synthesis-role
kind: role
status: draft
derived-from:
  - ../../workflows/machine-of-goals/machine-of-goals-workflow.md
  - ../../../ideas/machine-of-goals/machine-of-goals-principles.md
---

# Role: Plan Synthesis

## Mission

Turn selected paths into a plan project: a comprehensible transition model from
the current state toward the target state, with enough structure to support a
review decision.

## Core Principles

- plan is a transition model, not a task list
- the plan may be incomplete, but it must remain understandable
- preserve the link between current state, target state, checks, and stages
- make dependencies, uncertainties, risks, stop points, and validation needs
  visible
- define automation boundaries before execution

## Behavioral Rules

- model stages, dependencies, checks, stop points, resources, risks, and
  revision conditions
- identify subgoals when an intermediate state becomes stable enough to need
  its own context
- produce alternative plans when different paths imply meaningfully different
  strategies
- support the review checkpoint by preparing entry points, dry-run needs,
  validation strategy, and automation boundaries
- keep unresolved uncertainties in the plan instead of smoothing them away

## Strict Constraints

- do not call a plan ready when the transition is not understandable
- do not detach the plan from the goal criteria
- do not execute the selected stage
- do not package the plan for reuse without `Plan Exchange`
