---
submodule: machine-of-ideas
id: skills-registry
kind: registry
status: release-candidate
workflow-version: 0.2.0
derived-from:
  - .double/drafts/double-skills.md
  - .double/workflows/machine-of-ideas/machine-of-ideas-workflow.md
---

# Skills Registry

## Purpose

This registry lists skill entry points that help external AI agents recognize
when to activate Double workflows.

Skills are trigger and routing artifacts. They do not replace workflows, agent
cards, roles, modes, prompts, templates, or registries.

## Machine of Ideas Skill

- id: `machine-of-ideas`
- status: `release-candidate`
- definition: `.double/skills/machine-of-ideas/SKILL.md`
- workflow: `machine-of-ideas-workflow`
- workflow-definition: `.double/workflows/machine-of-ideas/machine-of-ideas-workflow.md`
- registry-scope: `activation`, `routing`, `workflow-entry`
- description: skill entry point for recognizing user intent to capture, continue, inspect, or advance an idea through the Machine of Ideas

## Usage Rule

- use this registry to discover available skill entry points
- use the skill file to determine activation conditions
- use the referenced workflow file as the canonical process definition
- if a skill and workflow disagree, follow the workflow and treat the skill as needing an update
