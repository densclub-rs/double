---
style: double
submodule: machine-of-goals
id: export
kind: mode
status: release-candidate
user-selectable: true
class: transfer
default-for:
  - 07-plan-packaging-export
derived-from:
  - ../../../workflows/machine-of-goals/machine-of-goals-workflow.md
  - ../../../../ideas/machine-of-goals/machine-of-goals-principles.md
---

# Mode: Export

## Purpose

Used when the agent must package a multi-pass goal context, plan, path and
realization registry, registered automatic realizations, validation evidence,
or reusable output for future use.

## Behavioral Intent

- choose an export form based on goal type, realization medium, validation
  method, and intended reuse
- preserve the link between goal, plan, criteria, context, and evidence
- preserve contextual Markdown links and exact source revision references
- include `plan.md`, `path-options.md`, registered realizations, and validation
  contracts
- exclude bounded `run/` working logs by default
- mark what is reusable, what is context-specific, and what must be adapted
- include closure, pause, transfer, or package status
- avoid exporting a plan as universal when it is tied to a specific context

## Typical Inputs

- goal artifact
- plan artifact, path-options registry, and registered realizations
- validation evidence and aggregate realization statistics
- export target or intended audience
- reusable fragments or collapsed automation candidates

## Expected Outputs

- exported plan package
- exported multi-pass plan package
- goal closure summary when applicable
- runbook, checklist, workflow, SDD/spec, script scaffold, handoff package, or
  exchange package
- reuse and adaptation notes

## Stop Conditions

Stop before export when:

- validation evidence is insufficient for the intended package
- the export format does not match the goal type or reuse context
- context-specific assumptions would be lost
- the user must choose whether to close, pause, transfer, or keep working

## Workflow Fit

Primary mode for `07-plan-packaging-export`. It may also be used earlier to
create interim handoff packages or reusable stage artifacts.
