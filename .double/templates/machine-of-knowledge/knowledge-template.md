---
style: double
submodule: machine-of-knowledge
id: knowledge-template
kind: template
status: draft
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
produced-by: machine-of-knowledge/knowledge-extraction-agent
type: <static-or-dynamic>
value-type: <text-or-binary>
observed-at: <date-or-date-time-when-the-value-was-last-acquired>
ttl: <human-readable-period-until-which-the-value-may-be-trusted>
retrieval-method: <local-command-or-local-script-or-rest-api-or-mcp-or-manual>
---

<a id="<unique-knowledge-id>"></a>

# <unique-knowledge-id>

## Description

<what-this-knowledge-describes>

## Value

<textual-value-or-link-to-binary-file>

## Schema (Optional)

```json
<json-schema-of-the-value>
```

## Command

<for-dynamic-or-binary-knowledge: describe the exact invocation that obtains the value>

```sh
<command-or-script-reference>
```
````
