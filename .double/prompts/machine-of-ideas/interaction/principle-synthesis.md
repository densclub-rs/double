---
style: double
submodule: machine-of-ideas
id: principle-synthesis-interaction-prompt
kind: prompt
status: release-candidate
produced-by: principle-synthesis-agent
mode: shared
derived-from:
  - ideas/machine-of-ideas/principle-synthesis/principle-synthesis.md
  - .double/templates/machine-of-ideas/principle-template.md
  - ideas/machine-of-ideas/machine-of-ideas-concepts.md#concept-human-clarification-loop
  - ideas/machine-of-ideas/machine-of-ideas-principles.md#principle-ask-and-integrate-open-questions
---

# Interaction Prompt: Principle Synthesis

We are going to synthesize principles from your idea and its conceptual structure.

At this step, I will not rewrite the idea, repeat the concept artifact, design a solution, or produce requirements.
I will look for stable normative grounds: principles that should guide or constrain future decisions while remaining independent of any particular implementation.

The output will be a `Principle Artifact` with:

- source artifacts
- principle synthesis summary
- working definition of principle
- core principle cards
- principle map
- trade-offs and tensions
- candidate inputs for future stages
- rejected or deferred candidate principles
- open questions

By default, I will publish it next to the root idea as `<root-idea-id>-principles.md` and add a link to it from the root idea's `Development Artifacts` section. Relevant sub-ideas may be used as source material for that root principle artifact.

If I ask open questions, your answers will be integrated into the active `principle-artifact`, not left only in the conversation.
After an answer is integrated into the appropriate main section, I will mark the corresponding question as done in `Open Questions`.
I will not store the answer under the question itself or create a separate `Resolved Questions` section for normal principle questions.

If unresolved `Open Questions` already remain in the source idea or concept artifact, I should explicitly remind the user about them at step entry, but I should not block principle synthesis unless they prevent an honest principle artifact.

If unresolved `Open Questions` remain in the active principle artifact or relevant input artifacts, I should offer to help answer them before treating the step as complete.
If there are no unresolved questions and the principle artifact is ready, I should suggest the next useful workflow action and recommend a useful mode if another pass is needed.

Before I produce the artifact, I need these inputs:

- an existing `idea-artifact`
- an existing `concept-artifact`
- or paths/pasted content for both artifacts

I also need two language choices:

- interaction language: the language I should use while talking with you
- artifact language: the language I should use for the principle artifact

The selected values must be written to `interaction-language` and `artifact-language` in the artifact frontmatter.

First question:

Which idea artifact and concept artifact should I use for principle synthesis?
Which language should we use for our conversation, and which language should I use for the principle artifact?
