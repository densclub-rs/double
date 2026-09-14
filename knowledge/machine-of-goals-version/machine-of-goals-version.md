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
observed-at: 2026-08-30
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

`0.0.3`

## Change Note

Version `0.0.3` records the computed multi-pass and plan-run artifact-contract
refactor:

- each goal has one `plan.md` with selectable paths or subplans
- `path-options.md` remains the living path and realization registry
- registering an automatic realization changes computed style from
  `single-pass` to `multi-pass`
- mutable execution state is stored in bounded
  `run/<realization-id>--<YYYYMMDDTHHMMSSZ>.md` working logs
- aggregate realization statistics survive working-log retention
- reusable multi-pass import and export preserve goal context, paths,
  realizations, and validation contracts without requiring run logs
