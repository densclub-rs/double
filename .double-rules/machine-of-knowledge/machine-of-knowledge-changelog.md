---
id: machine-of-knowledge-changelog
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
  - .double-rules/machine-of-knowledge/machine-of-knowledge-version.md
  - knowledge/machine-version-and-changelog-locations/machine-version-and-changelog-locations.md
  - git history and local annotated machine tags inspected on 2026-10-28
---

<a id="machine-of-knowledge-changelog"></a>

# machine-of-knowledge Changelog

## Description

Changes recorded for the `machine-of-knowledge` module.

## Value

### 0.0.3 — 2026-10-29

- Load project-owned common and Machine of Knowledge rules before extraction.
- Recognize project-level facts, settings, versions and history and route them to project rules.
- Clarify missing project-context scope and honor configured knowledge catalogs.
- Preserve project rules during machine installation and updates.
- Prefer project-defined version knowledge and use the default path when no project source exists.
- Allow knowledge artifacts without a defined schema and omit the optional Schema section for unstructured knowledge.
- Validate defined schemas and values using JSON Schema Draft 2020-12.
- Resolve artifact placement from applicable storage schemas, supporting multiple independent knowledge files in one subject directory.
- Validate structured layout descriptors, resolved files, identifiers, anchors and index links.
- Require knowledge artifacts to follow the template's defined fields and sections.
- Preserve machine change history in separate changelog knowledge.
- Use Notes for material gaps or uncertainty and include retrieval metadata only when justified.

### 0.0.2 — 2026-10-28

- Load project-owned common and Machine of Knowledge rules before extraction.
- Recognize project-rule requests, confirm their scope and publish them using the ordinary knowledge template.
- Honor configured catalogs and preserve project rules during machine installation or updates.
