---
style: double
submodule: machine-of-goals
id: templates-registry
kind: registry
status: release-candidate
---

# Templates Registry

## Purpose

This registry lists draft artifact templates used by Machine of Goals workflow
outputs and their stable template identifiers.

## Templates

| Artifact Kind | Template ID | Template |
| --- | --- | --- |
| `goal-artifact` | `goal-template` | `.double/templates/machine-of-goals/goal-template.md` |
| `path-options` | `path-options-template` | `.double/templates/machine-of-goals/path-options-template.md` |
| `plan-model` | `plan-model-template` | `.double/templates/machine-of-goals/plan-model-template.md` |
| `plan-artifact` | `plan-template` | `.double/templates/machine-of-goals/plan-template.md` |
| `realization-artifact` | `realization-template` | `.double/templates/machine-of-goals/realization-template.md` |
| `stage-realization` | `stage-realization-template` | `.double/templates/machine-of-goals/stage-realization-template.md` |
| `exported-plan-package` | `exported-plan-package-template` | `.double/templates/machine-of-goals/exported-plan-package-template.md` |

## Usage Rule

- use templates as draft artifact shapes, not final storage contracts
- copy the template's top-level `id` into the generated artifact's
  frontmatter `template-id`; do not replace it with the template path or the
  generated artifact id
- update this registry when an artifact template is added, renamed, split, or
  removed

## Model and Realization Shape

- Both editable and frozen documents keep the user-facing name `Plan` and
  heading `# Plan: <Goal Title> / <Branch>`. Technical kinds and template IDs
  distinguish their roles without changing the artifact name to `Plan Model`.
- Step 03: create `<goal-directory>/plan.md` from `plan-model-template` by
  default. Every plan has only `id`, a generated short human-readable word
  derived from the plan's context: jointly express its subject, core meaning
  and goal in a single word. Always write it in frontmatter and use it as the
  root anchor. Use lowercase English letters only and choose another word
  combining all three concepts on collision. Revisions and frozen copies retain
  the same `id`; paths, revisions/versions and digests identify exact copies.
  Parallel variants use `plan-<id>.md`; author variants use `plan<owner_id>.md`
  with the actual author's `owner-id`, without a hyphen after `plan`. Variants
  may be formed directly at synthesis after discovery. Keep each actual plan's
  `id`, branch, review revision and file/anchor in the goal table. `plan-id` in
  another artifact references this `id`, rather than duplicating plan identity.
- Step 04: show the actual plan file link and request approval of its current
  contents, path/entry and boundaries. Keep the computed digest internal, not
  in the question, title, choices or normal summary. A deferred start leaves
  only the model; any edit requires renewed review of the linked contents.
- Authorized manual step-05 start: freeze `_realizations/<start>/plan-v1.md` from
  `plan-template` with `kind: plan-artifact`, `plan-version: 1` and approved
  source provenance. Rebase links without changing approved transition content.
- Create `realization.md` in that directory after the plan, recording its exact
  digest and the approved source digest separately. Stage records link the local
  frozen plan; progress, evidence and actual results stay in these records.
  Render each State cell with only an emoji, explained by the canonical
  legend above the map; do not repeat state words or add a duplicate status
  column. 🟠 means awaiting verification; ✅ requires
  accepted output conditions. Preserve textual metadata and keep both plans
  free of mutable execution progress.
- Request documentary evidence first; explicit user statements are an identified
  fallback. Verify input before action and output before completion. The model
  and frozen plan contain no execution progress.
- A source edit stops further planned action, requires renewed review and an
  authorized successor. Preserve the old plan and facts; validate already
  observed outputs against that unchanged plan. Inherited results retain origin
  and require an applicability check.
- No separate decision, registration wrapper, execution index, evidence manifest or
  validation document is required on the manual/interactive route. Omit unused
  optional fields/sections and never link nonexistent execution files.

A collapsed skill/action is the reusable mechanism itself. Invocation creates
no Machine of Goals execution artifacts. There are no alternate execution
shapes or computed plan styles. See the canonical
[execution boundary](../../workflows/machine-of-goals/machine-of-goals-workflow.md#plan-model-execution-boundary).
