---
style: double
submodule: machine-of-knowledge
id: templates-registry
kind: registry
status: release-candidate
---

# Templates Registry

## Knowledge Artifact

- id: `knowledge-template`
- kind: `knowledge-artifact`
- definition: `.double/templates/machine-of-knowledge/knowledge-template.md`
- producer: `knowledge-extraction-agent`
- workflow-stage: `01-knowledge-extraction`
- static-use: omit dynamic metadata
- dynamic-use: require `retrieval-method`, `cached-value`, `cached-value-date`
- access: `free-of-charge`
