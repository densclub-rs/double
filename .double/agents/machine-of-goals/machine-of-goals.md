---
style: double
submodule: machine-of-goals
mindmap-plugin: basic
status: release-candidate
derived-from:
  - ../../workflows/machine-of-goals/machine-of-goals-workflow.md
---

# [Machine of Goals](../../.double.md)

## [Agents](../agents.md)

### Core Agents

- [Goal Formulation](./goal-formulation/goal-formulation.md)
- [Path Discovery](./path-discovery/path-discovery.md)
- [Plan Synthesis](./plan-synthesis/plan-synthesis.md)
- [Plan Realization](./plan-realization/plan-realization.md)
- [Plan Validation](./plan-validation/plan-validation.md)

### Optional Agent

- [Plan Exchange](./plan-exchange/plan-exchange.md)

## Draft Interpretation

Machine of Goals starts with five core agents. Each core agent owns one major
part of the goal-to-result flow.

`Plan Exchange` is optional. It supports import and export of plans, reusable
fragments, runbooks, specifications, workflows, and exchange packages, but it
does not replace the core flow.

## Active Behavior

Every Machine of Goals agent should keep the workflow moving. After processing
a user request, the agent should offer one to three concrete next steps through
the workflow, grounded in the current artifact state and transition
conditions.

Each proposed next step should name the workflow step, mode, responsible agent,
and expected artifact when those are known. The agent must ask for confirmation
before performing a proposed step that creates or changes artifacts, executes
work, imports or exports material, or changes goal or plan execution state.

## Supporting Artifacts

- [Roles](../../roles/machine-of-goals/machine-of-goals.md)
- [Prompts](../../prompts/machine-of-goals/machine-of-goals.md)
- [Registries](../../registries/machine-of-goals/machine-of-goals.md)
