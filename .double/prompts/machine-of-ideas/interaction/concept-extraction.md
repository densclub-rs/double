---
submodule: machine-of-ideas
id: concept-extraction-interaction-prompt
kind: prompt
status: release-candidate
produced-by: concept-extraction-agent
mode: shared
derived-from:
  - ideas/machine-of-ideas/concept-extraction/concept-extraction.md
  - .double/templates/machine-of-ideas/concept-template.md
  - ideas/machine-of-ideas/machine-of-ideas-concepts.md#concept-human-clarification-loop
  - ideas/machine-of-ideas/machine-of-ideas-principles.md#principle-ask-and-integrate-open-questions
---

# Interaction Prompt: Concept Extraction

We are going to extract the conceptual structure of your idea.

At this step, I will not rewrite the idea, design a solution, or formulate principles yet.
I will look for the stable meaning units inside the idea: important entities, relationships, processes, distinctions, tensions, and interpretive frames.

The output will be a `Concept Artifact` with:

- source idea
- conceptual summary
- working definition of concept
- core concept cards
- conceptual map
- terms and non-concepts
- candidate inputs for principle synthesis
- open questions

By default, I will publish it next to the root idea as `<root-idea-id>-concepts.md` and add a link to it from the root idea's `Development Artifacts` section. Relevant sub-ideas may be used as source material for that root concept artifact.

If I ask open questions, your answers will be integrated into the active `concept-artifact`, not left only in the conversation.
After an answer is integrated into the appropriate main section, I will mark the corresponding question as done in `Open Questions`.
I will not store the answer under the question itself or create a separate `Resolved Questions` section for normal concept questions.

If unresolved `Open Questions` already remain in the source idea, I should explicitly remind the user about them at step entry, but I should not block concept extraction unless they prevent an honest concept artifact.

If unresolved `Open Questions` remain in the active concept artifact or relevant source artifact, I should offer to help answer them before suggesting a transition.
If there are no unresolved questions and the concept artifact is ready, I should suggest moving to `principle-synthesis` and recommend a useful mode.

Before I produce the artifact or review, I need one of these inputs:

- an existing `idea-artifact`
- a path to an idea file
- pasted idea content
- a short instruction to use the currently active idea

I also need two language choices:

- interaction language: the language I should use while talking with you
- artifact language: the language I should use for the concept artifact

The selected values must be written to `interaction-language` and `artifact-language` in the artifact frontmatter.

I also need to know whether you want:

- a full `Concept Artifact`
- a focused concept review of an existing or partial artifact

First questions:

Which idea artifact should I analyze for concept extraction?
Which language should we use for our conversation, and which language should I use for the concept artifact?
Do you want a full concept artifact or a focused concept review?
