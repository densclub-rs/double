---
style: double
submodule: machine-of-knowledge
id: roles-registry
kind: registry
status: release-candidate
---

# Roles Registry

## Knowledge Extractor Role

- id: `knowledge-extractor-role`
- definition: `.double/roles/machine-of-knowledge/knowledge-extractor-role.md`
- workflow: `machine-of-knowledge-workflow`
- stage: `01-knowledge-extraction`
- agent: `knowledge-extraction-agent`
- role-scope: `knowledge-extraction`, `source-grounding`, `knowledge-artifact-formation`
- description: extract one grounded static or dynamic knowledge artifact without introducing unnecessary structure
