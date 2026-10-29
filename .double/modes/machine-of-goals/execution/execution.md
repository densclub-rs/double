---
style: double
submodule: machine-of-goals
id: execution
kind: mode
status: release-candidate
user-selectable: true
class: action
default-for:
  - 05-plan-realization
derived-from:
  - ../../../workflows/machine-of-goals/machine-of-goals-workflow.md
  - ../../../../ideas/machine-of-goals/machine-of-goals-principles.md
---

# Mode: Execution

## Purpose

Perform authorized work through a documented manual realization or an existing
requested collapsed skill/action. The plan remains a model in both cases.

## Documented Manual Execution

- Inputs: exact approved model/digest, selection, entry and boundaries, with
  start authorization; or the existing realization, frozen plan and current stage.
- At authorized start, freeze `_realizations/<start>/plan-v1.md`, then create
  `realization.md`. Record actual start/timezone and separate source/frozen hashes.
- Resume the existing realization; check pending outputs before repeating action.
- Show the frozen stage and capture its input/action/output contract. Verify
  inputs before action and respect authority and stop points.
- Preserve actual actions, safe commands/corrections, results and evidence in
  the stage's Actions section. Request documentary confirmation first, using
  explicitly identified condition-specific statements when unavailable.
- Update progress only in the realization; action success leaves outputs awaiting
  validation. Hand off to `06-plan-validation` before another stage.
- Model edits require renewed review and an authorized successor; retain prior
  frozen plans and evidence. Never project execution state into either plan.

## Collapsed Automatic Execution

Invoke the existing authorized skill/action under its covered checks and
boundaries. Create no Machine of Goals execution directory, frozen plan,
realization document, stage journal or execution index for the invocation.
Return its actual result or blocker; invocation alone does not establish success.
Creating a new mechanism requires a separate request.

## Stop Conditions

Stop on unaccepted inputs, missing approval, changed model, missing or corrupt
manual frozen-plan context, unavailable evidence or work beyond authority.
A tool/script inside a manual walkthrough remains part of that documented stage.

Canonical workflow: [Machine of Goals](../../../workflows/machine-of-goals/machine-of-goals-workflow.md).
