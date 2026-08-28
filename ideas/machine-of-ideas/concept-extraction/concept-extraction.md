---
id: concept-extraction
kind: idea-artifact
status: release-candidate
produced-by: machine-of-ideas/idea-capture-agent
interaction-language: en
artifact-language: en
derived-from:
  - ideas/machine-of-ideas/machine-of-ideas.md
---

<a id="concept-extraction"></a>

# Idea: Concept Extraction

![Concept Extraction](../../../_media/machine-of-ideas/concept-extraction-illustration.png)

## 1. Summary

`Concept Extraction` is a sub-idea within `Machine of Ideas` dedicated to the movement from a developed idea to a conceptual artifact. It treats concepts not as isolated terms, but as stable units of meaning that reveal how an idea is internally organized.

The purpose of this stage is to clarify what counts as a concept in the machine of ideas, how a concept differs from an entity, term, principle, requirement, or design decision, and how a set of concepts can preserve the structure of an idea without turning it into implementation planning.

In the broader machine, concept extraction is the analytical layer between preserved thought and later normative work. It keeps the idea open enough to retain its tensions and ambiguities, but structured enough to support principle synthesis and later development.

## 2. Context / Origin

- This idea belongs to [machine-of-ideas](../machine-of-ideas.md) and develops the analytical layer between idea capture and principle synthesis.
- It grows from the need to make the step after an idea reproducible: the next artifact should expose the idea's conceptual structure, not merely summarize it in different words.
- It also grows from the distinction between public idea documentation and reusable working artifacts described in [directory-layout](../directory-layout/directory-layout.md): concept artifacts remain close to the source idea, while generalized templates or agent rules may later live in the shared working catalog.
- The broader context is the desire to keep later specification or development work traceable to stable meanings, without binding this stage to a particular implementation tool, runtime, or spec-driven development process.

## 3. Problem / Motivation

- After idea capture, the source artifact still contains narrative, context, examples, tensions, and possible directions. The next stage needs to make the internal meaning structure visible without flattening it into a summary.
- Without a concept layer, the transition from idea to principles depends too much on reader intuition: important distinctions may remain implicit, and later principles may be derived from the most obvious wording rather than from the idea's deeper structure.
- Concept extraction protects the machine from two premature reductions: treating an idea as a glossary of terms, or turning it too early into rules, requirements, and design decisions.
- A stable concept artifact gives principle synthesis a traceable base: later principles can be checked against the concepts, relations, boundaries, and unresolved questions that were extracted from the source idea.

## 4. Raw Description

A concept in the machine of ideas is not merely a word, topic, or named object. It is a stable meaning unit that helps explain how an idea is organized. A concept may describe an entity, relation, process, distinction, tension, or interpretive frame, but its value comes from the role it plays inside the idea rather than from its grammatical form.

This makes concept extraction different from both summary and principle synthesis. A summary compresses the idea into a shorter narrative. A principle begins to say what should guide later action. A concept artifact stays between these two movements: it makes the idea's structure more explicit while keeping the original ambiguity, tension, and interpretive space available for later work.

The concept formation stage should therefore decompose the source idea into stable semantic elements without cutting them away from the original `Idea Artifact`. After reading the conceptual artifact, one should be able to see which meanings carry the idea, which relations between them matter, where their boundaries are, and which questions remain unresolved before principles are synthesized.

The artifact should describe both individual concepts and the conceptual map they form together. An individual concept needs enough context to be understood and challenged: its name, definition, source in the idea, role, relations, boundaries, and open questions. In a concept artifact, open questions are identified as all unanswered questions in the `Questions` subsection of the corresponding concept. The concept artifact should not contain a general artifact-level `Open Questions` section, because concept-local questions preserve the narrower context needed to answer them well. The concept set, however, should not become a flat glossary. It should show how the idea holds together as a field of meanings.

Because concept extraction is part of the public development path of an idea, the concept artifact should be published beside the source idea rather than hidden in the working catalog. For a source idea stored as `ideas/<...>/<idea-id>/<idea-id>.md`, the corresponding concept artifact can be published as `ideas/<...>/<idea-id>/<idea-id>-concepts.md`. The source idea can then expose this relation through a `Development Artifacts` section, making the current development stage discoverable from the idea itself.

## 5. Key Elements

- working definition of concept as a stable meaning unit inside an idea
- preservation of the idea's conceptual structure without reducing it to a summary or glossary
- individual concept descriptions with definition, source, role, relations, boundaries, and open questions
- conceptual map showing how the extracted concepts hold together
- boundaries and anti-examples that prevent concepts from becoming too broad or too operational
- publication of the concept artifact beside the source idea
- visible link from the source idea to its concept artifact
- preparation of traceable material for later `Principle Synthesis`

## 6. Assumptions

- One source idea may contain several concepts, and their relations can matter as much as the individual concepts themselves.
- A concept may appear as a named thing, relation, process, distinction, tension, or interpretive frame.
- Not every important term or entity in the source idea deserves to become a concept.
- A concept should be stable enough to survive multiple implementation variants while still being concrete enough to support later principle synthesis.
- A conceptual artifact should remain readable as project documentation while also being structured enough for later machine-assisted processing.
- A published concept artifact belongs beside the idea it analyzes, while generalized templates, roles, prompts, or workflow rules may later belong in `.double`.

## 7. Examples / Scenarios

- From `Machine of Ideas`, `Idea Artifact` can be extracted as a concept: the stable public trace of an idea that gives later stages a grounded source.
- From the same source, `Workflow Stage` can be extracted as a concept: a bounded transformation step with its own input, output, responsibility, and transition conditions.
- From `Directory Layout`, `Publication Surface` can be extracted as a concept: the visible place where an idea exposes its derived artifacts and current development path.
- From the connection to spec-driven development, `Development-Ready Principle` can be extracted as a concept: a future constraint that is not yet a task, requirement, or design.

## 8. Signals of Value

- The transition from free idea description to normative principles becomes explicit and inspectable.
- Later principles can be traced back to concepts rather than justified only by general intuition about the idea.
- The system is less likely to move too early into requirements, design, or implementation planning.
- Concepts become reusable units of thought that can survive future changes in workflow, tooling, or publication format.
- The concept set can later support proposals, designs, specifications, or other artifacts of a chosen spec-driven development process.

## 9. Boundaries / Non-Goals

- `Concept Extraction` does not formulate principles; it prepares the meaning structure from which principles may later be synthesized.
- `Concept Extraction` does not define proposals, designs, specifications, or artifacts of a specific spec-driven development process.
- `Concept Extraction` does not define the final ontology of Double; it only clarifies one analytical layer of the `Machine of Ideas`.
- `Concept Extraction` does not describe a concrete software implementation of the machine of ideas.
- `Concept Extraction` does not turn the concept artifact into a glossary of every term used by the project.

## 10. Related Ideas

- The root idea [machine-of-ideas](../machine-of-ideas.md)
- The sub-idea [directory-layout](../directory-layout/directory-layout.md)

## 12. Notes

A working definition:

> A concept is a stable semantic unit of an idea that describes an important entity, relation, process, distinction, or interpretive frame, and serves as material for subsequent principle synthesis, while not yet being a rule, requirement, or design decision.

A preliminary structure for a conceptual artifact:

```md
# Concept Artifact: <Title>

Idea: [<Root Idea Title>](./<root-idea-id>.md#<root-idea-id>)

## 1. Conceptual Summary

## 2. Working Definition of Concept

## 3. Core Concepts

<a id="<concept-id>"></a>

### <concept-id>: <Concept Name>

#### Definition

#### Source in Idea

#### Role in the Idea

#### Related Concepts

#### Boundaries

#### Questions

## 4. Terms and Non-Concepts

## 5. Candidate Inputs for Principle Synthesis
```

The working template may expand this structure with metadata, extraction mode, and an explicit working definition of concept, but it should preserve these conceptual sections as the minimum shape of the artifact.
