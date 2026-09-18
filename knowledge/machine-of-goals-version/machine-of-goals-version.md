---
id: machine-of-goals-version
kind: knowledge-artifact
status: release-candidate
produced-by: knowledge-extraction-agent
interaction-language: ru
artifact-language: en
knowledge-type: static
access: free-of-charge
value-type: text
observed-at: 2026-09-18
ttl: one month
derived-from:
  - knowledge/double-main-modules/double-main-modules.md
  - ideas/machine-of-goals/machine-of-goals.md
  - .double/workflows/machine-of-goals/machine-of-goals-workflow.md
  - user-provided project versioning decision
---

<a id="machine-of-goals-version"></a>

# Machine of Goals Version

## Description

The version assigned to the `machine-of-goals` main module of the Double
project.

## Value

`0.0.6`

## Change Note

Version `0.0.6` makes plan revision history realization-triggered:

- before the first realization, `plan.md` is the only plan artifact, both plan
  revision frontmatter fields are null, and every clarification updates the
  main plan without creating a snapshot
- registering the first realization freezes revision 1 as the first immutable
  executable baseline
- after a realization exists, a semantic clarification of the transition model
  increments the plan revision and creates the corresponding snapshot
- realizations pinned to an earlier revision require alignment review after a
  semantic plan change
- registering another realization against unchanged plan content, updating
  registry statistics or timestamps, and projecting run progress do not create
  a plan revision
- immutable plan revision snapshots retain neutral progress and are never
  rewritten
