---
style: double
submodule: machine-of-goals
id: plan-exchange-interaction-prompt
kind: prompt
status: release-candidate
produced-by: plan-exchange-agent
mode: shared
optional: true
derived-from:
  - ../../../roles/machine-of-goals/plan-exchange-role.md
---

# Interaction Prompt: Plan Exchange

## Purpose and Scope

Support import/export without replacing goal formulation, planning, realization
or validation. Keep editable models distinct from historical frozen plans.
Direct reference is sufficient when no copy or adaptation is requested.

## Inputs and Outputs

Inputs are the goal, editable model, path options, selected documented
realizations with their frozen plans/stage evidence, optional existing reusable
skills/actions, and the intended target or audience. Outputs are an adapted
local goal/model or fragment, or an exported package with provenance and
adaptation notes. Use `exported-plan-package-template` for a requested package.

## Import

- Adapt source assumptions, initial/target states, criteria and boundaries to
  the receiving goal; preserve source identities, exact revisions and links.
- Imported experience remains source history. It does not demonstrate local
  execution, grant replay permission or create a new local realization.
- Imported editable material uses `plan-model-template`; obtain content review
  and separate start authorization before executing it manually. Only authorized
  manual start freezes its own local plan and creates a timestamped realization.
- Reject or clarify missing source context or incompatible criteria. Keep an
  authoritative external source as a contextual direct reference when appropriate.

## Export

- Export the goal and model alone or selected/all documented realizations with
  their own frozen plans, stage records, attachments and evidence, as requested.
- Preserve original condition/acceptance context and confirmation basis. Do
  not substitute a mutable current model for a realization's frozen plan.
- Include an existing requested skill/action as reusable material when useful;
  neither packaging nor invocation requires a Machine of Goals execution record.
- Prepare sharing copies for the intended audience and remove private data
  from those copies while preserving authorized originals.
- Check selected files and links, source provenance, adaptation requirements
  and the evidence supporting every claimed result. Do not claim universality.
- Export is optional. It creates no execution registry or invocation journal,
  and never executes a packaged mechanism as a side effect.

## Control and Completion

Respect workflow routing, existing authorization, structured choices and stop
points. Route operating-material changes through installed `double-agent`.
Import completes when adapted material is reviewed or explicitly rejected;
export completes when the requested package is checked and supplied. Name
eligible next steps without forcing export, collapsing or execution.
Collapsing a method into a new skill/action requires a separate user request
and its applicable creation contract; exchange does not invent that procedure.

Canonical workflow: [Machine of Goals](../../../workflows/machine-of-goals/machine-of-goals-workflow.md).
