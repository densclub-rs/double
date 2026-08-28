---
id: principle-synthesis
kind: idea-artifact
status: release-candidate
produced-by: machine-of-ideas/idea-capture-agent
interaction-language: en
artifact-language: en
derived-from:
  - ideas/machine-of-ideas/machine-of-ideas.md
  - ideas/machine-of-ideas/concept-extraction/concept-extraction.md
---

<a id="principle-synthesis"></a>

# Idea: Principle Synthesis

![Principle Synthesis](../../../_media/machine-of-ideas/principle-synthesis-illustration.png)

## 1. Summary

`Principle Synthesis` is a sub-idea within `Machine of Ideas` dedicated to the transition from a conceptual artifact to a set of principles. Its goal is to define what exactly counts as a principle in the machine of ideas, how to derive principles from an idea and its concepts, and how to avoid mixing principles with requirements, tasks, design decisions, or technical implementation.

## 2. Context / Origin

- The sub-idea arose as the third element of the base workflow `Getting Idea -> Concept Extraction -> Principle Synthesis`.
- The source was the need to complete the first full pass of the machine of ideas not with a specification, but with a normative layer that can guide future decisions.
- The stage draws on the `Idea Artifact` and the `Concept Artifact`, especially the conceptual map, boundaries, tensions, and candidate inputs for principle synthesis.
- Additional context is provided by the future possibility of using principles as input for proposals, designs, specs, or other stages, without tying the machine of ideas to a specific SDD process.

## 3. Problem / Motivation

- Without a separate synthesis stage, principles easily arise too early and get mixed with concepts.
- If principles are not grounded in the source idea, they become attractive but arbitrary declarations.
- If principles too quickly turn into requirements, the machine of ideas jumps from understanding to implementation.
- For future work, an artifact is needed that captures stable grounds for action: what should be preserved across different design and implementation options.

## 4. Raw Description

A principle in the machine of ideas should not be just a value statement, slogan, or wish. It should be a stable normative foundation derived from the idea and its conceptual structure. A principle says how something should be thought about, evaluated, or constrained in future decisions, but it does not yet specify which exact function, interface, architecture, or task must be implemented.

The `Principle Synthesis` stage accepts a polished idea and a set of concepts. Its task is to identify which relations, tensions, boundaries, and semantic nodes require normative anchoring. For example, if the concepts distinguish between exploratory and operational layers, a principle may establish the rule not to mix those layers in one artifact. If the conceptual map shows that the agent must preserve connection to the original thought, a principle may require traceability from the principle back to the concepts and the original idea.

A good principle should be testable with questions: from which concepts was it derived, which problem does it constrain, what does it forbid or guide, which solutions are compatible with it, and which violate it. At the same time, a principle should not become a checklist of tasks. It should survive multiple possible implementations and remain useful as a guide for later stages.

As a result, the stage should produce a `Principle Artifact`: a document defining a working principle concept, listing core principles, linking to source artifacts, providing rationale, trade-offs, anti-patterns, unresolved tensions, and principle-local questions.

The principle artifact also needs a stable publication location. For a source idea stored as `ideas/<...>/<idea-id>/<idea-id>.md`, the principle artifact should be published in the same directory as `ideas/<...>/<idea-id>/<idea-id>-principles.md`. The source idea's main file should include a `Development Artifacts` section with a link to that principles file, so the current development stage can be discovered from the idea itself.

## 5. Key Elements

- A working definition of principle
- The distinction between principle, concept, requirement, task, design decision, and value statement
- Synthesis of principles from conceptual relations, tensions, and boundaries
- Explicit traceability to the `Idea Artifact` and `Concept Artifact`
- Publication as `<idea-id>-principles.md` next to the source idea
- Link from the source idea's `Development Artifacts` section
- Core principles as stable normative foundations
- Rationale for each principle
- Implications without implementation
- Anti-patterns and failure modes
- Open questions and unresolved tensions

## 6. Assumptions

- One idea can generate multiple principles.
- Not every concept must become a principle.
- A principle may be derived not only from a single concept, but also from a relationship or tension between concepts.
- A principle should be abstract enough to survive different implementations, and concrete enough to constrain future choices.
- Principles should be verifiable through links to source artifacts.
- A published principle artifact belongs next to the idea it develops.
- A good principle can have trade-offs and does not have to resolve all tensions in the idea.

## 7. Examples / Scenarios

- From the `Idea Artifact` concept, a principle `Preserve Source Context` can be synthesized: later stages should maintain visible connection to the original user material.
- From the distinction between exploratory and operational layers, a principle `Separate Exploratory and Operational Artifacts` can be synthesized: ideas and operational system artifacts should be stored and read as different layers.
- From the concept `Agent-First Organization`, a principle `Agent as Workflow Unit` can be synthesized: the agent is the main executing unit of a step, but it does not replace the whole workflow.
- From the tension between free thinking and structured artifact, a principle `Delay Premature Formalization` can be synthesized: structure should help an idea emerge, not close it too early.

## 8. Signals of Value

- A completed first pass of the machine of ideas from raw input to principles.
- Principles provide future stages with stable criteria without becoming a premature specification.
- The risk of arbitrary design decisions detached from the original idea is reduced.
- Traceability from principles to concepts makes idea development verifiable and reviewable.
- The principle layer can become a bridge between knowledge work and future spec-driven development.

## 9. Boundaries / Non-Goals

- This is not the stage of writing requirements.
- This is not a proposal, design, implementation plan, or task breakdown.
- This is not a list of project values without connection to a specific idea.
- This is not a restatement of the conceptual artifact.
- This is not the final methodology for all future Double stages.

## 10. Related Ideas

- The root idea [machine-of-ideas](../machine-of-ideas.md)
- The sub-idea [concept-extraction](../concept-extraction/concept-extraction.md)
- The sub-idea [directory-layout](../directory-layout/directory-layout.md)
- The working template [.double/templates/machine-of-ideas/principle-template.md](../../../.double/templates/machine-of-ideas/principle-template.md)

## 12. Notes

A working definition:

> A principle is a stable normative foundation derived from an idea and its conceptual structure, which guides or constrains future solutions without yet being a requirement, task, design decision, or implementation.

A preliminary structure for a principle artifact:

```md
# Principle Artifact: <Title>

Idea: [<Root Idea Title>](./<root-idea-id>.md#<root-idea-id>)

## 1. Principle Synthesis Summary

## 2. Working Definition of Principle

## 3. Core Principles

<a id="<principle-id>"></a>

### <principle-id>: <Principle Name>

#### Statement

#### Derived From

#### Rationale

#### Implications Without Implementation

#### Boundaries

#### Anti-Patterns

#### Questions

## 4. Trade-offs and Tensions

## 5. Candidate Inputs for Future Stages

## 6. Rejected or Deferred Candidate Principles
```

This structure should become the basis for refining the working template `principle-template`.
