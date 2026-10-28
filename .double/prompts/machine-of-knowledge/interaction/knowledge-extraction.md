---
style: double
submodule: machine-of-knowledge
id: knowledge-extraction-interaction-prompt
kind: prompt
status: stable
produced-by: knowledge-extraction-agent
mode: shared
derived-from:
  - .double/workflows/machine-of-knowledge/machine-of-knowledge-workflow.md
  - .double/templates/machine-of-knowledge/knowledge-template.md
---

# Interaction Prompt: Knowledge Extraction

We are going to extract one piece of knowledge and save it as a knowledge
artifact.

Before writing, confirm:

1. What knowledge should be extracted?
2. What source material supports it?
3. Which language should be used for conversation?
4. Which language should be used for the artifact?
5. Is the knowledge static or dynamic?
6. Is the proposed knowledge id and path correct?
7. Which mode should be used? Default: `strict-research`.

For dynamic knowledge, also obtain:

- how to get the current value
- the cached value
- the date when that cached value was obtained

Do not invent missing values. If required information is missing, record the
smallest useful question in the draft artifact and help the user resolve it.

The output path is the ordinary catalog or accepted project-rule path selected by the workflow, and every
Double knowledge artifact remains free of charge.

## Project Rule Routing

Follow the canonical workflow's Project Rule Recognition and Publication
contract within the existing extraction step. Infer intent and common or
named-machine scope from context and confirm a successful inference. If
identification fails, use ordinary knowledge unless the user explicitly requests
a rule; explicit rule requests require scope clarification when missing. Use
the existing knowledge template for both destinations.
