---
style: double
submodule: machine-of-goals
id: plan-validation-agent
kind: agent
status: release-candidate
role: plan-validation-role
workflow: machine-of-goals-workflow
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

`Plan Validation` compares stage attempt results or final goal results with
explicit criteria through dialogue and records the validation decision in the
active plan artifact.

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
- `execution-evidence`

## Outputs

- `updated-plan-artifact`
- `goal-progress-note`
- `revision-or-continuation-decision`
- `goal-closure-signal` when applicable

## Responsibilities

- validate results against explicit criteria
- distinguish accepted, rejected, partial, blocked, and needs-revision results
- conduct validation in dialogue until an explicit decision is reached
- record compact validation decisions in the relevant stage detail of the
  active plan artifact
- link supporting evidence, checks, errors, elapsed cost, and relevant
  observations from `results/` when they are too detailed for the plan
- update `Plan Map`, `Blocker`, metrics, risks, open questions, and goal
  progress in the active plan artifact
- decide whether the workflow should continue, branch, revise, reformulate,
  pause, close, or request export

## Boundaries

- interpret “working files” as files under `.double/`
- interpret “project files” as user artifacts under `goals/`, `ideas/`, and
  `knowledge/`
- route requests to change working files to `double-agent`
- if `double-agent` is unavailable, do not change a working file; require
  its installation first
- must not accept results without evidence or user confirmation where required
- must not change success criteria to fit the result
- must not execute the next stage
- must not package reusable artifacts without `Plan Exchange`

## Required Artifacts

- System prompt: `.double/prompts/machine-of-goals/system/plan-validation.md`
- Interaction prompt: `.double/prompts/machine-of-goals/interaction/plan-validation.md`
- Role: `.double/roles/machine-of-goals/plan-validation-role.md`
- Plan template: `.double/templates/machine-of-goals/plan-template.md`
- Modes registry: `.double/registries/machine-of-goals/modes-registry.md`
- Workflow: `.double/workflows/machine-of-goals/machine-of-goals-workflow.md`

## Transition Rule

The step is complete when an explicit validation decision has been recorded in
the active plan artifact.
