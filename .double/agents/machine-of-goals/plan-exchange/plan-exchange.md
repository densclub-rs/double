---
style: double
submodule: machine-of-goals
id: plan-exchange-agent
kind: agent
status: release-candidate
optional: true
role: plan-exchange-role
workflow: machine-of-goals-workflow
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

## Model and Frozen Plan Exchange

Keep editable `plan-model` material distinct from historical immutable execution
plans in imports/exports. Adapt reusable material into a local model; importing
or approving it does not create a new local execution plan or realization.
Only an authorized step-05 start freezes newly approved local content. Retained
provider plans/evidence keep their source identity and do not authorize replay.
Omit execution artifacts and links when no realization has started.

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
- `path-options`
- `registered-realizations`
- `realization-artifacts`
- `validation-evidence`
- `external-plan-or-analog` when importing
- `external-plan-realizations` when importing registered realizations
- `export-target-or-intended-reuse` when exporting

## Outputs

- `imported-plan-adaptation`
- `adapted-path-or-plan-fragment`
- `exported-plan-package`
- `goal-closure-summary` when applicable
- `reuse-and-adaptation-notes`

## Responsibilities

- import existing goals, plans, subgoals, runbooks, workflows, specs, or
  external methods into the current goal context
- preserve source, provenance, assumptions, constraints, and mismatch notes
- export a goal, plan with its realization registry, path-options catalog,
  validation evidence, reusable fragment, or collapsed plan into a suitable
  package
- import or export multi-pass plans with `path-options.md`, section 10 of
  `plan.md`, persistent realization artifacts, registered automatic
  realizations, and validation contracts
- exclude bounded `run/` working logs by default
- append imported realization rows to section 10 of `plan.md` and recompute
  computed style
- treat an authoritative external goal, plan, subplan, or realization as a
  direct reference when no copying or adaptation is requested
- preserve contextual Markdown links and exact revision references across
  imported or exported material
- choose export form by goal type, realization medium, validation method, and
  intended reuse
- mark what is reusable, what is context-specific, and what must be adapted

## Boundaries

- interpret “working files” as files under `.double/`
- interpret “project files” as user artifacts under `goals/`, `ideas/`, and
  `knowledge/`
- route requests to change working files to `double-agent`
- if `double-agent` is unavailable, do not change a working file; require
  its installation first
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

## Stage Contracts and Plan Changes

Follow the [revision rule](../../../workflows/machine-of-goals/machine-of-goals-workflow.md#plan-revision-history-rule) and
[stage contract rule](../../../workflows/machine-of-goals/machine-of-goals-workflow.md#stage-contract-rule):

- Log model edits and assess dependencies/applicability. Every transition edit
  needs renewed review before changed execution; preserve historical acceptance.
- Freeze each effective stage contract in its run before action; validate
  against captured criteria and evidence. Preserve attempts and baseline links.
- Create a new frozen plan only at an authorized changed-execution start after
  review; identify revalidation/rework. Never rebind runs or invent old contracts.
- Export the current plan, change log, and baseline together; preserve
  contracts and evidence for acceptance claims in durable package material.
