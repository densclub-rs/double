---
style: double
submodule: machine-of-ideas
id: validation
kind: mode
status: stable
user-selectable: true
class: cognitive
derived-from:
  - ideas/machine-of-ideas/directory-layout/directory-layout.md
---

# Mode: Validation

## Purpose

Used when the agent must verify artifacts of the current stage and make a reasoned judgment about their validity.

## Mandatory Conditions

- look for discrepancies and gaps
- check completeness and internal consistency of artifacts
- check that idea, concept, and principle artifacts include `interaction-language` and `artifact-language` frontmatter
- check that artifact text is formulated in the selected artifact language unless a documented exception exists
- provide a reasoned assessment of the quality of the result

## Output Expectation

The result should contain a conclusion about the validity of the artifact and arguments for each significant comment.

## Role, Mode, and Style Boundary

Follow [Style Application Protocol](../../../workflows/machine-of-ideas/machine-of-ideas-workflow.md#style-application-protocol)
at task entry and when the role changes. Responsibilities, mandatory mode
conditions, artifact contracts, permissions, and workflow transitions remain
binding. Behavioral defaults live only in the selected global style; do not
merge a replacement with `double.md`. The legacy `style: double` frontmatter
classifies this document and does not select the runtime style.
