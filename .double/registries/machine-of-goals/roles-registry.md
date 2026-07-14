---
style: double
submodule: machine-of-goals
id: roles-registry
kind: registry
status: draft
workflow-version: 0.1.5
---

# Roles Registry

## Purpose

This registry lists role definitions used by Machine of Goals agents.

## Roles

- `goal-formulation-role` -> `.double/roles/machine-of-goals/goal-formulation-role.md`
- `path-discovery-role` -> `.double/roles/machine-of-goals/path-discovery-role.md`
- `plan-synthesis-role` -> `.double/roles/machine-of-goals/plan-synthesis-role.md`
- `plan-realization-role` -> `.double/roles/machine-of-goals/plan-realization-role.md`
- `plan-validation-role` -> `.double/roles/machine-of-goals/plan-validation-role.md`
- `plan-exchange-role` -> `.double/roles/machine-of-goals/plan-exchange-role.md`

## Usage Rule

- use role files to determine stable responsibilities, boundaries, and behavior
- use agent cards to determine inputs, outputs, prompts, and supported modes
- use the workflow file as the canonical source for step order and transition conditions
- if a role and workflow disagree, follow the workflow and treat the role as needing an update
