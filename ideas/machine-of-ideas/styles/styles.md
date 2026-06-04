---
id: styles
kind: idea-artifact
status: draft
produced-by: idea-capture-agent
workflow-version: 0.2.0
interaction-language: ru
artifact-language: en
derived-from:
  - ideas/machine-of-ideas/machine-of-ideas.md
---

# Idea: Styles

## 1. Summary

`Styles` is a sub-idea of the `Machine of Ideas` that introduces a way to perform the same workflow step in different personal or collective styles. A style should preserve the basic structure of the machine while changing the manner of presentation, interaction, artifact templates, prompts, roles, or other expressive working forms.

The purpose of this idea is to support an individual approach to working with ideas. The machine should not only allow a person or group to override an existing style, but also help them develop their own style as a recognizable way of thinking, asking, structuring, and documenting ideas.

## 2. Context / Origin

- The idea emerged while developing the `Machine of Ideas` as a process that should support subjective knowledge, personal experience, and creative exploration.
- The current project already has a default style, called `double`.
- The current material in the `.double/` catalog is understood as being written in the `double` style.
- The `double` style is a group approach: a way of working approved by the active participants of the Double project.
- Another person using the project may want to rewrite workflows, agents, roles, prompts, templates, or other working materials in their own way without abandoning the underlying machine.

## 3. Problem / Motivation

- A workflow can be structurally correct but still feel alien to a particular person.
- If the machine fixes only one tone, one way of asking questions, one artifact shape, or one style of interaction, it may limit creative search.
- People differ in how they think, formulate uncertainty, respond to questions, preserve context, and move from raw thought to structured artifacts.
- The machine therefore needs a way to distinguish stable process structure from the personal or collective style in which that structure is expressed.
- Without an explicit style layer, personal adaptation may become an untracked fork of the machine rather than a visible, reusable, and developable approach.

## 4. Raw Description

The idea is to add `styles` to the `Machine of Ideas` so that one and the same workflow step can be executed in different styles. A style is not meant to replace the basic structure of the machine. It is closer to CSS in relation to HTML: the basic structure remains recognizable, but the way it is presented, spoken, asked, and documented can change.

For example, the current project has a default style called `double`. Everything currently created in the `.double/` catalog is made in this style. This means that the existing workflow definitions, agents, roles, prompts, and templates express not only a process structure, but also a particular approach to working with ideas.

Another person who uses the project may want to rewrite or adapt those materials. They may want different prompts, different role descriptions, different artifact templates, different interaction tone, or a different way of guiding a person through the same step. This should be possible without destroying the underlying workflow identity.

A style should therefore be represented explicitly in artifact properties. An artifact should be able to say which style shaped it, so that later readers and agents can understand not only which workflow produced the artifact, but also which expressive and methodological variant was used.

The machine should also help a person develop their style. Style is not merely a technical preset. It is an individual approach to working with ideas: a way of asking, clarifying, preserving ambiguity, shaping artifacts, moving between freedom and discipline, and making thought feel alive for a particular person or group.

The goal is for the `Machine of Ideas` to limit creative search as little as possible. It should provide enough structure to preserve traceability, but not force every person to think, speak, or document ideas in the same manner.

## 5. Key Elements

- style as a first-class property of idea-machine work
- a default `double` style
- styles as variants of presentation, interaction, prompts, roles, templates, and artifact expression
- the same workflow step being executable in different styles
- style metadata in produced artifacts
- support for individual and group approaches
- style development as part of the machine's work
- distinction between stable workflow structure and variable expressive form
- the analogy between style and CSS: structure remains, presentation changes

## 6. Assumptions

- The current `.double/` catalog expresses the default `double` style.
- The basic workflow structure can remain stable while the style of execution changes.
- A style can affect prompts, roles, templates, interaction tone, and artifact shape without necessarily changing the meaning of the workflow step.
- A style is important enough to be recorded in artifact metadata.
- Different people may need different styles to work productively with ideas.
- The machine can help users not only select a style, but also articulate and refine one.

## 7. Examples / Scenarios

- A user runs `Idea Capture` in the default `double` style and receives the current structured, careful, epistemic form of the artifact.
- Another user keeps the same `Idea Capture -> Concept Extraction -> Principle Synthesis` flow, but rewrites prompts and templates in a more poetic, therapeutic, academic, entrepreneurial, or technical style.
- A small group agrees on its own shared style and uses it as the default for its project artifacts.
- An artifact includes style metadata, making it clear that it was produced by the `Machine of Ideas` workflow in a specific style rather than by a generic version of the step.
- A person does not yet know their preferred style, so the machine helps them develop it by asking what kind of interaction, artifact structure, and creative constraints make their thinking work best.

## 8. Signals of Value

- The idea strengthens the machine's support for subjective fit and personal knowledge work.
- It prevents the default `double` style from becoming an implicit universal norm.
- It allows adaptation without losing traceability to the shared workflow structure.
- It gives future agents a visible signal about how an artifact was shaped.
- It makes the machine more hospitable to creative, personal, and group-specific approaches.
- It may allow styles themselves to become reusable and developable project assets.

## 9. Open Questions

- What exactly belongs to a style, and what must remain part of the workflow structure?
- Should style be recorded as a single metadata field, or should artifacts record several style-related properties?
- How should the machine distinguish a style change from a workflow change?
- Where should style definitions live: inside `.double/`, inside `ideas/`, or in another layer?
- What is the minimum contract that every style must preserve for workflow compatibility?
- How should the machine help a person discover or develop their own style?
- Can styles inherit from other styles, such as a personal style inheriting from `double`?

## 10. Resolved Questions

- The default style of the current project is called `double`.
- The `double` style is a group approach approved by active participants of the Double project.
- Style should be explicitly represented in artifact properties.
- Style should allow different execution forms for the same workflow step.
- A style is not only a technical override, but an individual approach to working with ideas.

## 11. Boundaries / Non-Goals

- This idea does not yet define the concrete implementation format for styles.
- This idea does not yet redesign the current workflow, agents, roles, prompts, or templates.
- This idea does not yet specify how style inheritance, validation, or compatibility should work.
- This idea does not replace modes; the relationship between styles and modes remains open.
- This idea does not require every user to create a personal style before using the machine.

## 12. Related Ideas

- The root idea [Machine of Ideas](../machine-of-ideas.md)
- The sub-idea [Directory Layout](../directory-layout/directory-layout.md)
- The sub-idea [Concept Extraction](../concept-extraction/concept-extraction.md)
- The sub-idea [Principle Synthesis](../principle-synthesis/principle-synthesis.md)

## 13. Maturity Level

- [x] Raw thought
- [ ] Developed idea
- [ ] Near-concept

## 14. Notes

This idea appears closely related to the existing distinction between workflow structure, modes, roles, prompts, and artifact templates. Its central contribution is the claim that a person's or group's way of working should become explicit and developable rather than remaining hidden in the current wording of process materials.

## 15. Development Artifacts

- Concepts: `[pending]`
- Principles: `[pending]`
