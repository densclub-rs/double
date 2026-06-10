---
id: mini-idea
kind: idea-artifact
status: release-candidate
produced-by: idea-capture-agent
workflow-version: 0.2.0
interaction-language: ru
artifact-language: en
derived-from:
  - ideas/machine-of-ideas/machine-of-ideas.md
---

# Idea: Mini-Idea

## 1. Summary

`Mini-Idea` is a sub-idea of the `Machine of Ideas` that introduces a lighter way to develop one concrete aspect of an already established main idea. In this model, `mini-idea` and `sub-idea` are synonyms: both name a focused idea fragment that belongs to a parent idea rather than a fully independent idea project.

The central distinction is that a mini-idea has its own lighter idea artifact and template, but its concept and principle work is routed back into the main idea's concept and principle artifacts. Those parent artifacts must explicitly reference the mini-idea as source material and tell the user when answers or unresolved questions from the mini-idea change the main idea's conceptual or principle layer.

## 2. Context / Origin

- The idea emerged while developing the `Machine of Ideas` itself.
- The current workflow is useful for full ideas, but it may be too heavy when the user wants to develop only one aspect of a larger idea.
- The main idea already carries the broader context, concept space, and principle layer.
- A smaller working form is needed for additions that should enrich the parent idea without becoming fully independent idea projects.
- The machine needs a routing rule: when the user says they are working on a mini-idea or sub-idea, the mini-idea template should be selected automatically.

## 3. Problem / Motivation

- Not every meaningful thought deserves a full independent concept and principle artifact.
- Some thoughts are valuable precisely because they clarify, extend, or correct one aspect of a larger idea.
- If every small addition becomes a full parallel idea flow, the project may fragment into many local concept and principle artifacts.
- If small additions are not captured separately at all, their source context may disappear before they can influence the parent idea.
- The machine therefore needs a way to preserve focused development while keeping the conceptual and principled source of truth near the main idea.

## 4. Raw Description

A mini-idea is a small, focused development inside a larger idea. It should allow a user to explore one aspect without rebuilding the full intellectual context from the beginning. The parent idea provides the larger frame; the mini-idea adds a bounded fragment of development.

The mini-idea has its own artifact and should use a dedicated mini-idea template in the machine's template catalog. When the user says they will work on a `mini-idea` or a `sub-idea`, the machine should treat those terms as equivalent and automatically use this lighter template rather than the full idea template.

The mini-idea artifact records the origin, motivation, raw formulation, assumptions, open questions, and examples for the specific aspect being developed. It gives the thought enough body to be revisited and cited later without forcing it to become a full parallel idea project.

Concepts and principles should not automatically be published as separate peer artifacts next to the mini-idea. Since the mini-idea exists to supplement the parent idea, its conceptual and principled output should be integrated into the parent idea's concept and principle artifacts. Those parent artifacts should reference the mini-idea as a source, so the added concept or principle remains traceable to the focused discussion that produced it.

When the user says that work on the mini-idea is finished, later concept extraction and principle synthesis should use the corresponding parent idea artifacts as the publication targets. The mini-idea becomes part of the source corpus for those parent artifacts, not the root of a separate concept/principle chain.

Open and unresolved questions in a mini-idea may affect the parent idea. Their answers can rewrite sections in the main idea's concept or principle artifacts when the answer changes the parent-level understanding. When this happens, the machine must explicitly report the affected parent artifact and sections to the user instead of silently absorbing the change.

The goal is not to make mini-ideas second-class or disposable. Their value is different: they act as precise additions, probes, or corrections inside the larger living structure of an idea.

## 5. Key Elements

- mini-idea as a focused parent-scoped idea
- `mini-idea` and `sub-idea` as synonyms
- dedicated lighter mini-idea template
- automatic template routing when the user names a mini-idea or sub-idea
- parent idea as the main conceptual and principle surface
- explicit links from parent concepts and principles back to the mini-idea
- reduced workflow weight for small additions
- separate mode or workflow variant for mini-idea development
- avoidance of unnecessary artifact fragmentation
- preservation of source traceability for small idea fragments
- explicit user notification when mini-idea answers rewrite parent concept or principle artifacts

## 6. Assumptions

- The parent idea is already developed enough to provide the main context.
- A mini-idea usually develops one concrete aspect rather than a whole independent idea.
- A mini-idea may still need its own artifact to preserve source context.
- Concept and principle artifacts for mini-ideas should normally be integrated into the parent idea's artifacts rather than created separately.
- A smaller template can be honest and useful without losing traceability.
- The machine can treat `sub-idea` and `mini-idea` as equivalent terms.
- Parent concept and principle artifacts can be safely updated from mini-idea answers when the update is explicit and traceable.
- A mini-idea is not normally a candidate for promotion into a fully independent idea; significant semantic mismatch with the parent idea is a stop signal that should be brought to the user.

## 7. Examples / Scenarios

- While working on `Machine of Ideas`, a user notices that the workflow needs a smaller path for focused additions. The mini-idea is captured separately, but later concept and principle updates are made in `machine-of-ideas-concepts.md` and `machine-of-ideas-principles.md`.
- A main idea already has a principle about traceability. A mini-idea proposes that parent principles should cite mini-idea artifacts when they incorporate material from them.
- A user develops a small idea about language choice, style metadata, or directory naming. The small artifact preserves the local reasoning, while the main idea remains the public surface for concepts and principles.
- A user says, "I want to work on a sub-idea about templates." The machine automatically uses the mini-idea template, records the parent idea, and later integrates relevant conclusions into the parent concept and principle artifacts.
- A mini-idea leaves an unresolved question about routing. When the user answers it, the answer changes the parent workflow concept; the machine updates the parent concept artifact and tells the user that the parent artifact was affected.

## 8. Signals of Value

- It reduces the overhead of working with small but important thoughts.
- It keeps parent idea concepts and principles coherent.
- It prevents unnecessary proliferation of concept and principle artifacts.
- It gives small additions a clear traceable source.
- It supports gradual evolution of a main idea without requiring every addition to become an independent idea project.
- It makes the machine more usable during real ongoing work, where many valuable insights are local and partial.
- It gives the machine an explicit path for letting focused work reshape parent-level concepts and principles without hiding that influence.

## 9. Open Questions

- How should semantic closeness and unresolved-question load be measured in practice without turning mismatch detection into a rigid automatic decision?

## 10. Resolved Questions

- A mini-idea may have its own idea artifact.
- A mini-idea is intended to develop one concrete aspect of a larger idea.
- The main idea remains the main place for concepts and principles.
- Concepts and principles influenced by a mini-idea should link back to the mini-idea as source material.
- The mini-idea flow should use a smaller template than the full idea flow.
- The mini-idea should have its own separate template in the machine.
- When the user says they are working on a mini-idea or sub-idea, the machine should automatically use the mini-idea template.
- `Mini-idea` and `sub-idea` are synonyms in this model.
- When the user says work on a mini-idea is finished, concept extraction and principle synthesis should use the corresponding artifacts of the main idea as integration targets.
- Open and unresolved questions in a mini-idea can affect the main idea, including rewriting sections of the main idea's concept and principle artifacts.
- When mini-idea answers affect the main idea, the machine should explicitly tell the user which parent artifacts or sections were changed.
- No special metadata should be added to the main idea for links to mini-ideas; mini-ideas are treated as parts, additions, and detailed explanations of the whole.
- A mini-idea should not normally be promoted into an independent idea.
- If a mini-idea significantly stops matching the meaning of the parent idea, work on it as a mini-idea should stop and the user should be asked whether to turn it into a separate independent idea.
- Significant semantic mismatch can be indicated by low semantic closeness between the parent idea and mini-idea artifacts, more open questions in the mini-idea than in the parent idea, or user difficulty answering mini-idea questions while unresolved mini-idea questions exceed unresolved parent questions.

## 11. Boundaries / Non-Goals

- This idea does not require every mini-idea to immediately change parent concepts or principles.
- This idea does not define the complete workflow registry changes needed to automate mini-idea routing.
- This idea does not define the exact threshold for significant semantic mismatch between a mini-idea and its parent idea.

## 12. Related Ideas

- The root idea [Machine of Ideas](../machine-of-ideas.md)
- The sub-idea [Directory Layout](../directory-layout/directory-layout.md)
- The sub-idea [Concept Extraction](../concept-extraction/concept-extraction.md)
- The sub-idea [Principle Synthesis](../principle-synthesis/principle-synthesis.md)
- The sub-idea [Styles](../styles/styles.md)

## 13. Maturity Level

- [ ] Raw thought
- [x] Developed idea
- [ ] Near-concept

## 14. Notes

This idea is especially important for the machine working on itself. As the main idea grows, many useful changes will appear as small process insights. A mini-idea mode would let those insights be captured and integrated without forcing the whole system into heavy formalization each time.

## 15. Development Artifacts

- Mini-idea template: `.double/templates/machine-of-ideas/mini-idea-template.md`
- Parent concept integration: `ideas/machine-of-ideas/machine-of-ideas-concepts.md#concept-mini-idea`
- Parent principle integration: `ideas/machine-of-ideas/machine-of-ideas-principles.md#principle-route-mini-ideas-through-parent-artifacts`
