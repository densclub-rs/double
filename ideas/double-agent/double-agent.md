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

Double Agent is a machine of the Double project that actively supports as wide a range as possible of a person's activities when working on a project with Double. Among these activities, it helps create new machines and develop existing ones, using accumulated experience to help avoid known mistakes.

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

## 8. Signals of Value

- People can obtain advice throughout machine development, not only when requesting a change.
- Problems can be brought to a person's attention before a plan is agreed.
- Accumulated experience can help prevent known mistakes from recurring.
- Local experimentation remains possible while the public project retains its foundational ideas.

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
