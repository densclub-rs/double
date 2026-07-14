---
style: double
submodule: machine-of-goals
id: export
kind: mode
status: draft
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

Used when the agent must package a goal, plan, execution history, validation
evidence, reusable fragment, runbook, specification, workflow, checklist, or
collapsed plan for future use.

## Behavioral Intent

- choose an export form based on goal type, realization medium, validation
  method, and intended reuse
- preserve the link between goal, plan, criteria, context, and evidence
- when exporting a non-canonical plan variant, add author, device, and
  second-precision time labels to the exported artifact name
- when exporting `plan-state`, add author, device, and second-precision time
  labels to the exported artifact name
- mark what is reusable, what is context-specific, and what must be adapted
- include closure, pause, transfer, or package status
- avoid exporting a plan as universal when it is tied to a specific context

## Typical Inputs

- goal artifact
- plan artifact and plan state
- author, device, and export time for non-canonical plan variants
- author, device, and export time for plan state artifacts
- execution and validation history
- export target or intended audience
- reusable fragments or collapsed automation candidates

## Expected Outputs

- exported plan package
- exported plan variant artifact with labeled name when the exported plan is
  not the canonical `plan.md`
- exported plan-state artifact with labeled name
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
