---
id: styles
kind: idea-artifact
status: draft
produced-by: idea-capture-agent
interaction-language: Russian
artifact-language: English
derived-from:
  - user conversations on 2026-08-27
---

<a id="styles"></a>

# Idea: Styles

## 1. Summary

A style is a named, reusable, and modifiable way of working in Double. A style may determine or replace the complete workflow used in a particular context while preserving the applicable contracts.

Styles allow a workflow developed during concrete work to be remembered, refined, and reused. Their definition, creation, and modification belong to a dedicated Double-level process owned by Double Agent rather than to Machine of Ideas, Machine of Goals, or another individual machine. This responsibility does not require a separate Style Agent.

## 2. Context / Origin

The idea emerged from two observations about working with Double:

- Machine of Ideas may need different workflows for different people, groups, and contexts.
- Machine of Goals may select different workflows for plans described generally as single-pass or multi-pass.

This led to a broader understanding of style. A style is not merely a presentation layer inside a fixed workflow. It may change the entire workflow while preserving the contract that makes the result valid within Double and the relevant machine.

The idea also comes from practical project work. A person may gradually develop a workflow that fits a particular project and later want to preserve that workflow as a named style for future use.

## 3. Problem / Motivation

A fixed workflow cannot express every useful way of working. Different projects, people, and goals may require different sequences of interaction, execution, review, and artifact production.

At the same time, useful workflows often emerge during real work rather than being fully designed in advance. Without a style mechanism, such a workflow may remain an undocumented local adaptation and disappear when the project ends.

Double therefore needs a way to:

- select a suitable way of working without changing the underlying contract;
- preserve a workflow that emerged during a concrete project;
- name, reuse, exchange, and modify that way of working;
- keep style development independent from the machines that consume styles.

## 4. Raw Description

A style describes a general way of working in Double. It may affect communication, prompts, roles, agents, templates, artifact forms, stage structure, transition logic, and the workflow as a whole. Workflow is mutable; preserving one fixed workflow is not part of the definition of style.

What remains stable is the applicable contract. Double has foundational project-level contracts, and an individual machine may have its own contract for the meaning and validity of its results. A style may realize these contracts through a different workflow, but it must not silently invalidate them.

A style can be selected using a simple general designation. For example, a plan may be described as having a `single-pass` style or a `multi-pass` style. Machine of Goals can then select the workflow associated with that style. The style does not need to expose a detailed specification of every plan-usage parameter merely to make this distinction.

Styles can also emerge from practice. While working on a concrete project, a person and an agent may adapt or develop a workflow that fits the project well. If that workflow is valuable beyond the immediate run, it can be captured and remembered as a style. The style can later be reused or modified without treating the original project as the only place where the workflow exists.

Machines consume styles but do not own their lifecycle. Machine of Ideas, Machine of Goals, and other machines may discover a style, select it, execute its workflow, and record which style shaped their work. They should not independently define or modify shared styles.

Style definition, creation, capture from project work, validation, and modification should form a dedicated `Style Development` process owned by Double Agent. Double Agent can keep style work distinct from ordinary machine-artifact maintenance without introducing another agent identity. The agents of individual machines remain consumers of styles and may hand a candidate project workflow over to Double Agent when the user wants to preserve it as a style.

## 5. Key Elements

- style
- style identity and name
- applicable Double and machine contracts
- workflow selected or defined by a style
- style selection by a machine
- single-pass and multi-pass plan styles
- project-specific workflow
- capturing an emergent workflow as a style
- style reuse and exchange
- style modification
- `Style Development` process owned by Double Agent
- Double Agent as the single agent responsible for style definition and modification
- machines as consumers rather than owners of styles

## 6. Assumptions

- A workflow is a mutable operational form, not the invariant core of a machine.
- Different workflows can satisfy the same applicable contract.
- A style may determine the complete workflow rather than only changing presentation or interaction tone.
- A useful style can be discovered through concrete work and formalized afterward.
- A simple style designation can be sufficient for selecting a workflow; a detailed declarative usage specification is not always necessary.
- Styles are relevant across Double and should not belong exclusively to Machine of Ideas or Machine of Goals.
- Shared style creation and modification require dedicated responsibility and should not happen implicitly inside a machine run.
- A dedicated process inside Double Agent is sufficient to preserve this responsibility; a separate Style Agent is not currently needed.

## 7. Examples / Scenarios

### Single-pass and multi-pass plans

A plan is marked with the `single-pass` style. Machine of Goals selects a workflow intended for one realization of the plan.

Another plan is marked with the `multi-pass` style. Machine of Goals selects a different workflow that supports returning to the plan and producing another realization.

The style names express the general distinction. The detailed behavior remains in the workflows selected by those styles.

### Capturing a project workflow

A person works with Double on a concrete project. During the work, the original workflow is adjusted until it fits the project well. The person decides that this way of working will be useful again.

Double Agent enters its dedicated `Style Development` process, captures the developed workflow, helps name and clarify the style, checks it against the applicable contracts, and preserves it for later reuse. Future projects can select this style without reconstructing the workflow from scratch.

## 8. Signals of Value

- The same machine can support substantially different ways of working without making one workflow universal.
- Valuable project experience can become a reusable Double asset.
- People can develop recognizable personal or collective working styles.
- Machines remain focused on their own subject matter while style lifecycle concerns stay with Double Agent at the Double level.
- Simple style names can select complex workflows without forcing detailed configuration into every goal, plan, or idea artifact.
- Contracts preserve compatibility while workflows remain free to evolve.

## 9. Open Questions

- [ ] What is the minimum definition required for a workflow to be remembered as a style?
- [ ] Does a style directly contain a workflow, select a workflow, or support both relationships?
- [ ] Which contracts must a style preserve, and how are applicable machine contracts identified?
- [ ] When should an adapted project workflow remain local, and when should it become a reusable style?
- [x] Does style development require a dedicated Style Agent, or can Double Agent own it as a separate process?
- [ ] How should style identity and modification remain traceable without making style use unnecessarily complex?
- [ ] Can one style apply to several machines, or does each machine need its own compatible expression of that style?

## 10. Boundaries / Non-Goals

- This idea does not define a detailed plan-usage configuration schema.
- This idea does not require styles to preserve a fixed workflow, stage sequence, mode set, or transition logic.
- This idea does not yet define the storage layout, registry format, or loading mechanism for styles.
- This idea does not yet design the concrete `Style Development` process or its operating artifacts inside Double Agent.
- This idea does not yet modify Double operating artifacts under `.double/`.
- This idea does not define every field that an artifact must use to record a selected style.
- Output formats such as Markdown, PDF, HTML, or JSON are not automatically styles merely because they change artifact representation.

## 11. Related Ideas

- [Machine of Ideas](../machine-of-ideas/machine-of-ideas.md)
- [Machine of Goals](../machine-of-goals/machine-of-goals.md)
- [Single-Pass and Multi-Pass Plans](../machine-of-goals/single-pass-and-multi-pass-plans/single-pass-and-multi-pass-plans.md)
- [Double](../../Double.md)

## 12. Notes

The current working distinction is:

```text
applicable contract -> selected style -> workflow -> concrete realization
```

This is an idea-level relationship, not yet an implementation design.

The current responsibility model is:

```text
Double Agent
  -> Machine Artifact Maintenance
  -> Style Development
```

`Style Development` is a separate process, not a separate agent.
