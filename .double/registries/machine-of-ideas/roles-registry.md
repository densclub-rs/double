---
style: double
submodule: machine-of-ideas
id: roles-registry
kind: registry
status: release-candidate
---

# Roles Registry

## Purpose

This registry lists role definitions used by Double agents inside workflows.

Roles describe stable responsibilities, boundaries, and behavioral rules. They
do not replace agent cards, modes, prompts, templates, or workflow transition
rules.

## Idea Capture Role

- id: `idea-capture-role`
- status: `release-candidate`
- definition: `.double/roles/machine-of-ideas/idea-capture-role.md`
- workflow: `machine-of-ideas-workflow`
- stage: `01-idea-capture`
- agent: `idea-capture-agent`
- role-scope: `idea-articulation`, `clarification`, `idea-artifact-formation`
- description: role for helping the user articulate an idea in structured Markdown without prematurely turning it into concepts, principles, architecture, or implementation

## Concept Extractor Role

- id: `concept-extractor-role`
- status: `release-candidate`
- definition: `.double/roles/machine-of-ideas/concept-extractor-role.md`
- workflow: `machine-of-ideas-workflow`
- stage: `02-concept-extraction`
- agent: `concept-extraction-agent`
- role-scope: `concept-extraction`, `source-grounding`, `concept-artifact-formation`
- description: role for extracting stable concepts from an articulated idea without rewriting it as a summary, principles, requirements, or design decisions

## Principle Synthesizer Role

- id: `principle-synthesizer-role`
- status: `release-candidate`
- definition: `.double/roles/machine-of-ideas/principle-synthesizer-role.md`
- workflow: `machine-of-ideas-workflow`
- stage: `03-principle-synthesis`
- agent: `principle-synthesis-agent`
- role-scope: `principle-synthesis`, `traceability`, `principle-artifact-formation`
- description: role for synthesizing verifiable principles from an idea and concept artifact while preserving traceability and avoiding requirements, design, or implementation

## Usage Rule

- use this registry to discover available role definitions
- use the role file to determine responsibilities, constraints, and behavioral rules
- use the associated agent card to determine inputs, outputs, prompts, and supported modes
- use the workflow file as the canonical source for step order and transition conditions
- if a role and workflow disagree, follow the workflow and treat the role as needing an update
