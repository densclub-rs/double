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
observed-at: 2026-11-04
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

### 0.0.8-rc — 2026-11-05

- Define how Markdown headings and lists map to structured knowledge values.
- Preserve atomic text as strings without implicit type conversion.
- Interpret media links and fenced commands without executing commands.
- Validate mapped values against JSON Schema and preserve existing knowledge formats.

### 0.0.7-rc — 2026-11-04

- Assess whether each new or changed knowledge item needs a schema.
- Represent composite values with Markdown sections and lists of atomic properties.
- Describe value structure and meaning in JSON Schema.
- Keep supplemental explanations, examples and uncertainty in Notes.
- Preserve existing schema-free knowledge and JSON descriptors.

### 0.0.5 — 2026-11-04

- Load applicable project and group knowledge from three directory levels.
- Prefer the nearest usable whole knowledge item and silently skip unusable rules.
- Create and update project or group knowledge at the selected directory level.
- Identify semantic overlap and reconcile confirmed knowledge identities with the user.
- Preserve scoped values and refactor affected schemas, paths and references.
- Keep release version checks strict and reproducible.

### 0.0.4 — 2026-11-04

- Identify potential knowledge overlap and resolve semantic identity with the user.
- Reconcile confirmed identities while preserving scope-specific values and their temporal metadata.
- Review and refactor affected schemas, paths and references, validating schemas and structured values.
- Apply project rule precedence over equivalent group rules while preserving both scoped values.

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
