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
| `realization-decision` | `realization-decision-template` | `.double/templates/machine-of-goals/realization-decision-template.md` |
| `realization-artifact` | `realization-template` | `.double/templates/machine-of-goals/realization-template.md` |
| `stage-realization` | `stage-realization-template` | `.double/templates/machine-of-goals/stage-realization-template.md` |
| `plan-run` | `plan-run-template` | `.double/templates/machine-of-goals/plan-run-template.md` |
| `run-index` | `run-index-template` | `.double/templates/machine-of-goals/run-index-template.md` |
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
- Step 03: create `plan-model-<branch>.md` from `plan-model-template`, with
  `kind: plan-model`, branch and `model-revision`; no execution plan version.
- Step 04: approve exact model content/digest, path/entry and boundaries in the
  conversation. A deferred start leaves only the model; any model edit requires
  renewed review before execution.
- Authorized step-05 start: freeze `realizations/<start>/plan-v1.md` from
  `plan-template` with `kind: plan-artifact`, `plan-version: 1` and approved
  source provenance. Rebase links without changing approved transition content.
- Create `realization.md` in that directory after the plan, recording its exact
  digest and the approved source digest separately. Stage records link the local
  frozen plan; progress, evidence and actual results stay in these records.
- Request documentary evidence first; explicit user statements are an identified
  fallback. Verify input before action and output before completion. The model
  and frozen plan contain no manual/interactive execution progress.
- A source edit stops further planned action, requires renewed review and an
  authorized successor. Preserve the old plan and facts; validate already
  observed outputs against that unchanged plan. Inherited results retain origin
  and require an applicability check.
- No separate decision, registration wrapper, run, index, evidence manifest or
  validation document is required on the manual/interactive route. Omit unused
  optional fields/sections and never link nonexistent execution files.

## Existing Rules for Other Execution Modes

Other-mode models use the legacy `plan.md` shape in `plan-model-template`;
immutable `realizations/plan-revision-<N>.md` snapshots use `plan-template`.
Their existing registration/run/statistics mechanisms remain supported, but
materialization happens only at the authorized start of step 05. Step 04
records approval/selection without creating snapshots, decisions or realizations.

A snapshot changes `template-id` from `plan-model-template` to `plan-template`:
it is a new execution artifact, not an editable model revision. Strip mutable
bookkeeping, preserve approved transition content and rebase links. Every
transition edit requires renewed review and a new frozen baseline before changed
execution; registry/statistics updates alone do not. Capture stage contracts
from the pinned plan and preserve old baselines, attempts and acceptance.

Use the [workflow](../../workflows/machine-of-goals/machine-of-goals-workflow.md#plan-model-execution-boundary)
as the source of step order and boundaries, and the agents registry for producers.
