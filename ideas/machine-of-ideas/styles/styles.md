---
id: styles
kind: mini-idea-artifact
status: draft
produced-by: idea-capture-agent
workflow-version: 0.2.0
interaction-language: ru
artifact-language: en
parent-idea:
  id: machine-of-ideas
  artifact: ideas/machine-of-ideas/machine-of-ideas.md
integration-targets:
  concepts: ideas/machine-of-ideas/machine-of-ideas-concepts.md
  principles: ideas/machine-of-ideas/machine-of-ideas-principles.md
derived-from:
  - ideas/machine-of-ideas/machine-of-ideas.md
  - conversation about styles as a mini-idea of Machine of Ideas
---

# Mini-Idea: Styles

## 1. Summary

`Styles` is a mini-idea of the `Machine of Ideas` that introduces a way to perform the same workflow step in different personal or collective styles. A style should preserve the basic structure of the machine while changing the manner of presentation, interaction, artifact templates, prompts, roles, or other expressive working forms.

The purpose of this mini-idea is to support an individual approach to working with ideas. The machine should not only allow a person or group to override an existing style, but also help them develop their own style as a recognizable way of thinking, asking, structuring, and documenting ideas.

## 2. Main Idea Context

- Main idea: `ideas/machine-of-ideas/machine-of-ideas.md`
- This mini-idea clarifies the part of the `Machine of Ideas` concerned with subjective fit, personal knowledge work, and the machine's ability to adapt its working forms without losing traceability.
- It belongs inside the main idea because it does not propose a separate idea machine. It extends the existing machine by distinguishing stable workflow structure from the personal or collective style in which that structure is expressed.
- The current project already has a default style, called `double`.
- The current material in the `.double/` catalog is understood as being written in the `double` style.
- The `double` style is a group approach approved by the active participants of the Double project.
- Another person using the project may want to rewrite workflows, agents, roles, prompts, templates, or other working materials in their own way without abandoning the underlying machine.
- Related mini-ideas and sub-ideas include [Directory Layout](../directory-layout/directory-layout.md), [Concept Extraction](../concept-extraction/concept-extraction.md), and [Principle Synthesis](../principle-synthesis/principle-synthesis.md).

## 3. Motivation

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

A style works inside the workflow: while moving through workflow steps, the user and agent may clarify which style should shape subsequent work. Style is a fine-tuning layer for adapting the flow of the `Machine of Ideas` to a particular person, group, or working context.

Style preserves the workflow contract. A style may shape how workflow steps are expressed, supported, and mediated, but it should not override the core workflow of the `Machine of Ideas` or change the transition logic that makes a workflow recognizable as the same workflow.

Style differs from mode. A mode changes the kind of work being performed in a step, such as brainstorming, editing, validation, explanation, or strict research. A style does not change that stage function. Instead, it changes the way the work is expressed and mediated: tone of communication, degree of formality, model temperature or associative freedom, templates, prompts, roles, agents, and other working forms.

Styles should be exchangeable. A person or group should be able to formulate a style, reuse it, share it, adapt it, or use another person's style as a starting point. This makes styles project assets rather than private, invisible local modifications.

The `Machine of Ideas` may later include a dedicated mode or working path for helping a person create their own style. That future mechanism belongs to later development; the current mini-idea only establishes that style creation is a valid kind of support the machine may provide.

Styles may inherit from other styles in a loose source-material sense: an existing style can be used as input when forming a new style. This does not yet define a technical inheritance mechanism.

Output format is not style. Earlier examples such as `pdf`, `html`, and `json` describe artifact representation or export format, not the style of working through the machine. A style may influence how artifacts are phrased, structured, or guided, but it should not be reduced to the output medium.

## 5. Key Points

- style as a first-class property of idea-machine work
- a default `double` style
- the `double` style as a group approach approved by active participants of the Double project
- styles as variants of presentation, interaction, prompts, roles, templates, and artifact expression
- the same workflow step being executable in different styles
- style metadata in produced artifacts
- support for individual and group approaches
- style development as part of the machine's work
- distinction between stable workflow structure and variable expressive form
- the analogy between style and CSS: structure remains, presentation changes
- style as more than a technical override: an individual or collective approach to working with ideas
- possible future style inheritance, such as a personal style inheriting from `double`
- style selection as part of moving through a workflow
- style as a layer that can affect tone, model temperature, associative freedom, templates, prompts, roles, and agents
- style as distinct from mode: mode changes the work lens; style changes the expression and configuration of that work
- style as preserving the workflow contract rather than overriding the core workflow
- styles as exchangeable and reusable assets
- style creation as a possible future mode or working path of the machine
- style inheritance as using existing styles as source material for forming new styles
- output format as outside the definition of style

## 6. Main Idea Impact

- Possible concept impact: `ideas/machine-of-ideas/machine-of-ideas-concepts.md`
- Possible principle impact: `ideas/machine-of-ideas/machine-of-ideas-principles.md`
- Possible parent idea section impact: `ideas/machine-of-ideas/machine-of-ideas.md`
- Semantic mismatch with main idea: `none`
- Mismatch signals: `high semantic closeness; several unresolved questions; no current mismatch with the parent idea`

This mini-idea may require adding a `Style` concept to the parent concept artifact, or refining existing concepts around `Mode`, `Role`, `Workflow Stage`, `Artifact Contract`, and `Self-Evolving Working Form`. It may also require a parent principle that style variation should preserve workflow identity, workflow contract, traceability, artifact compatibility, and shareability.

The parent idea may need a small clarification that the machine's mutability includes not only changes to workflow stages and templates, but also explicit style variation. The concrete directory layout, loading rules, and storage format for styles should be left for a later design or specification stage rather than settled at the idea level.

Parent concept and principle artifacts have now been updated to integrate this mini-idea.

## 7. Open Questions

- [x] What exactly belongs to a style, and what must remain part of the workflow structure?
- [x] Should style be recorded as a single metadata field, or should artifacts record several style-related properties?
- [x] How should the machine distinguish a style change from a workflow change?
- [x] Where should style definitions live: inside `.double/`, inside `ideas/`, or in another layer?
- [x] What is the minimum contract that every style must preserve for workflow compatibility?
- [x] How should the machine help a person discover or develop their own style?
- [x] Can styles inherit from other styles, such as a personal style inheriting from `double`?
- [x] How should `Style` relate to the existing `Mode` concept?
- [x] Could answers to the style/workflow boundary questions require rewriting parent concepts or principles?
- [x] Should output-oriented styles such as `pdf`, `html`, and `json` be treated as full styles, export styles, or artifact-format styles?
- [x] How should styles be exchanged, reused, and adapted between people or projects?
- [x] What later design artifact should define the concrete storage layout and loading rules for styles?

## 8. Boundaries / Non-Goals

- This mini-idea does not yet finalize the concrete implementation format for styles.
- This mini-idea does not define the concrete directory structure for storing styles.
- This mini-idea does not define the concrete mechanism for exchanging styles between people or projects.
- This mini-idea does not define a technical inheritance mechanism for styles.
- This mini-idea does not treat output formats such as PDF, HTML, Markdown, or JSON as styles.
- This mini-idea does not yet redesign the current workflow, agents, roles, prompts, or templates.
- This mini-idea does not yet specify how style validation or compatibility should work at implementation level.
- This mini-idea does not allow style to replace or override the core workflow contract of the `Machine of Ideas`.
- This mini-idea does not replace modes; style and mode remain separate workflow dimensions.
- This mini-idea does not require every user to create a personal style before using the machine.
- This mini-idea should remain inside `Machine of Ideas` unless style work develops into a broader independent theory of personal or collective knowledge practice.

## 9. Maturity Level

- [ ] Raw thought
- [x] Developed mini-idea
- [x] Ready for parent integration

## 10. Parent Integration

- Parent concept integration: `ideas/machine-of-ideas/machine-of-ideas-concepts.md#concept-style`
- Parent principle integration: `ideas/machine-of-ideas/machine-of-ideas-principles.md#principle-support-exchangeable-styles`
- Parent sections changed: `machine-of-ideas-concepts.md: Conceptual Summary, Concept: Mode, Concept: Style, Conceptual Map, Entities and Terms; machine-of-ideas-principles.md: Principle Synthesis Summary, Principle: Stabilize Roles, Vary Modes, Principle: Support Exchangeable Styles Without Overriding Workflow Contracts, Principle Map, Trade-offs and Tensions, Candidate Inputs for Future Stages, Rejected or Deferred Candidate Principles`
- User notification required before parent rewrite: `[done]`
