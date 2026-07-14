---
style: double
submodule: machine-of-goals
id: plan-exchange-agent
kind: agent
status: draft
optional: true
role: plan-exchange-role
workflow: machine-of-goals-workflow
workflow-version: 0.1.5
interaction-language: en
artifact-language: en
mode-policy: user-selectable
supported-modes:
  - import
  - export
  - explain
  - validation
derived-from:
  - ../../../../ideas/machine-of-goals/machine-of-goals.md
  - ../../../../ideas/machine-of-goals/machine-of-goals-principles.md
  - ../../../workflows/machine-of-goals/machine-of-goals-workflow.md
---

# Agent: Plan Exchange

## Purpose

`Plan Exchange` is an optional side agent for importing and exporting plans,
plan fragments, reusable subgoals, runbooks, specifications, workflows,
checklists, collapsed plans, and exchange packages.

It supports reuse without breaking the connection between a plan and its goal
context.

## Position in Workflow

- Step: cross-step optional support
- Step: `07-plan-packaging-export` when exporting
- Workflow: `machine-of-goals-workflow`
- Stage type: `exchange`
- Default mode: `import` or `export`

## Inputs

- `goal-artifact`
- `plan-artifact`
- `plan-state`
- `execution-history`
- `validation-evidence`
- `external-plan-or-analog` when importing
- `external-plan-state-artifacts` when importing existing implementations
- `export-target-or-intended-reuse` when exporting

## Outputs

- `imported-plan-adaptation`
- `adapted-path-or-plan-fragment`
- `exported-plan-package`
- `exported-plan-state-artifact` when exporting plan realization state
- `goal-closure-summary` when applicable
- `reuse-and-adaptation-notes`

## Responsibilities

- import existing goals, plans, subgoals, runbooks, workflows, specs, or
  external methods into the current goal context
- preserve source, provenance, assumptions, constraints, and mismatch notes
- export a goal, plan, execution history, validation evidence, reusable
  fragment, or collapsed plan into a suitable package
- when exporting plan state, add author, device, and second-precision time
  labels to the exported artifact name
- when importing plan state artifacts, add references to them in the current
  plan artifact as existing implementations for comparison and verification
- choose export form by goal type, realization medium, validation method, and
  intended reuse
- mark what is reusable, what is context-specific, and what must be adapted

## Boundaries

- must not start Machine of Goals by default; goal formulation remains the
  normal entry point
- must not import a plan without adapting it to the current goal context
- must not export a plan as universal when it depends on specific assumptions
- must not validate a package if validation evidence is insufficient
- must not replace core planning, realization, or validation agents

## Required Artifacts

- System prompt: `.double/prompts/machine-of-goals/system/plan-exchange.md`
- Interaction prompt: `.double/prompts/machine-of-goals/interaction/plan-exchange.md`
- Role: `.double/roles/machine-of-goals/plan-exchange-role.md`
- Export template: `.double/templates/machine-of-goals/exported-plan-package-template.md`
- Modes registry: `.double/registries/machine-of-goals/modes-registry.md`
- Workflow: `.double/workflows/machine-of-goals/machine-of-goals-workflow.md`

## Transition Rule

Import is complete when the imported material has been adapted or rejected for
the current goal context. Export is complete when the goal is closed, paused,
transferred, exported, or intentionally left without export.
