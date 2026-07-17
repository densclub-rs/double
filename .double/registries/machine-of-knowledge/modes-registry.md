---
style: double
submodule: machine-of-knowledge
id: modes-registry
kind: registry
status: draft
workflow-version: 0.1.0
---

# Modes Registry

## Purpose

Machine of Knowledge reuses common Machine of Ideas modes. A mode changes the
working posture but never replaces `01-knowledge-extraction`.

## Available Modes

- `brainstorm` -> `.double/modes/machine-of-ideas/brainstorm/brainstorm.md`
- `explain` -> `.double/modes/machine-of-ideas/explain/explain.md`
- `strict-research` -> `.double/modes/machine-of-ideas/strict-research/strict-research.md`
- `validation` -> `.double/modes/machine-of-ideas/validation/validation.md`
- `editor` -> `.double/modes/machine-of-ideas/editor/editor.md`

## Usage Rule

- default to `strict-research`
- preserve the selected interaction and artifact languages
- preserve the human clarification loop in every mode
- use knowledge-specific rules from the Machine of Knowledge workflow when a shared mode is silent
