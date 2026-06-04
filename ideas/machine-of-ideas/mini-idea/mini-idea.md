---
id: mini-idea
kind: idea-artifact
status: draft
produced-by: idea-capture-agent
workflow-version: 0.2.0
interaction-language: ru
artifact-language: en
derived-from:
  - ideas/machine-of-ideas/machine-of-ideas.md
---

# Idea: Mini-Idea

## 1. Summary

`Mini-Idea` is a sub-idea of the `Machine of Ideas` that introduces a lighter way to develop one concrete aspect of an already established main idea. It is not meant to repeat the full idea-development cycle at the same scale as the parent idea; instead, it captures a focused addition that can later enrich the concepts and principles of the main idea.

The central distinction is that a mini-idea may have its own idea artifact, but its concept and principle work should remain attached to the main idea, with explicit references back to the mini-idea as source material.

## 2. Context / Origin

- The idea emerged while developing the `Machine of Ideas` itself.
- The current workflow is useful for full ideas, but it may be too heavy when the user wants to develop only one aspect of a larger idea.
- The main idea already carries the broader context, concept space, and principle layer.
- A smaller working form is needed for additions that should enrich the parent idea without becoming fully independent idea projects.

## 3. Problem / Motivation

- Not every meaningful thought deserves a full independent concept and principle artifact.
- Some thoughts are valuable precisely because they clarify, extend, or correct one aspect of a larger idea.
- If every small addition becomes a full parallel idea flow, the project may fragment into many local concept and principle artifacts.
- If small additions are not captured separately at all, their source context may disappear before they can influence the parent idea.
- The machine therefore needs a way to preserve focused development while keeping the conceptual and principled source of truth near the main idea.

## 4. Raw Description

A mini-idea is a small, focused development inside a larger idea. It should allow a user to explore one aspect without rebuilding the full intellectual context from the beginning. The parent idea provides the larger frame; the mini-idea adds a bounded fragment of development.

The mini-idea can still have its own artifact. This artifact records the origin, motivation, raw formulation, assumptions, open questions, and examples for the specific aspect being developed. It gives the thought enough body to be revisited and cited later.

However, concepts and principles should not automatically be published as separate peer artifacts next to the mini-idea. Since the mini-idea exists to supplement the parent idea, its conceptual and principled output should be integrated into the parent idea's concept and principle artifacts. Those parent artifacts should reference the mini-idea as a source, so the added concept or principle remains traceable to the focused discussion that produced it.

This suggests a separate mode or workflow variant. In a normal idea flow, the machine moves from idea artifact to concept artifact to principle artifact for the same idea. In a mini-idea flow, the machine captures a small idea artifact and then routes later extraction or synthesis toward the parent idea's concept and principle layers.

The goal is not to make mini-ideas second-class or disposable. Their value is different: they act as precise additions, probes, or corrections inside the larger living structure of an idea.

## 5. Key Elements

- mini-idea as a focused sub-idea
- lighter idea template
- optional or minimal concept section
- optional or minimal principle section
- parent idea as the main conceptual and principle surface
- explicit links from parent concepts and principles back to the mini-idea
- reduced workflow weight for small additions
- separate mode or workflow variant for mini-idea development
- avoidance of unnecessary artifact fragmentation
- preservation of source traceability for small idea fragments

## 6. Assumptions

- The parent idea is already developed enough to provide the main context.
- A mini-idea usually develops one concrete aspect rather than a whole independent idea.
- A mini-idea may still need its own artifact to preserve source context.
- Concept and principle artifacts for mini-ideas should usually be integrated into the parent idea's artifacts rather than created separately.
- A smaller template can be honest and useful without losing traceability.
- The machine can distinguish between a sub-idea that deserves its own full cycle and a mini-idea that mainly supplements a parent idea.

## 7. Examples / Scenarios

- While working on `Machine of Ideas`, a user notices that the workflow needs a smaller path for focused additions. The mini-idea is captured separately, but later concept and principle updates are made in `machine-of-ideas-concepts.md` and `machine-of-ideas-principles.md`.
- A main idea already has a principle about traceability. A mini-idea proposes that parent principles should cite focused sub-idea artifacts when they incorporate material from them.
- A user develops a small idea about language choice, style metadata, or directory naming. The small artifact preserves the local reasoning, while the main idea remains the public surface for concepts and principles.

## 8. Signals of Value

- It reduces the overhead of working with small but important thoughts.
- It keeps parent idea concepts and principles coherent.
- It prevents unnecessary proliferation of concept and principle artifacts.
- It gives small additions a clear traceable source.
- It supports gradual evolution of a main idea without requiring every addition to become an independent idea project.
- It makes the machine more usable during real ongoing work, where many valuable insights are local and partial.

## 9. Open Questions

- What is the minimum template for a mini-idea?
- Should `Mini-Idea` be a mode, a workflow variant, an artifact kind, or all three?
- What criteria distinguish a mini-idea from a normal sub-idea?
- How should a parent concept or principle record that it was supplemented by a mini-idea?
- Should mini-idea artifacts have their own `Development Artifacts` section, or a different section that points to parent-level integration?
- Can a mini-idea later be promoted into a full sub-idea with its own concept and principle artifacts?
- How should unresolved questions in a mini-idea affect the parent idea's development state?

## 10. Resolved Questions

- A mini-idea may have its own idea artifact.
- A mini-idea is intended to develop one concrete aspect of a larger idea.
- The main idea remains the main place for concepts and principles.
- Concepts and principles influenced by a mini-idea should link back to the mini-idea as source material.
- The mini-idea flow should use a smaller template than the full idea flow.

## 11. Boundaries / Non-Goals

- This idea does not yet define the final mini-idea template.
- This idea does not yet change the canonical workflow in `.double/`.
- This idea does not require all sub-ideas to become mini-ideas.
- This idea does not remove the normal full flow for substantial sub-ideas.
- This idea does not yet specify the exact metadata schema for parent integration.

## 12. Related Ideas

- The root idea [Machine of Ideas](../machine-of-ideas.md)
- The sub-idea [Directory Layout](../directory-layout/directory-layout.md)
- The sub-idea [Concept Extraction](../concept-extraction/concept-extraction.md)
- The sub-idea [Principle Synthesis](../principle-synthesis/principle-synthesis.md)
- The sub-idea [Styles](../styles/styles.md)

## 13. Maturity Level

- [x] Raw thought
- [ ] Developed idea
- [ ] Near-concept

## 14. Notes

This idea is especially important for the machine working on itself. As the main idea grows, many useful changes will appear as small process insights. A mini-idea mode would let those insights be captured and integrated without forcing the whole system into heavy formalization each time.

## 15. Development Artifacts

- Parent concept integration: `[pending]`
- Parent principle integration: `[pending]`
