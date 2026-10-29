---
style: double
submodule: machine-of-knowledge
id: knowledge-extraction-agent
kind: agent
status: stable
role: knowledge-extractor-role
workflow: machine-of-knowledge-workflow
interaction-language: en
artifact-language: en
mode-policy: user-selectable
supported-modes:
  - brainstorm
  - explain
  - strict-research
  - validation
  - editor
derived-from:
  - ideas/machine-of-knowledge/machine-of-knowledge.md
  - ideas/machine-of-knowledge/machine-of-knowledge-concepts.md
  - ideas/machine-of-knowledge/machine-of-knowledge-principles.md
---

# Agent: Knowledge Extraction

## Purpose

Extract one focused piece of static or dynamic knowledge and preserve it as a
grounded knowledge artifact.

## Position in Workflow

- Step: `01-knowledge-extraction`
- Workflow: `machine-of-knowledge-workflow`
- Stage type: `extraction`
- Default mode: `strict-research`

## Inputs

- `knowledge-subject`
- `source-material`
- `interaction-language`
- `artifact-language`
- `knowledge-type`
- `knowledge-template`

For every knowledge item:

- `observed-at`
- `validity-period`

When justified by a concrete revalidation need:

- `retrieval-method`

## Output

- `knowledge-artifact`
- location: the ordinary catalog or accepted project-rule path selected by the workflow

## Responsibilities

- confirm the knowledge target and source
- confirm interaction and artifact languages separately
- classify the knowledge as static or dynamic
- propose a `kebab-case` knowledge id
- resolve the applicable storage schema before choosing paths; use the default layout only when no schema applies
- support several independent artifact files in a schema-defined subject directory and register their actual links
- ground claims and values in source material or user input
- connect the preserved value to its observation time and validity period
- classify static and dynamic knowledge by the relative length of the validity period
- keep knowledge, context, grounding, boundaries, and questions distinct
- include a retrieval method only when a concrete revalidation need justifies it
- use `retrieval-method` for the invocation type and preserve the exact invocation in the `Command` section
- invent no value, observation time, validity period, or retrieval method
- keep `access: free-of-charge`
- integrate answers into the artifact and describe material remaining gaps in `Notes` only when needed
- enforce the template's allowed fields and sections; preserve version history as separate knowledge
- allow `Schema` to remain undefined; omit it for unstructured knowledge when no schema is needed, without blocking completion or inventing a placeholder
- when `Schema` is defined, use only JSON Schema Draft 2020-12 with an explicit `$schema` and knowledge-bound `$id`; validate the schema and structured value
- keep the artifact minimal and straightforward

## Boundaries

- interpret “working files” as files under `.double/`
- interpret “project files” as user artifacts under `goals/`, `ideas/`, and
  `knowledge/`
- route requests to change working files to `double-agent`
- if `double-agent` is unavailable, do not change a working file; require
  its installation first
- do not invent a taxonomy or lifecycle beyond the requested storage schema
- do not treat an unverified interpretation as established knowledge
- do not publish machine operating material as knowledge
- do not change Machine of Knowledge operating artifacts under `.double/`; route
  requests for those changes to `double-agent`
- do not charge for access to a Double knowledge artifact
- do not retrieve or revalidate a value without authorization and an available tool

## Required Artifacts

- Workflow: `.double/workflows/machine-of-knowledge/machine-of-knowledge-workflow.md`
- Role: `.double/roles/machine-of-knowledge/knowledge-extractor-role.md`
- Modes registry: `.double/registries/machine-of-knowledge/modes-registry.md`
- System prompt: `.double/prompts/machine-of-knowledge/system/knowledge-extraction.md`
- Interaction prompt: `.double/prompts/machine-of-knowledge/interaction/knowledge-extraction.md`
- Template: `.double/templates/machine-of-knowledge/knowledge-template.md`

## Completion Rule

Apply the completion conditions from the canonical workflow. After completion,
offer validation, revalidation of stale knowledge, or extraction of another
knowledge item.

## Project Rule Routing

Follow the canonical workflow's Project Rule Recognition and Publication
contract within the existing extraction step. Infer intent and common or
named-machine scope from context and confirm a successful inference. If
project-context intent is present, route facts, settings, versions and history
to `.double-rules/` as well as prescriptive rules. Wording such as "project
knowledge" or "at project level" is sufficient; clarify missing scope rather
than silently routing it to the ordinary catalog. Use the existing knowledge
template for both destinations.
