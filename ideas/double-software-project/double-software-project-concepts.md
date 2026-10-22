---
id: double-software-project-concepts
kind: concept-artifact
mindmap-plugin: basic
produced-by: machine-of-ideas/concept-extraction-agent
interaction-language: ru
artifact-language: en
publication-path: ideas/double-software-project/double-software-project-concepts.md
derived-from:
  - double-software-project
---

# Concept Artifact: Implementing Double as Software

Idea: [Implementing Double as Software](./double-software-project.md#double-software-project)

## 1. Conceptual Summary

The central pattern is continuity from accumulated human experience to executable work: machine modules make knowledge discoverable, context gives a realization meaning, and coordinated execution preserves its connection to intention. External environments provide access and execution locations while Double retains ownership of its domain processes.

A second pattern concerns the boundaries of that execution. Realization, access, authority, isolation, and evidence are distinct concepts. Delegation and autonomy change who performs or interprets work, while retaining questions of user control and information disclosure. Controlled evolution applies the same concern for deliberate change to the machines themselves.

This extraction is grounded in the source idea’s architectural hypothesis. It does not claim existing software capabilities. Concept names and grouping are analytical formulations; each card identifies the explicit source material it organizes. Implementation uncertainties remain deferred unless they expose an unresolved conceptual boundary.

## 2. Working Definition of Concept

A concept is a stable meaning unit describing an entity, relationship, process, distinction, tension, or interpretive frame that survives different implementations. It provides material for principle synthesis without itself being a rule, requirement, task, or design decision.

## 3. Core Concepts

<a id="concept-machine-module"></a>

### concept-machine-module: Machine Module

#### Definition

An installable implementation that owns a Double machine’s models, behavior, and knowledge of how to access its catalogs and registries.

#### Source in Idea

Explicit source material: sections 4.1, 4.3, 4.4 of [the source idea](./double-software-project.md#double-software-project). The concept label and grouping are analytical formulations of that material.

#### Role in the Idea

Connects the machine’s intellectual process to software ownership, discovery, and evolution.

#### Related Concepts

- [Controlled Process Evolution](#concept-controlled-process-evolution): Module behavior is the subject of controlled evolution.

#### Boundaries

A catalog of user artifacts is not the module itself. A module is not a separate declarative YAML description. Local adaptation does not establish how upstream acceptance works.

#### Questions

- [ ] How should a project-specific adaptation relate to the globally installed machine when both are available?

<a id="concept-domain-continuity"></a>

### concept-domain-continuity: Domain Continuity Across Environments

#### Definition

The persistence of Double’s domain meaning and accumulated work when the host agent, LLM provider, storage system, or execution location changes.

#### Source in Idea

Explicit source material: sections 3, 4.2, 4.8 of [the source idea](./double-software-project.md#double-software-project). The concept label and grouping are analytical formulations of that material.

#### Role in the Idea

Explains why Double owns its core logic and why external integrations remain adapters.

#### Related Concepts

- [Realization and Access Separation](#concept-realization-access): Access adapters expose work without taking ownership of its meaning.

#### Boundaries

Independence does not imply the absence of external dependencies. A stable interface does not by itself prove portability or select an internal architecture.

#### Questions

No unresolved conceptual questions identified in this pass.

<a id="concept-working-scope"></a>

### concept-working-scope: Working Scope and Knowledge Sources

#### Definition

The context in which artifacts and machine implementations are created, discovered, and used, together with the available local or shared sources of knowledge.

#### Source in Idea

Explicit source material: sections 4.1, 4.3, 4.4 of [the source idea](./double-software-project.md#double-software-project). The concept label and grouping are analytical formulations of that material.

#### Role in the Idea

Distinguishes project work from global availability and connects personal context to shared experience.

#### Related Concepts

- [Context Assembly Through Machine-Owned Discovery](#concept-context-assembly): Scope determines which sources can contribute to working context.

#### Boundaries

Working scope, publication audience, and permission to act are distinct. A public source is not automatically trusted; a project is not necessarily a public repository.

#### Questions

- [ ] When local and global sources contain competing versions or interpretations, how should the active working scope be determined?

<a id="concept-context-assembly"></a>

### concept-context-assembly: Context Assembly Through Machine-Owned Discovery

#### Definition

Finding related artifacts and realizations across entity types and assembling compact context through the access functions owned by machine modules.

#### Source in Idea

Explicit source material: sections 4.3, 4.5 of [the source idea](./double-software-project.md#double-software-project). The concept label and grouping are analytical formulations of that material.

#### Role in the Idea

Makes accumulated experience usable without requiring an external agent to know catalog layouts or choose an entity type first.

#### Related Concepts

- [Machine Module](#concept-machine-module): Modules supply access knowledge for discovery.

#### Boundaries

Search identifies candidate material; context assembly organizes relevant material. Neither proves that a realization applies or that an action is authorized. This concept does not choose a ranking method or registry schema.

#### Questions

No unresolved conceptual questions identified in this pass.

<a id="concept-intent-linked-realization"></a>

### concept-intent-linked-realization: Intent-Linked Realization

#### Definition

An executable way of carrying out a plan that retains its connection to human intention, expected results, conditions of use, and approval points.

#### Source in Idea

Explicit source material: sections 4.5, 7.3, 7.8 of [the source idea](./double-software-project.md#double-software-project). The concept label and grouping are analytical formulations of that material.

#### Role in the Idea

Connects understandable work to repeatable execution without equating a different execution form with a different path to the goal.

#### Related Concepts

- [Context Assembly Through Machine-Owned Discovery](#concept-context-assembly): Related goals and plans provide the context needed to interpret a realization.

#### Boundaries

A plan can have several realizations. A runtime module and a standalone script may realize the same plan. Availability, past success, and permission to use a realization are separate matters.

#### Questions

No unresolved conceptual questions identified in this pass.

<a id="concept-realization-access"></a>

### concept-realization-access: Realization and Access Separation

#### Definition

The distinction between the executable work and the mechanism through which an agent discovers or invokes that work.

#### Source in Idea

Explicit source material: sections 4.2, 4.5, 4.9 of [the source idea](./double-software-project.md#double-software-project). The concept label and grouping are analytical formulations of that material.

#### Role in the Idea

Explains how standalone scripts, native SKILL exports, and MCP access can coexist without moving core logic into host-specific plugins.

#### Related Concepts

- [Intent-Linked Realization](#concept-intent-linked-realization): Access makes a realization available without redefining its purpose.

#### Boundaries

SKILL and MCP are access or distribution mechanisms, not execution isolation. Independent execution does not remove security requirements. CLI/API details and packaging formats remain undecided.

#### Questions

No unresolved conceptual questions identified in this pass.

<a id="concept-bounded-autonomy"></a>

### concept-bounded-autonomy: Bounded Autonomy for Mastered Work

#### Definition

Reusing an applicable automatic realization without involving an external host agent, within the person’s agreed limits of control.

#### Source in Idea

Explicit source material: sections 4.5, 6, 8 of [the source idea](./double-software-project.md#double-software-project). The concept label and grouping are analytical formulations of that material.

#### Role in the Idea

Distinguishes reuse of accumulated experience from repeatedly asking AI to reconstruct a known way of working.

#### Related Concepts

- [Scoped and Revocable Action Authority](#concept-action-authority): Autonomy remains bounded by permissions and approvals.

#### Boundaries

Operating without a host agent does not mean operating without user control or without any possible LLM involvement elsewhere. Expected resource savings remain unmeasured.

#### Questions

- [ ] What makes a discovered realization an exact enough match to use without further host-agent interpretation?

<a id="concept-durable-coordination"></a>

### concept-durable-coordination: Durable Work Coordination

#### Definition

Maintaining understandable goal-execution state across pauses, restarts, approvals, retries, and related work, including parallel independent parts and dependent results.

#### Source in Idea

Explicit source material: sections 3, 4.6, 7.4 of [the source idea](./double-software-project.md#double-software-project). The concept label and grouping are analytical formulations of that material.

#### Role in the Idea

Explains continuity of execution over hours or days and the relationship between user decisions and ongoing work.

#### Related Concepts

- [Intent-Linked Realization](#concept-intent-linked-realization): Execution state belongs to work with a purpose and expected result.

#### Boundaries

A durable execution state is not the plan itself. Persistence alone does not define retry safety, result validity, or an execution engine. Parallel execution does not change the meaning of a path.

#### Questions

No unresolved conceptual questions identified in this pass.

<a id="concept-confidential-delegation"></a>

### concept-confidential-delegation: Confidential Delegation

#### Definition

Assigning part of a goal to a local or remote executor with only the information and authority needed for that part, while overall responsibility remains with Double Agent.

#### Source in Idea

Explicit source material: sections 4.7, 6, 7.5 of [the source idea](./double-software-project.md#double-software-project). The concept label and grouping are analytical formulations of that material.

#### Role in the Idea

Separates task meaning from execution location and limits disclosure of the user’s overall intent.

#### Related Concepts

- [Durable Work Coordination](#concept-durable-coordination): Delegated results return to the coordination of the overall goal.

#### Boundaries

Reduced context is not proof of confidentiality. Inputs, outputs, and metadata may reveal additional information. The concept does not select a transport or assume that a remote executor is trusted.

#### Questions

- [ ] What disclosure through task inputs, results, and metadata is acceptable for a delegated part of the work?

<a id="concept-action-authority"></a>

### concept-action-authority: Scoped and Revocable Action Authority

#### Definition

User-controlled permission to perform a particular external action, evaluated through policies and exposed to executable code as a temporary capability rather than credentials.

#### Source in Idea

Explicit source material: sections 4.9, 7.6 of [the source idea](./double-software-project.md#double-software-project). The concept label and grouping are analytical formulations of that material.

#### Role in the Idea

Separates possession of executable code from authority to cause effects and makes approval scope and revocation meaningful.

#### Related Concepts

- [Execution Isolation and Mediated Effects](#concept-execution-isolation): Isolation supports enforcement of the authorized action boundary.

#### Boundaries

Once, session, project, and global approval scopes describe permission, not ownership of code. Provenance is not authorization. The temporary lifetime of a capability is distinct from the duration of an approval.

#### Questions

No unresolved conceptual questions identified in this pass.

<a id="concept-execution-isolation"></a>

### concept-execution-isolation: Execution Isolation and Mediated Effects

#### Definition

The boundary that limits executable code’s resource access and prevents uncontrolled external effects, using complementary layers of isolation, runtime restrictions, capabilities, and policy.

#### Source in Idea

Explicit source material: sections 4.9, 6, 10 of [the source idea](./double-software-project.md#double-software-project). The concept label and grouping are analytical formulations of that material.

#### Role in the Idea

Makes limited authority meaningful even for untrusted or compromised executable code and for independently launched scripts.

#### Related Concepts

- [Scoped and Revocable Action Authority](#concept-action-authority): Authority defines allowed effects; isolation constrains the channels through which effects can occur.

#### Boundaries

Signatures, static checks, export formats, and approved provenance do not establish isolation. The source states a required protection property, not evidence that it is currently achieved. No sandbox product or enforcement architecture is selected.

#### Questions

- [ ] How is responsibility for enforcing isolation assigned when a realization runs independently of Double?

<a id="concept-action-evidence"></a>

### concept-action-evidence: Action Evidence and Explainability

#### Definition

Records and verifiable evidence connecting an action to its goal and version, run, stage, and reason for permission.

#### Source in Idea

Explicit source material: sections 3, 4.10, 8 of [the source idea](./double-software-project.md#double-software-project). The concept label and grouping are analytical formulations of that material.

#### Role in the Idea

Makes performed actions and authority decisions traceable for the person using shared goal programs.

#### Related Concepts

- [Scoped and Revocable Action Authority](#concept-action-authority): Evidence explains why an action was allowed.

#### Boundaries

A permission record alone is not proof that execution stayed within its boundaries or achieved the intended result. Evidence of an action is distinct from evidence of goal completion. A specific audit format is not selected.

#### Questions

No unresolved conceptual questions identified in this pass.

<a id="concept-controlled-process-evolution"></a>

### concept-controlled-process-evolution: Controlled Process Evolution

#### Definition

Changing Double’s own ways of working through proposal, validation, tests or simulation, approval, and a new version, with room for project adaptation and shared improvements.

#### Source in Idea

Explicit source material: sections 4.1, 4.10, 6 of [the source idea](./double-software-project.md#double-software-project). The concept label and grouping are analytical formulations of that material.

#### Role in the Idea

Connects extensibility to reproducible and deliberate change, including the possibility of Double developing itself.

#### Related Concepts

- [Machine Module](#concept-machine-module): Machine implementations carry the behavior that evolves.

#### Boundaries

Self-development is a possibility, not an existing capability or unrestricted permission to self-modify. Local experimentation, sharing, and acceptance into Double are distinct transitions.

#### Questions

No unresolved conceptual questions identified in this pass.

## 4. Terms and Non-Concepts

| Term or entity | Why it remains supporting material |
| --- | --- |
| Double Agent; user; host agent; executor | Actors with different responsibilities across the concepts; naming an actor alone does not explain the relevant relationship. |
| Idea, Knowledge, Goal, and Flow Machines | Named domains of machine behavior; this idea does not define each machine’s full conceptual model. |
| CLI, API, MCP, native SKILL, plugins | Interface and compatibility forms supporting domain continuity and access separation. |
| Search, context, catalog, registry | Operations or organizational structures supporting discovery and context assembly; no schema is selected. |
| Goal, path, plan, realization, result | Domain vocabulary retained in the intent-linked realization distinction; execution variants do not automatically create new paths. |
| Capability Broker; Policy Engine; sandbox | Proposed mechanisms or component labels supporting authority and isolation, rather than selected component designs. |
| Signature, hash, static check, provenance | Supporting checks and origin information; they neither authorize actions nor prove execution confinement. |
| Bash, Zsh, TypeScript, JavaScript, nono | Possible implementation technologies, not conceptual commitments or verified product choices. |
| GitHub, GitLab, public storage, cloud services | Examples of sharing infrastructure; commercial channels remain possible without defining a business model. |
| Bootstrap; installation; update | Lifecycle operations supporting module availability; the shell-to-CLI sequence is an illustrative installation arrangement. |
| Token use, energy costs, environmental impact | Expected consequences of reuse requiring measurement, not demonstrated properties. |

## 5. Candidate Inputs for Principle Synthesis

- Domain continuity, machine ownership, and access separation: where domain behavior belongs as environments change.
- Working scope and context assembly: the relationship between local adaptation, global availability, shared sources, and relevance.
- Intent-linked realization and bounded autonomy: preservation of purpose and result criteria when mastered work becomes executable and reusable.
- Durable coordination and confidential delegation: continuity of responsibility despite pauses, parallel work, and changes of execution location.
- Action authority, isolation, and evidence: complementary boundaries between origin, permission, containment, and demonstrated behavior.
- Controlled process evolution: the relationship between project experimentation, user approval, reproducibility, and accepted changes.

These are candidate relationships and tensions, not synthesized principles. Five concept-local questions remain in this pass: project/global implementation coexistence, source precedence, exact-match applicability, delegation disclosure, and independent isolation enforcement. The first two belong to separate conceptual boundaries even though both concern project/global coexistence. They warrant clarification before principle synthesis; no implementation format is selected by this artifact.
