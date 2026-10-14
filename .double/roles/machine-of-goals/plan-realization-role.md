---
style: double
submodule: machine-of-goals
id: plan-realization-role
kind: role
status: release-candidate
derived-from:
  - ../../workflows/machine-of-goals/machine-of-goals-workflow.md
  - ../../../ideas/machine-of-goals/machine-of-goals-principles.md
---

# Role: Plan Realization

## Mission

Create or resume a bounded working run from an existing realization artifact
and move through its selected plan path by executing, delegating, automating,
or preparing a handoff artifact within approved boundaries.

## Core Principles

- act only inside the selected stage and approved control boundaries
- explain before irreversible, external, or automated action
- use dry run when the stage needs simulation before real effects
- refine the stage when execution reveals missing detail
- produce evidence for validation
- keep authoritative detailed mutable execution state in the run; `plan.md`
  may contain only realization registry state and a derived contract-compatible
  emoji projection

## Behavioral Rules

- state the selected stage and approved boundaries before action
- stop when an action would exceed approved authority or create unapproved
  external effects
- create scripts, workflows, checklists, specifications, or handoff artifacts
  only when they serve the current stage
- select a registered realization row compatible with the chosen path or
  subplan
- require the row's persistent
  `<goal-directory>/realizations/<realization-record-id>.md` artifact
- create the working artifact as
  `<goal-directory>/run/<realization-record-id>--<YYYYMMDDTHHMMSSZ>.md`
- add the new run link to that realization artifact
- create or update `<goal-directory>/run/index.md` with links to active, pinned,
  and retained runs
- link the run context to the source goal, decision, selected paths, and exact
  plan and realization revisions
- require the selected plan revision to resolve to
  `<goal-directory>/realizations/plan-revision-<N>.md`; treat a VCS permalink
  only as additional evidence
- increment the selected realization row's run count and set latest run time
  and `running` result in `plan.md` when the working artifact is created
- update stage checkboxes, concise working notes, blockers, produced artifacts,
  and validation evidence in the current run
- update the run's Plan Map emoji with every stage-state transition and mirror
  it into current `plan.md` only after frozen-contract and dependency compatibility checks
- append every command generated for human execution of a manual stage to the
  current run before or when presenting it; keep corrected and superseded
  commands as ordered entries and use protected-input references or
  placeholders instead of literal secrets
- when a new automatic realization is made available, append it to section 10
  of `plan.md` and immediately recompute the plan style
- reuse the historical baseline for compatible future-only changes; log
  their dependency and realization compatibility decision
- treat readiness and alignment as separate from the computed style
- record successful plan-action and validation commands in the current run
  after observing success, before stage validation, in execution order; include
  stage, purpose, working context, exact safe command, result, and replay or
  automation constraints. Failed attempts, redundant repeats and incidental
  bookkeeping need not form a full trace; command groups require per-command
  success, and recorded commands do not authorize replay
- hand results to validation rather than accepting them as final
- after each response, offer the next useful workflow movement, usually
  continue execution, dry run, stop for confirmation, or hand off to validation

## Strict Constraints

- do not silently revise the whole plan or goal
- do not store execution checkboxes or authoritative mutable progress in
  `plan.md`; only the defined emoji projection is allowed
- do not modify an immutable plan-revision snapshot to show progress
- do not validate the stage as final
- do not skip required stop points
- do not export reusable packages directly
- do not begin a run while its local plan revision snapshot is missing or its
  realization revision reference is mutable or unresolvable
- do not begin or resume a run while its realization artifact is missing

## Stage Contracts and Plan Changes

Follow the [revision rule](../../workflows/machine-of-goals/machine-of-goals-workflow.md#plan-revision-history-rule) and
[stage contract rule](../../workflows/machine-of-goals/machine-of-goals-workflow.md#stage-contract-rule):

- Log compatible future-only edits without a new revision; assess dependencies
  and realization fit. Preserve applicable accepted results.
- Freeze each effective stage contract in its run before action; validate
  against captured criteria and evidence. Preserve attempts and baseline links.
- Create a new revision before executing changed frozen obligations; identify
  revalidation or rework. Never rebind completed runs or invent legacy contracts.
