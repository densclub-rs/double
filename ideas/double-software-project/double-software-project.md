---
id: double-software-project
kind: idea-artifact
status: release-candidate
produced-by: machine-of-ideas/idea-capture-agent
interaction-language: ru
artifact-language: en
derived-from:
  - user-provided architectural scenarios on 2026-10-01
  - user clarification on external automated realizations on 2026-10-05
  - user clarification on machine catalogs and access functions on 2026-10-05
---

<a id="double-software-project"></a>

# Idea: Implementing Double as Software

## 1. Short Description

The idea covers implementing the Double project as software. Double is envisioned as an extensible software platform that brings together different ways of working with ideas, knowledge, goals, and processes that emerge from the interaction between artificial intelligence and people. It gives external AI agents a common interface to the accumulated context of ideas, knowledge, and ways to achieve goals: from clarifying intentions to carrying out specific actions while preserving state. The platform's scope includes managing its own knowledge processes, executing trusted plans for previously defined goals, controlling security and permissions, and keeping actions explainable and reproducible.

## 2. Context and Origins

The idea grew out of reflections on how to turn the knowledge accumulated in the project's ideas into a software product that helps people make sense of their personal knowledge and put it to use more easily and quickly. It connects the already discussed machines of ideas, goals, and knowledge with future software interfaces, integration with popular AI agents and LLM providers, and practical ways for people to use their accumulated knowledge on mobile devices and personal computers.

In the [overall vision of Double](../../Double.md), a digital twin represents a person's knowledge, skills, and capabilities in their interaction with the digital world. This independent, overarching idea describes implementing all of Double as software and clarifies its boundaries: what belongs to Double itself, what stays with external AI platforms, and how intellectual work turns into automated actions or actions that run automatically.

What follows is an architectural hypothesis for developing the idea, rather than a description of existing capabilities or an approved technical specification.

## 3. Problem and Motivation

Work with ideas, knowledge, and goals should remain continuous when switching AI providers or user environments. If the core logic lives in separate plugins for Claude, Codex, or other systems, Double's development becomes dependent on those integrations, and the accumulated context has to be recreated each time.

There is also a gap between a plan a person can understand and a program that can reliably carry it out over hours or days. This kind of execution needs persistent state, waiting for a person, parallel work, subgoals, and recovery from failures.

Shared goal programs may perform external actions and handle sensitive data. Their ability to run therefore needs to come with security, limited permissions, approval management, and an explanation of why a particular action was allowed.

## 4. Initial Description

### 4.1. The Double Platform

Double brings together at least the Idea Machine, Knowledge Machine, Goal Machine, and Double Agent.

The machines' models, code, and behavior belong to the Double project. A separate declarative YAML contract for each machine is not needed: installing or updating a machine means updating the implementation of a Double module. The platform should support installing and updating these implementations both globally and within a particular user project. For example, in a given project, a user may use just one specific Double machine. What's more, while working on a project, the user may change and adapt a Double machine to their own needs. The Double project should provide ways to share these modifications among interested users, and the most successful changes should be accepted and incorporated into Double itself.

### 4.2. A Universal Interface and Thin Integrations

The Double CLI is the main universal software interface. External environments, including Claude, Codex, ChatGPT, VS Code, and others, work with Double through a stable CLI/API. MCP can serve as another adapter for accessing and interacting with Double.

The proposed command family:

```text
double goal ...
double idea ...
double knowledge ...
double flow ...
double search ...
double context ...
```

A skill or plugin for an AI platform explains to the local host agent how to use Double. The core logic stays inside Double. After the initial connection, new capabilities arrive through Double updates, without moving every new feature into the platform's plugin.

Automated capabilities can, when needed, be exported as a native SKILL, for example through `double export skill --target claude ...`, or made available through MCP. A capability like this may rely on a standalone external script. SKILL and MCP let users distribute an implementation or provide access to it; they do not require its core logic to move into a plugin for a particular AI platform.

The Double project defines ways to share accumulated knowledge both about the project itself and about other areas of an individual user's activity where Double is used.

### 4.3. Search, Context, and Project Scope

Each machine has its own catalog for publishing the corresponding artifacts: ideas, goals, or knowledge. A machine module loaded into Double implements functions for accessing its catalogs and registries. Through these functions, Double Agent can search for published artifacts and available realizations, access related materials, and clarify the working context. Knowledge of how the catalogs are organized and how to access them belongs to the corresponding machine module.

Unified search covers Double's own space. An external agent does not need to choose an entity type in advance: a query such as `double search "distributed execution"` may return related goals, ideas, knowledge, and flows.

`double context` provides compact working context: related ideas, knowledge, goals, flows, decisions, and possibly code. This lets an external agent start with an already accumulated and organized knowledge base, drawing on the individual and shared experience of Double users.

A project is a working scope of its own. Creating and searching for entities should be possible both globally and within a project. The rules for using these scopes together have not yet been defined. Projects may be local, accessible only to a particular user, or shared with a limited audience or the public. In any case, Double Agent should maintain a registry of available knowledge sources for finding additional ideas, goals, and knowledge.

Sharing accumulated ideas, goals, and knowledge should rely on publicly available Internet methods and services, such as GitLab and GitHub, public file storage, or cloud services. The Double project does not prohibit commercial or paid distribution of knowledge, but this would require dedicated private commercial channels for distributing information, built on the open part of Double.

### 4.4. Installation and Updates

Installation starts with a minimal shell bootstrap:

```text
install.sh → Double CLI → manage the remaining capabilities through Double
```

The shell handles OS/arch detection, downloading, verification, and PATH setup. Complex installation logic and further management belong to Double. Installation, updates, and integration of Double modules should support both global and local (project) use.

### 4.5. From Intention to Repeatable Work

Double helps people clarify their goals and learn ways to achieve them. As experience accumulates, repeatable work can be handed over to Double, keeping its connection to the person's intention (an idea or plan), the criteria for the result, and the approval points for states that can be reached.

The form used to describe this work and the way it becomes executable actions and code are not fixed here. What matters is the ability to collapse and automate repeated manual actions into either software modules for the Double runtime or external shell scripts that can run on their own. One example is setting up a personal workspace on a computer. Another is simplifying and automating verification of the state reached: for example, documenting the process of obtaining a required document to preserve the nuances of navigating bureaucratic procedures.

Double Agent learns about available automatic realizations through the catalog and registry access functions provided by loaded machine modules. Through them, the agent finds a realization and clarifies its context using related artifacts, including the original goal and plan, to understand its purpose and conditions of use. The same plan may have different realizations; an external script is one of them. A different form of execution does not, by itself, create a new path to the goal. Specific formats for describing and invoking realizations are not fixed here.

Execution inside the Double runtime is not required for every automated function: a standalone script can do its job without it. An executable realization and the way to access it are distinct: the script does the work, while SKILL or MCP makes that capability available to agents.

Double can operate to some extent without a host agent. For example, if it finds an exact match in an idea or goal that already has an automatic realization, it can use that realization without involving an external AI agent. Within this scenario, a ready-made way of working removes the need to call on AI again for an already mastered task. This independence keeps the requirements for sandboxing, permissions, and approvals; the absence of a host agent does not mean the absence of user control.

### 4.6. Long-Running Work and Related Goals

Work on a goal should preserve state and survive restarts, waiting for the user, and long pauses. It may include LLM calls, approvals, external actions, and achieving other goals.

Independent parts of the work can run in parallel, while dependent parts take each other's results into account. The user should be able to pause or cancel the work; errors and retries should be handled while keeping the execution state understandable.

### 4.7. Local and Remote Execution

Double should allow work to run both locally and through remote executors. Where it runs should not change the meaning of the assigned task or its expected result. For example, management and control may happen on a mobile device, while the actual actions take place on a personal computer or remote server.

An executor receives only the information and permissions needed for its part of the work. Responsibility for the overall goal and coordination stays with the central Double agent.

This creates a basis for confidential delegation: an external party can do part of the work without access to the user's whole intent. What information may be revealed through task inputs, results, and metadata still needs to be clarified.

### 4.8. Independence from External Environments

Work with goals, ideas, knowledge, and processes belongs to Double Agent. External environments provide ways to access and execute this work while preserving its underlying domain model.

Double should be able to evolve independently of a particular LLM provider, storage system, or execution location. The specific internal design that enables this separation is not chosen here.

### 4.9. Permissions, Policies, and Isolation

External scripts must run in a sandbox with limited permissions, both when launched through Double and when run on their own. Execution isolation and control over resource access are mandatory requirements of this idea and must be reflected when concepts are later extracted and principles are formed.

Exporting a script or SKILL, or providing access through MCP, does not remove this requirement or create a protected environment by itself. Choosing a tool, specific restrictions, and a way to enforce them belongs to later implementation work. [nono](https://nono.sh/) or alternatives may be considered at that stage.

External code, ideas, goals, and knowledge are considered untrusted by default. A signature or provenance check does not replace security requirements and restrictions during execution.

Code accepted for execution by Double Agent does not get full access to the execution environment: direct access to file systems, the network, the working environment, passwords, and so on. All interaction is controlled by Double Agent's security system. For example, instead of calling `fetch()` or the Google API directly, the code calls the agent's `capability.invoke(...)`. Each external action must receive user approval at one of several levels: once, for the session, permanently for a project, or permanently at the global level. At any time, the user can audit permissions and revoke those previously granted.

Tokens, passwords, and accounts are not passed to the code; it receives a temporary capability to perform an allowed action.

The desired protection model has several layers:

```text
isolated process/container
        ↓
restricted runtime
        ↓
capability boundary
        ↓
policy engine
```

Signatures, hashes, static checks, isolated execution environments (sandboxes), capability restrictions, policies, approvals, and audits complement one another. No single mechanism is considered sufficient on its own. The absence of a direct channel to the outside, even for compromised code, is a required property that will need to be strictly enforced in Double Agent's execution system.

### 4.10. Explainable Actions and Process Development

Audit records and verifiable evidence should make it possible to establish what action was performed, which goal and version it belonged to, in which run and at which stage of work, and why it was allowed. This is part of building trust in shared goal programs.

Double Agent allows the processes of Double machines to change through a controlled sequence:

```text
proposal → validation → tests/simulation → approval → new version
```

This means Double could potentially use its own machines to develop itself. Rules for changing processes and approving a new version will be defined later as part of the Double Agent machine.

## 5. Key Elements

| Element | Role in the Idea |
| --- | --- |
| User | Expresses intentions, refines plans, and makes decisions at approval points |
| Double Agent | Interacts with the person and participates in orchestrating the machines |
| Idea / Knowledge / Goal / Flow Machines | Develop ideas, preserve knowledge, work with goals, and change processes |
| Project | Defines the working context and connects project artifacts |
| CLI / API / MCP | Give external agents access to Double |
| Search / Context | Find entities of different kinds and gather working context |
| Goal / way to achieve it / result | Connect the person's intention to actions and verification of the result |
| Coordination and work state | Allow long-running work to continue and its parts to stay coordinated |
| Task / executor / result | Define the boundaries of the delegated part of the work |
| Capability Broker / Policy Engine | Control access to side effects |
| Sandbox / Audit / Provenance | Provide isolation and traceability of actions |

## 6. Assumptions

- A proven way to achieve a goal can be made repeatable and handed over to Double within agreed limits, preserving the meaning of the work and human control.
- A stable interface will keep integrations with LLM platforms thin as Double's machines evolve.
- Sufficient context can be assembled for an individual task without giving the executor the entire plan.
- The effects of executable code can be limited by a controlled capability boundary. This assumption requires a threat model and verification of isolation.
- Global and project implementations of machines can be updated in a controlled way, keeping new ways of working with knowledge reproducible.

## 7. Examples and Scenarios

1. **Connecting and developing Double.** The user installs the CLI through a bootstrap and connects a thin integration to an external agent. A new machine capability appears after updating Double.
2. **Starting work in a project.** The agent calls `double context` and `double search`, gets related knowledge, ideas, goals, and processes, then continues working in the project context.
3. **Handing over mastered work.** A person works with Double to refine and verify a way to achieve a goal. Once it is mastered, Double takes over the repeatable actions within agreed limits of independence.
4. **A long-running goal with human involvement.** Independent parts of the work run in parallel; one waits for approval. State is preserved, and execution continues after a restart and a decision.
5. **Delegating part of a goal.** Double gives a remote executor a separate task and the context it needs. The executor returns a result without receiving the whole intent.
6. **A controlled external action.** Goal code invokes a capability. The Policy Engine allows or denies the action, or requests approval; credentials stay under Double's control, and the decision is recorded in the audit log.
7. **Developing its own process.** The Flow Machine takes a change through proposal, validation, testing or simulation, approval, and the release of a new version.
8. **A standalone realization and integration.** A repeatable function is collapsed into a shell script that can run on its own. When needed, it is exported as a SKILL or made available through MCP. Double Agent learns about the realization and uses it for a suitable task.

## 8. Signs of Value

- Reusing a ready-made automatic realization without a host agent avoids unnecessary AI calls and token use. The expected effect is lower computing and energy costs and a smaller associated environmental impact; the size of this effect needs to be assessed.
- Accumulated knowledge and ways of working can be preserved when switching external LLM environments.
- Work on a plan can become the basis for repeatable execution while keeping its connection to human intention.
- Long-running goals can continue after pauses and failures without losing state.
- Local and remote execution can use the same task model.
- Limiting the context provided can reduce information disclosure during delegation.
- Control over permissions and the provenance of actions can make shared goal programs easier for the user to understand.

These are the idea's expected effects; measurements and practical evidence are not yet available.

## 9. Open Questions

There are no open questions at the idea level.

## 10. Scope and What Falls Outside the Idea

The idea sets the boundaries of Double as software: its own machines and context, interaction interfaces, the transition from intention to action, long-running execution, security, and controlled process development.

The core logic stays within Double rather than moving into plugins for LLM platforms or external AI agents. Native skills remain a compatibility format for major AI agents. The choice of programming languages will be made later, during development. At first glance, shell scripting (Bash, Zsh) and TypeScript (JavaScript) look like useful starting points for the Double project.

This initial description does not choose a format for describing work, an execution model, Double's implementation language, a database, a transport, a sandbox product, or a final API design. The idea does not set an implementation plan or change the machines' existing working contracts. This broad idea provides a basis for defining the core concepts and principles of the Double software agent.

For external automatic realizations, this idea does not choose a registry format, metadata schema, specific MCP server, or SKILL packaging method. Security requirements remain; how to enforce them for different ways of launching the code still needs to be determined.

## 11. Related Ideas

- [Double: the overall vision of a digital twin](../../Double.md) — knowledge, skills, and a person's interaction with the digital world.
- [Machine of Ideas](../machine-of-ideas/machine-of-ideas.md#machine-of-ideas) — developing an initial thought into lasting artifacts.
- [Machine of Goals](../machine-of-goals/machine-of-goals.md#machine-of-goals) — a target state, paths to reach it, plans, and their realizations.
- [Machine of Knowledge](../machine-of-knowledge/machine-of-knowledge.md#machine-of-knowledge) — extracting and preserving knowledge.

## 12. Notes

The agreed basic project rules are preserved in the knowledge artifact [Double Project](../../knowledge/double-project/double-project.md#double-project): the source tree location and the requirement to write knowledge artifacts in English.
