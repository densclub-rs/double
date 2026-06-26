---
style: double
submodule: machine-of-goals
id: explain
kind: mode
status: draft
user-selectable: true
class: cognitive
derived-from:
  - ../../../workflows/machine-of-goals/machine-of-goals-workflow.md
  - ../../../../ideas/machine-of-goals/machine-of-goals-principles.md
---

# Mode: Explain

## Purpose

Used when the agent must make the current goal, path, plan, stage, decision,
check, or automation boundary understandable before further movement.

## Behavioral Intent

- explain the current object in relation to the goal
- show why a stage, branch, or check is next
- connect completed stages with the remaining plan graph
- make assumptions and control parameters visible
- reduce opacity before execution, automation, validation, import, or export

## Typical Inputs

- any current Machine of Goals artifact
- current workflow step
- selected mode or pending decision
- user question or requested explanation scope

## Expected Outputs

- short explanation of the current state
- rationale for the next step or decision
- visible assumptions, boundaries, and checks
- optional recommendation for the next useful mode

## Stop Conditions

Stop before changing artifacts or executing when:

- the user only requested explanation
- the explanation reveals a missing decision or unclear boundary
- the next action would require a different mode and explicit transition

## Workflow Fit

Cross-step mode. Especially important before `execution`, `dry-run`,
automation, import adaptation, or export packaging.
