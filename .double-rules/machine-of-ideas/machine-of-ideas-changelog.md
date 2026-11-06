---
id: machine-of-ideas-changelog
kind: knowledge-artifact
status: stable
produced-by: machine-of-knowledge/knowledge-extraction-agent
interaction-language: ru
artifact-language: en
type: static
access: free-of-charge
value-type: text
observed-at: 2026-11-04
ttl: one month
derived-from:
  - .double-rules/machine-of-ideas/machine-of-ideas-version.md
  - knowledge/machine-version-and-changelog-locations/machine-version-and-changelog-locations.md
  - git history and local annotated machine tags inspected on 2026-10-28
---

<a id="machine-of-ideas-changelog"></a>

# machine-of-ideas Changelog

## Description

Changes recorded for the `machine-of-ideas` module.

## Value

### 0.2.8 — 2026-11-05

- Name generated idea documents by their idea title.
- Use `<Idea title>: Concepts` and `<Idea title>: Principles` for derived documents.
- Remove “Artifact” from the leading template and generated-document headings.
- Remove answered questions from question sections after integrating their answers.

### 0.2.8-rc — 2026-11-05

- Name generated idea documents by their idea title.
- Use `<Idea title>: Concepts` and `<Idea title>: Principles` for derived documents.
- Remove “Artifact” from the leading template and generated-document headings.
- Remove answered questions from question sections after integrating their answers.

### 0.2.7 — 2026-11-04

- Load applicable project and group knowledge from three directory levels.
- Prefer the nearest usable whole knowledge item and silently skip unusable rules.
- Keep release version checks strict and reproducible.

### 0.2.6 — 2026-10-29

- Load project-owned common and Machine of Ideas rules before starting work.
- Recognize project-level facts, settings, versions and history as project context under `.double-rules/`.
- Honor project-configured idea catalog settings and retain `ideas/` as the default.
- Prefer project-defined version knowledge and use the historical path when no project source exists.
- Preserve project rules during machine installation and updates without including them in machine archives.

### 0.2.5 — 2026-10-14

- Use permitted structured choices for mode, target, review scope and workflow transitions.
- Require an explicit response before dependent actions, preserving existing approval and free-form clarification.
- Fall back to another permitted interface when the preferred question tool is unavailable.
