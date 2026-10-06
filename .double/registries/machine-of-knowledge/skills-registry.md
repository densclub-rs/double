---
style: double
submodule: machine-of-knowledge
id: skills-registry
kind: registry
status: release-candidate
---

# Skills Registry

## Machine of Knowledge Skill

- id: `machine-of-knowledge`
- status: `release-candidate`
- definition: `.double/skills/machine-of-knowledge/SKILL.md`
- workflow: `machine-of-knowledge-workflow`
- workflow-definition: `.double/workflows/machine-of-knowledge/machine-of-knowledge-workflow.md`
- registry-scope: `activation`, `routing`, `workflow-entry`
- description: recognize requests to extract, preserve, inspect, validate, or refresh static or dynamic knowledge artifacts

## Usage Rule

The skill routes into the workflow and does not replace it. When they disagree,
follow the workflow and treat the skill as needing an update.
