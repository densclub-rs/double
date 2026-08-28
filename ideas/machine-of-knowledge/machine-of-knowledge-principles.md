---
id: machine-of-knowledge-principles
kind: principle-artifact
mindmap-plugin: basic
produced-by: machine-of-ideas/principle-synthesis-agent
interaction-language: Russian
artifact-language: English
publication-path: ideas/machine-of-knowledge/machine-of-knowledge-principles.md
derived-from:
  - machine-of-knowledge
  - machine-of-knowledge-concepts
---

# Principle Artifact: Machine of Knowledge

Idea: [Machine of Knowledge](./machine-of-knowledge.md#machine-of-knowledge)

## 1. Principle Synthesis Summary

Machine of Knowledge is governed by a minimal normative structure: extracted knowledge becomes an explicit artifact; every artifact exposes enough temporal state to distinguish current knowledge from stale knowledge; static and dynamic knowledge differ by the relative length of their validity periods; knowledge belonging to Double remains free of charge permanently; operating material remains distinct from produced knowledge; and the machine introduces no structure beyond what honest preservation requires. Together these principles protect explicitness, temporal clarity, universal free access, separation of concerns, and simplicity without prescribing a particular implementation.

## 2. Working Definition of Principle

A principle is a stable normative ground derived from an idea and its conceptual structure. It guides or constrains future decisions, but it is not yet a requirement, task, design decision, implementation step, or generic value statement.

## 3. Core Principles

<a id="principle-explicit-knowledge-artifact"></a>

### principle-explicit-knowledge-artifact: Preserve Extracted Knowledge as an Explicit Artifact

#### Statement

Knowledge extracted by Machine of Knowledge must be preserved as an explicit knowledge artifact rather than remaining only in its source material or extraction conversation.

#### Derived From

- Source concepts: [`concept-knowledge-extraction`](./machine-of-knowledge-concepts.md#concept-knowledge-extraction), [`concept-knowledge-artifact`](./machine-of-knowledge-concepts.md#concept-knowledge-artifact)
- Source relationship, boundary, or tension: knowledge extraction produces a persistent knowledge artifact; an artifact is not an unprocessed source or transcript.
- Source idea support: `Knowledge Extraction -> Knowledge Artifact` and the stated purpose to extract knowledge and save it as an artifact.
- Explicit or inferred: explicit

#### Rationale

The machine exists to make knowledge explicit and reusable. If the result remains only in a source or conversation, the defining movement of the machine has not been completed.

#### Implications Without Implementation

- Future decisions should preserve a visible result of every completed extraction.
- Artifact quality can be evaluated by whether the extracted knowledge is understandable independently of the extraction exchange.
- The principle does not prescribe the final knowledge template or extraction procedure.

#### Boundaries

- It does not require preservation of every piece of source material.
- It does not claim that unsupported interpretation becomes knowledge merely because it is written down.
- It does not define validation, review, or publication mechanics.

#### Anti-Patterns

- Treating a conversation transcript as the final knowledge result.
- Leaving extracted meaning only in temporary agent context.
- Copying source material without making the represented knowledge explicit.

#### Questions


<a id="principle-knowledge-temporality"></a>

### principle-knowledge-temporality: Preserve Knowledge According to Its Temporality

#### Statement

Every knowledge artifact must expose enough temporal state to determine whether its preserved value can still be treated as current or has become stale. Static and dynamic knowledge follow the same temporal model and differ by the relative length of their validity periods.

#### Derived From

- Source concepts: [`concept-knowledge-temporality`](./machine-of-knowledge-concepts.md#concept-knowledge-temporality), [`concept-static-knowledge`](./machine-of-knowledge-concepts.md#concept-static-knowledge), [`concept-dynamic-knowledge`](./machine-of-knowledge-concepts.md#concept-dynamic-knowledge), [`concept-knowledge-temporal-state`](./machine-of-knowledge-concepts.md#concept-knowledge-temporal-state)
- Source relationship, boundary, or tension: all knowledge may become stale; static and dynamic knowledge differ by time-to-live scale rather than by the presence or absence of temporal state.
- Source idea support: the explicit distinction between static and dynamic knowledge, refined by the clarification that freshness and staleness belong to all knowledge.
- Explicit or inferred: explicit

#### Rationale

No knowledge is absolutely timeless. Connecting a preserved value to its observation time and validity period makes its freshness interpretable without claiming that the value is guaranteed to remain true. A retrieval method may support revalidation when needed without requiring continuous or automatic refresh.

#### Implications Without Implementation

- Future artifact forms should expose the observation time and validity period needed to interpret the freshness of every preserved value.
- Future decisions should classify knowledge as static or dynamic according to the relative length of its validity period.
- A preserved value should remain interpretable after it becomes stale, while no longer being assumed current without revalidation.
- The principle constrains temporal completeness but does not prescribe refresh schedules or automation.

#### Boundaries

- Static does not mean timeless, universally true, or exempt from becoming stale; it denotes a comparatively long validity period.
- Dynamic denotes a comparatively short validity period and does not require automatic or continuous refresh.
- Time to live is a horizon for treating knowledge as current, not a guarantee that it remains true throughout that period.
- The principle does not define expiration, failure handling, data types, or retrieval technology.

#### Anti-Patterns

- Presenting any preserved value without enough temporal context to determine whether it should still be treated as current.
- Treating static knowledge as permanently valid or exempt from staleness.
- Classifying knowledge as static or dynamic without reference to the relative length of its validity period.
- Treating a stale value as current without revalidation.

#### Questions


<a id="principle-perpetually-free-double-knowledge"></a>

### principle-perpetually-free-double-knowledge: Keep Double Knowledge Free of Charge Permanently

#### Statement

All knowledge belonging to the Double project must remain available to everyone free of charge for the entire lifetime of the project.

#### Derived From

- Source concept: [`concept-perpetual-freedom-of-double-knowledge`](./machine-of-knowledge-concepts.md#concept-perpetual-freedom-of-double-knowledge)
- Source relationship, boundary, or tension: the freedom condition applies to both static and dynamic knowledge and is independent of age or commercial value; non-knowledge artifacts may follow different access models.
- Source idea support: the root idea's permanent free-of-charge condition, aligned with the foundational statement in [`Double.md`](../../Double.md).
- Explicit or inferred: explicit

#### Rationale

Permanent free access makes knowledge an enduring shared foundation of Double rather than a resource whose availability can later depend on payment, subscription, or membership. The condition is part of what qualifies knowledge as Double project knowledge.

#### Implications Without Implementation

- Future decisions about access and monetization must distinguish knowledge from other artifacts.
- Static and dynamic knowledge receive the same freedom guarantee.
- The principle can be used to reject later changes that place Double knowledge behind a payment or subscription barrier.

#### Boundaries

- The principle does not force unrelated private knowledge held by participants to become part of Double.
- It does not define copyright ownership, licensing terms, or rights to modify and redistribute knowledge.
- It does not require every non-knowledge artifact to be free of charge.

#### Anti-Patterns

- Charging for access to knowledge belonging to Double.
- Moving previously free Double knowledge behind a subscription or membership barrier.
- Relabeling knowledge as another artifact type only to permit paid access.

#### Questions


<a id="principle-operation-artifact-separation"></a>

### principle-operation-artifact-separation: Separate Machine Operation from Produced Knowledge

#### Statement

The operating material of Machine of Knowledge and the knowledge artifacts it produces must remain conceptually distinct working contexts.

#### Derived From

- Source concepts: [`concept-knowledge-artifact`](./machine-of-knowledge-concepts.md#concept-knowledge-artifact), with the supporting structural terms `.double/` and `knowledge/`
- Source relationship, boundary, or tension: the knowledge artifact is not a workflow, prompt, role, or other machine operating material.
- Source idea support: the machine's working directory belongs under `.double/`, while produced knowledge belongs under `knowledge/`.
- Explicit or inferred: inferred from an explicit structural distinction

#### Rationale

Separating how the machine operates from what it knows prevents internal process material from being confused with the machine's published result and keeps the simple purpose of each context visible.

#### Implications Without Implementation

- Future organization should preserve a recognizable boundary between operational and knowledge material.
- Knowledge artifacts may refer to their sources or machine context without becoming part of the machine's operating definition.
- The principle does not prescribe internal subdirectories or machine architecture.

#### Boundaries

- Separation does not prohibit links or traceability between operating material and knowledge artifacts.
- It does not imply that `.double/` material is unimportant or disposable.
- It does not define access or subscription rules for non-knowledge operating artifacts.

#### Anti-Patterns

- Publishing prompts or workflow state as though they were extracted knowledge.
- Hiding produced knowledge inside the machine's operational working material.
- Treating the `knowledge/` catalog as a storage location for every machine artifact.

#### Questions


<a id="principle-minimum-adequate-structure"></a>

### principle-minimum-adequate-structure: Use the Minimum Adequate Knowledge Structure

#### Statement

Machine of Knowledge should introduce only the structure required to extract, preserve, and honestly interpret a piece of knowledge.

#### Derived From

- Source concepts: [`concept-knowledge-artifact`](./machine-of-knowledge-concepts.md#concept-knowledge-artifact), [`concept-knowledge-temporality`](./machine-of-knowledge-concepts.md#concept-knowledge-temporality)
- Source relationship, boundary, or tension: every knowledge artifact needs temporal state, but only the information necessary to interpret freshness and support justified revalidation should be retained.
- Source idea support: repeated instruction that the machine remain simple and straightforward and avoid complex hierarchy, lifecycle, or processing architecture.
- Explicit or inferred: explicit

#### Rationale

The value of the machine comes from dependable knowledge preservation, not from structural complexity. Temporal state is necessary for honest interpretation of every knowledge artifact, while optional elements such as a retrieval method should be included only when they serve a concrete revalidation need.

#### Implications Without Implementation

- Future additions should be justified by a concrete preservation or interpretation need.
- Every knowledge artifact should carry the minimum temporal information needed to determine freshness or staleness.
- A long validity period should not cause static knowledge to lose its temporal state, and a short validity period should not automatically introduce unnecessary refresh machinery.
- The principle guides evaluation of future proposals without fixing a final schema or workflow.

#### Boundaries

- Simplicity does not justify omitting information necessary to interpret knowledge honestly.
- The principle does not prohibit later refinement when a demonstrated need appears.
- It does not specify a maximum number of fields, stages, or artifact types.

#### Anti-Patterns

- Introducing taxonomies, lifecycle stages, or hierarchy without a demonstrated knowledge need.
- Omitting temporal state from static knowledge merely because its validity period is long.
- Requiring an automated retrieval method for every knowledge artifact regardless of revalidation needs.
- Removing essential freshness context in the name of simplicity.

#### Questions


## 4. Trade-offs and Tensions

- **Simplicity versus temporal completeness:** all knowledge needs enough temporal state to expose freshness, but this does not justify adding retrieval or refresh machinery where observation time and validity period are sufficient.
- **Permanent free knowledge versus paid artifacts:** Double may monetize other artifacts, but future stages must preserve a clear boundary so that knowledge is not moved behind paid access through relabeling.
- **Operational separation versus traceability:** operating material and knowledge artifacts should remain distinct, while still allowing links that explain origin and maintenance.
- **Preserved usability versus current truth:** a stale value remains interpretable knowledge, but its preservation must not imply that it is still current beyond its validity period.

## 5. Candidate Inputs for Future Stages

- A future knowledge artifact template can be evaluated against explicitness, temporality, and minimum adequate structure.
- A future common temporal-state form can be evaluated by whether value, observation time, and validity period remain connected and understandable for both static and dynamic knowledge.
- Future static and dynamic classifications can be evaluated by whether they express relative validity-period length rather than the presence or absence of expiration.
- Future access and monetization proposals can be rejected when they charge for Double project knowledge, while still considering paid access for other artifacts.
- Future Machine of Knowledge workflow material can be evaluated by whether it stays within `.double/` and produces knowledge artifacts in the `knowledge/` project context.
- Validation can check that future structures implement these distinctions without introducing unsupported hierarchy or lifecycle concepts.

## 6. Rejected or Deferred Candidate Principles

- **Automatic refresh of knowledge** is deferred because temporal state does not require retrieval or revalidation to be automatic.
- **Universal open licensing** is deferred because free-of-charge access does not yet define modification, redistribution, copyright, or license terms.
- **Mandatory validation methodology** is deferred because the idea establishes extraction and preservation but does not define how knowledge claims are verified.
- **Detailed knowledge taxonomy** is rejected for the base machine because the source limits the initial distinction to static and dynamic knowledge and explicitly rejects unnecessary complexity.
