---
id: machine-of-ideas-principles
kind: principle-artifact
status: release-candidate
produced-by: principle-synthesis-agent
workflow-version: 0.1.0
interaction-language: en
artifact-language: en
publication-path: ideas/machine-of-ideas/machine-of-ideas-principles.md
derived-from:
  - ideas/machine-of-ideas/machine-of-ideas.md
  - ideas/machine-of-ideas/machine-of-ideas-concepts.md
  - ideas/machine-of-ideas/principle-synthesis/principle-synthesis.md
  - ideas/machine-of-ideas/mini-idea/mini-idea.md
  - ideas/machine-of-ideas/styles/styles.md
---

# Principle Artifact: Machine of Ideas

## 1. Source Artifacts

- Source idea artifact: `ideas/machine-of-ideas/machine-of-ideas.md`
- Source concept artifact: `ideas/machine-of-ideas/machine-of-ideas-concepts.md`
- Source idea directory: `ideas/machine-of-ideas`
- Published as: `machine-of-ideas-principles.md`
- Synthesis mode: `strict-research`

## 2. Principle Synthesis Summary

The `Machine of Ideas` is guided by a small set of principles that protect the movement from living thought to structured artifacts. The central normative structure is: preserve the source context, transform ideas gradually, keep conceptual layers distinct, make every derived artifact traceable, use human clarification where the artifact needs it, support multilingual artifact formation, route mini ideas back through their parent artifacts, support exchangeable styles without overriding workflow contracts, and allow the machine to evolve without losing continuity.

These principles are not requirements, tasks, architecture, or implementation design. Within the machine-of-ideas workflow, formulated principles are the final stage of idea elaboration. They become the basis for forming specifications in other projects that implement SDD methodology, while the integration with those projects can itself be developed through this machine.

Each core principle has a stable explicit id and matching explicit anchor. These ids make principles usable in catalogs and referable from later SDD-oriented specifications, other idea artifacts, and integration work without depending on automatically generated heading anchors.

## 3. Working Definition of Principle

A principle is a stable normative ground derived from an idea and its conceptual structure.
It guides or constrains future decisions, but it is not yet a requirement, task, design decision, implementation step, or generic value statement.

## 4. Core Principles

<a id="principle-preserve-source-context"></a>

### Principle: Preserve Source Context

Principle id: `principle-preserve-source-context`

#### Statement

Every later artifact should keep a visible, usable connection to the original idea context from which it was derived.

#### Derived From

- Source concepts: [Idea Artifact](./machine-of-ideas-concepts.md#concept-idea-artifact), [Traceability](./machine-of-ideas-concepts.md#concept-traceability)
- Source relationship, boundary, or tension: raw thought must become structured without losing its living origin
- Source idea support: the root idea repeatedly emphasizes preservation of original thought, ambiguity, associations, gaps, and unresolved tensions
- Explicit or inferred: explicit

#### Rationale

The machine exists because raw thoughts can lose their context, prematurely solidify, or fragment into notes that are difficult to revisit. Preserving source context lets later stages develop the idea without replacing it with an attractive but detached interpretation.

#### Implications Without Implementation

- Future artifacts should expose where they came from.
- Later work should distinguish source material from interpretation.
- A future tool, workflow, or publication format should make source continuity easy to inspect.
- The principle does not prescribe a specific metadata schema, database, UI, or linking mechanism.

#### Boundaries

- This principle does not require quoting every source line.
- It does not forbid interpretation or synthesis.
- It should not turn every artifact into a full copy of its source.

#### Anti-Patterns

- Producing a polished artifact that no longer shows what idea it develops.
- Treating inferred conclusions as if they were directly present in the source.
- Removing ambiguity before it has been understood.

#### Questions

- How much source context is enough for different artifact types?
- Which source fragments, beyond concepts and principles, need stable ids?

<a id="principle-transform-gradually"></a>

### Principle: Transform Gradually

Principle id: `principle-transform-gradually`

#### Statement

The machine should move from raw expression to more formal layers through meaningful intermediate transformations rather than jumping directly to implementation, architecture, requirements, or tasks.

#### Derived From

- Source concepts: [Idea Machine](./machine-of-ideas-concepts.md#concept-idea-machine), [Workflow Stage](./machine-of-ideas-concepts.md#concept-workflow-stage), [Transition Condition](./machine-of-ideas-concepts.md#concept-transition-condition)
- Source relationship, boundary, or tension: living thought needs structure, but too much structure too early distorts it
- Source idea support: the root idea describes movement from raw material to idea artifact, concepts, principles, and later possible designs
- Explicit or inferred: explicit

#### Rationale

The value of the machine depends on protecting intermediate layers of understanding. If the process skips from an unfinished idea to a solution, it loses the conceptual and principled material needed to evaluate future decisions.

#### Implications Without Implementation

- Future workflows should make the current layer of work explicit.
- A later stage should use prior artifacts as input rather than silently overwriting them.
- Movement to another layer should happen because the current layer is adequate for that transition.
- This principle does not define a fixed final list of all possible stages.

#### Boundaries

- Gradual transformation is not bureaucratic delay.
- It does not mean every idea must pass through every possible stage.
- It does not prevent a user from naming future implementation possibilities as long as they remain marked as possibilities.

#### Anti-Patterns

- Turning an early idea into a task list before concepts are clear.
- Treating a workflow as a single prompt that produces all layers at once.
- Hiding the transition from interpretation to design.

#### Questions

- How should the final principle stage hand off to external specification work without becoming a specification itself?
- How should the machine handle ideas that genuinely need fast movement to action?

<a id="principle-keep-layers-distinct"></a>

### Principle: Keep Layers Distinct

Principle id: `principle-keep-layers-distinct`

#### Statement

Ideas, concepts, principles, requirements, design decisions, tasks, and implementation details should remain distinct layers of work, even when they are stored near each other or refer to the same source.

#### Derived From

- Source concepts: [Boundary Discipline](./machine-of-ideas-concepts.md#concept-boundary-discipline), [Artifact Contract](./machine-of-ideas-concepts.md#concept-artifact-contract), [Project Documentation Layer](./machine-of-ideas-concepts.md#concept-project-documentation-layer)
- Source relationship, boundary, or tension: the same idea can be described, interpreted, constrained, specified, and implemented, but these are different acts
- Source idea support: the root idea explicitly separates conceptual description from concrete implementation
- Explicit or inferred: explicit

#### Rationale

Without layer distinction, the machine collapses into ordinary note-taking or premature specification. Keeping layers distinct lets each artifact answer a different question: what is the idea, what concepts compose it, what principles should guide it, and what later solution might realize it.

#### Implications Without Implementation

- A concept artifact should describe meaning units, not implementation rules.
- A principle artifact should guide and constrain future decisions without becoming a spec.
- Future requirements and designs should be able to cite principles without rewriting them as tasks.
- This principle does not prescribe a specific folder hierarchy or file naming scheme by itself.

#### Boundaries

- Layer distinction does not require isolation.
- Cross-links between layers are expected.
- Some artifacts may mention future possibilities, but should mark their layer clearly.

#### Anti-Patterns

- Putting implementation decisions inside concept definitions.
- Describing principles as user stories or acceptance criteria.
- Treating a directory layout as the idea itself.

#### Questions

- Where is the practical boundary between a principle implication and a design decision?
- What notation should future artifacts use when they intentionally refer across layers?

<a id="principle-make-artifacts-contractual"></a>

### Principle: Make Artifacts Contractual

Principle id: `principle-make-artifacts-contractual`

#### Statement

Each produced artifact should have a clear contract: what kind of artifact it is, what sources it derives from, what role it plays, and what structure makes it usable by later stages.

#### Derived From

- Source concepts: [Idea Artifact](./machine-of-ideas-concepts.md#concept-idea-artifact), [Artifact Contract](./machine-of-ideas-concepts.md#concept-artifact-contract), [Workflow Stage](./machine-of-ideas-concepts.md#concept-workflow-stage)
- Source relationship, boundary, or tension: artifacts must remain readable to humans and usable by agents
- Source idea support: the root idea describes structured artifacts as stable traces of work that make later development possible
- Explicit or inferred: inferred from the machine's artifact-centered organization

#### Rationale

The machine depends on artifacts being more than loose notes. A contract gives later stages enough shape to reuse the artifact. Within the machine of ideas, strong formalization is allowed when it helps the person developing the idea.

#### Implications Without Implementation

- Future artifacts should state their type and derivation.
- Concept and principle artifacts should give each core concept or principle a stable explicit id.
- Later stages should be able to tell whether an artifact is adequate input.
- The person developing the idea may choose a stricter or lighter artifact contract for the current work.
- Templates, registries, metadata, or validation tools may express this principle, but none of those are mandated here.

#### Boundaries

- A contract is not the same as a full implementation schema.
- It may be strict, but it should not pretend that unresolved idea content has already been settled.
- It should not make artifacts unreadable to humans.

#### Anti-Patterns

- Producing artifacts with no visible type or source.
- Duplicating entire source artifacts instead of linking and interpreting them.
- Treating a template as more important than the idea it helps preserve.

#### Questions

- Which fields are useful enough for ordinary use and strong enough for validation in a given idea context?
- Should artifact contracts evolve independently from workflow versions?

<a id="principle-use-stable-addressable-units"></a>

### Principle: Use Stable Addressable Units

Principle id: `principle-use-stable-addressable-units`

#### Statement

Core concepts and principles should have stable explicit ids and matching anchors, and derived artifacts should reference those ids instead of relying on plain names or automatically generated Markdown heading anchors.

#### Derived From

- Source concepts: [Traceability](./machine-of-ideas-concepts.md#concept-traceability), [Artifact Contract](./machine-of-ideas-concepts.md#concept-artifact-contract), [Project Documentation Layer](./machine-of-ideas-concepts.md#concept-project-documentation-layer)
- Source relationship, boundary, or tension: derived artifacts should remain readable as text while also supporting precise navigation between layers
- Source idea support: the machine treats Markdown artifacts as stable traces of work that should remain usable by humans and AI
- Explicit or inferred: explicit after refinement of the principle and concept artifact contracts

#### Rationale

Concepts and principles need to survive title edits, catalog extraction, cross-artifact references, and use in later specifications. Explicit ids make a concept or principle addressable as a stable unit of meaning rather than as a by-product of its current heading text.

#### Implications Without Implementation

- Concept artifacts should assign each core concept a unique concept id and expose a matching anchor.
- Principle artifacts should assign each core principle a unique principle id and expose a matching anchor.
- Derived artifacts should use relative Markdown links to stable ids when grounding claims in concepts or principles.
- Plain names may remain in prose, maps, or explanatory text, but derivation fields and catalogs should prefer stable ids.
- Catalogs may index these ids, but the principle does not prescribe a specific catalog format.

#### Boundaries

- This principle applies to core concepts and principles, and to references that need stable grounding.
- It does not require every casual mention to become a link.
- It does not require duplicating concept or principle content inside catalogs or derived artifacts.
- It should not make the document unreadable with excessive linking.

#### Anti-Patterns

- Listing source concepts or principles only as code-formatted names when stable ids already exist.
- Depending on renderer-generated heading anchors as the only persistent reference mechanism.
- Renaming a concept or principle id casually when other artifacts may already cite it.
- Creating multiple ids for the same conceptual unit without recording why.

#### Questions

- What id-change policy should apply when a concept or principle is renamed, split, or merged?
- Should templates require stable id links in `Derived From` sections?

<a id="principle-separate-interaction-and-artifact-language"></a>

### Principle: Separate Interaction and Artifact Language

Principle id: `principle-separate-interaction-and-artifact-language`

#### Statement

Agents should offer the user a choice of language for communication and a separate choice of language for final artifacts, then record the selected artifact language in frontmatter.

#### Derived From

- Source concepts: [Multilingual Artifact Form](./machine-of-ideas-concepts.md#concept-multilingual-artifact-form), [Human Clarification Loop](./machine-of-ideas-concepts.md#concept-human-clarification-loop), [Artifact Contract](./machine-of-ideas-concepts.md#concept-artifact-contract), [Traceability](./machine-of-ideas-concepts.md#concept-traceability)
- Source relationship, boundary, or tension: thought may be clearest in one language while artifacts may need another language for collaboration, publication, or later technical work
- Source idea support: the machine prioritizes subjective fit and treats artifacts as reusable traces of work
- Explicit or inferred: explicit after multilingual workflow refinement

#### Rationale

The machine should not force a person to think in the language of the final artifact. Dialogue can remain close to the user's natural expression, while the artifact can be formulated in a language chosen for its future use. Making this choice explicit prevents accidental language drift and makes artifacts easier to reuse.

#### Implications Without Implementation

- At workflow entry, agents should ask which language to use for dialogue and which language to use for final artifacts.
- The two choices may be identical or different.
- Artifact templates should include `interaction-language` and `artifact-language` frontmatter fields.
- Agents should formulate idea, concept, and principle artifacts in the selected artifact language.
- If translation or reformulation introduces uncertainty, the agent should preserve that uncertainty as an open question or note.

#### Boundaries

- This principle does not require every source quote or source phrase to be translated.
- It does not require all previous artifacts in a chain to use the same language.
- It does not turn multilingual support into a separate workflow stage.
- It does not let the agent silently choose a language because the user happened to write in that language.

#### Anti-Patterns

- Producing an English artifact only because the agent defaults to English while the user expected Russian.
- Continuing the dialogue in a language that is uncomfortable for the user after the user selected another interaction language.
- Omitting language metadata from the artifact frontmatter.
- Translating ambiguous user language into a polished artifact while hiding uncertainty.

#### Questions

- Should the machine later support per-section artifact languages, or should one artifact have one primary language?
- How should older artifacts without language metadata be migrated?

<a id="principle-ask-and-integrate-open-questions"></a>

### Principle: Ask and Integrate Open Questions

Principle id: `principle-ask-and-integrate-open-questions`

#### Statement

At every workflow stage, the machine may ask open questions to the human when the active artifact needs clarification, and the answers should be integrated into that active artifact within the current stage.

#### Derived From

- Source concepts: [Human Clarification Loop](./machine-of-ideas-concepts.md#concept-human-clarification-loop), [Workflow Stage](./machine-of-ideas-concepts.md#concept-workflow-stage), [Artifact Contract](./machine-of-ideas-concepts.md#concept-artifact-contract), [Traceability](./machine-of-ideas-concepts.md#concept-traceability)
- Source relationship, boundary, or tension: agents need human clarification without inventing missing context or jumping to a later layer
- Source idea support: the machine is developed through iterative human-agent work on artifacts
- Explicit or inferred: explicit after refinement of the workflow and role contracts

#### Rationale

The machine works with unfinished thought. Some uncertainty should remain open, but some uncertainty belongs to the human and can be resolved through direct questions. If the answer stays only in conversation, the artifact loses the development step that made it clearer.

#### Implications Without Implementation

- Agents should ask open questions when the current artifact cannot be completed honestly from available material.
- Open questions should be recorded in the active artifact when they matter to the stage.
- Human answers should be treated as source material for the current artifact.
- Resolved questions may be recorded explicitly or integrated into the relevant artifact sections.
- This principle applies inside idea capture, concept extraction, principle synthesis, and later workflow stages.

#### Boundaries

- The loop does not require asking every possible question before continuing.
- It does not turn the artifact into a chat transcript.
- It does not permit the agent to leave the current stage boundary.
- It does not require resolving questions that are intentionally deferred or system-level.

#### Anti-Patterns

- Asking important questions in chat and failing to update the active artifact.
- Treating an unanswered question as if the agent can safely invent the answer.
- Resolving a concept question by silently writing a principle or specification.
- Deleting meaningful unresolved questions only to make an artifact look complete.

#### Questions

- How should artifacts distinguish answers integrated into content from answers kept as explicit resolved questions?
- Which questions are important enough to block transition to the next workflow stage?

<a id="principle-route-mini-ideas-through-parent-artifacts"></a>

### Principle: Route Mini-Ideas Through Parent Artifacts

Principle id: `principle-route-mini-ideas-through-parent-artifacts`

#### Statement

When the user works on a mini-idea or sub-idea, the machine should use a dedicated mini-idea template for capture, then route concept extraction and principle synthesis back into the corresponding parent idea's concept and principle artifacts.

#### Derived From

- Source concepts: [Mini Idea](./machine-of-ideas-concepts.md#concept-mini-idea), [Artifact Contract](./machine-of-ideas-concepts.md#concept-artifact-contract), [Traceability](./machine-of-ideas-concepts.md#concept-traceability), [Human Clarification Loop](./machine-of-ideas-concepts.md#concept-human-clarification-loop)
- Source relationship, boundary, or tension: small additions need their own source context, but parent ideas need coherent concept and principle surfaces
- Source idea support: `ideas/machine-of-ideas/mini-idea/mini-idea.md` states that `mini-idea` and `sub-idea` are synonyms, that a dedicated template should be used, and that later synthesis should update parent artifacts
- Explicit or inferred: explicit after mini-idea refinement

#### Rationale

Mini-ideas are valuable because they let the user develop a focused aspect without rebuilding the whole idea. If each mini-idea automatically produced separate concept and principle artifacts, the parent idea would fragment. If the mini-idea had no artifact, the local source context would disappear. Routing keeps both needs intact: the mini-idea preserves the focused discussion, while parent artifacts remain the conceptual and principled source of truth.

#### Implications Without Implementation

- The machine should automatically choose the mini-idea template when the user says they are working on a mini-idea or sub-idea.
- The terms `mini-idea` and `sub-idea` should be treated as synonyms.
- When the user says the mini-idea work is finished, concept and principle synthesis should use the parent idea's corresponding artifacts as integration targets.
- Parent concept and principle artifacts should cite the mini-idea when they incorporate material from it.
- Answers to mini-idea open questions may rewrite sections of the parent concept or principle artifacts when they change parent-level understanding.
- The machine should explicitly tell the user when a mini-idea answer or unresolved question affects a parent artifact, including which parent artifact or section changed.
- The main idea should not need special metadata that links it to mini-ideas; mini-ideas are treated as parts, additions, and detailed explanations of aspects of the whole.
- If the mini-idea develops a significant semantic mismatch with the parent idea, the machine should stop working on it as a mini-idea, alert the user, and propose turning it into a separate independent idea.
- Semantic mismatch should be judged through several signals: low semantic closeness between the parent idea artifact and the mini-idea artifact, more open questions in the mini-idea than in the parent idea, and the user's difficulty answering mini-idea questions when unresolved questions exceed the parent idea's unresolved question load.

#### Boundaries

- This principle does not require every mini-idea to change parent concepts or principles.
- It does not treat mini-ideas as normal candidates for promotion into independent ideas.
- It does not require parent-idea metadata for tracking mini-idea links.
- It does not make parent rewrites silent or implicit.

#### Anti-Patterns

- Creating separate peer concept and principle artifacts for every mini-idea by default.
- Treating `sub-idea` as a separate workflow type from `mini-idea` without user intent.
- Updating parent concept or principle artifacts from a mini-idea without citing the mini-idea.
- Letting a mini-idea answer change the parent idea while failing to tell the user what changed.
- Continuing to develop a mini-idea as part of the parent idea after it has materially diverged from the parent's meaning.

#### Questions

- How should these semantic mismatch signals be measured or compared in practice without turning them into rigid automatic decisions?

<a id="principle-stabilize-roles-vary-modes"></a>

### Principle: Stabilize Roles, Vary Modes

Principle id: `principle-stabilize-roles-vary-modes`

#### Statement

An agent's role should preserve the responsibility and boundary of a stage, while modes may vary the execution lens without changing what stage is being performed.

#### Derived From

- Source concepts: [Stage Agent](./machine-of-ideas-concepts.md#concept-stage-agent), [Role](./machine-of-ideas-concepts.md#concept-role), [Mode](./machine-of-ideas-concepts.md#concept-mode), [Workflow Stage](./machine-of-ideas-concepts.md#concept-workflow-stage)
- Source relationship, boundary, or tension: different execution lenses are useful, but stage identity must remain stable
- Source idea support: the machine is conceived as agents, roles, and modes activated at stages of an idea-management flow
- Explicit or inferred: inferred from the operational concept structure

#### Rationale

The machine needs flexibility without losing orientation. Modes let the same stage be exploratory, validating, explanatory, or editorial, while roles prevent the work from drifting into another layer.

#### Implications Without Implementation

- Future agents should make their stage responsibility explicit.
- Mode changes should affect behavior, emphasis, or rigor, not the underlying stage boundary.
- A future interface may expose mode switching, but the principle does not prescribe how.

#### Boundaries

- This principle does not require a separate software agent for every stage.
- It does not say roles and modes must be implemented as files.
- It does not prevent the same human or AI from performing multiple stages when the boundary is explicit.

#### Anti-Patterns

- A concept extraction pass that silently becomes principle synthesis.
- A validation mode that changes the artifact type instead of checking it.
- A role that contains the entire workflow and loses stage responsibility.

#### Questions

- When should a repeated behavior become a role, and when is it only a mode?
- How should mixed user requests be handled when they intentionally cross stages?

<a id="principle-separate-operational-machinery-from-project-understanding"></a>

### Principle: Separate Operational Machinery From Project Understanding

Principle id: `principle-separate-operational-machinery-from-project-understanding`

#### Statement

The machine should distinguish the human-readable project understanding of an idea from the operational machinery used to process it, while keeping the two connected.

#### Derived From

- Source concepts: [Operational Workspace](./machine-of-ideas-concepts.md#concept-operational-workspace), [Project Documentation Layer](./machine-of-ideas-concepts.md#concept-project-documentation-layer), [Registry](./machine-of-ideas-concepts.md#concept-registry)
- Source relationship, boundary, or tension: the system needs executable working forms without hiding the reasons and development history of the idea
- Source idea support: the root idea distinguishes conceptual description from concrete implementation and emphasizes readable Markdown artifacts
- Explicit or inferred: inferred from the directory-layout and concept artifacts

#### Rationale

The idea needs both a place where meaning is developed and a place where operational forms can be organized. If these collapse, project documentation becomes machinery, or machinery becomes invisible and detached from the idea it serves.

#### Implications Without Implementation

- Future implementations should keep operational structures inspectable.
- Project documentation should remain the visible place where an idea's development can be understood.
- Operational files, registries, prompts, templates, or tools should remain traceable to the idea layer.
- This principle does not mandate the current `.double` and `ideas/` layout as the only possible layout.

#### Boundaries

- The operational layer is not a hidden black box.
- The project layer is not a dumping ground for every prompt or runtime detail.
- The principle should survive a future reorganization of directories or storage formats.

#### Anti-Patterns

- Moving all reasoning into operational files where the idea becomes hard to read.
- Treating public idea documentation as an implementation directory.
- Breaking links between working machinery and the idea it develops.

#### Questions

- Which operational changes should be reflected back into project documentation?
- How should this separation work if future storage is not file-based?

<a id="principle-preserve-productive-tension"></a>

### Principle: Preserve Productive Tension

Principle id: `principle-preserve-productive-tension`

#### Statement

Unresolved tensions, ambiguity, and competing interpretations should be preserved when they are meaningful material for later thought, rather than prematurely smoothed into a single answer.

#### Derived From

- Source concepts: [Idea Artifact](./machine-of-ideas-concepts.md#concept-idea-artifact), [Boundary Discipline](./machine-of-ideas-concepts.md#concept-boundary-discipline), [Self-Evolving Working Form](./machine-of-ideas-concepts.md#concept-self-evolving-working-form)
- Source relationship, boundary, or tension: the machine must structure thought without destroying unfinishedness
- Source idea support: the root idea emphasizes living thought, ambiguity, gaps, and unresolved tensions
- Explicit or inferred: explicit

#### Rationale

The machine is meant to work with unfinished cognitive material. Some tensions are not defects; they are the material from which clearer concepts and principles emerge. Premature resolution can make an artifact look cleaner while making it less true to the idea.

#### Implications Without Implementation

- Future artifacts should be allowed to record open questions and unresolved tensions.
- Validation should not treat every ambiguity as a failure.
- Future stages may use tensions as input for research, proposal, design, or decision work.

#### Boundaries

- This principle does not romanticize confusion.
- It does not prevent clarification when enough context exists.
- It should not be used to avoid making decisions forever.

#### Anti-Patterns

- Deleting open questions because they make an artifact look unfinished.
- Collapsing two plausible interpretations into one without explanation.
- Treating tension as an error rather than as possible source material.

#### Questions

- How should future stages decide which tensions require resolution and which should remain open?

<a id="principle-evolve-traceably"></a>

### Principle: Evolve Traceably

Principle id: `principle-evolve-traceably`

#### Statement

The machine may change its own stages, roles, templates, contracts, and organization, but structural evolution should happen through the machine's own developed workflow and leave the full set of process artifacts behind.

#### Derived From

- Source concepts: [Self-Evolving Working Form](./machine-of-ideas-concepts.md#concept-self-evolving-working-form), [Traceability](./machine-of-ideas-concepts.md#concept-traceability), [Workflow Stage](./machine-of-ideas-concepts.md#concept-workflow-stage), [Artifact Contract](./machine-of-ideas-concepts.md#concept-artifact-contract)
- Source relationship, boundary, or tension: adaptability is necessary, but arbitrary mutation would destroy trust in the process
- Source idea support: the root idea states that the machine should refine its forms while preserving traceability to the original idea
- Explicit or inferred: explicit

#### Rationale

The machine is not a fixed doctrine. It should adapt to actual work with ideas. But because it is itself a thinking instrument, structural changes should be worked through as ideas inside the machine. The presence of the workflow's artifacts is the sign that the machine's evolution is mature rather than merely accidental.

#### Implications Without Implementation

- Future changes to workflow structure, artifact contracts, agent responsibilities, or transition conditions should be recorded.
- Structural evolution of the machine should pass through the developed machine-of-ideas workflow.
- Mature structural evolution should leave the expected artifacts of that workflow, including idea, concept, and principle artifacts where applicable.
- Versioning, changelogs, review artifacts, or registries may express this principle, but the principle does not prescribe one mechanism.
- The machine can improve itself without pretending its current form is final.

#### Boundaries

- Self-evolution is not arbitrary mutation.
- It does not make every small wording edit a structural change.
- It does not permit hidden changes to the rules by which artifacts are produced.
- It does not treat operational edits alone as mature structural evolution unless the corresponding idea-workflow artifacts exist.

#### Anti-Patterns

- Changing a stage boundary without leaving a trace.
- Updating templates in a way that makes prior artifacts unintelligible.
- Modifying the machine's structure directly without working the change through the machine's own idea workflow.
- Treating the current operational form as either sacred or disposable.

#### Questions

- What kinds of changes require a new workflow version?
- How should compatibility with older artifacts be handled?

<a id="principle-prefer-subjective-fit-over-methodological-purity"></a>

### Principle: Prefer Subjective Fit Over Methodological Purity

Principle id: `principle-prefer-subjective-fit-over-methodological-purity`

#### Statement

The machine should adapt established methods and scientific precedents to the subject who uses it, rather than enforcing a fixed doctrine or universal behavioral template.

#### Derived From

- Source concepts: [Idea Machine](./machine-of-ideas-concepts.md#concept-idea-machine), [Self-Evolving Working Form](./machine-of-ideas-concepts.md#concept-self-evolving-working-form), [Project Documentation Layer](./machine-of-ideas-concepts.md#concept-project-documentation-layer)
- Source relationship, boundary, or tension: the machine draws on existing methods but centers subjective knowledge and experience
- Source idea support: the root idea explicitly prioritizes subjective fit over methodological purity
- Explicit or inferred: explicit

#### Rationale

The machine is grounded in an individual and potentially collective practice of working with knowledge. Its value depends on fitting actual thinking, memory, forgetting, collaboration, and development patterns, not on reproducing any external methodology literally.

#### Implications Without Implementation

- Future designs should allow adaptation of questions, stages, and artifact forms.
- Scientific and methodological references should inform the machine without becoming unquestioned authority.
- The principle can guide evaluation of future features by asking whether they help the subject work better with ideas.
- The person developing an idea may choose a stricter degree of formalization when that fits the work.

#### Boundaries

- Subjective fit does not mean lack of discipline.
- It does not remove the need for traceability, artifact contracts, or stage boundaries.
- It should not be used to justify arbitrary inconsistency.

#### Anti-Patterns

- Copying GTD, scientific terminology, or any productivity system as doctrine.
- Designing the machine around generic best practices while ignoring the user's actual thinking practice.
- Treating personal adaptation as a reason to abandon continuity.

#### Questions

- How can the machine support multiple people without erasing individual working styles?
- Which parts of the workflow should be customizable, and which should remain stable?

<a id="principle-support-exchangeable-styles"></a>

### Principle: Support Exchangeable Styles Without Overriding Workflow Contracts

Principle id: `principle-support-exchangeable-styles`

#### Statement

The machine should allow people and groups to create, reuse, exchange, and adapt styles that fine-tune how the machine works with them, while preserving the core workflow contract of the `Machine of Ideas`.

#### Derived From

- Source concepts: [Style](./machine-of-ideas-concepts.md#concept-style), [Workflow Stage](./machine-of-ideas-concepts.md#concept-workflow-stage), [Mode](./machine-of-ideas-concepts.md#concept-mode), [Artifact Contract](./machine-of-ideas-concepts.md#concept-artifact-contract), [Self-Evolving Working Form](./machine-of-ideas-concepts.md#concept-self-evolving-working-form)
- Source relationship, boundary, or tension: the machine should fit individual and collective working preferences without turning every adaptation into a different workflow
- Source idea support: `ideas/machine-of-ideas/styles/styles.md` defines style as a fine-tuning layer that preserves workflow contracts, remains distinct from modes, is exchangeable, and is not an output format
- Explicit or inferred: explicit after style mini-idea refinement

#### Rationale

The machine should not force every person or group to work in the same tone, degree of formality, prompting style, or artifact expression. At the same time, if style changes could replace the workflow itself, the machine would lose the continuity that makes its artifacts comparable and traceable. Exchangeable styles preserve adaptation while keeping the underlying workflow recognizable.

#### Implications Without Implementation

- Future workflow runs may ask which style should shape subsequent work.
- A style may affect tone, formality, model temperature or associative freedom, prompts, templates, roles, agents, and artifact expression.
- A style must preserve the stage identity, transition logic, and workflow contract of the machine.
- Styles should be reusable and adaptable by other people or projects.
- A future mode or working path may help a person formulate their own style.
- Existing styles may serve as source material for new styles.
- Concrete storage, loading, validation, and exchange mechanisms for styles should be defined in later design or specification work.

#### Boundaries

- This principle does not define a directory layout or style registry.
- It does not define a technical inheritance mechanism for styles.
- It does not make output formats such as PDF, HTML, Markdown, or JSON into styles.
- It does not permit style to override the core workflow or replace workflow transition conditions.
- It does not replace modes; styles and modes are separate dimensions of workflow execution.

#### Anti-Patterns

- Treating a personal preference change as a forked workflow when the workflow contract remains the same.
- Letting a style silently change the stage sequence or transition conditions.
- Calling an output format a style.
- Making styles private untraceable edits that cannot be reused, compared, or adapted.
- Treating inheritance between styles as a settled technical mechanism before the implementation layer exists.

#### Questions

- What later design artifact should define the storage, loading, and validation rules for styles?
- What is the practical minimum style contract that allows safe exchange between projects?

## 5. Principle Map

```text
Preserve Source Context
  -> supports Transform Gradually
  -> supports Make Artifacts Contractual
  -> supports Evolve Traceably

Transform Gradually
  -> requires Keep Layers Distinct
  -> is executed through Stabilize Roles, Vary Modes
  -> depends on Preserve Productive Tension

Keep Layers Distinct
  -> protects concepts from becoming principles too early
  -> protects principles from becoming requirements or tasks
  -> clarifies the relation between project understanding and operational machinery

Use Stable Addressable Units
  -> makes concept and principle grounding directly navigable
  -> operationalizes Preserve Source Context inside Markdown artifacts
  -> supports catalogs of concepts and principles

Ask and Integrate Open Questions
  -> operationalizes Preserve Productive Tension through human clarification
  -> depends on Keep Layers Distinct
  -> strengthens Make Artifacts Contractual

Route Mini-Ideas Through Parent Artifacts
  -> depends on Preserve Source Context and Make Artifacts Contractual
  -> uses Ask and Integrate Open Questions when mini-idea answers affect parent artifacts
  -> protects Keep Layers Distinct by preventing unnecessary concept and principle fragmentation

Separate Interaction and Artifact Language
  -> extends Prefer Subjective Fit Over Methodological Purity
  -> strengthens Make Artifacts Contractual
  -> depends on Ask and Integrate Open Questions when language transformation creates uncertainty

Separate Operational Machinery From Project Understanding
  -> gives operational forms a place without replacing project documentation
  -> relies on Preserve Source Context and Make Artifacts Contractual

Prefer Subjective Fit Over Methodological Purity
  -> motivates Evolve Traceably
  -> limits rigid use of any fixed method

Support Exchangeable Styles Without Overriding Workflow Contracts
  -> extends Prefer Subjective Fit Over Methodological Purity
  -> depends on Stabilize Roles, Vary Modes
  -> must preserve Make Artifacts Contractual and Transform Gradually
```

## 6. Trade-offs and Tensions

- `Transform Gradually` can slow down action, while future work may sometimes need fast movement from idea to implementation.
- `Make Artifacts Contractual` provides stability, but too much contract pressure can damage `Preserve Productive Tension`.
- `Use Stable Addressable Units` improves precision and catalogability, but it creates responsibility for id stability and id-change policy.
- `Ask and Integrate Open Questions` improves grounding in human judgment, but too many questions can slow the current stage or overburden the user.
- `Route Mini-Ideas Through Parent Artifacts` keeps parent concepts and principles coherent, but it creates maintenance responsibility when small focused answers rewrite parent-level sections.
- `Separate Interaction and Artifact Language` supports subjective fit and collaboration, but it adds an explicit setup choice before artifact generation.
- `Stabilize Roles, Vary Modes` protects stage identity, but real user requests may intentionally mix stages.
- `Separate Operational Machinery From Project Understanding` improves readability, but it creates maintenance work to keep both layers connected.
- `Prefer Subjective Fit Over Methodological Purity` supports personal adaptation, but it must be balanced against traceability and reproducibility.
- `Support Exchangeable Styles Without Overriding Workflow Contracts` supports personal and group adaptation, but it must not turn style variation into hidden workflow forks.
- `Evolve Traceably` allows change, but future stages must decide how much change requires versioning.

## 7. Candidate Inputs for Future Stages

- Define criteria for when an artifact is ready to transition to another stage.
- Use formulated principles as the final idea-elaboration output that can ground later SDD-oriented specifications in other projects.
- Explore a stable reference model for linking ideas, concepts, principles, and later specs.
- Define an id-change policy for concepts and principles when they are renamed, split, merged, or deprecated.
- Explore catalog formats for indexing concept ids and principle ids across idea artifacts.
- Decide how workflow versioning should respond to changes in stages, roles, artifact contracts, and transition conditions.
- Consider how a multi-person Double practice can preserve subjective fit while supporting collective knowledge development.
- Define validation rules for `interaction-language` and `artifact-language` metadata in idea, concept, and principle artifacts.
- Explore language migration rules for older artifacts that do not yet declare their artifact language.
- Investigate validation methods that check traceability and layer boundaries without forcing premature closure.
- Define registry and routing rules for automatic mini-idea template selection and parent artifact integration.
- Define a later style design or specification artifact for style storage, loading, validation, exchange, and minimum compatibility contracts.
- Explore a future mode or working path that helps a person formulate their own style.

## 8. Rejected or Deferred Candidate Principles

- `Use Markdown Everywhere`: deferred because Markdown is currently assumed and valuable, but the principle should be readability and traceability rather than one fixed format.
- `Use Agents as the Only Execution Model`: rejected as too implementation-specific; the principle is role and stage discipline, not a mandatory runtime form.
- `Keep the Current Directory Layout`: rejected as too concrete; the principle is separation and connection between project understanding and operational machinery.
- `Treat Output Format as Style`: rejected because PDF, HTML, Markdown, JSON, and similar forms are artifact representation or export formats rather than styles of working through the machine.
- `Automate Validation`: deferred because validation is a plausible future stage or tool, but not yet a principle of the idea itself.
- `Publish Everything Publicly`: deferred because public artifacts are valuable, but the source idea does not require every working artifact to be public.
- `Use One Canonical Language`: rejected because the machine should support the user's thinking language and the artifact's intended-use language as separate choices.

## 9. Deferred System Notes

- How should Double represent conflicts between valid ideas, concepts, and principles?
  - Status: deferred.
  - Reason: this is a central question of the broader Double project, not a local question for this principle artifact.
  - Local decision: skip it at the current concept/principle elaboration level and revisit it after the machine of ideas is working.

## 10. Development Notes

- What future stage should follow principle synthesis in the base workflow?
  - Answer: none as a mandatory base-workflow stage. Formulated principles are the final stage of idea elaboration inside the machine of ideas.
  - Consequence: principles can serve as the basis for specifications in other projects that implement SDD methodology.
  - Boundary: integration with those projects is not folded directly into this principle artifact; it can be explored as a separate idea through the same machine.
- Which principles should receive stable ids if cross-reference becomes heavy?
  - Answer: every core principle should receive a stable explicit id immediately, not only after cross-reference becomes heavy.
  - Consequence: principle catalogs and later specifications can cite principles by stable ids from the start.
- Should future concept headings include explicit custom anchors to make links stable across title edits?
  - Answer: yes. Every core concept should receive a stable explicit id and matching anchor.
  - Consequence: concept references no longer depend on renderer-generated Markdown heading anchors.
- What is the minimum artifact contract that preserves usefulness without over-formalizing early thought?
  - Answer: excess formalization is acceptable within the machine of ideas when the person developing the idea chooses it.
  - Consequence: artifact contracts do not need to optimize for the lightest possible structure; they should remain human-readable and honest about unresolved content.
  - Boundary: the machine should not impose strictness as doctrine when a lighter form better fits the idea or the person working with it.
- How should mini-ideas or sub-ideas be routed?
  - Answer: `mini-idea` and `sub-idea` are synonyms in this model; both use the dedicated mini-idea template and route later concept and principle synthesis into the parent idea's artifacts.
  - Consequence: focused work can affect parent concepts and principles without creating unnecessary peer artifacts.
  - Boundary: parent artifact changes must be explicitly reported to the user.
- What metadata should record parent integration targets and affected parent sections?
  - Answer: no special metadata should be added to the main idea for links to mini-ideas.
  - Consequence: mini-ideas are treated as parts of the whole: additions and detailed explanations of aspects of the parent idea.
  - Boundary: parent-level changes still need to be explicitly reported to the user, but not encoded as special parent metadata.
- What exact promotion rule should turn a mini-idea into a fully independent idea?
  - Answer: a mini-idea is not normally a candidate for promotion into an independent idea.
  - Consequence: if a mini-idea significantly stops matching the meaning of the parent idea, work on it as a mini-idea should stop and the user should be asked whether to turn it into a separate independent idea.
  - Boundary: semantic mismatch is a stop-and-ask signal, not an automatic conversion.
- How should the machine judge that a semantic mismatch between a mini-idea and its parent idea is significant enough to stop and ask the user?
  - Answer: use a combination of signals: semantic closeness between parent and mini-idea artifacts, whether the mini-idea has more open questions than the parent idea, and whether the user has difficulty answering mini-idea questions while unresolved mini-idea questions outnumber unresolved parent questions.
  - Consequence: mismatch assessment combines meaning comparison with the practical state of clarification work.
  - Boundary: these criteria should guide attention and user escalation, not silently decide that the mini-idea has become independent.
- What practical mechanism should distinguish ordinary edits from structural evolution of the machine?
  - Answer: structural evolution must happen through the developed workflow of the machine of ideas itself.
  - Consequence: the expected artifacts of that process are the sign of mature evolution.
  - Boundary: ordinary edits may still happen locally, but they do not count as mature structural evolution of the machine unless supported by the workflow artifacts.
