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

`Plan Realization` requires the persistent artifact of the approved
realization, creates or resumes a working plan run from it, and realizes its
selected path through execution, delegation, automation, or external handoff.

## Position in Workflow

- Step: `05-plan-realization`
- Workflow: `machine-of-goals-workflow`
- Stage type: `realization`
- Default mode: `execution`

## Inputs

- `plan-artifact`
- `plan-revision-snapshot`
- `path-options`
- `realization-decision`
- `selected-realization-record`
- `realization-artifact`
- `selected-plan-stage`
- `automation-boundaries`
- `stage-validation-criteria`
- `working-context`
- `plan-stop-points`

## Outputs

- `plan-run`
- `updated-realization-artifact`
- `run-index`
- `updated-plan-artifact` when a realization is registered or a run starts
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
  `<goal-directory>/run/<realization-record-id>--<YYYYMMDDTHHMMSSZ>.md`
- require `<goal-directory>/realizations/<realization-record-id>.md` before
  creating or resuming a run
- add every created run to the realization artifact's retained-run table
- increment run count and set latest run time and result `running` in
  the selected realization row in `plan.md` when the run is created
- record selected paths, stage checkboxes, concise work, blockers, outputs, and
  validation evidence in the run
- append every command generated for human execution of a manual stage to the
  current run before or when presenting it; preserve generation order and
  corrected or superseded commands, and never interpolate literal secrets
- append automatic realization rows to section 10 of `plan.md` when the user
  makes them available and recompute style immediately
- keep plan and realization revisions in the run
- require the plan revision to resolve to the selected local
  `<goal-directory>/realizations/plan-revision-<N>.md` snapshot; a VCS
  permalink may be recorded only as additional evidence
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
- must not store detailed mutable execution state in `plan.md`; only realization
  registry status and aggregate fields belong there
- must not begin a run when the selected local plan revision snapshot is
  missing
- must not begin or resume a run when its realization artifact is missing
- must not export reusable packages directly

## Required Artifacts

- System prompt: `.double/prompts/machine-of-goals/system/plan-realization.md`
- Interaction prompt: `.double/prompts/machine-of-goals/interaction/plan-realization.md`
- Role: `.double/roles/machine-of-goals/plan-realization-role.md`
- Plan run template: `.double/templates/machine-of-goals/plan-run-template.md`
- Run index template: `.double/templates/machine-of-goals/run-index-template.md`
- Realization template: `.double/templates/machine-of-goals/realization-template.md`
- Plan template: `.double/templates/machine-of-goals/plan-template.md`
- Modes registry: `.double/registries/machine-of-goals/modes-registry.md`
- Workflow: `.double/workflows/machine-of-goals/machine-of-goals-workflow.md`

## Transition Rule

The step is complete when the run has produced a stage or final result that can
be validated, or when the run is blocked and needs plan or realization
revision.
