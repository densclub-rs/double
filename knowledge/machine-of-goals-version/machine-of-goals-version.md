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
observed-at: 2026-09-15
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

`0.0.4`

## Change Note

Version `0.0.4` records the persistent realization-artifact contract:

- each goal has one `plan.md` with selectable paths or subplans
- `path-options.md` remains the living path catalog, while section 10 of
  `plan.md` is the realization registry and aggregate-statistics source
- registering an automatic realization changes computed style from
  `single-pass` to `multi-pass`
- approving either a manual or automatic realization creates
  `realizations/<realization-record-id>.md` before the first run
- the persistent realization artifact records the selected path, plan and
  realization revisions, procedure or implementation, control boundaries, and
  validation contract
- every run links to its realization artifact, which links all active, pinned,
  and retained runs for that realization record
- mutable execution state is stored in bounded
  `run/<realization-record-id>--<YYYYMMDDTHHMMSSZ>.md` working logs
- aggregate realization statistics survive working-log retention
- reusable multi-pass import and export preserve goal context, paths,
  realization artifacts, and validation contracts without requiring run logs
