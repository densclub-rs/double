---
style: double
submodule: machine-of-knowledge
id: templates-registry
kind: registry
status: stable
---

# Templates Registry

## Knowledge Artifact

- id: `knowledge-template`
- kind: `knowledge-artifact`
- definition: `.double/templates/machine-of-knowledge/knowledge-template.md`
- producer: `knowledge-extraction-agent`
- workflow-stage: `01-knowledge-extraction`
- static-and-dynamic-use: value, observation date and validity period; retrieval method only when justified
- structure: follow the template exactly; use `Notes` only when needed to describe material gaps
- schema-use: optional and may remain undefined; omit when unnecessary, without blocking completion
- defined-schema-standard: only JSON Schema Draft 2020-12, explicit `$schema` and knowledge-bound `$id`; validate the schema and structured value
- access: `free-of-charge`
