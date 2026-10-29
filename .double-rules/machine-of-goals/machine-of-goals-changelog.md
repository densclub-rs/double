---
id: machine-of-goals-changelog
kind: knowledge-artifact
status: stable
produced-by: machine-of-knowledge/knowledge-extraction-agent
interaction-language: ru
artifact-language: en
type: static
access: free-of-charge
value-type: text
observed-at: 2026-10-28
ttl: one month
derived-from:
  - .double-rules/machine-of-goals/machine-of-goals-version.md
  - knowledge/machine-version-and-changelog-locations/machine-version-and-changelog-locations.md
  - git history and local annotated machine tags inspected on 2026-10-28
---

<a id="machine-of-goals-changelog"></a>

# machine-of-goals Changelog

## Description

Changes recorded for the `machine-of-goals` module.

## Value

### 0.0.15-rc — 2026-10-29

- Load project-owned common and Machine of Goals rules and honor configured catalog settings.
- Recognize project-level facts, versions and history as project context under `.double-rules/`.
- Prefer project-defined version knowledge and retain the historical knowledge path as the default.
- Separate the editable plan from the immutable execution plan; freeze approved content only when execution is authorized to start.
- Give every plan one contextual, human-readable word ID and matching root anchor, preserving them across revisions and frozen copies.
- Use `plan.md` for ordinary plans, `plan-<id>.md` for independent parallel variants and `plan<owner_id>.md` for author variants.
- Track logical branches and `plan-revision` independently of execution versions and selectable paths.
- Review linked plan contents while retaining checksums as internal integrity evidence; require renewed review after edits.
- Keep execution facts, progress and evidence in realizations and stage records; leave editable and frozen plans free of progress.
- Display realization stage states as emoji with a legend and mark completion only after required results are verified and accepted.
- Resume existing realizations without repeating completed actions; require an authorized successor when approved execution obligations change.
- Let collapsed skills and automated actions produce their native outputs without extra Machine of Goals execution records.
- Remove obsolete execution-record contracts and align planning, realization, validation and exchange guidance.

### 0.0.14-rc — 2026-10-22

- Connect plan models, realizations and stage records to the manual and interactive workflow.
- Require explicit selection and execution authorization, input checks before actions and output checks before completion.
- Prefer documentary evidence and identify any accepted user-statement fallback.
- Stop execution against edited models, check inherited results for applicability and distinguish pending actions from results awaiting verification on resume.

### 0.0.12-rc — 2026-10-21

- Align the idea, concepts, principles and version knowledge with interchangeable goals and subgoals, preserving the existing operating contract.

### 0.0.11-rc — 2026-10-21

- Add interactive handoffs after workflow steps and plan stages, with linked results and eligible next actions.
- Require continuation consent unless already authorized, preserving mandatory validation, selection and stop points.

### 0.0.10-rc — 2026-10-14

- Use permitted structured choices and require explicit responses before dependent actions.
- Preserve stage contracts and immutable revision boundaries when execution obligations change.
- Record useful successful commands with their context, observed results and replay constraints.
- Validate command evidence and preserve historical execution baselines during continuation.
