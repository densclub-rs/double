---
style: double
submodule: machine-of-goals
id: review
kind: mode
status: release-candidate
user-selectable: true
class: decision
default-for:
  - 04-plan-review-and-decision
derived-from:
  - ../../../workflows/machine-of-goals/machine-of-goals-workflow.md
  - ../../../../ideas/machine-of-goals/machine-of-goals-principles.md
---

# Mode: Review

## Purpose

Used when the agent must help choose how realization should start and under
which control boundaries the plan may proceed.

## Behavioral Intent

- compare plan options and plan branches without collapsing trade-offs too early
- choose an entry point for realization
- define automation boundaries and confirmation points
- decide where dry run is required or useful
- define validation strategy and revision conditions
- make the realization decision explicit before execution begins

## Typical Inputs

- plan artifact or plan alternatives
- path comparison
- goal criteria and constraints
- user risk tolerance and automation preferences

## Expected Outputs

- realization decision
- selected plan, hybrid plan, branch, or first entry point
- automation boundary notes
- confirmation and stop points
- validation strategy for the first realization cycle

## Stop Conditions

Stop before execution when:

- no plan or branch has been selected
- automation boundaries are unclear
- the first stage lacks a validation strategy
- the decision would exceed user-approved risk or authority

## Workflow Fit

Primary mode for `04-plan-review-and-decision`. It may also be used whenever
validation creates a branch, pause, stop, or major revision decision.
