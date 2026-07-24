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

## 1. Concept Index

Use this section as the compact map entry point for the artifact.
Keep it short enough to work as the first visible layer in a mindmap or markmap.
Each index item must be a markdown link to the matching detailed concept section.
Use nested bullets only to show possible conceptual nesting.
If one concept depends on another at the overview level, place it as a child item under that concept.
Do not label relationship types here and do not duplicate full definitions.

- [`<concept-id>: <Concept Name>`](#concept-id-concept-name): <one-sentence-description-of-the-concept>
  - [`<dependent-concept-id>: <Dependent Concept Name>`](#dependent-concept-id-dependent-concept-name): <one-sentence-description-of-the-dependent-concept>
- [`<independent-concept-id>: <Independent Concept Name>`](#independent-concept-id-independent-concept-name): <one-sentence-description-of-the-concept>

## 2. Source Idea

- Source scope: `root idea plus optional relevant sub-ideas`
- Source title: `<root-idea-title>`
- Root idea artifact: `<root-idea-artifact-id-or-path>`
- Root idea directory: `<root-idea-directory>`
- Relevant sub-ideas: `<optional-sub-idea-id-or-path-list>`
- Published as: `<root-idea-id>-concepts.md`
- Extraction mode: `<brainstorm|explain|strict-research|validation|editor>`
- Interaction language: `<interaction-language>`
- Artifact language: `<artifact-language>`

## 3. Conceptual Summary

A short summary of the conceptual structure of the idea.
Do not restate the whole idea; describe the main conceptual pattern.

## 4. Working Definition of Concept

A concept is a stable meaning unit of an idea.
It may describe an entity, relationship, process, distinction, tension, or interpretive frame.
It is not yet a principle, requirement, task, or design decision.

## 5. Core Concepts

Each core concept should use a stable id in its heading.
This makes the heading usable as both a readable mindmap node and a link target from the Concept Index.

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

- Depends on: [`<related-concept-id>`](#related-concept-id-related-concept-name)
- Conflicts or tensions: [`<other-concept-id>`](#other-concept-id-other-concept-name)
- Other relations: [`<another-concept-id>`](#another-concept-id-another-concept-name): <short-relationship-note>

#### Boundaries

- What should not be included in this concept?
- What similar terms or ideas should not be confused with it?
- What anti-examples help keep the concept from becoming too broad or too operational?

#### Questions

- Unanswered questions that remain unclear about this concept.
- Each unanswered item in this subsection is an open question for this specific concept.
- When a question is answered, integrate the answer into this concept's definition, boundaries, relationships, source grounding, or the Concept Index, then mark the item as answered or remove it from this subsection.

## 6. Terms and Non-Concepts

List important entities, terms, or labels that appear in the idea but are not treated as core concepts.
Explain briefly why they remain supporting terms, entities, or non-concepts.

## 7. Candidate Inputs for Principle Synthesis

- Which concepts are likely to become principles?
- Which relationships or tensions need normative clarification?
```
