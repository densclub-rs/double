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

## Manual and Interactive Route

Use the canonical [Model and Realization Execution Rule](../../../workflows/machine-of-goals/machine-of-goals-workflow.md#model-and-realization-execution-rule)
for this route. It selects the lightweight model/realization/stage templates
and governs steps 03–06 as applicable. Existing authorization, language,
structured-choice, stop-point, and continuation rules remain binding.

### Inputs and Outputs

- Inputs: selected model file/branch/version, authorized entry or existing
  realization/current stage, and the relevant conditions and stop points.
- Outputs: `realization-artifact`, `stage-realization`, and directly linked
  evidence or actual deliverables required by the approved stage.

### Execution Rules

- At actual authorized start, create the timestamped `realization.md` from
  the first `realization-template` shape. Record actual time/timezone and the
  computed model digest. Resume the selected existing realization otherwise.
- Show current stage and its model anchor, required inputs, planned action,
  expected outputs, and checks. Keep progress/current-stage only in the main
  realization map and use `stage-realization-template` for stage detail.
- Capture source conditions/action before acting. Compare model identity and
  content digest before action; a change ends this realization and requires
  authorized review/continuation into a successor.
- Offer appropriate documentary confirmation of inputs. Inspect what it
  establishes; when unavailable, an explicit condition-specific user statement
  can support acceptance, labeled as such. Silence and unrelated files
  do not confirm conditions. Do not act on unaccepted inputs.
- Record actual actions and relevant safe commands/corrections in order inside
  Actions. Do not invent evidence, timestamps, or command success, and remain
  within existing approval boundaries and stop points.
- After action, leave outputs awaiting verification and hand off to step 06.
  An existing stage awaiting validation must be checked, not blindly executed
  again on resume. Do not mark it completed from action success alone.
- Do not create a run, registry, index, evidence manifest, or validation file;
  do not mirror progress into the model or introduce collapsing/automation.

## Retained Instructions for Other Execution Modes

The remainder is retained for other modes. Its legacy execution-data rules
(run, registry, snapshot, statistics, or progress projection) do not apply to
the manual/interactive route above. Common operating-change routing and user
control boundaries still apply in either route. No collapsing or automatic
behavior is redesigned by this synchronization.

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
- `updated-plan-artifact` when a realization is registered, a run starts, or a
  contract-compatible progress projection changes
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
- maintain emoji progress in the run's stage-attempt Plan Map; project it by
  stable stage id only after frozen-contract and dependency compatibility checks
- append every command generated for human execution of a manual stage to the
  current run before or when presenting it; preserve generation order and
  corrected or superseded commands, and never interpolate literal secrets
- record successful plan-action and validation commands in the current run
  after observing success, before stage validation, in execution order; include
  stage, purpose, working context, exact safe command, result, and replay or
  automation constraints. Failed attempts, redundant repeats and incidental
  bookkeeping need not form a full trace; command groups require per-command
  success, and recorded commands do not authorize replay
- append automatic realization rows to section 10 of `plan.md` when the user
  makes them available and recompute style immediately
- reuse the current plan revision when an automatic realization is registered
  against unchanged plan content
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
- must not store authoritative detailed execution state in `plan.md`; only the
  realization registry and a contract-compatible emoji projection may change
- must not update an immutable plan-revision snapshot with execution progress
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

## Stage Contracts and Plan Changes

Follow the [revision rule](../../../workflows/machine-of-goals/machine-of-goals-workflow.md#plan-revision-history-rule) and
[stage contract rule](../../../workflows/machine-of-goals/machine-of-goals-workflow.md#stage-contract-rule):

- Log compatible future-only edits without a new revision; assess dependencies
  and realization fit. Preserve applicable accepted results.
- Freeze each effective stage contract in its run before action; validate
  against captured criteria and evidence. Preserve attempts and baseline links.
- Create a new revision before executing changed frozen obligations; identify
  revalidation or rework. Never rebind completed runs or invent legacy contracts.
