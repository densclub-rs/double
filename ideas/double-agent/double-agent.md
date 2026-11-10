---
id: double-agent
kind: idea-artifact
status: stable
produced-by: machine-of-ideas/idea-capture-agent
interaction-language: ru
artifact-language: en
derived-from:
  - user clarification of the Double Agent idea on 2026-11-03
---

<a id="double-agent"></a>

# Idea: Double Agent

## 1. Summary

Double Agent is a machine of the Double project that actively supports as wide a range as possible of a person's activities when working on a project with Double. Among these activities, it helps create new machines and develop existing ones, using accumulated experience to help avoid known mistakes. It also coordinates local and collaborative parallel work in projects that use Double.

## 2. Context / Origin

Double already has machines and a working Double Agent for maintaining their operating artifacts. This idea describes the broader purpose of Double Agent as a machine for helping people create and tune machines that share the foundational ideas of Double.

## 3. Problem / Motivation

Creating and changing machines requires attention to their purpose and to how they fit into Double. Without a deliberate review, a change may contradict the project's foundational ideas, be inconsistent with other machines, or repeat a known mistake. A person developing a machine also needs an active assistant to consult, not only a way to apply changes.

## 4. Description

Double Agent is an active assistant for a person's work on a project with Double. It aims to support as wide a range of that work as possible. A person can ask it questions, seek advice, discuss alternatives, and request suggestions. The person determines the desired result and makes the significant decisions; Double Agent helps explore, carry out, and check the agreed work.

Double Agent helps identify the appropriate machine for specialized work and routes that work through its process. Machine of Ideas develops a new machine's idea, concepts, and principles; Double Agent helps form and review its operating contracts using those artifacts.

Working with project and group rules is one example of such an activity. These rules are represented as knowledge: project rules apply to a project, while group rules are intended for a group of projects that use them. Their organization and use belong to the subsequent formulation of principles.

Double Agent helps create new machines and tune or develop existing ones. The machines it helps create are intended to share the foundational ideas of Double described in [Double.md](../../Double.md). They may be local machines and need not become part of the public Double project repository.

Double Agent brings formalism to machine development. It analyzes a machine's ideas, concepts, principles, and operating contracts, using accumulated knowledge and experience to help people avoid known mistakes. Its analysis covers three complementary areas:

1. Check for contradictions with [Double's foundational ideas](../../Double.md).
2. Check operating contracts against the machine's own concepts and principles.
3. Examine consistency with other machines.

Before presenting a machine change plan for agreement, Double Agent validates proposed changes in all three areas. It presents the results, problems, and possible solutions with the plan and asks the person how to handle them. The person can decide to proceed with a local machine despite a contradiction with Double's foundational ideas.

A contradiction with those foundational ideas prevents a machine from being added to the public Double repository until the contradiction is resolved. The nature and consequences of inconsistencies with other machines are considered by project members; this idea does not prescribe a rigid decision for every case.

### 4.1. Parallel Project Work

Double Agent provides a dedicated workflow for coordinating parallel work in any project that uses Double. In local parallel work, one person develops several ideas, goals, or knowledge artifacts independently. Double Agent prepares or reuses an isolated working copy for each work item. In a Git project, a branch and worktree give the person separate places to work from a known revision. In collaborative parallel work, participants can start, join, or resume work on a shared artifact from their own working copies. This includes collaboration on one computer and across repositories.

A participant can ask Double Agent to start collaborative work on a project artifact. Another participant can ask to continue that work. Double Agent finds the shared work in the project, prepares a separate working copy for each session, and makes the current work and possible overlaps visible before handing off to the Machine of Ideas, Goals, or Knowledge. A returning participant can also resume their own session. The specialized machine continues to govern work on its artifact.

In either mode, the participant can ask to inspect the state of parallel work. Double Agent shows the open work, its working copies, known divergence from the selected base, and what is ready, blocked, or already integrated. It offers next actions based on that state. For example, a person can continue editing, review changes from a base branch before updating a work branch, or prepare selected contributions for a destination branch. Inspection itself leaves the project and working copies untouched.

Participants can work independently and submit their contributions for integration. Double Agent coordinates the checks needed to combine them, preserves each contribution when there is a conflict, and asks for a decision when the project rules and the owning machine leave alternatives open. Each project determines who can see active work, receive notifications, and accept contributions.

The person can choose which ready contributions to integrate and which branch receives them. Local integration, pushing to a remote, and preparing or publishing a release are separate decisions. Double Agent can show the outgoing changes for a selected branch and hand a release request off to the appropriate release process for a selected revision.

## 5. Key Elements

| Element | Role in the Idea |
| --- | --- |
| Person | Defines the desired result, seeks advice, and makes significant decisions |
| Double Agent | Actively assists with creating, developing, and reviewing machines |
| Machine | The subject of creation or change |
| Ideas, concepts, and principles | Material for understanding and analyzing a machine |
| Double's foundational ideas | A basis for checking a machine's consistency with the project |
| Other machines | Context for assessing consistency across machines |
| Accumulated knowledge and experience | Help identify known mistakes and inform advice |
| Project and group rules | Knowledge used in project work, including knowledge shared by a group of projects |
| Parallel work | Work coordinated across isolated working copies, locally or with other participants |
| Collaborative work | Shared work on an idea, goal, or knowledge artifact within a project |
| Work session | A participant's working copy, area of work, and starting revision |
| Contribution | A participant's changes submitted for review and integration |
| Change plan | Presents proposed work and validation findings for the person's consideration |
| Project members | Consider the nature and consequences of inconsistencies with other machines |

## 6. Assumptions

- Explicit analysis can reveal contradictions, inconsistencies, and known mistakes before a change plan is agreed.
- Formalizing machine development can help people make informed decisions while retaining control over their local machines.

## 7. Examples / Scenarios

1. **Creating a machine.** A person discusses a new machine with Double Agent, which helps clarify its idea and examine it against Double's foundational ideas and the other machines.
2. **Tuning a local machine.** Double Agent finds a possible contradiction while preparing a change plan. It describes the issue and asks how to proceed; the person may choose to retain the contradiction locally.
3. **Contributing a machine.** A machine proposed for the public Double repository must first resolve any contradiction with Double's foundational ideas. Project members consider any inconsistencies with other machines.
4. **Working with project and group rules.** A person works with Double Agent on knowledge that applies to a project or is shared by a group of projects.
5. **Continuing collaborative work.** Anna asks Double Agent to start collaborative work on a goal. Boris later asks to continue it. Double Agent shows Boris that Anna is revising the success criteria and prepares a separate working copy. Both use the Machine of Goals. If Boris submits evidence based on an earlier criterion, Double Agent asks the Machine of Goals to check it against the candidate revision before the changes are integrated.

6. **Integrating two local ideas selectively.** A person in Wubble develops ideas A and B in separate branches and worktrees. A is ready first. Double Agent prepares a candidate from A for the local integration branch, while B remains open in its worktree. After A is accepted, the person can review the outgoing commits and decide whether to push them, prepare a release, or continue with B.

## 8. Signals of Value

- People can obtain advice throughout machine development, not only when requesting a change.
- Problems can be brought to a person's attention before a plan is agreed.
- Accumulated experience can help prevent known mistakes from recurring.
- Local experimentation remains possible while the public project retains its foundational ideas.
- Participants can see possible overlaps before editing and can tell why a contribution needs another check.
- A person can see the available next actions and accept one ready contribution while other work continues.

## 9. Open Questions

There are no open questions at the idea level. The organization and use of project and group rules are described in the principles.

## 10. Boundaries / Non-Goals

This idea describes the general purpose and boundaries of Double Agent. It does not prescribe the detailed validation process, contribution decision process, or implementation of machine creation and changes. It does not decide the character or consequences of every inconsistency between machines.

## 11. Related Ideas

- [Double's foundational ideas](../../Double.md)
- [Machine of Ideas](../machine-of-ideas/machine-of-ideas.md#machine-of-ideas)
- [Machine of Goals](../machine-of-goals/machine-of-goals.md#machine-of-goals)
- [Machine of Knowledge](../machine-of-knowledge/machine-of-knowledge.md#machine-of-knowledge)

## 12. Notes

The principles describe the agreed project and group rule model; operating contracts determine how machines apply it.

## 13. Development Artifacts

### 13.1 Concepts

Concept artifact: [Double Agent Concepts](./double-agent-concepts.md)

| Concept | Summary |
| --- | --- |
| [Active Assistance](./double-agent-concepts.md#concept-active-assistance) | Consultative and practical support throughout project work with Double. |
| [Human Direction](./double-agent-concepts.md#concept-human-direction) | The person sets the desired result and makes significant decisions. |
| [Machine Development](./double-agent-concepts.md#concept-machine-development) | Creation, tuning, and development of machines with assistance. |
| [Formalized Analysis and Experience](./double-agent-concepts.md#concept-formalized-analysis) | Explicit examination informed by accumulated knowledge and experience. |
| [Consistency Across Three Areas](./double-agent-concepts.md#concept-two-dimensions-consistency) | Analysis against Double's foundations, the machine's own concepts and principles, and other machines. |
| [Informed Change Agreement](./double-agent-concepts.md#concept-informed-change-agreement) | Validation findings inform the person's decision before plan agreement. |
| [Local and Public Contexts](./double-agent-concepts.md#concept-local-public-contexts) | Local decisions and public contribution have different contexts. |
| [Project and Group Knowledge](./double-agent-concepts.md#concept-scoped-project-knowledge) | Rules are knowledge associated with a project or shared by a group. |
| [Parallel Project Work](./double-agent-concepts.md#concept-parallel-project-work) | Coordination across isolated working copies in local and collaborative modes. |
| [Collaborative Work](./double-agent-concepts.md#concept-collaborative-work) | Shared undertaking on a project artifact. |
| [Work Session](./double-agent-concepts.md#concept-work-session) | A participant's working context and declared area of work. |
| [Contribution](./double-agent-concepts.md#concept-contribution) | Changes submitted from a session for review and integration. |

### 13.2 Principles

Principle artifact: [Double Agent Principles](./double-agent-principles.md)

| Principle | Statement | Related Concepts |
| --- | --- | --- |
| [Active Assistance Under Human Direction](./double-agent-principles.md#principle-active-human-assistance) | Actively support project work while the person directs significant decisions. | [Active Assistance](./double-agent-concepts.md#concept-active-assistance), [Human Direction](./double-agent-concepts.md#concept-human-direction) |
| [Develop Machines With Accumulated Experience](./double-agent-principles.md#principle-learned-machine-development) | Apply explicit analysis and experience to machine development. | [Machine Development](./double-agent-concepts.md#concept-machine-development), [Formalized Analysis and Experience](./double-agent-concepts.md#concept-formalized-analysis) |
| [Examine Three Areas of Consistency](./double-agent-principles.md#principle-two-consistency-dimensions) | Examine consistency with Double's foundations, the machine's own concepts and principles, and other machines. | [Consistency Across Three Areas](./double-agent-concepts.md#concept-two-dimensions-consistency), [Formalized Analysis and Experience](./double-agent-concepts.md#concept-formalized-analysis) |
| [Reveal Findings Before Plan Agreement](./double-agent-principles.md#principle-informed-plan-agreement) | Present validation findings and ask how to handle them before agreement. | [Informed Change Agreement](./double-agent-concepts.md#concept-informed-change-agreement), [Human Direction](./double-agent-concepts.md#concept-human-direction), [Consistency Across Three Areas](./double-agent-concepts.md#concept-two-dimensions-consistency) |
| [Respect Local Choice and Public Foundations](./double-agent-principles.md#principle-local-and-public-boundaries) | Preserve local choice and the distinct public contribution boundary. | [Local and Public Contexts](./double-agent-concepts.md#concept-local-public-contexts), [Human Direction](./double-agent-concepts.md#concept-human-direction), [Consistency Across Three Areas](./double-agent-concepts.md#concept-two-dimensions-consistency) |
| [Treat Project and Group Rules as Scoped Knowledge](./double-agent-principles.md#principle-scoped-rules-as-knowledge) | Use two ancestor levels and resolve whole knowledge items by nearest valid scope. | [Project and Group Knowledge](./double-agent-concepts.md#concept-scoped-project-knowledge), [Active Assistance](./double-agent-concepts.md#concept-active-assistance) |
| [Enter Collaborative Work Explicitly](./double-agent-principles.md#principle-explicit-collaborative-entry) | Start or continue shared work on explicit request and surface overlap before handoff. | [Collaborative Work](./double-agent-concepts.md#concept-collaborative-work), [Work Session](./double-agent-concepts.md#concept-work-session), [Human Direction](./double-agent-concepts.md#concept-human-direction) |
| [Integrate Checked Contributions](./double-agent-principles.md#principle-integrate-checked-contributions) | Check selected contributions against the current integration target and preserve them during conflicts. | [Contribution](./double-agent-concepts.md#concept-contribution), [Parallel Project Work](./double-agent-concepts.md#concept-parallel-project-work), [Human Direction](./double-agent-concepts.md#concept-human-direction) |
| [Guide Parallel Work From Its State](./double-agent-principles.md#principle-guide-parallel-work-from-state) | Enter local parallel work explicitly and offer actions based on observed state. | [Parallel Project Work](./double-agent-concepts.md#concept-parallel-project-work), [Work Session](./double-agent-concepts.md#concept-work-session) |
| [Separate Integration and Publication Decisions](./double-agent-principles.md#principle-separate-integration-and-publication) | Keep selection, local integration, remote publication, and release decisions distinct. | [Parallel Project Work](./double-agent-concepts.md#concept-parallel-project-work), [Contribution](./double-agent-concepts.md#concept-contribution), [Human Direction](./double-agent-concepts.md#concept-human-direction) |
