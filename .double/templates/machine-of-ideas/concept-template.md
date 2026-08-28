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
mindmap-plugin: basic
produced-by: concept-extraction-agent
interaction-language: <language-code-or-name-used-for-dialogue>
artifact-language: <language-code-or-name-used-for-this-artifact>
publication-path: <root-idea-directory>/<root-idea-id>-concepts.md
derived-from:
  - <root-idea-artifact-id>
  - <optional-relevant-sub-idea-artifact-id>
---

# Concept Artifact: <Title>

Idea: [<Root Idea Title>](./<root-idea-id>.md#<root-idea-id>)

## 1. Conceptual Summary

A short summary of the conceptual structure of the idea.
Do not restate the whole idea; describe the main conceptual pattern.

## 2. Working Definition of Concept

A concept is a stable meaning unit of an idea.
It may describe an entity, relationship, process, distinction, tension, or interpretive frame.
It is not yet a principle, requirement, task, or design decision.

## 3. Core Concepts

Each core concept must use a unique stable id, a matching explicit HTML anchor,
and the stable id in its heading. Links must target the explicit anchor so they
remain valid when the readable heading title changes.

<a id="<concept-id>"></a>

### <concept-id>: <Concept Name>

#### Definition

A concise definition of the concept in this idea.

#### Source in Idea

- Which part of the source idea supports this concept?
- Is the concept explicit in the idea, or inferred from it?

#### Role in the Idea

- Why does this concept matter?
- What does it help explain?

#### Related Concepts

- Depends on: [`<related-concept-id>`](#<related-concept-id>)
- Conflicts or tensions: [`<other-concept-id>`](#<other-concept-id>)
- Other relations: [`<another-concept-id>`](#<another-concept-id>): <short-relationship-note>

#### Boundaries

- What should not be included in this concept?
- What similar terms or ideas should not be confused with it?
- What anti-examples help keep the concept from becoming too broad or too operational?

#### Questions

- Unanswered questions that remain unclear about this concept.
- Each unanswered item in this subsection is an open question for this specific concept.
- When a question is answered, integrate the answer into this concept's definition, boundaries, relationships, or source grounding, then mark the item as answered or remove it from this subsection.

## 4. Terms and Non-Concepts

List important entities, terms, or labels that appear in the idea but are not treated as core concepts.
Explain briefly why they remain supporting terms, entities, or non-concepts.

## 5. Candidate Inputs for Principle Synthesis

- Which concepts are likely to become principles?
- Which relationships or tensions need normative clarification?
```
