---
style: double
submodule: machine-of-goals
id: machine-of-goals-workflow
kind: workflow
status: draft
version: 0.1.0
interaction-language: en
artifact-language: en
derived-from:
  - ideas/machine-of-goals/machine-of-goals.md
  - ideas/machine-of-goals/machine-of-goals-concepts.md
  - ideas/machine-of-goals/machine-of-goals-principles.md
---

# Workflow: Machine of Goals

## Purpose

This workflow defines the first working draft of Machine of Goals.

Machine of Goals helps transform a user's goal description into a verifiable
goal, discover possible paths, synthesize a plan, choose a realization strategy,
realize the plan through iterative work, validate results, and optionally
package or export the resulting plan.

The current working flow:

```text
Goal Formulation
-> Path Discovery
-> Plan Synthesis
-> Plan Review and Decision
-> Plan Realization
-> Plan Validation
-> Plan Packaging / Export
```

## Working Thesis

Machine of Goals does not require a final complete plan before realization.

`Plan Synthesis` produces a project of a plan: a sufficiently understandable
transition model from the current state toward the target state. The plan is
expected to gain detail during the main work cycle:

```text
Plan Realization <-> Plan Validation
```

During this cycle, plan stages may be refined, validation specifications may be
created, external implementation may happen, automation may be introduced, and
the plan may be revised as the goal becomes clearer through execution.

## Versioning Rule

- current version: `0.1.0`
- a new version is created if the structure of steps, artifact contracts, modes,
  execution policy, validation policy, or transition conditions change

## Catalog Interpretation Rule

The `.double/` directory is the working catalog of Double.

Machine of Goals working files should be placed in subdirectories named
`machine-of-goals` when the file belongs to a specific workflow, agent, role,
mode, prompt, template, registry, or skill of this submodule.

Goal artifacts themselves are not process files. They belong in the goal working
context defined by Machine of Goals, not in this workflow directory.

## Default State

If Machine of Goals starts without an existing goal artifact, the initial state
is considered to be:

- current-step: `01-goal-formulation`
- current-mode: `clarification`
- interaction-language: `ask-user`
- artifact-language: `ask-user`
- expected-output: `goal-artifact`
- available-actions:
  - `describe-goal`
  - `clarify-goal`
  - `inspect-existing-goal`
  - `look-for-existing-analog`
  - `choose-mode`
  - `inspect-workflow`

If the user starts from an existing goal, plan, imported plan, or subgoal, the
agent should infer the current step from the artifact state and explain that
inference before advancing.

## Modes

The first draft assumes these cross-step modes. Draft contracts are defined in
[Machine of Goals Modes](../../modes/machine-of-goals/machine-of-goals.md).

- `clarification`: formulate, refine, and disambiguate user intent
- `research`: inspect available context and possible ways to reach the goal
- `planning`: create or revise the plan as a transition model
- `review`: compare plan options and prepare a realization decision
- `execution`: move through selected plan stages
- `validation`: verify stage results or overall goal achievement
- `explain`: explain the current goal, path, plan, stage, decision, or check
- `dry-run`: simulate an execution stage without real-world effects
- `import`: adapt an existing goal, plan, or reusable analog into this context
- `export`: package a goal, plan, runbook, specification, workflow, or checklist

## Agents

The first draft uses five core agents plus one optional exchange agent. Draft
contracts are defined in
[Machine of Goals Agents](../../agents/machine-of-goals/machine-of-goals.md).

Core agents:

- `goal-formulation-agent`: formulates a user intention as a verifiable goal
- `path-discovery-agent`: discovers and compares possible realization paths
- `plan-synthesis-agent`: creates the plan project and supports the review
  decision checkpoint
- `plan-realization-agent`: realizes selected plan stages within approved
  boundaries
- `plan-validation-agent`: validates stage or goal results and updates plan
  state

Optional agent:

- `plan-exchange-agent`: imports and exports plans, plan fragments, runbooks,
  workflows, specifications, and exchange packages

## Templates

Draft artifact templates are defined in
[Machine of Goals Templates](../../templates/machine-of-goals/machine-of-goals.md).

- `goal-artifact` -> `.double/templates/machine-of-goals/goal-artifact-template.md`
- `path-options` -> `.double/templates/machine-of-goals/path-options-template.md`
- `plan-artifact` -> `.double/templates/machine-of-goals/plan-artifact-template.md`
- `realization-decision` -> `.double/templates/machine-of-goals/realization-decision-template.md`
- `stage-result` -> `.double/templates/machine-of-goals/stage-result-template.md`
- `validation-result` -> `.double/templates/machine-of-goals/validation-result-template.md`
- `updated-plan-state` -> `.double/templates/machine-of-goals/updated-plan-state-template.md`
- `exported-plan-package` -> `.double/templates/machine-of-goals/exported-plan-package-template.md`

## Import and Existing Analog Rule

Machine of Goals starts from goal formulation, not from import.

During `Goal Formulation`, the machine may look for an existing analog of the
goal or plan in a local catalog, future marketplace, or user-provided material.
If a useful analog exists, it may be imported or adapted instead of inventing a
plan from scratch.

Until a marketplace exists, the normal working behavior is to formulate and
clarify the goal directly from the user's description.

## Main Realization Loop

`Plan Realization` and `Plan Validation` form the primary working loop of the
machine:

```text
choose next plan stage
-> explain current stage
-> refine stage if needed
-> prepare validation specification if needed
-> execute, delegate, automate, or hand off externally
-> validate result
-> update plan state
-> revise plan if needed
-> continue, branch, stop, or close goal
```

This loop is where the plan becomes more concrete. The machine may discover
that a stage needs more detail, a validation specification, a subgoal, an
external implementation artifact, or a different realization route.

## Steps

### 01. Goal Formulation

- step-id: `01-goal-formulation`
- default-mode: `clarification`
- purpose:
  - formulate the user's goal as a verifiable target state
  - clarify the subject of the goal, current state, target state, motivation,
    constraints, resources, and success criteria
  - identify obvious subgoals when they are already visible
  - optionally look for an existing analog of the goal or plan
- produced-outputs:
  - `goal-artifact`
- transition-condition:
  - the goal is sufficiently clear to search for possible realization paths
- next-step:
  - `02-path-discovery`

### 02. Path Discovery

- step-id: `02-path-discovery`
- default-mode: `research`
- purpose:
  - discover possible ways to reach the formulated goal
  - include direct, minimal, exploratory, long-term, delegated, automated,
    tool-based, external, or reusable-plan paths
  - compare paths at a preliminary level by fit, risk, cost, and expected value
- produced-outputs:
  - `path-options`
- transition-condition:
  - at least one plausible path exists, or the goal is marked as blocked,
    infeasible, or requiring reformulation
- next-step:
  - `03-plan-synthesis`

### 03. Plan Synthesis

- step-id: `03-plan-synthesis`
- default-mode: `planning`
- purpose:
  - turn one or more paths into one or more plan projects
  - model the plan as a transition from current state to target state
  - include stages, dependencies, resources, risks, checks, stop points,
    subgoals, and known uncertainties
- produced-outputs:
  - `plan-artifact`
  - `alternative-plan-artifacts` when useful
- transition-condition:
  - at least one plan project is understandable enough to review and choose a
    realization strategy
- next-step:
  - `04-plan-review-and-decision`

### 04. Plan Review and Decision

- step-id: `04-plan-review-and-decision`
- default-mode: `review`
- purpose:
  - act as the commit point before movement through the plan
  - choose a plan, a hybrid plan, or a first plan branch
  - define the first entry point
  - choose the realization mode
  - set automation boundaries, confirmation points, dry-run needs, validation
    strategy, and plan revision conditions
- produced-outputs:
  - `realization-decision`
- transition-condition:
  - the user or responsible agent has selected how the plan will start and under
    which control boundaries it may proceed
- next-step:
  - `05-plan-realization`

### 05. Plan Realization

- step-id: `05-plan-realization`
- default-mode: `execution`
- purpose:
  - execute, delegate, automate, or externally realize the selected plan stage
  - refine the stage when necessary before or during work
  - create additional specifications, scripts, workflows, checklists, or
    handoff artifacts when the current stage requires them
- produced-outputs:
  - `stage-result`
  - `updated-plan-state`
- transition-condition:
  - a stage has produced a result that can be validated, or the stage is blocked
    and needs plan revision
- next-step:
  - `06-plan-validation`

### 06. Plan Validation

- step-id: `06-plan-validation`
- default-mode: `validation`
- purpose:
  - validate the result of the current realized stage
  - compare evidence with the stage completion criteria
  - update plan state, goal progress, metrics, risks, and open questions
  - decide whether to continue, branch, revise, stop, or close the goal
- produced-outputs:
  - `validation-result`
  - `updated-plan-state`
- transition-condition:
  - the stage result has been accepted, rejected, marked partial, or marked as
    requiring revision
- next-step:
  - `05-plan-realization`
  - `07-plan-packaging-export`
  - `01-goal-formulation` when the goal itself must be reformulated
  - `03-plan-synthesis` when the plan project must be rebuilt

### 07. Plan Packaging / Export

- step-id: `07-plan-packaging-export`
- default-mode: `export`
- purpose:
  - optionally package the goal, plan, execution history, validation evidence,
    reusable fragments, or collapsed plan for future use
  - export into a suitable form such as Markdown plan, runbook, checklist,
    workflow, SDD/spec, script scaffold, handoff package, or exchange package
- produced-outputs:
  - `exported-plan-package`
  - `goal-closure-summary`
- transition-condition:
  - the goal is closed, paused, transferred, exported, or intentionally left
    without export
- next-step:
  - `<end>`

## Deferred Contracts

The following contracts are intentionally left for detailed design:

- mode-specific prompts and templates
- marketplace or reusable-plan lookup protocol
- import and export package formats
