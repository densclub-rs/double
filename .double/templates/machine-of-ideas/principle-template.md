---
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
status: release-candidate
produced-by: principle-synthesis-agent
workflow-version: <workflow-version>
interaction-language: <language-code-or-name-used-for-dialogue>
artifact-language: <language-code-or-name-used-for-this-artifact>
publication-path: <root-idea-directory>/<root-idea-id>-principles.md
derived-from:
  - <root-idea-artifact-id>
  - <concept-artifact-id>
  - <optional-relevant-sub-idea-artifact-id>
---

# Principle Artifact: <Title>

## 1. Source Artifacts

- Source idea artifact: `<root-idea-artifact-id-or-path>`
- Source concept artifact: `<concept-artifact-id-or-path>`
- Root idea artifact: `<root-idea-artifact-id-or-path>`
- Root idea directory: `<root-idea-directory>`
- Relevant sub-ideas: `<optional-sub-idea-id-or-path-list>`
- Published as: `<root-idea-id>-principles.md`
- Synthesis mode: `<brainstorm|explain|strict-research|validation|editor>`
- Interaction language: `<interaction-language>`
- Artifact language: `<artifact-language>`

## 2. Principle Synthesis Summary

A short summary of the normative structure that emerges from the idea and concept artifact.
Do not restate the whole idea or concept artifact; describe the main principles and why they matter.

## 3. Working Definition of Principle

A principle is a stable normative ground derived from an idea and its conceptual structure.
It guides or constrains future decisions, but it is not yet a requirement, task, design decision, implementation step, or generic value statement.

## 4. Core Principles

### Principle: <Principle Name>

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

- What remains unclear or contested about this principle?

## 5. Principle Map

Describe how the principles relate to each other.
Use bullets, a table, or a small diagram if helpful.

## 6. Trade-offs and Tensions

- Which principles may pull in different directions?
- What tensions should future stages preserve instead of resolving prematurely?

## 7. Candidate Inputs for Future Stages

- Which principles can guide future proposals, designs, specs, or validation?
- Which principles require more research or user confirmation first?

## 8. Rejected or Deferred Candidate Principles

- Which plausible principles were not included?
- Why were they rejected or deferred?

## 9. Open Questions

- What needs to be clarified before the next stage?
- When an answer has been supplied, first integrate it into principle statements, boundaries, implications, or deferred questions, then mark the question as done here.
- Do not store answers, consequences, or resolved-question notes under the question itself.
- Do not create a separate `Resolved Questions` section for normal principle questions.
```
