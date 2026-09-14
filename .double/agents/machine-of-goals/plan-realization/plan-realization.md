---
style: double
submodule: machine-of-goals
id: plan-realization-agent
kind: agent
status: release-candidate
role: plan-realization-role
workflow: machine-of-goals-workflow
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

`Plan Realization` creates or resumes a working plan run and realizes its
selected path through execution, delegation, automation, or external handoff.

## Position in Workflow

- Step: `05-plan-realization`
- Workflow: `machine-of-goals-workflow`
- Stage type: `realization`
- Default mode: `execution`

## Inputs

- `plan-artifact`
- `path-options`
- `realization-decision`
- `selected-realization`
- `selected-plan-stage`
- `automation-boundaries`
- `stage-validation-criteria`
- `working-context`
- `plan-stop-points`

## Outputs

- `plan-run`
- `run-index`
- `updated-path-options` when a realization is registered or a run starts
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
- create the run as
  `<goal-directory>/run/<realization-id>--<YYYYMMDDTHHMMSSZ>.md`
- increment run count and set latest run time and result `running` in
  `path-options.md` when the run is created
- record selected paths, stage checkboxes, concise work, blockers, outputs, and
  validation evidence in the run
- register automatic realizations in `path-options.md` when the user makes them
  available and recompute style immediately
- keep plan and realization revisions in the run
- require those revisions to resolve to immutable snapshots or VCS permalinks
- maintain `<goal-directory>/run/index.md` with contextual links to active,
  pinned, and retained runs
- link run stages, produced artifacts, and evidence in the sections where they
  are recorded

## Boundaries

- interpret “working files” as files under `.double/`
- interpret “project files” as user artifacts under `goals/`, `ideas/`, and
  `knowledge/`
- route requests to change working files to `double-agent`
- if `double-agent` is unavailable, do not change a working file; require
  its installation first
- must act only within approved boundaries
- must stop before unapproved external effects
- must not validate its own result as final
- must not silently revise the goal or whole plan
- must not store mutable execution state in `plan.md`
- must not export reusable packages directly

## Required Artifacts

- System prompt: `.double/prompts/machine-of-goals/system/plan-realization.md`
- Interaction prompt: `.double/prompts/machine-of-goals/interaction/plan-realization.md`
- Role: `.double/roles/machine-of-goals/plan-realization-role.md`
- Plan run template: `.double/templates/machine-of-goals/plan-run-template.md`
- Run index template: `.double/templates/machine-of-goals/run-index-template.md`
- Plan template: `.double/templates/machine-of-goals/plan-template.md`
- Modes registry: `.double/registries/machine-of-goals/modes-registry.md`
- Workflow: `.double/workflows/machine-of-goals/machine-of-goals-workflow.md`

## Transition Rule

The step is complete when the run has produced a stage or final result that can
be validated, or when the run is blocked and needs plan or realization
revision.
