---
style: double
submodule: machine-of-ideas
id: principle-template
kind: template
status: release-candidate
workflow-stage: principle-synthesis
interaction-language: en
artifact-language: en
derived-from:
  - ideas/machine-of-ideas/principle-synthesis/principle-synthesis.md
  - ideas/machine-of-ideas/machine-of-ideas-concepts.md#concept-human-clarification-loop
  - ideas/machine-of-ideas/machine-of-ideas-principles.md#principle-ask-and-integrate-open-questions
---

# Template: Principle Artifact

```md
---
id: <principle-artifact-id>
kind: principle-artifact
mindmap-plugin: basic
produced-by: principle-synthesis-agent
interaction-language: <language-code-or-name-used-for-dialogue>
artifact-language: <language-code-or-name-used-for-this-artifact>
publication-path: <root-idea-directory>/<root-idea-id>-principles.md
derived-from:
  - <root-idea-artifact-id>
  - <concept-artifact-id>
  - <optional-relevant-sub-idea-artifact-id>
---

# Principle Artifact: <Title>

## 1. Principle Index

Use this section as the compact map entry point for the artifact.
Keep it short enough to work as the first visible layer in a mindmap or markmap.
Each index item must be a markdown link to the matching detailed principle section.
Use nested bullets only to show possible normative nesting between principles.
If one principle depends on or is constrained by another at the overview level, place it as a child item under that principle.
Do not label relationship types here and do not duplicate full principle statements.

- [`<principle-id>: <Principle Name>`](#principle-id-principle-name): <one-sentence-description-of-the-principle>
  - [`<dependent-principle-id>: <Dependent Principle Name>`](#dependent-principle-id-dependent-principle-name): <one-sentence-description-of-the-dependent-principle>
- [`<independent-principle-id>: <Independent Principle Name>`](#independent-principle-id-independent-principle-name): <one-sentence-description-of-the-principle>

## 2. Source Artifacts

- Source idea artifact: `<root-idea-artifact-id-or-path>`
- Source concept artifact: `<concept-artifact-id-or-path>`
- Root idea artifact: `<root-idea-artifact-id-or-path>`
- Root idea directory: `<root-idea-directory>`
- Relevant sub-ideas: `<optional-sub-idea-id-or-path-list>`
- Published as: `<root-idea-id>-principles.md`
- Synthesis mode: `<brainstorm|explain|strict-research|validation|editor>`
- Interaction language: `<interaction-language>`
- Artifact language: `<artifact-language>`

## 3. Principle Synthesis Summary

A short summary of the normative structure that emerges from the idea and concept artifact.
Do not restate the whole idea or concept artifact; describe the main principles and why they matter.

## 4. Working Definition of Principle

A principle is a stable normative ground derived from an idea and its conceptual structure.
It guides or constrains future decisions, but it is not yet a requirement, task, design decision, implementation step, or generic value statement.

## 5. Core Principles

Each core principle should use a stable id in its heading.
This makes the heading usable as both a readable mindmap node and a link target from the Principle Index.

### <principle-id>: <Principle Name>

#### Statement

A concise normative statement.

#### Derived From

- Source concept(s): `<concept-name-or-id>`
- Source relationship, boundary, or tension: `<description>`
- Source idea support: `<short reference to source idea>`
- Explicit or inferred: `<explicit|inferred>`

#### Rationale

Why this principle follows from the source idea and concept artifact.

#### Implications Without Implementation

- What this principle should guide or constrain
- What decisions it makes easier to evaluate
- What it does not prescribe yet

#### Boundaries

- What this principle is not saying
- Where it should not be overextended

#### Anti-Patterns

- What would violate this principle
- What failure modes it helps prevent

#### Questions

- Unanswered questions that remain unclear or contested about this principle.
- Each unanswered item in this subsection is an open question for this specific principle.
- When a question is answered, integrate the answer into this principle's statement, source grounding, rationale, implications, boundaries, anti-patterns, or related artifact sections, then mark the item as answered or remove it from this subsection.

## 6. Trade-offs and Tensions

- Which principles may pull in different directions?
- What tensions should future stages preserve instead of resolving prematurely?

## 7. Candidate Inputs for Future Stages

- Which principles can guide future proposals, designs, specs, or validation?
- Which principles require more research or user confirmation first?

## 8. Rejected or Deferred Candidate Principles

- Which plausible principles were not included?
- Why were they rejected or deferred?
```
