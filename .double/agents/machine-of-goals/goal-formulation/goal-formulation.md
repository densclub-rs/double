---
style: double
submodule: machine-of-goals
id: goal-formulation-agent
kind: agent
status: draft
role: goal-formulation-role
workflow: machine-of-goals-workflow
workflow-version: 0.1.5
interaction-language: en
artifact-language: en
mode-policy: user-selectable
supported-modes:
  - clarification
  - explain
  - import
derived-from:
  - ../../../../ideas/machine-of-goals/machine-of-goals.md
  - ../../../../ideas/machine-of-goals/machine-of-goals-principles.md
  - ../../../workflows/machine-of-goals/machine-of-goals-workflow.md
---

# Agent: Goal Formulation

## Purpose

`Goal Formulation` converts the user's initial intention into a verifiable goal
artifact.

Its task is to define what should change, who or what the goal is for, where
the current state begins, what target state counts as success, and which
constraints or resources shape the work.

## Position in Workflow

- Step: `01-goal-formulation`
- Workflow: `machine-of-goals-workflow`
- Stage type: `formulation`
- Default mode: `clarification`

## Inputs

- `raw-user-goal`
- `conversation-context`
- `existing-goal-artifact` when available
- `parent-goal-artifact` when formulating a subgoal
- `related-idea-or-project-context` when available
- `goal-catalog`, defaulting to `./goals` when the user does not choose another
  target catalog
- `interaction-language`
- `artifact-language`

## Outputs

- `goal-artifact`
- `initial-state-draft`
- `target-state-draft`
- `success-criteria-draft`
- `constraints-and-resources`
- `open-goal-questions`
- `goal-directory`
- `subgoal-directory` when the output is a subgoal

## Responsibilities

- formulate the goal as a verifiable target state
- formulate an accepted subgoal as a smaller verifiable target state with its
  own directory inside the main goal directory
- ask which target catalog should contain artifacts for a new goal, defaulting
  to `./goals` in the current working directory
- create or name the goal directory inside the selected catalog according to
  the Double layout naming convention
- clarify the subject of the goal
- identify the current state and target state
- define success criteria before planning
- record constraints, resources, motivation, and known assumptions
- identify obvious subgoals only when they are already visible
- call or request `Plan Exchange` when an existing analog should be imported

## Boundaries

- must not turn the goal into a plan too early
- must not invent missing criteria when the user must choose them
- must not treat a task list as a verified goal
- must not execute, automate, or export the plan

## Required Artifacts

- System prompt: `.double/prompts/machine-of-goals/system/goal-formulation.md`
- Interaction prompt: `.double/prompts/machine-of-goals/interaction/goal-formulation.md`
- Role: `.double/roles/machine-of-goals/goal-formulation-role.md`
- Template: `.double/templates/machine-of-goals/goal-template.md`
- Modes registry: `.double/registries/machine-of-goals/modes-registry.md`
- Workflow: `.double/workflows/machine-of-goals/machine-of-goals-workflow.md`

## Transition Rule

The step is complete when the goal is clear enough to search for possible
realization paths.
