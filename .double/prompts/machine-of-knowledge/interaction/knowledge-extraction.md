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
6. Does a storage schema apply, or is it undefined, and are the knowledge id and path correct?
7. Which mode should be used? Default: `strict-research`.

Follow the workflow's Knowledge Identity and Semantic Overlap protocol. When
knowledge may overlap, explain the evidence and ask the user to confirm its
meaning before unifying identity. Show differences between affected schemas and
seek a decision on their meaning; preserve distinct scope-specific values.

Assess whether a schema helps interpret each new or changed value. For composite
values and lists of properties, propose a source-grounded schema describing
structure and meaning when useful. A schema may be undefined; do not ask for one
merely to finish an otherwise unambiguous artifact. Existing schema-free
knowledge need not be migrated. Follow the workflow's Markdown representation
and place supplemental explanations in `Notes`.

When `Schema` is needed, use only JSON Schema Draft 2020-12 with its explicit
`$schema` declaration and a stable `$id` tied to the knowledge artifact. Follow
the workflow's Knowledge Schema Standard; do not invent another schema format.

A schema may group several artifact files in one subject directory. Without an
applicable schema use the workflow's default layout. Reuse paths and schema
choices already approved in context.

For both knowledge types obtain the value, observation date, and validity
period. Obtain a retrieval method only when a concrete revalidation need exists.

Do not invent missing values. If required information is missing, record the
smallest useful question in conversation, describe material gaps in `Notes`,
and help the user resolve them.

The output path is the ordinary catalog or accepted project/group-rule path selected by the workflow, and every
Double knowledge artifact remains free of charge.

## Project Rule Routing

Follow the workflow's Project Rule Recognition and Publication contract.
Identify the selected project, immediate-parent group, or second-parent group
level as well as common or named-machine applicability. Reuse explicit user
choices and clarify missing group level or machine scope. Route facts, settings,
versions, history, and prescriptive rules to the selected level's
`.double-rules/`, using the existing knowledge template. Respect filesystem
permissions for writes outside the project root.
