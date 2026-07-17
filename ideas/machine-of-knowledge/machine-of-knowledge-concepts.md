---
id: machine-of-knowledge-concepts
kind: concept-artifact
mindmap-plugin: basic
status: release-candidate
produced-by: concept-extraction-agent
workflow-version: 0.2.0
interaction-language: Russian
artifact-language: English
publication-path: ideas/machine-of-knowledge/machine-of-knowledge-concepts.md
derived-from:
  - machine-of-knowledge
  - user clarification on 2026-07-15
  - user clarification on 2026-07-16
---

# Concept Artifact: Machine of Knowledge

## 1. Concept Index

- [`concept-knowledge-extraction: Knowledge Extraction`](#concept-knowledge-extraction-knowledge-extraction): The movement from available material to explicit knowledge.
- [`concept-knowledge-artifact: Knowledge Artifact`](#concept-knowledge-artifact-knowledge-artifact): The persistent form in which extracted knowledge is preserved.
- [`concept-knowledge-temporality: Knowledge Temporality`](#concept-knowledge-temporality-knowledge-temporality): The inherent temporal character of knowledge and its practical classification by rate of change.
  - [`concept-static-knowledge: Static Knowledge`](#concept-static-knowledge-static-knowledge): Knowledge whose meaning changes so slowly that it is deliberately treated as unchanged.
  - [`concept-dynamic-knowledge: Dynamic Knowledge`](#concept-dynamic-knowledge-dynamic-knowledge): Knowledge whose meaning changes often enough that its current value must be distinguished from earlier values.
  - [`concept-knowledge-temporal-state: Knowledge Temporal State`](#concept-knowledge-temporal-state-knowledge-temporal-state): The observation time and validity period that make the freshness or staleness of any knowledge explicit.
- [`concept-perpetual-freedom-of-double-knowledge: Perpetual Freedom of Double Knowledge`](#concept-perpetual-freedom-of-double-knowledge-perpetual-freedom-of-double-knowledge): Knowledge belonging to the Double project remains freely accessible to everyone throughout the project's entire lifetime.

## 2. Source Idea

- Source scope: `root idea`
- Source title: `Machine of Knowledge`
- Root idea artifact: [`machine-of-knowledge.md`](./machine-of-knowledge.md)
- Root idea directory: `ideas/machine-of-knowledge/`
- Relevant sub-ideas: none
- Published as: `machine-of-knowledge-concepts.md`
- Extraction mode: `strict-research`
- Interaction language: Russian
- Artifact language: English

## 3. Conceptual Summary

Machine of Knowledge is organized around a short semantic movement: material is interpreted as knowledge, and that knowledge is preserved as an artifact. All knowledge is temporally situated and therefore has a temporal state through which its freshness or staleness can be understood. Knowledge whose validity period is very long is classified as static, while knowledge with a short validity period is classified as dynamic. The difference is one of temporal scale rather than the presence or absence of expiration. Independently of this temporal classification, knowledge belonging to the Double project has a permanent freedom condition: it remains freely accessible to everyone for the entire lifetime of the project.

## 4. Working Definition of Concept

A concept is a stable meaning unit of an idea. It may describe an entity, relationship, process, distinction, tension, or interpretive frame. It is not yet a principle, requirement, task, or design decision.

## 5. Core Concepts

### concept-knowledge-extraction: Knowledge Extraction

#### Definition

Knowledge extraction is the interpretive movement through which available material becomes explicit knowledge suitable for preservation.

#### Source in Idea

- Explicit in the summary and in the movement `Knowledge Extraction -> Knowledge Artifact`.
- Supported by the motivation to turn information, explanations, observations, and other source material into explicit knowledge artifacts.

#### Role in the Idea

- Establishes the activity performed by Machine of Knowledge.
- Explains that the machine does more than store unprocessed material: it identifies knowledge that can be made explicit.
- Provides the semantic entry point for the resulting knowledge artifact.

#### Related Concepts

- Produces: [`concept-knowledge-artifact`](#concept-knowledge-artifact-knowledge-artifact): extracted knowledge is preserved in artifact form.
- Classified through: [`concept-knowledge-temporality`](#concept-knowledge-temporality-knowledge-temporality): the nature of the extracted knowledge determines how it is preserved.

#### Boundaries

- Extraction is not arbitrary invention of knowledge unsupported by available material.
- It is not the definition of a complex research, validation, or publication workflow.
- It does not imply that every source can be transformed into dependable knowledge without clarification.

#### Questions


### concept-knowledge-artifact: Knowledge Artifact

#### Definition

A knowledge artifact is the persistent, explicit form in which a piece of extracted knowledge is preserved within Double.

#### Source in Idea

- Explicit throughout the source idea as the result of knowledge extraction.
- Grounded in the stated purpose to extract knowledge and save it as an artifact.
- Associated in the source with Markdown storage and the general Double naming convention.

#### Role in the Idea

- Makes knowledge inspectable, reusable, and independent of the conversation or material from which it was extracted.
- Serves as the shared result form for both static and dynamic knowledge.
- Connects the specialized machine to Double's general artifact-based knowledge space.

#### Related Concepts

- Produced by: [`concept-knowledge-extraction`](#concept-knowledge-extraction-knowledge-extraction).
- Characterized by: [`concept-knowledge-temporality`](#concept-knowledge-temporality-knowledge-temporality).
- Carries: [`concept-knowledge-temporal-state`](#concept-knowledge-temporal-state-knowledge-temporal-state), because the represented knowledge may become stale regardless of whether it is classified as static or dynamic.

#### Boundaries

- A knowledge artifact is not the machine's workflow, prompt, role, or other operating material.
- It is not merely an unprocessed source or a transcript of extraction.
- This concept does not determine the final fields of the knowledge artifact template.

#### Questions


### concept-knowledge-temporality: Knowledge Temporality

#### Definition

Knowledge temporality is the inherent condition that every piece of knowledge exists in time, has a finite period for which it can be treated as current, and may eventually become stale. Machine of Knowledge classifies knowledge by the scale of this validity period: knowledge with a very long time to live is treated as static, while knowledge with a short time to live is treated as dynamic.

#### Source in Idea

- Explicit in the clarification that temporality is inseparable from knowledge, even when a piece of knowledge appears unchanged for a very long time.
- Explicit in the distinction between knowledge whose meaning changes very slowly and knowledge whose meaning changes frequently.
- Supported by the observation that a single storage approach is insufficient for knowledge with different rates of change.

#### Role in the Idea

- Establishes temporality as a universal property of knowledge rather than a property exclusive to dynamic knowledge.
- Provides the minimal practical classification needed by Machine of Knowledge.
- Explains that static and dynamic knowledge both have freshness-bearing state and differ by the duration of their validity periods.
- Keeps changing values from being mistaken for timeless statements.

#### Related Concepts

- Classifies: [`concept-knowledge-artifact`](#concept-knowledge-artifact-knowledge-artifact).
- Specializes into: [`concept-static-knowledge`](#concept-static-knowledge-static-knowledge) and [`concept-dynamic-knowledge`](#concept-dynamic-knowledge-dynamic-knowledge).
- Expressed through: [`concept-knowledge-temporal-state`](#concept-knowledge-temporal-state-knowledge-temporal-state), which makes freshness and staleness explicit for every knowledge artifact.
- Informs: [`concept-knowledge-extraction`](#concept-knowledge-extraction-knowledge-extraction): extraction must recognize whether the resulting knowledge is static or dynamic.

#### Boundaries

- No knowledge is timeless in an absolute sense; `static` is a deliberate practical treatment of very slowly changing knowledge.
- The classification concerns the expected validity period of the knowledge, not merely the passage of time since an artifact was created.
- `Static` and `dynamic` are relative temporal classes rather than a distinction between knowledge with and without expiration.
- The distinction does not introduce further knowledge types, taxonomies, or lifecycle stages.

#### Questions


### concept-static-knowledge: Static Knowledge

#### Definition

Static knowledge is knowledge with a validity period long enough that Machine of Knowledge deliberately treats it as unchanged during normal use, even though it still has temporal state and may eventually become stale.

#### Source in Idea

- Explicit in the clarification that some knowledge changes so slowly that it can be considered unchanged for practical purposes.
- Refines the earlier use of `static` by grounding it in a very low rate of meaningful change rather than in absolute timelessness.

#### Role in the Idea

- Provides the practical exception through which temporally situated knowledge may be preserved and used as if it were unchanged.
- Allows a knowledge artifact to remain usable as written for a long validity period, which may span years.
- Prevents the static category from implying that knowledge is eternally or universally true.

#### Related Concepts

- Specializes: [`concept-knowledge-temporality`](#concept-knowledge-temporality-knowledge-temporality).
- Characterizes: [`concept-knowledge-artifact`](#concept-knowledge-artifact-knowledge-artifact) when its preserved meaning changes only over a very long period.
- Contrasts with: [`concept-dynamic-knowledge`](#concept-dynamic-knowledge-dynamic-knowledge), whose shorter validity period makes its temporal state operationally significant sooner.
- Has: [`concept-knowledge-temporal-state`](#concept-knowledge-temporal-state-knowledge-temporal-state) with a comparatively long validity period.

#### Boundaries

- Static does not mean timeless, universally true, infallible, or impossible to revise.
- A static knowledge artifact may still be corrected when it is inaccurate; correction is distinct from the expected rate at which the represented knowledge changes.
- Static knowledge is not exempt from freshness and staleness; its time to live is simply comparatively large.

#### Questions


### concept-dynamic-knowledge: Dynamic Knowledge

#### Definition

Dynamic knowledge is knowledge with a short validity period, such as days or minutes, whose preserved value must be understood in relation to when it was observed and when it becomes stale.

#### Source in Idea

- Explicit in the clarification that the meaning of dynamic knowledge changes often.
- Supported by the source requirement to preserve a method for obtaining its current value, a cached value, and the date associated with that value.

#### Role in the Idea

- Identifies knowledge for which freshness affects meaning and usability.
- Explains why preserving content alone is insufficient for frequently changing knowledge.
- Identifies the knowledge category whose short time to live makes freshness checks frequent and operationally visible.

#### Related Concepts

- Specializes: [`concept-knowledge-temporality`](#concept-knowledge-temporality-knowledge-temporality).
- Contrasts with: [`concept-static-knowledge`](#concept-static-knowledge-static-knowledge), which is deliberately treated as unchanged.
- Has: [`concept-knowledge-temporal-state`](#concept-knowledge-temporal-state-knowledge-temporal-state) with a comparatively short validity period.

#### Boundaries

- Dynamic does not mean that change is continuous, predictable, or automatic.
- Dynamic does not require retrieval to be automated or continuously performed.
- A frequently edited artifact is not necessarily dynamic knowledge; the classification concerns change in the meaning of the represented knowledge.

#### Questions


### concept-knowledge-temporal-state: Knowledge Temporal State

#### Definition

Knowledge temporal state is the freshness-bearing representation shared by all knowledge. It connects a value and its observation time with a validity period, or time to live, so that the value can be understood as current or stale; it may also include a method for obtaining a refreshed value.

#### Source in Idea

- Explicit in the clarification that freshness and staleness belong to all knowledge rather than only to dynamic knowledge.
- Explicitly framed as a time-to-live model: static knowledge may remain valid for years, while dynamic knowledge may remain valid for days or minutes.
- Extends the earlier requirement that changing knowledge retain its cached value, observation date, and method for obtaining a current value.

#### Role in the Idea

- Makes the current or stale status of any preserved knowledge explicit.
- Provides a common temporal model for both static and dynamic knowledge.
- Connects a stored value to its validity horizon and, when available, to a way of refreshing what it represents.

#### Related Concepts

- Expresses: [`concept-knowledge-temporality`](#concept-knowledge-temporality-knowledge-temporality) for an individual piece of knowledge.
- Applies to: [`concept-knowledge-artifact`](#concept-knowledge-artifact-knowledge-artifact) regardless of whether it represents static or dynamic knowledge.
- Differentiates: [`concept-static-knowledge`](#concept-static-knowledge-static-knowledge) and [`concept-dynamic-knowledge`](#concept-dynamic-knowledge-dynamic-knowledge) through the relative length of their validity periods.
- Supports: [`concept-knowledge-extraction`](#concept-knowledge-extraction-knowledge-extraction) by keeping extracted knowledge temporally interpretable after initial capture.

#### Boundaries

- Time to live is a validity horizon for treating knowledge as current, not a guarantee that the knowledge remains true throughout that period.
- A stale value does not cease to be knowledge; its temporal state indicates that it should not be assumed current without revalidation.
- A retrieval method describes how a current value may be obtained but is not required to be automated or continuously executed.
- The concept does not define refresh schedules, expiration rules, failure handling, or implementation technology.

#### Questions


### concept-perpetual-freedom-of-double-knowledge: Perpetual Freedom of Double Knowledge

#### Definition

Perpetual freedom of Double knowledge is the mandatory and irreversible condition that knowledge belonging to the Double project remains freely accessible to everyone, without a payment or subscription barrier, throughout the entire lifetime of the project.

#### Source in Idea

- Explicitly established by the user during concept extraction as a mandatory concept and strict requirement, then integrated into the root idea artifact and `Double.md`.
- The permanence of the condition is explicit: it applies for all time that the Double project exists.

#### Role in the Idea

- Establishes freedom of access as an essential property of Double project knowledge rather than an optional publication choice.
- Prevents knowledge extracted and preserved for the Double project from later becoming paid, subscription-only, or access-restricted.
- Applies equally to static and dynamic knowledge artifacts.

#### Related Concepts

- Constrains: [`concept-knowledge-artifact`](#concept-knowledge-artifact-knowledge-artifact): a knowledge artifact that belongs to the Double project must remain freely accessible.
- Applies across: [`concept-knowledge-temporality`](#concept-knowledge-temporality-knowledge-temporality): neither static nor dynamic status changes the freedom condition.
- Aligned with project framing: [`Double.md`](../../Double.md) states that knowledge accumulated within Double is always available to everyone free of charge, while other artifacts may be restricted or available through a paid subscription.

#### Boundaries

- The concept applies specifically to knowledge belonging to the Double project; it does not claim ownership of or impose publication on unrelated private knowledge held by participants.
- Free access does not by itself define a software license, copyright assignment, or permission to modify and redistribute the material.
- The condition is not temporary, discretionary, or dependent on the type, age, or commercial value of the knowledge.
- Charging for access to Double project knowledge is outside this concept, including payment, subscription, or member-only access barriers.

#### Questions


## 6. Terms and Non-Concepts

- **Machine of Knowledge** is the name of the machine that performs the extraction and preservation movement, not a separate conceptual unit inside that movement.
- **Machine of Ideas** is the inherited conceptual foundation and related machine. Its common concepts are referenced rather than re-extracted here.
- **`knowledge/`** is the project catalog label and publication context for knowledge artifacts. It is a structural placement term rather than a core meaning unit.
- **`.double/`** is the working-directory label for machine operating material. It expresses the separation between operational material and produced artifacts but is not itself a concept.
- **Double layout naming convention** is an existing project convention applied to knowledge artifacts, not a concept introduced by Machine of Knowledge.
- **knowledge artifact template** is a future artifact-form definition. The idea establishes its need but does not yet define its fields.
- **Markdown** is the expected representation format inherited from Double, not a conceptual distinction specific to this idea.

## 7. Candidate Inputs for Principle Synthesis

- The relationship between knowledge extraction and knowledge artifacts may support a principle that extracted knowledge should become explicit and persistent.
- The inherent temporality of knowledge may support a principle that no knowledge should be understood as absolutely timeless.
- The distinction between static and dynamic knowledge may support a principle that their classification should reflect the relative length of their validity periods.
- Static knowledge may support a principle that knowledge with a very long time to live can be deliberately treated as unchanged without denying its freshness state or eventual staleness.
- Knowledge temporal state may support a principle that every knowledge artifact should expose enough temporal information to determine whether its value is current or stale.
- Perpetual freedom of Double knowledge requires a strict principle that all knowledge belonging to the Double project remains freely accessible to everyone for the entire lifetime of the project.
- The distinction between `.double/` working material and `knowledge/` artifacts may support a principle separating machine operation from the knowledge it produces.
- The explicit simplicity boundary may support a principle of using only the minimum structure required to preserve a piece of knowledge honestly.
