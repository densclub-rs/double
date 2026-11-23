---
style: double
submodule: machine-of-ideas
id: explain
kind: mode
status: stable
user-selectable: true
class: service
derived-from:
  - ideas/machine-of-ideas/directory-layout/directory-layout.md
---

# Mode: Explain

## Purpose

Used when the agent must explain to the user why it chooses one step or another, the plan of reasoning, the current state of artifacts, and the principles being applied.

## Mandatory Conditions

- increase transparency of the agent's work
- explain the choice of workflow transitions
- reveal the current plan of action and the grounds for conclusions

## Output Expectation

The artifact or response should contain not only the result, but also an explanation of the logic that led to it.

## Role, Mode, and Style Boundary

Follow [Style Application Protocol](../../../workflows/machine-of-ideas/machine-of-ideas-workflow.md#style-application-protocol)
at task entry and when the role changes. Responsibilities, mandatory mode
conditions, artifact contracts, permissions, and workflow transitions remain
binding. Behavioral defaults live only in the selected global style; do not
merge a replacement with `double.md`. The legacy `style: double` frontmatter
classifies this document and does not select the runtime style.
