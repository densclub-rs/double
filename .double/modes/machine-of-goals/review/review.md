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

Used when the agent must interactively help the user choose how realization
should start and under which control boundaries the plan may proceed.

## Behavioral Intent

- compare selectable paths, plan branches, and compatible registered
  realizations without collapsing trade-offs too early
- show the selectable paths or subplans, material trade-offs, and compatible
  registered realizations to the user
- recommend an option when useful while keeping the recommendation distinct
  from the user's decision
- ask the user to confirm the selected path or subplan explicitly and wait for
  the response
- after path confirmation, choose an entry point for realization
- after path confirmation, select a compatible realization row or append a
  manual or interactive realization to section 10 of `plan.md`
- append a new row whenever another path or subplan is selected, even when the
  realization mechanism is reused
- define automation boundaries and confirmation points
- decide where dry run is required or useful
- define validation strategy and revision conditions
- make the realization decision explicit before execution begins
- record the user's explicit path or subplan confirmation in the realization
  decision
- after updating the realization registry, copy the current plan to
  `realizations/plan-revision-<N>.md`, rebase its relative links, and preserve
  every earlier snapshot unchanged
- create `realizations/<realization-record-id>.md` for the approved manual or
  automatic realization before the execution transition
- require resolvable exact plan and realization revision links before the
  execution commit point
- link selected paths, subplans, realization, and first stage in the decision

## Typical Inputs

- plan artifact with realization registry and separate path-options artifact
- path comparison
- goal criteria and constraints
- user risk tolerance and automation preferences
- explicit user response confirming the selected path or subplan

## Expected Outputs

- realization decision
- user-confirmed path or subplan, realization record, and first entry point
- local `realizations/plan-revision-<N>.md` snapshot
- persistent `realizations/<realization-record-id>.md` realization artifact
- automation boundary notes
- confirmation and stop points
- validation strategy for the first realization cycle

## Stop Conditions

Stop before execution when:

- selectable paths or subplans and their material trade-offs have not been
  shown to the user
- the user has not explicitly confirmed the selected path or subplan
- the selected local plan revision snapshot does not exist or would require
  overwriting an earlier snapshot
- the selected realization artifact does not exist
- no path, branch, or realization record has been selected
- automation boundaries are unclear
- the first stage lacks a validation strategy
- a selected plan or realization revision is mutable or unresolvable
- the decision would exceed user-approved risk or authority

Silence, an agent recommendation, or a request to review the plan is not path
confirmation. The agent must not select or confirm a path or subplan on the
user's behalf.

## Workflow Fit

Primary mode for `04-plan-review-and-decision`. It may also be used whenever
validation creates a branch, pause, stop, or major revision decision.
