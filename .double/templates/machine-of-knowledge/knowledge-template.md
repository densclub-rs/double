---
style: double
submodule: machine-of-knowledge
id: knowledge-template
kind: template
status: stable
workflow-stage: knowledge-extraction
interaction-language: en
artifact-language: en
derived-from:
  - .double/workflows/machine-of-knowledge/machine-of-knowledge-workflow.md
  - ideas/machine-of-knowledge/machine-of-knowledge-principles.md
---

# Template: Knowledge Artifact

````md
---
id: <unique-knowledge-id>
kind: knowledge-artifact
status: <draft-or-release-candidate-or-stable>
produced-by: machine-of-knowledge/knowledge-extraction-agent
interaction-language: <interaction-language>
artifact-language: <artifact-language>
type: <static-or-dynamic>
access: free-of-charge
value-type: <text-or-binary>
observed-at: <date-or-date-time-when-the-value-was-last-acquired>
ttl: <human-readable-period-until-which-the-value-may-be-trusted>
retrieval-method: <optional-invocation-type>
derived-from: <optional-list-of-sources>
---

<a id="<unique-knowledge-id>"></a>

# <unique-knowledge-id>

## Description

<what-this-knowledge-describes>

## Value

<textual-value-or-link-to-binary-file>

## Notes (Optional)

<assessment-of-completeness-and-material-uncertainty-and-whether-clarification-is-needed>

## Schema (Optional)

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "$id": "urn:double:knowledge:<unique-knowledge-id>",
  "description": "<what-structured-value-this-schema-validates>",
  "type": "object",
  "properties": {}
}
```

## Command

<when retrieval or binary knowledge requires it: describe the exact invocation that obtains the value>

```sh
<command-or-script-reference>
```
````

The frontmatter fields and sections above define the artifact contract. Omit
`retrieval-method` and `derived-from` when not applicable; omit `Notes` when
there are no material gaps or uncertainties, omit `Schema` when
unnecessary and `Command` unless a retrieval method or binary value requires
it. Do not add other fields or top-level sections. Ask clarification questions
in conversation and capture material gaps in `Notes`, not a questions list.
For version knowledge, `Value` contains the current version; version history
belongs in a separate knowledge artifact.

`Schema` may be undefined. For unstructured knowledge or whenever no schema is
needed, omit this optional section entirely. Do not create an empty schema,
`null`, an "undefined" marker or a placeholder, and do not treat its absence
as incomplete knowledge. Existing artifacts without schemas remain valid.

When present, `Schema` uses only JSON Schema Draft 2020-12 to describe the
structured `Value`. Its root `$schema` must equal
`https://json-schema.org/draft/2020-12/schema`, and its stable `$id` identifies
the knowledge artifact. Validate the schema and value with this explicit dialect;
do not silently accept a missing declaration or another schema language. For
layout knowledge, the value can describe a directory and several artifact
files. Apply that layout through the workflow's Storage Schema Resolution,
then verify actual paths and files separately. A value schema alone does not
automatically change the artifact's own location or content contract.

Reference: [Dialect declaration and `$schema`](https://json-schema.org/understanding-json-schema/reference/schema).
