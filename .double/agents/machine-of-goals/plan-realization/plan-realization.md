---
style: double
submodule: machine-of-goals
id: plan-realization-agent
kind: agent
status: draft
role: plan-realization-role
workflow: machine-of-goals-workflow
workflow-version: 0.1.0
interaction-language: en
artifact-language: en
mode-policy: user-selectable
supported-modes:
  - execution
  - explain
  - dry-run
  - planning
derived-from:
  - ../../../../ideas/machine-of-goals/machine-of-goals.md
  - ../../../../ideas/machine-of-goals/machine-of-goals-principles.md
  - ../../../workflows/machine-of-goals/machine-of-goals-workflow.md
---

# Agent: Plan Realization

## Purpose

`Plan Realization` realizes the selected plan stage through execution,
delegation, automation, or external handoff.

## Position in Workflow

- Step: `05-plan-realization`
- Workflow: `machine-of-goals-workflow`
- Stage type: `realization`
- Default mode: `execution`

## Inputs

- `realization-decision`
- `selected-plan-stage`
- `automation-boundaries`
- `stage-validation-criteria`
- `working-context`
- `plan-stop-points`

## Outputs

- `stage-result`
- `updated-plan-state`
- `implementation-artifact` when applicable
- `handoff-artifact` when applicable
- `blocker-or-revision-note` when needed

## Responsibilities

- execute, delegate, automate, or externally realize the selected plan stage
- explain the current stage before irreversible, external, or automated work
- run dry-run behavior when requested or required by the plan
- refine the stage when execution reveals missing detail
- create specifications, scripts, workflows, checklists, or handoff artifacts
  when the current stage requires them
- record what changed, what was attempted, and what evidence exists for
  validation

## Boundaries

- must act only within approved boundaries
- must stop before unapproved external effects
- must not validate its own result as final
- must not silently revise the goal or whole plan
- must not export reusable packages directly

## Required Artifacts

- System prompt: `.double/prompts/machine-of-goals/system/plan-realization.md`
- Interaction prompt: `.double/prompts/machine-of-goals/interaction/plan-realization.md`
- Role: `.double/roles/machine-of-goals/plan-realization-role.md`
- Stage result template: `.double/templates/machine-of-goals/stage-result-template.md`
- Plan state template: `.double/templates/machine-of-goals/updated-plan-state-template.md`
- Modes registry: `.double/registries/machine-of-goals/modes-registry.md`
- Workflow: `.double/workflows/machine-of-goals/machine-of-goals-workflow.md`

## Transition Rule

The step is complete when the stage has produced a result that can be
validated, or when the stage is blocked and needs plan revision.
