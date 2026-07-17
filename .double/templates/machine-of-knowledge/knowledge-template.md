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
produced-by: knowledge-extraction-agent
workflow-version: 0.1.1
type: <static-or-dynamic>
value-type: <text-or-binary>
observed-at: <date-or-date-time-when-the-value-was-last-acquired>
ttl: <date-time-or-bounded-period-until-which-the-value-may-be-trusted>
---

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

<for-dynamic-or-binary-knowledge: describe-how-the-command-obtains-the-value>

```sh
<command-or-script-reference>
```
````
