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

Idea: [<Root Idea Title>](./<root-idea-id>.md#<root-idea-id>)

## 1. Principle Synthesis Summary

A short summary of the normative structure that emerges from the idea and concept artifact.
Do not restate the whole idea or concept artifact; describe the main principles and why they matter.

## 2. Working Definition of Principle

A principle is a stable normative ground derived from an idea and its conceptual structure.
It guides or constrains future decisions, but it is not yet a requirement, task, design decision, implementation step, or generic value statement.

## 3. Core Principles

Each core principle must use a unique stable id, a matching explicit HTML
anchor, and the stable id in its heading. Links must target the explicit anchor
so they remain valid when the readable heading title changes.

<a id="<principle-id>"></a>

### <principle-id>: <Principle Name>

#### Statement

A concise normative statement.

#### Derived From

- Source concept(s): [`<Concept Name>`](./<root-idea-id>-concepts.md#<concept-id>)
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

## 4. Trade-offs and Tensions

- Which principles may pull in different directions?
- What tensions should future stages preserve instead of resolving prematurely?

## 5. Candidate Inputs for Future Stages

- Which principles can guide future proposals, designs, specs, or validation?
- Which principles require more research or user confirmation first?

## 6. Rejected or Deferred Candidate Principles

- Which plausible principles were not included?
- Why were they rejected or deferred?
```
