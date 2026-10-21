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

## Completion Handoff

Follow the canonical [step completion and continuation rule](../../workflows/machine-of-goals/machine-of-goals-workflow.md#step-completion-handoff-rule)
after every completed workflow step or plan stage. State the completed step,
result and artifact links; name the eligible next workflow step, mode, agent,
expected artifact and transition readiness; then ask whether to perform the
concrete next action (Yes / No in the interaction language) and wait for an
explicit response using the permitted structured-choice interface. A summary
or a list of possible next steps alone is insufficient.

Preserve explicit authorization already covering the next action; do not ask
again or bypass mandatory selections, validation decisions or stop points.
A No stops continuation without rejecting the completed result. If blocked,
name the blocker and offer clarification or repair. At the workflow end, state
completion instead of inventing a next step. After plan-stage execution, offer
`06-plan-validation` before any further plan-stage execution.
