---
submodule: machine-of-ideas
id: validation
kind: mode
status: release-candidate
user-selectable: true
class: cognitive
derived-from:
  - ideas/machine-of-ideas/directory-layout/directory-layout.md
---

# Mode: Validation

## Purpose

Used when the agent should verify artifacts of the current stage and make a reasoned judgment about their validity.

## Behavioral Intent

- look for discrepancies and gaps
- check completeness and internal consistency of artifacts
- check that idea, concept, and principle artifacts include `interaction-language` and `artifact-language` frontmatter
- check that artifact text is formulated in the selected artifact language unless a documented exception exists
- provide a reasoned assessment of the quality of the result

## Output Expectation

The result should contain a conclusion about the validity of the artifact and arguments for each significant comment.
