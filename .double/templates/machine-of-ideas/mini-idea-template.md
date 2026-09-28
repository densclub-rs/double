---
style: double
submodule: machine-of-ideas
id: mini-idea-template
kind: template
status: release-candidate
workflow-stage: idea-capture
interaction-language: en
artifact-language: en
derived-from:
  - ideas/machine-of-ideas/mini-idea/mini-idea.md
  - ideas/machine-of-ideas/machine-of-ideas-concepts.md#concept-mini-idea
  - ideas/machine-of-ideas/machine-of-ideas-principles.md#principle-route-mini-ideas-through-parent-artifacts
---

# Template: Mini-Idea Artifact

Use this template when the user says they are working on a `mini-idea` or `sub-idea`.

```md
---
id: <mini-idea-artifact-id>
kind: mini-idea-artifact
status: draft
produced-by: machine-of-ideas/idea-capture-agent
interaction-language: <language-code-or-name-used-for-dialogue>
artifact-language: <language-code-or-name-used-for-this-artifact>
parent-idea:
  id: <parent-idea-id>
  artifact: <parent-idea-artifact-path>
integration-targets:
  concepts: <parent-concept-artifact-path-or-pending>
  principles: <parent-principle-artifact-path-or-pending>
derived-from:
  - <parent-idea-or-conversation>
---

<a id="<mini-idea-artifact-id>"></a>

# Mini-Idea: <Short title>

## 1. Summary

A short description of the focused addition in 2 to 3 sentences.
State how it relates to the parent idea.

## 2. Main Idea Context

- Main idea: [`<parent-idea-id>`](<parent-idea-artifact-path>#<parent-idea-id>)
- What part of the main idea does this mini-idea clarify, extend, or correct?
- Why does it still belong inside the main idea?

## 3. Motivation

- What problem, gap, or opportunity inside the parent idea does this address?
- Why does this focused addition matter?

## 4. Raw Description

A focused but free description of the mini-idea.
Keep the parent idea in view, but do not repeat the whole parent artifact.

## 5. Key Points

- Important claims, distinctions, examples, or working rules introduced by the mini-idea
- Terms that may need to appear in the parent concept or principle artifacts

## 6. Main Idea Impact

- Possible concept impact: `<main-idea-concept-artifact>`
- Possible principle impact: `<main-idea-principle-artifact>`
- Possible parent idea section impact: `<main-idea-artifact>`
- Semantic mismatch with main idea: `<none-or-short-note>`
- Mismatch signals: `<semantic-closeness / open-question-count / unresolved-question-load>`

If answers or unresolved questions from this mini-idea affect the parent idea, explicitly report the affected parent artifact and section to the user before or while applying the change.
If the mini-idea significantly stops matching the meaning of the main idea, stop work on it as a mini-idea and ask the user whether to turn it into a separate independent idea.

## 7. Open Questions

- What is still unclear about the mini-idea?
- Which questions must be answered before integrating it into parent concepts or principles?
- Could any answer rewrite a section of the parent idea, parent concepts, or parent principles?
- Is there low semantic closeness between the mini-idea and main idea artifacts?
- Does the mini-idea have more open or unresolved questions than the main idea?
- Is the user having difficulty answering mini-idea questions?
- When an answer has been supplied, first integrate it into the relevant mini-idea or parent sections, then mark the question as done here.
- Do not store answers, consequences, or resolved-question notes under the question itself.

## 8. Boundaries / Non-Goals

- What is outside this mini-idea?
- What should remain in the parent idea or in a separate future idea?

## 9. Parent Integration

- Parent concept integration: `[pending]`
- Parent principle integration: `[pending]`
- Parent sections changed: `[none-yet]`
- User notification required before parent rewrite: `[yes]`

```
