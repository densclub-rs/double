---
style: double
submodule: machine-of-ideas
id: brainstorm
kind: mode
status: stable
user-selectable: true
class: cognitive
derived-from:
  - ideas/machine-of-ideas/directory-layout/directory-layout.md
---

# Mode: Brainstorm

## Purpose

Used when the agent must freely generate ideas without early criticism.

## Mandatory Conditions

- expand the space of options
- do not suppress raw thoughts too early
- temporarily reduce criticism toward hypotheses

## Output Expectation

Produce candidate options without prematurely rejecting raw hypotheses. Stay within the current step; the selected style determines elaboration and presentation.

## Role, Mode, and Style Boundary

Follow [Style Application Protocol](../../../workflows/machine-of-ideas/machine-of-ideas-workflow.md#style-application-protocol)
at task entry and when the role changes. Responsibilities, mandatory mode
conditions, artifact contracts, permissions, and workflow transitions remain
binding. Behavioral defaults live only in the selected global style; do not
merge a replacement with `double.md`. The legacy `style: double` frontmatter
classifies this document and does not select the runtime style.
