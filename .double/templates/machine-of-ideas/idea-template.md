---
style: double
submodule: machine-of-ideas
id: idea-template
kind: template
status: release-candidate
workflow-stage: idea-capture
interaction-language: en
artifact-language: en
derived-from:
  - ideas/ideas.md
  - ideas/machine-of-ideas/machine-of-ideas.md
  - ideas/machine-of-ideas/machine-of-ideas-concepts.md#concept-human-clarification-loop
  - ideas/machine-of-ideas/machine-of-ideas-principles.md#principle-ask-and-integrate-open-questions
---

# Template: Idea Artifact

```md
---
id: <idea-artifact-id>
kind: idea-artifact
status: draft
produced-by: idea-capture-agent
interaction-language: <language-code-or-name-used-for-dialogue>
artifact-language: <language-code-or-name-used-for-this-artifact>
derived-from:
  - <source-idea-or-conversation>
---

<a id="<idea-artifact-id>"></a>

# Idea: <Short title>

## 1. Summary

A short description of the idea in 2 to 3 sentences.

## 2. Context / Origin

- What was the source of this idea?
- Was it an observation, a problem, a conversation, or an insight?
- In what context did it emerge?

## 3. Problem / Motivation

- What problem or need does it address?
- Why does it matter?

## 4. Raw Description

A detailed, unstructured description of the idea.
Write freely, without unnecessary constraints.

## 5. Key Elements

- Entities involved in the idea
- Participants / objects / systems

## 6. Assumptions

- What is being treated as given?
- What may turn out to be wrong?

## 7. Examples / Scenarios

- Concrete examples
- How could this work in practice?

## 8. Signals of Value

- Why could this be useful?
- What signals suggest that the idea is worth pursuing?

## 9. Open Questions

- What is still unclear?
- Where does uncertainty remain?
- Which questions should be asked to the human before this idea can mature?
- When an answer has been supplied, first integrate it into the relevant main sections, then mark the question as done here.
- Do not store answers, consequences, or resolved-question notes under the question itself.
- Do not create a separate `Resolved Questions` section for normal idea questions.

## 10. Boundaries / Non-Goals

- What is explicitly outside the scope of the idea?
- Where are the boundaries?

## 11. Related Ideas

- Similar or related thoughts

## 12. Notes

Any additional thoughts

## 13. Development Artifacts

Include this section only after at least one concept or principle has been
published. If neither concepts nor principles exist, omit the entire section.

### 13.1 Concepts

Include this subsection only when a concept artifact exists.

Concept artifact: [<Concept Artifact Title>](./<root-idea-id>-concepts.md)

| Concept | Summary |
| --- | --- |
| [`<concept-id>: <Concept Name>`](./<root-idea-id>-concepts.md#<concept-id>) | <one-sentence-description-of-the-concept> |

### 13.2 Principles

Include this subsection only when a principle artifact exists.

Principle artifact: [<Principle Artifact Title>](./<root-idea-id>-principles.md)

| Principle | Statement | Related Concepts |
| --- | --- | --- |
| [`<principle-id>: <Principle Name>`](./<root-idea-id>-principles.md#<principle-id>) | <concise-normative-statement> | [`<concept-id>: <Concept Name>`](./<root-idea-id>-concepts.md#<concept-id>) |
```
