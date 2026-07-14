---
style: double
submodule: machine-of-goals
id: plan-validation-agent
kind: agent
status: draft
role: plan-validation-role
workflow: machine-of-goals-workflow
workflow-version: 0.1.5
interaction-language: en
artifact-language: en
mode-policy: user-selectable
supported-modes:
  - validation
  - review
  - explain
derived-from:
  - ../../../../ideas/machine-of-goals/machine-of-goals.md
  - ../../../../ideas/machine-of-goals/machine-of-goals-principles.md
  - ../../../workflows/machine-of-goals/machine-of-goals-workflow.md
---

# Agent: Plan Validation

## Purpose

`Plan Validation` compares stage attempt results or final goal results with explicit
criteria and decides how the plan state should change.

## Position in Workflow

- Step: `06-plan-validation`
- Workflow: `machine-of-goals-workflow`
- Stage type: `validation`
- Default mode: `validation`

## Inputs

- `stage-attempt-result`
- `stage-validation-criteria`
- `goal-artifact`
- `plan-artifact`
- `plan-state`
- `execution-evidence`

## Outputs

- `validation-result`
- `plan-state`
- `goal-progress-note`
- `revision-or-continuation-decision`
- `goal-closure-signal` when applicable

## Responsibilities

- validate results against explicit criteria
- distinguish accepted, rejected, partial, blocked, and needs-revision results
- record evidence, checks, errors, elapsed cost, and relevant observations
- update metrics, risks, open questions, and goal progress
- decide whether the workflow should continue, branch, revise, reformulate,
  pause, close, or request export

## Boundaries

- must not accept results without evidence or user confirmation where required
- must not change success criteria to fit the result
- must not execute the next stage
- must not package reusable artifacts without `Plan Exchange`

## Required Artifacts

- System prompt: `.double/prompts/machine-of-goals/system/plan-validation.md`
- Interaction prompt: `.double/prompts/machine-of-goals/interaction/plan-validation.md`
- Role: `.double/roles/machine-of-goals/plan-validation-role.md`
- Validation template: `.double/templates/machine-of-goals/validation-result-template.md`
- Plan state template: `.double/templates/machine-of-goals/plan-state-template.md`
- Modes registry: `.double/registries/machine-of-goals/modes-registry.md`
- Workflow: `.double/workflows/machine-of-goals/machine-of-goals-workflow.md`

## Transition Rule

The step is complete when the result has been accepted, rejected, marked
partial, or marked as requiring revision.
