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

### 0.0.3 — 2026-10-28

- Allow schemas to remain undefined and omit the optional `Schema` section for unstructured knowledge; schema absence alone does not block completion or require migration.
- Standardize defined schemas on JSON Schema Draft 2020-12 with an explicit dialect declaration, knowledge-bound schema id and schema/value validation; block missing or unsupported dialect declarations.
- Resolve artifact placement from an applicable storage schema, allowing several independent knowledge files in one subject directory; retain the per-artifact directory layout as the default.
- Validate structured layout descriptors against their JSON Schema and check resolved files, ids, anchors and index links separately.
- Route project-level facts, settings, versions and history to `.double-rules/` without requiring an explicit rule label.
- Clarify missing project-context scope instead of silently publishing project knowledge in the ordinary catalog.
- Prefer project-defined version knowledge and retain the historical knowledge path as the default.
- Require knowledge artifacts to follow the template's defined fields and sections.
- Keep machine change history in separate changelog knowledge.
- Use the optional `Notes` section only for material gaps or uncertainty.
- Align extraction instructions on `Value`, observation date and validity period for both knowledge types; include retrieval metadata only when justified.

### 0.0.2 — 2026-10-28

- Load project-owned common and Machine of Knowledge rules before extraction.
- Recognize project-rule requests, confirm their scope and publish them using the ordinary knowledge template.
- Honor configured catalogs and preserve project rules during machine installation or updates.
