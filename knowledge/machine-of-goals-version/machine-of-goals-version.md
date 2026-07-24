---
id: machine-of-goals-version
kind: knowledge-artifact
produced-by: machine-of-knowledge/knowledge-extraction-agent
interaction-language: ru
artifact-language: en
type: static
access: free-of-charge
value-type: text
observed-at: 2026-07-19
ttl: one month
derived-from:
  - knowledge/double-main-modules/double-main-modules.md
  - user-provided project versioning decision
---

<a id="machine-of-goals-version"></a>

# Machine of Goals Version

## Description

The version assigned to the `machine-of-goals` main module of the Double
project.

## Value

`0.0.2`

## Change Note

Version `0.0.2` records the Machine of Goals artifact-contract refactor:
execution state is stored in the active `plan.md`, `plan-state` is no longer a
separate artifact, and working/intermediate execution artifacts are stored under
`<goal-directory>/results/`.
