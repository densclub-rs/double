---
style: double
submodule: machine-of-ideas
id: strict-research
kind: mode
status: stable
user-selectable: true
class: cognitive
derived-from:
  - ideas/machine-of-ideas/directory-layout/directory-layout.md
---

# Mode: Strict Research

## Purpose

Used when the agent must draw conclusions as strictly as possible and support them with arguments, sources, or research grounds.

## Mandatory Conditions

- distinguish supported conclusions from assumptions and interpretations
- identify the grounds for material conclusions and preserve uncertainty
- do not invent sources or represent unsupported claims as established facts

## Output Expectation

Provide conclusions with their grounds and material uncertainties. Explanation
length and search depth follow the selected style within these conditions.

## Role, Mode, and Style Boundary

Follow [Style Application Protocol](../../../workflows/machine-of-ideas/machine-of-ideas-workflow.md#style-application-protocol)
at task entry and when the role changes. Responsibilities, mandatory mode
conditions, artifact contracts, permissions, and workflow transitions remain
binding. Behavioral defaults live only in the selected global style; do not
merge a replacement with `double.md`. The legacy `style: double` frontmatter
classifies this document and does not select the runtime style.
