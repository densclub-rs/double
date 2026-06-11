---
style: double
submodule: machine-of-ideas
id: concept-template
kind: template
status: release-candidate
workflow-stage: concept-extraction
interaction-language: en
artifact-language: en
derived-from:
  - ideas/machine-of-ideas/concept-extraction/concept-extraction.md
  - ideas/machine-of-ideas/machine-of-ideas-concepts.md#concept-human-clarification-loop
  - ideas/machine-of-ideas/machine-of-ideas-principles.md#principle-ask-and-integrate-open-questions
---

# Template: Concept Artifact

```md
---
id: <concept-artifact-id>
kind: concept-artifact
status: release-candidate
produced-by: concept-extraction-agent
workflow-version: <workflow-version>
interaction-language: <language-code-or-name-used-for-dialogue>
artifact-language: <language-code-or-name-used-for-this-artifact>
publication-path: <root-idea-directory>/<root-idea-id>-concepts.md
derived-from:
  - <root-idea-artifact-id>
  - <optional-relevant-sub-idea-artifact-id>
---

# Concept Artifact: <Title>

## 1. Source Idea

- Source scope: `root idea plus optional relevant sub-ideas`
- Source title: `<root-idea-title>`
- Root idea artifact: `<root-idea-artifact-id-or-path>`
- Root idea directory: `<root-idea-directory>`
- Relevant sub-ideas: `<optional-sub-idea-id-or-path-list>`
- Published as: `<root-idea-id>-concepts.md`
- Extraction mode: `<brainstorm|explain|strict-research|validation|editor>`
- Interaction language: `<interaction-language>`
- Artifact language: `<artifact-language>`

## 2. Conceptual Summary

A short summary of the conceptual structure of the idea.
Do not restate the whole idea; describe the main conceptual pattern.

## 3. Working Definition of Concept

A concept is a stable meaning unit of an idea.
It may describe an entity, relationship, process, distinction, tension, or interpretive frame.
It is not yet a principle, requirement, task, or design decision.

## 4. Core Concepts

### Concept: <Concept Name>

#### Definition

A concise definition of the concept in this idea.

#### Source in Idea

- Which part of the source idea supports this concept?
- Is the concept explicit in the idea, or inferred from it?

#### Role in the Idea

- Why does this concept matter?
- What does it help explain?

#### Related Concepts

- `<related-concept-name>`: <relationship>

#### Boundaries

- What should not be included in this concept?
- What similar terms or ideas should not be confused with it?
- What anti-examples help keep the concept from becoming too broad or too operational?

#### Questions

- What remains unclear about this concept?

## 5. Conceptual Map

Describe the relationships between the core concepts.
Use bullets, a table, or a small diagram if helpful.

## 6. Terms and Non-Concepts

List important entities, terms, or labels that appear in the idea but are not treated as core concepts.
Explain briefly why they remain supporting terms, entities, or non-concepts.

## 7. Candidate Inputs for Principle Synthesis

- Which concepts are likely to become principles?
- Which relationships or tensions need normative clarification?

## 8. Open Questions

- What needs to be clarified before principle synthesis?
- When an answer has been supplied, first integrate it into concepts, boundaries, relationships, or the conceptual map, then mark the question as done here.
- Do not store answers, consequences, or resolved-question notes under the question itself.
- Do not create a separate `Resolved Questions` section for normal concept questions.
```
