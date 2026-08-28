---
id: machine-of-ideas-concepts
kind: concept-artifact
mindmap-plugin: basic
produced-by: machine-of-ideas/concept-extraction-agent
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

Idea: [Machine of Ideas](./machine-of-ideas.md#machine-of-ideas)

## 1. Conceptual Summary

`Machine of Ideas` is a transformation system for thought. It takes raw or polished material through stages of clarification and produces artifacts that can become input for later stages.

The main conceptual pattern is a layered working machine: human-readable project documentation, operational working forms, stage-specific agents, roles, modes, human clarification loops, multilingual artifact formation, mini ideas, and artifacts all participate in one process as distinct concepts.

Each core concept has a stable id in its heading. These ids make concepts
referable from the root idea, principle artifacts, specifications, and other
ideas.

## 2. Working Definition of Concept

A concept is a stable meaning unit of an idea.
It may describe an entity, relationship, process, distinction, tension, or interpretive frame.
It is not yet a principle, requirement, task, design decision, architecture, or implementation detail.

## 3. Core Concepts

<a id="concept-idea-machine"></a>

### concept-idea-machine: Idea of Machine

#### Definition

A reproducible and mutable process for turning raw thoughts, observations, and conversations into structured artifacts.

#### Source in Idea

- Explicit in `ideas/machine-of-ideas/machine-of-ideas.md`, especially the summary and raw description.
- Reflected in the current workflow description for `Machine of Ideas`.

#### Role in the Idea

This is the umbrella concept that gives the other concepts their place. It explains why stages, agents, roles, modes, styles, templates, and artifacts belong to one system rather than to disconnected practices.

#### Related Concepts

- Other relations: [`concept-workflow-stage`](#concept-workflow-stage-workflow-stage)
- Other relations: [`concept-idea-artifact`](#concept-idea-artifact-idea-artifact)
- Other relations: [`concept-self-evolving-working-form`](#concept-self-evolving-working-form-self-evolving-working-form)

#### Boundaries

- It is not a concrete runtime implementation.
- It is not a final ontology of all Double artifacts.
- It is not just a folder layout or a single prompt.

#### Questions

No open questions are currently recorded.

<a id="concept-idea-artifact"></a>

### concept-idea-artifact: Idea Artifact

#### Definition

A structured Markdown representation of an idea that provides input for later stages.

#### Source in Idea

- Explicit in the root `Machine of Ideas` idea.
- Reflected in the idea artifact template and idea capture stage.

#### Role in the Idea

It is the first stable public form of the idea and a source for later conceptual work.

#### Related Concepts

- Other relations: [`concept-idea-machine`](#concept-idea-machine)
- Other relations: [`concept-traceability`](#concept-traceability-traceability)
- Other relations: [`concept-artifact-contract`](#concept-artifact-contract-artifact-contract)

#### Boundaries

- It is not a concept artifact.
- It is not a specification or implementation plan.
- It may preserve ambiguity when ambiguity remains meaningful.

#### Questions

No open questions are currently recorded.

<a id="concept-mini-idea"></a>

### concept-mini-idea: Mini Idea

#### Definition

A focused idea fragment inside a parent idea that has its own lighter idea artifact while routing later concept and principle work back into the parent idea's concept and principle artifacts. In this model, `mini-idea` and `sub-idea` are synonyms for the same concept.

#### Source in Idea

- Explicit in `ideas/machine-of-ideas/mini-idea/mini-idea.md`.
- Supported by the need to develop small additions without fragmenting the parent idea's concept and principle layers.
- `Mini-idea` and `sub-idea` are treated as synonyms for this concept.

#### Role in the Idea

It gives the machine a light but traceable form for working on one aspect of an existing idea. The mini-idea keeps local source context, while parent concept and principle artifacts remain the main publication surfaces for conceptual and principled synthesis.

#### Related Concepts

- Other relations: [`concept-idea-artifact`](#concept-idea-artifact-idea-artifact)
- Other relations: [`concept-artifact-contract`](#concept-artifact-contract-artifact-contract)
- Other relations: [`concept-traceability`](#concept-traceability-traceability)
- Other relations: [`concept-human-clarification-loop`](#concept-human-clarification-loop-human-clarification-loop)

#### Boundaries

- It is not a fully independent idea by default.
- It is not normally a candidate for promotion into a fully independent idea.
- It does not automatically produce separate peer concept and principle artifacts.
- It does not hide parent-level impact; changes to parent concepts or principles must be reported explicitly to the user.
- If its meaning significantly diverges from the parent idea, work should stop and the user should be asked whether the material should become a separate independent idea.

#### Questions

No open questions are currently recorded.

<a id="concept-workflow-stage"></a>

### concept-workflow-stage: Workflow Stage

#### Definition

A named step in the machine's transformation sequence that gives a specific layer of work its place in the whole process.

#### Source in Idea

- Explicit in the described sequence from raw idea to concepts to principles.
- Reflected in the current workflow files.

#### Role in the Idea

It makes the machine reproducible by distinguishing what kind of work is happening now from what belongs before or after it.

#### Related Concepts

- Other relations: [`concept-stage-agent`](#concept-stage-agent-stage-agent)
- Other relations: [`concept-artifact-contract`](#concept-artifact-contract-artifact-contract)
- Other relations: [`concept-transition-condition`](#concept-transition-condition-transition-condition)

#### Boundaries

- A stage is not the same thing as an agent.
- A stage is not a mode of behavior.
- It is not the whole transformation process.

#### Questions

No open questions are currently recorded.

<a id="concept-stage-agent"></a>

### concept-stage-agent: Stage Agent

#### Definition

A specialized working unit assigned to perform a workflow stage through a role, prompts, modes, and artifact expectations.

#### Source in Idea

- Explicit in the current agent-first organization of the machine.
- Reflected in the agent cards for idea capture, concept extraction, and principle synthesis.

#### Role in the Idea

It is the operational performer of a stage. The agent executes a stage, but does not replace the workflow that gives the stage its sequence and boundary.

#### Related Concepts

- Other relations: [`concept-workflow-stage`](#concept-workflow-stage-workflow-stage)
- Other relations: [`concept-role`](#concept-role-role)
- Other relations: [`concept-mode`](#concept-mode-mode)

#### Boundaries

- A stage agent is not a free-form persona.
- It does not own the whole machine.
- It is not the workflow that orders stages.

#### Questions

No open questions are currently recorded.

<a id="concept-role"></a>

### concept-role: Role

#### Definition

A stable responsibility model behind an agent, defining its mission, working definition, rules, heuristics, and constraints.

#### Source in Idea

- Explicit in the role files used by the current workflow.
- Reflected in the separation between agent identity and stage responsibility.

#### Role in the Idea

It separates an agent's responsibility model from a particular mode or execution emphasis.

#### Related Concepts

- Other relations: [`concept-stage-agent`](#concept-stage-agent-stage-agent)
- Other relations: [`concept-mode`](#concept-mode-mode)
- Other relations: [`concept-boundary-discipline`](#concept-boundary-discipline-boundary-discipline)

#### Boundaries

- A role is not a prompt by itself.
- A role is not a user-selectable mode.
- A role is not the full workflow sequence.

#### Questions

No open questions are currently recorded.

<a id="concept-mode"></a>

### concept-mode: Mode

#### Definition

A user-selectable execution lens that changes how an agent performs a stage.

#### Source in Idea

- Explicit in the modes registry and mode descriptions.
- Reflected in the user-selectable mode policy for machine stages.

#### Role in the Idea

It lets the same stage be performed with different cognitive or service behaviors, such as brainstorming, explanation, validation, or editing.

#### Related Concepts

- Other relations: [`concept-stage-agent`](#concept-stage-agent-stage-agent)
- Other relations: [`concept-role`](#concept-role-role)
- Other relations: [`concept-workflow-stage`](#concept-workflow-stage-workflow-stage)

#### Boundaries

- A mode is not a role.
- A mode is not a stage.
- A mode is not the artifact produced by a stage.

#### Questions

No open questions are currently recorded.

<a id="concept-multilingual-artifact-form"></a>

### concept-multilingual-artifact-form: Multilingual Artifact Form

#### Definition

The ability of the machine to support one language for human-agent dialogue and another selected language for generated idea, concept, and principle artifacts.

#### Source in Idea

- Explicit in the root idea's emphasis on subjective fit and adaptation to the person using the machine.
- Reflected in the workflow requirement that agents ask for both interaction language and artifact language before producing final artifacts.

#### Role in the Idea

It allows the machine to preserve the living context of thought in the user's natural language while still producing artifacts in a language chosen for publication, collaboration, research, or later technical work.

#### Related Concepts

- Other relations: [`concept-human-clarification-loop`](#concept-human-clarification-loop-human-clarification-loop)
- Other relations: [`concept-artifact-contract`](#concept-artifact-contract-artifact-contract)
- Other relations: [`concept-idea-artifact`](#concept-idea-artifact-idea-artifact)
- Other relations: [`concept-traceability`](#concept-traceability-traceability)

#### Boundaries

- It is not a translation mode by itself.
- It does not require the dialogue language and artifact language to be the same.
- It does not allow agents to silently choose the artifact language without user confirmation.
- It does not replace source traceability; when language transformation affects meaning, uncertainty should remain visible.

#### Questions

No open questions are currently recorded.

<a id="concept-artifact-contract"></a>

### concept-artifact-contract: Artifact Contract

#### Definition

A structured expectation for a produced artifact, including its kind, source relation, publication role, and usefulness for later workflow stages.

#### Source in Idea

- Explicit in the artifact templates and workflow artifact contract sections.
- Reflected in the publication and linking behavior of current artifacts.

#### Role in the Idea

It makes stage outputs comparable, reusable, and discoverable from their source ideas.

#### Related Concepts

- Other relations: [`concept-workflow-stage`](#concept-workflow-stage-workflow-stage)
- Other relations: [`concept-traceability`](#concept-traceability-traceability)
- Other relations: [`concept-idea-artifact`](#concept-idea-artifact-idea-artifact)

#### Boundaries

- A template is an expression of an artifact contract, not the whole concept.
- An artifact contract is not an implementation task.
- It is not the content of the artifact itself.

#### Questions

No open questions are currently recorded.

<a id="concept-registry"></a>

### concept-registry: Registry

#### Definition

A lookup and routing artifact that makes workflows, agents, roles, and modes discoverable by stable identifiers and paths.

#### Source in Idea

- Explicit in the current registries for workflows, agents, roles, and modes.
- Supported by the directory-layout sub-idea.

#### Role in the Idea

Registries make the machine loadable by agents and understandable to humans. They expose where operational components live without being the full source definition of those components.

#### Related Concepts

- Other relations: [`concept-operational-workspace`](#concept-operational-workspace-operational-workspace)
- Other relations: [`concept-workflow-stage`](#concept-workflow-stage-workflow-stage)
- Other relations: [`concept-stage-agent`](#concept-stage-agent-stage-agent)

#### Boundaries

- A registry is not the source definition of the component.
- A registry is not the full workflow, agent, role, or mode content.
- A registry is not a project documentation essay.

#### Questions

No open questions are currently recorded.

<a id="concept-operational-workspace"></a>

### concept-operational-workspace: Operational Workspace

#### Definition

The working layer where workflows, registries, agents, roles, modes, prompts, templates, drafts, and other operational forms of the machine are organized.

#### Source in Idea

- Explicit in the directory-layout sub-idea.
- Reflected by the current `.double` tree.

#### Role in the Idea

It names the operational side of the machine apart from human-facing project documentation.

#### Related Concepts

- Other relations: [`concept-project-documentation-layer`](#concept-project-documentation-layer-project-documentation-layer)
- Other relations: [`concept-registry`](#concept-registry-registry)
- Other relations: [`concept-self-evolving-working-form`](#concept-self-evolving-working-form-self-evolving-working-form)

#### Boundaries

- It is not the project documentation layer.
- It is not a single concrete file or registry.
- It is not identical to the conceptual description of the machine.

#### Questions

No open questions are currently recorded.

<a id="concept-project-documentation-layer"></a>

### concept-project-documentation-layer: Project Documentation Layer

#### Definition

The human-readable documentation and conceptual development space where the reasons, origins, sub-ideas, and artifacts of an idea can be studied.

#### Source in Idea

- Explicit in the directory-layout sub-idea.
- Reflected by the root and sub-idea files under `ideas/machine-of-ideas/`.

#### Role in the Idea

It names the human-facing side of the machine where meaning, origin, and development history are described.

#### Related Concepts

- Other relations: [`concept-operational-workspace`](#concept-operational-workspace-operational-workspace)
- Other relations: [`concept-artifact-contract`](#concept-artifact-contract-artifact-contract)
- Other relations: [`concept-traceability`](#concept-traceability-traceability)

#### Boundaries

- It is not the operational workspace.
- It is not a registry, prompt catalog, or runtime surface.

#### Questions

No open questions are currently recorded.

<a id="concept-traceability"></a>

### concept-traceability: Traceability

#### Definition

The visible continuity between a later artifact, conclusion, or transition and the source idea or prior artifacts it depends on.

#### Source in Idea

- Explicit in the root idea's emphasis on preserving source context.
- Reflected in the templates, prompts, and roles for derived artifacts.

#### Role in the Idea

It names the continuity by which later work remains understandable as derived from earlier material.

#### Related Concepts

- Other relations: [`concept-artifact-contract`](#concept-artifact-contract-artifact-contract)
- Other relations: [`concept-boundary-discipline`](#concept-boundary-discipline-boundary-discipline)
- Other relations: [`concept-self-evolving-working-form`](#concept-self-evolving-working-form-self-evolving-working-form)

#### Boundaries

- It does not eliminate interpretation.
- It is not the artifact contract that expresses it.
- It is not the same thing as validation.

#### Questions

No open questions are currently recorded.

<a id="concept-boundary-discipline"></a>

### concept-boundary-discipline: Boundary Discipline

#### Definition

The separation between idea, concept, principle, requirement, task, design decision, architecture, and implementation.

#### Source in Idea

- Explicit in the root idea's separation between conceptual description and future implementation.
- Reflected in the role constraints and stage descriptions.

#### Role in the Idea

It names the conceptual distinction between layers of work, especially between understanding an idea and turning it into later solution forms.

#### Related Concepts

- Other relations: [`concept-workflow-stage`](#concept-workflow-stage-workflow-stage)
- Other relations: [`concept-role`](#concept-role-role)
- Other relations: [`concept-transition-condition`](#concept-transition-condition-transition-condition)

#### Boundaries

- Boundary discipline is not a workflow stage.
- It is not the same as principle synthesis.
- It is not a transition condition.

#### Questions

No open questions are currently recorded.

<a id="concept-transition-condition"></a>

### concept-transition-condition: Transition Condition

#### Definition

A condition that determines whether the current stage has produced an adequate artifact and can meaningfully move to another stage.

#### Source in Idea

- Explicit in the workflow description.
- Reflected in agent transition rules.

#### Role in the Idea

It turns the workflow from a loose sequence into a controlled process. A stage can be repeated, validated, or edited if its artifact is not ready.

#### Related Concepts

- Other relations: [`concept-workflow-stage`](#concept-workflow-stage-workflow-stage)
- Other relations: [`concept-artifact-contract`](#concept-artifact-contract-artifact-contract)
- Other relations: [`concept-boundary-discipline`](#concept-boundary-discipline-boundary-discipline)

#### Boundaries

- A transition condition is not a user story or acceptance test.
- It does not define the full quality model of the artifact.
- It is not the same as implementation validation.

#### Questions

No open questions are currently recorded.

<a id="concept-self-evolving-working-form"></a>

### concept-self-evolving-working-form: Self-Evolving Working Form

#### Definition

The machine's capacity to refine its own forms of work through interaction.

#### Source in Idea

- Explicit in `ideas/machine-of-ideas/machine-of-ideas.md`.
- Supported by the directory-layout sub-idea and current operational drafts.

#### Role in the Idea

It explains why the machine is not only a fixed template pipeline.

#### Related Concepts

- Other relations: [`concept-idea-machine`](#concept-idea-machine)
- Other relations: [`concept-operational-workspace`](#concept-operational-workspace-operational-workspace)
- Other relations: [`concept-traceability`](#concept-traceability-traceability)

#### Boundaries

- It is not a second machine or separate workflow.
- It is not identical to workflow versioning.
- It is not a single edit to one artifact.

#### Questions

No open questions are currently recorded.

<a id="concept-human-clarification-loop"></a>

### concept-human-clarification-loop: Human Clarification Loop

#### Definition

A stage-local dialogue process in which the machine asks open questions to the human and integrates the answers into the active artifact.

#### Source in Idea

- Explicit in the refinement of the machine's working files under `.double`.
- Supported by the artifact sections for open and resolved questions.
- Inferred from the machine's need to preserve human choice while developing artifacts.

#### Role in the Idea

It keeps the machine from treating missing context as something the agent should silently invent. Questions become part of the artifact's development, and human answers become source material for the current stage.

#### Related Concepts

- Other relations: [`concept-workflow-stage`](#concept-workflow-stage-workflow-stage)
- Other relations: [`concept-idea-artifact`](#concept-idea-artifact-idea-artifact)
- Other relations: [`concept-artifact-contract`](#concept-artifact-contract-artifact-contract)
- Other relations: [`concept-traceability`](#concept-traceability-traceability)

#### Boundaries

- It is not a separate workflow stage.
- It is not a generic chat transcript.
- It does not allow the current stage to silently become a later stage.
- It does not require every minor uncertainty to be asked immediately.

#### Questions

No open questions are currently recorded.

## 4. Terms and Non-Concepts

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

## 5. Candidate Inputs for Principle Synthesis

- The relation between `Idea Machine`, `Workflow Stage`, `Artifact Contract`, and `Transition Condition` may support principles for preserving meaningful, controlled transitions between stages.
- `Traceability`, `Boundary Discipline`, and `Human Clarification Loop` may support principles for preserving source continuity, preventing premature implementation, and keeping unresolved human choices visible.
- The relation between parent ideas and `Mini Idea` needs normative clarification so that local development remains lightweight without hiding parent-level impact.
- `Multilingual Artifact Form` may support a principle that interaction language and artifact language remain explicit user choices.
