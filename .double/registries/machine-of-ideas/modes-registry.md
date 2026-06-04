---
submodule: machine-of-ideas
id: modes-registry
kind: registry
status: release-candidate
workflow-version: 0.2.0
derived-from:
  - ideas/machine-of-ideas/directory-layout/directory-layout.md
---

# Modes Registry

## Purpose

This registry lists user-selectable modes of operation for agents of the idea machine.

## Workflow Scope

- workflow: `machine-of-ideas-workflow` -> `.double/workflows/machine-of-ideas/machine-of-ideas-workflow.md`
- workflow registry: `.double/registries/machine-of-ideas/workflows-registry.md`

## Available Modes

- `brainstorm` -> `.double/modes/machine-of-ideas/brainstorm/brainstorm.md`
- `explain` -> `.double/modes/machine-of-ideas/explain/explain.md`
- `strict-research` -> `.double/modes/machine-of-ideas/strict-research/strict-research.md`
- `validation` -> `.double/modes/machine-of-ideas/validation/validation.md`
- `editor` -> `.double/modes/machine-of-ideas/editor/editor.md`

## Usage Rule

- mode is selected by the user for a specific workflow step
- the same agent can support multiple modes
- the same step can be executed in different modes
- prompt files should explicitly specify their mode or mode scope of application
- modes may change how questions are asked and answers are processed, but they must not remove the human clarification loop
- answers to open questions must be integrated into the active artifact of the current workflow step regardless of mode
- `Open Questions` records question status only; modes must not store answers under questions or create normal `Resolved Questions` sections
- modes must preserve the selected interaction language and artifact language
- modes must not silently change the artifact language; any language change requires user confirmation and frontmatter update
