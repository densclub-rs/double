---
style: double
submodule: machine-of-knowledge
id: agents-registry
kind: registry
status: stable
---

# Agents Registry

## Knowledge Extraction Agent

- id: `knowledge-extraction-agent`
- role: `knowledge-extractor-role`
- stage: `01-knowledge-extraction`
- input: `knowledge-subject`, `source-material`, `interaction-language`, `artifact-language`, `knowledge-type`, `knowledge-template`
- conditional-input-for-revalidation: `retrieval-method`
- output: `knowledge-artifact`
- output-location: schema-resolved path inside the selected catalog; per-artifact directory by default
- supported-modes: `brainstorm`, `explain`, `strict-research`, `validation`, `editor`
- system-prompt: `.double/prompts/machine-of-knowledge/system/knowledge-extraction.md`
- interaction-prompt: `.double/prompts/machine-of-knowledge/interaction/knowledge-extraction.md`
- definition: `.double/agents/machine-of-knowledge/knowledge-extraction/knowledge-extraction.md`
