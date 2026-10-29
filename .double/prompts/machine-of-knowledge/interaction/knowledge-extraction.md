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

A schema may be undefined. Unstructured knowledge can be saved and completed
without one: omit `Schema` and do not ask the user to define it merely to finish
the artifact. Existing schema-free knowledge need not be migrated.

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

The output path is the ordinary catalog or accepted project-rule path selected by the workflow, and every
Double knowledge artifact remains free of charge.

## Project Rule Routing

Follow the canonical workflow's Project Rule Recognition and Publication
contract within the existing extraction step. Infer intent and common or
named-machine scope from context and confirm a successful inference. If
project-context intent is present, route facts, settings, versions and history
to `.double-rules/` as well as prescriptive rules. Wording such as "project
knowledge" or "at project level" is sufficient; clarify missing scope rather
than silently routing it to the ordinary catalog. Use the existing knowledge
template for both destinations.
