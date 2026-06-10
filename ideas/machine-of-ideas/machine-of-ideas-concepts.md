---
id: machine-of-ideas-concepts
kind: concept-artifact
status: release-candidate
produced-by: concept-extraction-agent
workflow-version: 0.1.0
interaction-language: en
artifact-language: en
publication-path: ideas/machine-of-ideas/machine-of-ideas-concepts.md
derived-from:
  - ideas/machine-of-ideas/machine-of-ideas.md
  - ideas/machine-of-ideas/directory-layout/directory-layout.md
  - ideas/machine-of-ideas/concept-extraction/concept-extraction.md
  - ideas/machine-of-ideas/mini-idea/mini-idea.md
---

# Concept Artifact: Machine of Ideas

## 1. Source Idea

- Source artifact: `ideas/machine-of-ideas/machine-of-ideas.md`
- Supporting source corpus: `.double`
- Source title: `Machine of Ideas`
- Source idea directory: `ideas/machine-of-ideas`
- Published as: `machine-of-ideas-concepts.md`
- Produced by stage: `Concept Extraction`
- Stage description: `ideas/machine-of-ideas/concept-extraction/concept-extraction.md`
- Extraction mode: `validation`

## 2. Validation Conclusion

This artifact is already a result of the `Machine of Ideas` working on itself. It is the published output of the `Concept Extraction` stage and provides the conceptual input for `Principle Synthesis`.

The concept set is valid as a first concept artifact for `Machine of Ideas`. It treats concepts as stable units of meaning rather than as principles, requirements, tasks, or design decisions. Details that express how the machine should guide future decisions have been moved into `ideas/machine-of-ideas/machine-of-ideas-principles.md`.

## 3. Conceptual Summary

`Machine of Ideas` is a transformation system for thought. It takes raw or polished material through stages of clarification and produces artifacts that can become input for later stages.

The main conceptual pattern is a layered working machine: human-readable project documentation, operational working forms, stage-specific agents, roles, modes, human clarification loops, multilingual artifact formation, mini ideas, and artifacts all participate in one process as distinct concepts.

Each core concept has a stable explicit id and matching explicit anchor. These ids make concepts usable in catalogs and referable from principle artifacts, specifications, and other ideas without depending on automatically generated heading anchors.

## 4. Working Definition of Concept

A concept is a stable meaning unit of an idea.
It may describe an entity, relationship, process, distinction, tension, or interpretive frame.
It is not yet a principle, requirement, task, design decision, architecture, or implementation detail.

## 5. Core Concepts

<a id="concept-idea-machine"></a>

### Concept: Idea Machine

Concept id: `concept-idea-machine`

#### Definition

A reproducible and mutable process for turning raw thoughts, observations, and conversations into structured artifacts.

#### Source in Idea

- Explicit in `ideas/machine-of-ideas/machine-of-ideas.md`, especially the summary and raw description.
- Reflected in the current workflow description for `Machine of Ideas`.

#### Role in the Idea

This is the umbrella concept that gives the other concepts their place. It explains why stages, agents, roles, modes, templates, and artifacts belong to one system rather than to disconnected practices.

#### Related Concepts

- `Workflow Stage`
- `Idea Artifact`
- `Self-Evolving Working Form`

#### Boundaries

- It is not a concrete runtime implementation.
- It is not a final ontology of all Double artifacts.
- It is not just a folder layout or a single prompt.

<a id="concept-idea-artifact"></a>

### Concept: Idea Artifact

Concept id: `concept-idea-artifact`

#### Definition

A structured Markdown representation of an idea that provides input for later stages.

#### Source in Idea

- Explicit in the root `Machine of Ideas` idea.
- Reflected in the idea artifact template and idea capture stage.

#### Role in the Idea

It is the first stable public form of the idea and a source for later conceptual work.

#### Related Concepts

- `Idea Machine`
- `Traceability`
- `Artifact Contract`

#### Boundaries

- It is not a concept artifact.
- It is not a specification or implementation plan.
- It may preserve ambiguity when ambiguity remains meaningful.

<a id="concept-mini-idea"></a>

### Concept: Mini Idea

Concept id: `concept-mini-idea`

#### Definition

A focused idea fragment inside a parent idea that has its own lighter idea artifact while routing later concept and principle work back into the parent idea's concept and principle artifacts. In this model, `mini-idea` and `sub-idea` are synonyms for the same concept.

#### Source in Idea

- Explicit in `ideas/machine-of-ideas/mini-idea/mini-idea.md`.
- Supported by the need to develop small additions without fragmenting the parent idea's concept and principle layers.
- `Mini-idea` and `sub-idea` are treated as synonyms for this concept.

#### Role in the Idea

It gives the machine a light but traceable form for working on one aspect of an existing idea. The mini-idea keeps local source context, while parent concept and principle artifacts remain the main publication surfaces for conceptual and principled synthesis.

#### Related Concepts

- `Idea Artifact`
- `Artifact Contract`
- `Traceability`
- `Human Clarification Loop`

#### Boundaries

- It is not a fully independent idea by default.
- It is not normally a candidate for promotion into a fully independent idea.
- It does not automatically produce separate peer concept and principle artifacts.
- It does not hide parent-level impact; changes to parent concepts or principles must be reported explicitly to the user.
- If its meaning significantly diverges from the parent idea, work should stop and the user should be asked whether the material should become a separate independent idea.

<a id="concept-workflow-stage"></a>

### Concept: Workflow Stage

Concept id: `concept-workflow-stage`

#### Definition

A named step in the machine's transformation sequence that gives a specific layer of work its place in the whole process.

#### Source in Idea

- Explicit in the described sequence from raw idea to concepts to principles.
- Reflected in the current workflow files.

#### Role in the Idea

It makes the machine reproducible by distinguishing what kind of work is happening now from what belongs before or after it.

#### Related Concepts

- `Stage Agent`
- `Artifact Contract`
- `Transition Condition`

#### Boundaries

- A stage is not the same thing as an agent.
- A stage is not a mode of behavior.
- It is not the whole transformation process.

<a id="concept-stage-agent"></a>

### Concept: Stage Agent

Concept id: `concept-stage-agent`

#### Definition

A specialized working unit assigned to perform a workflow stage through a role, prompts, modes, and artifact expectations.

#### Source in Idea

- Explicit in the current agent-first organization of the machine.
- Reflected in the agent cards for idea capture, concept extraction, and principle synthesis.

#### Role in the Idea

It is the operational performer of a stage. The agent executes a stage, but does not replace the workflow that gives the stage its sequence and boundary.

#### Related Concepts

- `Workflow Stage`
- `Role`
- `Mode`

#### Boundaries

- A stage agent is not a free-form persona.
- It does not own the whole machine.
- It is not the workflow that orders stages.

<a id="concept-role"></a>

### Concept: Role

Concept id: `concept-role`

#### Definition

A stable responsibility model behind an agent, defining its mission, working definition, rules, heuristics, and constraints.

#### Source in Idea

- Explicit in the role files used by the current workflow.
- Reflected in the separation between agent identity and stage responsibility.

#### Role in the Idea

It separates an agent's responsibility model from a particular execution style.

#### Related Concepts

- `Stage Agent`
- `Mode`
- `Boundary Discipline`

#### Boundaries

- A role is not a prompt by itself.
- A role is not a user-selectable mode.
- A role is not the full workflow sequence.

<a id="concept-mode"></a>

### Concept: Mode

Concept id: `concept-mode`

#### Definition

A user-selectable execution lens that changes how an agent performs a stage.

#### Source in Idea

- Explicit in the modes registry and mode descriptions.
- Reflected in the user-selectable mode policy for machine stages.

#### Role in the Idea

It lets the same stage be performed with different cognitive or service behaviors, such as brainstorming, explanation, validation, or editing.

#### Related Concepts

- `Stage Agent`
- `Role`
- `Workflow Stage`

#### Boundaries

- A mode is not a role.
- A mode is not a stage.
- A mode is not the artifact produced by a stage.

<a id="concept-multilingual-artifact-form"></a>

### Concept: Multilingual Artifact Form

Concept id: `concept-multilingual-artifact-form`

#### Definition

The ability of the machine to support one language for human-agent dialogue and another selected language for generated idea, concept, and principle artifacts.

#### Source in Idea

- Explicit in the root idea's emphasis on subjective fit and adaptation to the person using the machine.
- Reflected in the workflow requirement that agents ask for both interaction language and artifact language before producing final artifacts.

#### Role in the Idea

It allows the machine to preserve the living context of thought in the user's natural language while still producing artifacts in a language chosen for publication, collaboration, research, or later technical work.

#### Related Concepts

- `Human Clarification Loop`
- `Artifact Contract`
- `Idea Artifact`
- `Traceability`

#### Boundaries

- It is not a translation mode by itself.
- It does not require the dialogue language and artifact language to be the same.
- It does not allow agents to silently choose the artifact language without user confirmation.
- It does not replace source traceability; when language transformation affects meaning, uncertainty should remain visible.

<a id="concept-artifact-contract"></a>

### Concept: Artifact Contract

Concept id: `concept-artifact-contract`

#### Definition

A structured expectation for a produced artifact, including its kind, source relation, publication role, and usefulness for later workflow stages.

#### Source in Idea

- Explicit in the artifact templates and workflow artifact contract sections.
- Reflected in the publication and linking behavior of current artifacts.

#### Role in the Idea

It makes stage outputs comparable, reusable, and discoverable from their source ideas.

#### Related Concepts

- `Workflow Stage`
- `Traceability`
- `Idea Artifact`

#### Boundaries

- A template is an expression of an artifact contract, not the whole concept.
- An artifact contract is not an implementation task.
- It is not the content of the artifact itself.

<a id="concept-registry"></a>

### Concept: Registry

Concept id: `concept-registry`

#### Definition

A lookup and routing artifact that makes workflows, agents, roles, and modes discoverable by stable identifiers and paths.

#### Source in Idea

- Explicit in the current registries for workflows, agents, roles, and modes.
- Supported by the directory-layout sub-idea.

#### Role in the Idea

Registries make the machine loadable by agents and understandable to humans. They expose where operational components live without being the full source definition of those components.

#### Related Concepts

- `Operational Workspace`
- `Workflow Stage`
- `Stage Agent`

#### Boundaries

- A registry is not the source definition of the component.
- A registry is not the full workflow, agent, role, or mode content.
- A registry is not a project documentation essay.

<a id="concept-operational-workspace"></a>

### Concept: Operational Workspace

Concept id: `concept-operational-workspace`

#### Definition

The working layer where workflows, registries, agents, roles, modes, prompts, templates, drafts, and other operational forms of the machine are organized.

#### Source in Idea

- Explicit in the directory-layout sub-idea.
- Reflected by the current `.double` tree.

#### Role in the Idea

It names the operational side of the machine apart from human-facing project documentation.

#### Related Concepts

- `Project Documentation Layer`
- `Registry`
- `Self-Evolving Working Form`

#### Boundaries

- It is not the project documentation layer.
- It is not a single concrete file or registry.
- It is not identical to the conceptual description of the machine.

<a id="concept-project-documentation-layer"></a>

### Concept: Project Documentation Layer

Concept id: `concept-project-documentation-layer`

#### Definition

The human-readable documentation and conceptual development space where the reasons, origins, sub-ideas, and artifacts of an idea can be studied.

#### Source in Idea

- Explicit in the directory-layout sub-idea.
- Reflected by the root and sub-idea files under `ideas/machine-of-ideas/`.

#### Role in the Idea

It names the human-facing side of the machine where meaning, origin, and development history are described.

#### Related Concepts

- `Operational Workspace`
- `Artifact Contract`
- `Traceability`

#### Boundaries

- It is not the operational workspace.
- It is not a registry, prompt catalog, or runtime surface.

<a id="concept-traceability"></a>

### Concept: Traceability

Concept id: `concept-traceability`

#### Definition

The visible continuity between a later artifact, conclusion, or transition and the source idea or prior artifacts it depends on.

#### Source in Idea

- Explicit in the root idea's emphasis on preserving source context.
- Reflected in the templates, prompts, and roles for derived artifacts.

#### Role in the Idea

It names the continuity by which later work remains understandable as derived from earlier material.

#### Related Concepts

- `Artifact Contract`
- `Boundary Discipline`
- `Self-Evolving Working Form`

#### Boundaries

- It does not eliminate interpretation.
- It is not the artifact contract that expresses it.
- It is not the same thing as validation.

<a id="concept-boundary-discipline"></a>

### Concept: Boundary Discipline

Concept id: `concept-boundary-discipline`

#### Definition

The separation between idea, concept, principle, requirement, task, design decision, architecture, and implementation.

#### Source in Idea

- Explicit in the root idea's separation between conceptual description and future implementation.
- Reflected in the role constraints and stage descriptions.

#### Role in the Idea

It names the conceptual distinction between layers of work, especially between understanding an idea and turning it into later solution forms.

#### Related Concepts

- `Workflow Stage`
- `Role`
- `Transition Condition`

#### Boundaries

- Boundary discipline is not a workflow stage.
- It is not the same as principle synthesis.
- It is not a transition condition.

<a id="concept-transition-condition"></a>

### Concept: Transition Condition

Concept id: `concept-transition-condition`

#### Definition

A condition that determines whether the current stage has produced an adequate artifact and can meaningfully move to another stage.

#### Source in Idea

- Explicit in the workflow description.
- Reflected in agent transition rules.

#### Role in the Idea

It turns the workflow from a loose sequence into a controlled process. A stage can be repeated, validated, or edited if its artifact is not ready.

#### Related Concepts

- `Workflow Stage`
- `Artifact Contract`
- `Boundary Discipline`

#### Boundaries

- A transition condition is not a user story or acceptance test.
- It does not define the full quality model of the artifact.
- It is not the same as implementation validation.

<a id="concept-self-evolving-working-form"></a>

### Concept: Self-Evolving Working Form

Concept id: `concept-self-evolving-working-form`

#### Definition

The machine's capacity to refine its own forms of work through interaction.

#### Source in Idea

- Explicit in `ideas/machine-of-ideas/machine-of-ideas.md`.
- Supported by the directory-layout sub-idea and current operational drafts.

#### Role in the Idea

It explains why the machine is not only a fixed template pipeline.

#### Related Concepts

- `Idea Machine`
- `Operational Workspace`
- `Traceability`

#### Boundaries

- It is not a second machine or separate workflow.
- It is not identical to workflow versioning.
- It is not a single edit to one artifact.

<a id="concept-human-clarification-loop"></a>

### Concept: Human Clarification Loop

Concept id: `concept-human-clarification-loop`

#### Definition

A stage-local dialogue process in which the machine asks open questions to the human and integrates the answers into the active artifact.

#### Source in Idea

- Explicit in the refinement of the machine's working files under `.double`.
- Supported by the artifact sections for open and resolved questions.
- Inferred from the machine's need to preserve human choice while developing artifacts.

#### Role in the Idea

It keeps the machine from treating missing context as something the agent should silently invent. Questions become part of the artifact's development, and human answers become source material for the current stage.

#### Related Concepts

- `Workflow Stage`
- `Idea Artifact`
- `Artifact Contract`
- `Traceability`

#### Boundaries

- It is not a separate workflow stage.
- It is not a generic chat transcript.
- It does not allow the current stage to silently become a later stage.
- It does not require every minor uncertainty to be asked immediately.

## 6. Conceptual Map

```text
Raw user input
  -> Idea Capture
  -> Idea Artifact
  -> Concept Extraction
  -> Concept Artifact
  -> Principle Synthesis
  -> Principle Artifact
```

The workflow sequence is held together by these relations:

- `Idea Machine` contains the overall transformation process.
- `Workflow Stage` defines a layer of work in the process.
- `Stage Agent` executes a `Workflow Stage`.
- `Role` stabilizes the responsibility of a `Stage Agent`.
- `Mode` changes execution style without changing the role or stage.
- `Artifact Contract` gives each output a reusable form.
- `Mini Idea` gives small additions a lighter artifact while routing concept and principle synthesis back into the parent idea.
- `Multilingual Artifact Form` separates the language of dialogue from the language of produced artifacts.
- `Registry` makes operational components discoverable.
- `Operational Workspace` stores the executable working form of the machine.
- `Project Documentation Layer` stores the human-readable reasons and sub-ideas.
- `Traceability` describes continuity between later artifacts and their sources.
- `Boundary Discipline` describes the distinction between layers of work.
- `Transition Condition` controls movement between stages.
- `Self-Evolving Working Form` names the machine's ability to change its own forms.
- `Human Clarification Loop` names the process by which open questions are asked to the human and answered inside the active artifact.

In the mini-idea variant, answers to open questions may affect the parent idea's concept or principle artifacts. When that happens, the parent artifact remains the integration target and the mini-idea remains a cited source.

## 7. Entities and Terms

These terms are important in the source corpus but are not treated here as core concepts:

- `brainstorm`: a concrete mode instance.
- `explain`: a concrete mode instance.
- `strict-research`: a concrete mode instance.
- `validation`: a concrete mode instance and the current execution mode.
- `editor`: a concrete mode instance.
- `idea-capture-agent`: a concrete agent instance.
- `concept-extraction-agent`: a concrete agent instance.
- `principle-synthesis-agent`: a concrete agent instance.
- `concept-template.md`: a concrete template file.
- `mini-idea-template.md`: a concrete template file for mini ideas.
- `principle-template.md`: a concrete template file.
- `.double/drafts`: a concrete draft directory.
- `workflow-version: 0.1.0`: current version marker, not a concept by itself.
- `interaction-language`: a frontmatter field that records the dialogue language selected for a run.
- `artifact-language`: a frontmatter field that records the language selected for the produced artifact.

## 8. Notes for Principle Synthesis

The previous version of this concept artifact contained several normative statements and future implementation directions. Those details have been moved into `ideas/machine-of-ideas/machine-of-ideas-principles.md`.

This artifact now keeps the concept layer focused on stable meanings, relations, and boundaries.
