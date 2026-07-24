---
name: machine-of-goals
description: >
  Use this skill when the user wants to formulate, clarify, inspect, plan, realize, validate, import, export, split, or continue a goal through the Machine of Goals. Trigger on requests about Machine of Goals, goal artifacts, subgoals, subgoal catalogs, path discovery, plan synthesis, subplans, plan realization, plan execution state, previous plan implementations, plan validation, plan exchange, reusable plans, collapsed plans, automatically executable plans, or goal workflow state. Trigger and route to `double-agent` when the user asks to create, change, move, or remove Machine of Goals operating artifacts under `.double/`. Do not trigger on casual mentions of goals inside unrelated discussion unless the user asks to enter the Machine of Goals workflow.
metadata:
  short-description: Transform goals into verifiable target states, paths, plans, realization loops, validation, and reusable plan packages
---

# Machine of Goals

This skill is an integration entry point for AI agents that can read local
project instructions. It connects user intent to the Machine of Goals
operational materials in `.double/`.

The skill does not replace the workflow. The canonical process is defined in:

- `.double/workflows/machine-of-goals/machine-of-goals-workflow.md`

## Activation Rule

Activate this skill when the user clearly wants to work with Machine of Goals,
including:

- formulating a goal as a verifiable target state
- splitting a goal into subgoals and subplans
- continuing or inspecting an existing goal artifact
- discovering possible realization paths
- synthesizing or revising a plan
- choosing a realization decision
- realizing plan stages
- working with plan execution state or previous plan implementations
- validating stage attempt results or overall goal achievement
- importing an existing plan, analog, runbook, workflow, or reusable fragment
- exporting a plan package, checklist, runbook, workflow,
  specification, or collapsed plan
- asking what the next useful step is for a goal

If the user's intent is only weakly implied, offer activation instead of
silently entering the workflow.

## Machine Operating Change Routing

Before normal workflow entry, detect whether the request creates, changes,
moves, or removes a Machine of Goals operating artifact under `.double/`.

If it does:

1. Verify that `double-agent` is installed and available. If it is not, do
   not change a working file; require its installation first.
2. Activate `.double/skills/double-agent/SKILL.md`.
3. Follow its read-only inspection, planning, versioning, confirmation, and
   validation protocol.
4. Do not route the operating-artifact change to a normal Machine of Goals
   workflow agent.

If the request also changes a user artifact under `goals/`, split that work
into a separate proposed step owned by the appropriate Machine of Goals
workflow agent.

Example:

> I can treat this as a Machine of Goals run and inspect the current goal state.
> Shall I start from the workflow entry protocol?

## Entry Protocol

When the skill is activated, follow the workflow definition in
`.double/workflows/machine-of-goals/machine-of-goals-workflow.md`.

Before producing or changing workflow artifacts, confirm or infer and explain:

- target artifact catalog for a new goal; default to `./goals`
- target goal, plan, imported plan, subgoal, or goal directory
- parent goal directory when the target is a subgoal
- current workflow step
- interaction language
- artifact language
- selected output template
- selected mode
- responsible agent

If Machine of Goals starts without an existing goal artifact, use the workflow's
default state:

- current-step: `01-goal-formulation`
- current-mode: `clarification`
- goal-catalog: `ask-user`, default `./goals`
- expected-output: `goal-artifact`

If the user starts from an existing goal, plan, imported plan, or subgoal,
infer the current step from the artifact state and explain that inference before
advancing.

During `01-goal-formulation`, inspect the goal artifact's `Open Questions`.
When any remain, keep the workflow in `clarification`, state that Path
Discovery is not yet available, and offer to resolve the questions one by one.
Offer transition to `02-path-discovery` only when the goal is sufficiently
clear and no `Open Questions` remain.

During `02-path-discovery`, inspect the path-options artifact's `Open
Questions`. When any remain, keep the workflow in `research`, state that Plan
Synthesis is not yet available, and offer to resolve the questions one by one.
Offer transition to `03-plan-synthesis` only when at least one plausible path
exists and no `Open Questions` remain.

## Active Response Rule

After processing a Machine of Goals request, offer one to three concrete next
steps for moving through the workflow. Ground each option in the current
artifact state and name the next workflow step, mode, responsible agent, and
expected artifact when known.

Do not advance automatically when the next step would create or modify
artifacts, execute work, import or export material, or change goal or plan
execution state. Ask for confirmation first.

## Loading Order

Load only what is needed for the current task.

1. Workflow:
   - `.double/workflows/machine-of-goals/machine-of-goals-workflow.md`
2. Current artifact or goal directory, if one exists.
3. Registries when routing is needed:
   - `.double/registries/machine-of-goals/agents-registry.md`
   - `.double/registries/machine-of-goals/modes-registry.md`
   - `.double/registries/machine-of-goals/roles-registry.md`
   - `.double/registries/machine-of-goals/templates-registry.md`
4. Agent, role, prompt, and template files required by the current step.

## Default Agent Routing

- `01-goal-formulation` -> `goal-formulation-agent`
- `02-path-discovery` -> `path-discovery-agent`
- `03-plan-synthesis` -> `plan-synthesis-agent`
- `04-plan-review-and-decision` -> `plan-synthesis-agent`
- `05-plan-realization` -> `plan-realization-agent`
- `06-plan-validation` -> `plan-validation-agent`
- `07-plan-packaging-export` -> `plan-exchange-agent`

`plan-exchange-agent` is optional and supports import/export. It must not
replace the core goal formulation, path discovery, planning, realization, or
validation flow.

## Boundaries

- This skill is a trigger and routing layer, not a separate workflow.
- The workflow file is the source of truth for step order, transition
  conditions, default state, and artifact contracts.
- Changes inside `.double/` are process changes.
- Goal artifacts themselves belong in the goal working context, not in this
  skill directory.
- A main goal artifact is named `<goal-id>.md` inside `<goal-catalog>/<goal-id>/`.
  A subgoal artifact is named `<subgoal-id>.md` inside its subgoal directory.
- Import must adapt existing material to the current goal context.
- Export must preserve the link between goal, plan, criteria, context, and
  validation evidence.
- The canonical Double community plan for a goal is `plan.md`; imported,
  exported, personal, local, or experimental plan variants must not overwrite
  it without explicit promotion.
- The active plan artifact stores both the intended transition model and the
  current execution state. Its `Plan Map`, `Blocker`, `Stage Attempts`, and
  stage-level `Validation` blocks are the main execution-state surface.
- Working and intermediate plan-execution files belong under
  `<goal-directory>/results/`.
- Imported and exported non-canonical plan artifact names must include author,
  device, and second-precision time labels.
- Imported execution histories and validation evidence must be linked from the
  current plan artifact as existing implementations, not used to overwrite the
  active plan.
