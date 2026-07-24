---
style: double
submodule: machine-of-goals
id: skills-registry
kind: registry
status: release-candidate
derived-from:
  - .double/workflows/machine-of-goals/machine-of-goals-workflow.md
---

# Skills Registry

## Purpose

This registry lists skill entry points that help external AI agents recognize
when to activate Machine of Goals.

Skills are trigger and routing artifacts. They do not replace workflows, agent
cards, roles, modes, prompts, templates, or registries.

## Machine of Goals Skill

- id: `machine-of-goals`
- status: `release-candidate`
- definition: `.double/skills/machine-of-goals/SKILL.md`
- workflow: `machine-of-goals-workflow`
- workflow-definition: `.double/workflows/machine-of-goals/machine-of-goals-workflow.md`
- registry-scope: `activation`, `routing`, `workflow-entry`
- description: skill entry point for recognizing user intent to formulate, inspect, plan, realize, validate, import, export, or continue a goal through Machine of Goals

## Usage Rule

- use this registry to discover available skill entry points
- use the skill file to determine activation conditions
- use the referenced workflow file as the canonical process definition
- if a skill and workflow disagree, follow the workflow and treat the skill as needing an update
