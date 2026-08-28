---
id: machine-of-knowledge
kind: idea-artifact
status: release-candidate
produced-by: machine-of-ideas/idea-capture-agent
interaction-language: English
artifact-language: English
derived-from:
  - user request on 2026-07-15
  - ../../Double.md
---

<a id="machine-of-knowledge"></a>

# Idea: Machine of Knowledge

## 1. Summary

Machine of Knowledge is a simple Double machine that helps extract knowledge and preserve it as an artifact. It follows the common concepts of Machine of Ideas while adding only the distinctions and metadata needed to work with static and dynamic knowledge. Knowledge belonging to the Double project remains available to everyone free of charge for the entire lifetime of the project.

## 2. Context / Origin

The idea appeared as a new machine in the Double ecosystem after Machine of Ideas. Machine of Ideas provides the common conceptual foundation, but knowledge needs a small specialized flow because some knowledge can be stored directly while other knowledge must be refreshed to remain current.

The machine should remain simple and straightforward. Its purpose is not to create a complex knowledge-management system, but to extract a piece of knowledge and save it in a dependable artifact form.

## 3. Problem / Motivation

Double needs a consistent way to turn available information, explanations, observations, and other source material into explicit knowledge artifacts. A single storage approach is insufficient because some knowledge remains useful as written, while other knowledge represents a value that changes over time.

Machine of Knowledge should make this distinction explicit without adding unnecessary structure. Static knowledge can be preserved directly. Dynamic knowledge must also retain enough information to obtain its current value and understand the freshness of its cached value.

## 4. Raw Description

Machine of Knowledge should obey the common concepts of Machine of Ideas and specialize them for knowledge. It is a simple kind of machine whose basic movement is:

`Knowledge Extraction -> Knowledge Artifact`

The project catalog for accumulated knowledge is `knowledge`. It follows the general [Double layout naming convention](../../Double.md#double-layout-naming-convention): names use `kebab-case`, each knowledge directory contains a Markdown artifact with the same name, and the directory and artifact together identify the knowledge item.

The machine's own working directory is placed under `.double/`. This working material supports the machine, while the `knowledge/` catalog contains the knowledge artifacts produced for the Double project.

The machine recognizes two kinds of knowledge:

- **Static knowledge** is preserved according to a knowledge artifact template.
- **Dynamic knowledge** represents knowledge whose current value may change. Its artifact keeps the method for obtaining the current value, a cached value, and the date of the last obtained value.

Knowledge accumulated within the Double project is always available to everyone free of charge, for all time that the project exists. This permanent condition applies to both static and dynamic knowledge. Other artifacts may be open, restricted, or available through a paid subscription.

The distinction is intentionally small. Machine of Knowledge should focus on extracting and preserving knowledge rather than introducing a complex hierarchy, lifecycle, or processing architecture.

## 5. Key Elements

- Machine of Knowledge
- knowledge extraction
- knowledge artifact
- `knowledge` project catalog
- `.double` working directory
- Double layout naming convention
- static knowledge
- dynamic knowledge
- knowledge artifact template
- method for obtaining a current value
- cached value
- date of the last value
- permanent free-of-charge access to Double project knowledge
- common concepts inherited from Machine of Ideas

## 6. Assumptions

- Knowledge can be extracted from available material and represented as a Markdown artifact.
- Machine of Ideas provides common concepts that Machine of Knowledge should reuse rather than redefine.
- The general Double naming rule is sufficient for organizing knowledge artifacts.
- The `knowledge` catalog is the published project location for knowledge artifacts.
- The machine's workflows, templates, prompts, roles, and other operating material belong under `.double/`.
- Static and dynamic knowledge are sufficient as the base distinction for the first version of the machine.
- Static knowledge can be kept according to one general knowledge artifact template.
- Dynamic knowledge needs retrieval and freshness metadata in addition to a cached value.
- The date of the last value makes the freshness of cached dynamic knowledge visible.
- Knowledge belonging to the Double project must remain available to everyone free of charge for the project's entire lifetime.
- Artifacts other than knowledge may use open, restricted, or paid-subscription access models.

## 7. Examples / Scenarios

### Static knowledge

A person provides an explanation of a stable project term. Machine of Knowledge extracts the meaning, context, and supporting information, then saves the result as a knowledge artifact according to the knowledge artifact template.

```text
knowledge/
  project-term/
    project-term.md
```

### Dynamic knowledge

A project needs to retain a value that changes over time. The knowledge artifact records how to obtain the current value, keeps the latest obtained value as a cache, and records the date when that value was obtained.

```text
knowledge/
  current-project-value/
    current-project-value.md
```

The artifact remains useful when live retrieval is unavailable because it contains the cached value, while its date makes clear how current that value is.

## 8. Signals of Value

- Knowledge becomes an explicit reusable artifact instead of remaining only in source material or conversation.
- A shared naming rule makes knowledge artifacts predictable within Double.
- Separating working material under `.double/` from produced artifacts under `knowledge/` keeps the machine understandable.
- The static and dynamic distinction handles changing knowledge without complicating static knowledge.
- Cached dynamic values remain inspectable even when their current value cannot be retrieved immediately.
- Reuse of Machine of Ideas concepts keeps Double machines conceptually consistent.
- Permanent free-of-charge access keeps Double project knowledge available as a shared foundation while allowing other artifacts to use different access models.

## 9. Open Questions


## 10. Boundaries / Non-Goals

- This artifact does not define a complex knowledge hierarchy or taxonomy.
- This artifact does not define the final Machine of Knowledge workflow.
- This artifact does not design software architecture or implementation.
- This artifact does not define the final knowledge artifact template.
- This artifact does not add knowledge kinds beyond the base static and dynamic distinction.
- This artifact does not redefine concepts already shared with Machine of Ideas.
- This artifact does not require every dynamic value to be retrieved automatically.
- The permanent free-of-charge condition applies to knowledge belonging to the Double project; it does not require unrelated private knowledge or every other artifact to be free of charge.

## 11. Related Ideas

- [Machine of Ideas](../machine-of-ideas/machine-of-ideas.md)
- [Double](../double/double.md)
- knowledge extraction
- knowledge artifacts
- personal knowledge management
- dynamic information and caching

## 12. Notes

Base project layout:

```text
double/
  .double/
    <machine-of-knowledge-working-material>/
  knowledge/
    knowledge.md
    knowledge-item/
      knowledge-item.md
```

This layout expresses the central separation: `.double/` contains the machine's working material, and `knowledge/` contains the artifacts created and maintained by the machine.

## 13. Development Artifacts

### 13.1 Concepts

Concept artifact: [Machine of Knowledge Concepts](./machine-of-knowledge-concepts.md)

| Concept | Summary |
| --- | --- |
| [`concept-knowledge-extraction: Knowledge Extraction`](./machine-of-knowledge-concepts.md#concept-knowledge-extraction) | The movement from available material to explicit knowledge. |
| [`concept-knowledge-artifact: Knowledge Artifact`](./machine-of-knowledge-concepts.md#concept-knowledge-artifact) | The persistent form in which extracted knowledge is preserved. |
| [`concept-knowledge-temporality: Knowledge Temporality`](./machine-of-knowledge-concepts.md#concept-knowledge-temporality) | The temporal character of knowledge and its classification by rate of change. |
| [`concept-static-knowledge: Static Knowledge`](./machine-of-knowledge-concepts.md#concept-static-knowledge) | Knowledge with a validity period long enough to be treated as unchanged during normal use. |
| [`concept-dynamic-knowledge: Dynamic Knowledge`](./machine-of-knowledge-concepts.md#concept-dynamic-knowledge) | Knowledge with a short validity period whose current and earlier values must be distinguished. |
| [`concept-knowledge-temporal-state: Knowledge Temporal State`](./machine-of-knowledge-concepts.md#concept-knowledge-temporal-state) | Observation time and validity period that make freshness or staleness explicit. |
| [`concept-perpetual-freedom-of-double-knowledge: Perpetual Freedom of Double Knowledge`](./machine-of-knowledge-concepts.md#concept-perpetual-freedom-of-double-knowledge) | Double knowledge remains freely accessible throughout the project's lifetime. |

### 13.2 Principles

Principle artifact: [Machine of Knowledge Principles](./machine-of-knowledge-principles.md)

| Principle | Statement | Related Concepts |
| --- | --- | --- |
| [Preserve Extracted Knowledge as an Explicit Artifact](./machine-of-knowledge-principles.md#principle-explicit-knowledge-artifact) | Preserve extracted knowledge as an explicit artifact rather than only in its source or conversation. | [Knowledge Extraction](./machine-of-knowledge-concepts.md#concept-knowledge-extraction), [Knowledge Artifact](./machine-of-knowledge-concepts.md#concept-knowledge-artifact) |
| [Preserve Knowledge According to Its Temporality](./machine-of-knowledge-principles.md#principle-knowledge-temporality) | Expose enough temporal state to distinguish current knowledge from stale knowledge. | [Knowledge Temporality](./machine-of-knowledge-concepts.md#concept-knowledge-temporality), [Static Knowledge](./machine-of-knowledge-concepts.md#concept-static-knowledge), [Dynamic Knowledge](./machine-of-knowledge-concepts.md#concept-dynamic-knowledge), [Knowledge Temporal State](./machine-of-knowledge-concepts.md#concept-knowledge-temporal-state) |
| [Keep Double Knowledge Free of Charge Permanently](./machine-of-knowledge-principles.md#principle-perpetually-free-double-knowledge) | Keep all Double knowledge available to everyone free of charge for the project's lifetime. | [Perpetual Freedom of Double Knowledge](./machine-of-knowledge-concepts.md#concept-perpetual-freedom-of-double-knowledge) |
| [Separate Machine Operation from Produced Knowledge](./machine-of-knowledge-principles.md#principle-operation-artifact-separation) | Keep machine operating material and produced knowledge as distinct contexts. | [Knowledge Artifact](./machine-of-knowledge-concepts.md#concept-knowledge-artifact) |
| [Use the Minimum Adequate Knowledge Structure](./machine-of-knowledge-principles.md#principle-minimum-adequate-structure) | Introduce only the structure required for honest extraction, preservation, and interpretation. | [Knowledge Artifact](./machine-of-knowledge-concepts.md#concept-knowledge-artifact), [Knowledge Temporality](./machine-of-knowledge-concepts.md#concept-knowledge-temporality) |
