---
style: double
submodule: machine-of-goals
id: export
kind: mode
status: stable
user-selectable: true
class: transfer
default-for:
  - 07-plan-packaging-export
derived-from:
  - ../../../workflows/machine-of-goals/machine-of-goals-workflow.md
  - ../../../../ideas/machine-of-goals/machine-of-goals-principles.md
---

# Mode: Export

## Purpose and Scope

Support import/export without replacing goal formulation, planning, realization
or validation. Use the current main plan and preserve the captured historical conditions.
Direct reference is sufficient when no copy or adaptation is requested.

## Inputs and Outputs

Inputs are the goal, editable model, path options, selected documented
realizations with their captured conditions and stage evidence, optional existing reusable
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
  manual start links the approved main plan and creates a timestamped realization without a local copy.
- Reject or clarify missing source context or incompatible criteria. Keep an
  authoritative external source as a contextual direct reference when appropriate.

## Export

- Present the goal, current selected plan and Sharing Realizations. Let the user
  select manual or automatic variants, or export without realizations.
- Prepare copies of the goal, main plan and selected materials, documentation
  and dependencies. Check package-relative links, captured conditions and
  applicability; report missing dependencies or incompatible historical context.
  Do not create per-realization frozen plans or alter private originals.
- Inspect sharing text and attachments for personal data; if found, ask the user
  whether to remove, retain or mask it before committing sharing materials.
- Delegate package format selection, construction and validation to the Double
  Agent exchange packaging contract. If unavailable, report the blocker; do not
  claim an arbitrary archive is a Double package.
- Export never executes a selected mechanism or creates invocation history.

## Control and Completion

Respect workflow routing, existing authorization, structured choices and stop
points. Route operating-material changes through installed `double-agent`.
Import completes when adapted material is reviewed or explicitly rejected;
export completes when the requested package is checked and supplied. Name
eligible next steps without forcing export, collapsing or execution.
Collapsing a method into a new skill/action requires a separate user request
and its applicable creation contract; exchange does not invent that procedure.

Canonical workflow: [Machine of Goals](../../../workflows/machine-of-goals/machine-of-goals-workflow.md).

## Existing Mechanism Context

Use Existing Automatic Mechanisms in the canonical workflow. Available Automatic
Realizations describes existence and mapped coverage, separately from Sharing
Realizations and invocation history. Transfer only selected existing materials
with their plan/revision, coverage, manual remainder, usage, inputs/dependencies,
checks, authority, evidence context and unchecked gaps. Report missing files and
compatibility limits. Transfer never creates or invokes a mechanism, grants
execution permission or confirms its operation in the receiving environment.

## Role, Mode, and Style Boundary

Follow [Style Application Protocol](../../../workflows/machine-of-goals/machine-of-goals-workflow.md#style-application-protocol)
at task entry and when the role changes. Responsibilities, mandatory mode
conditions, artifact contracts, permissions, and workflow transitions remain
binding. Behavioral defaults live only in the selected global style; do not
merge a replacement with `double.md`. The legacy `style: double` frontmatter
classifies this document and does not select the runtime style.
