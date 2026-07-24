---
style: double
submodule: machine-of-goals
id: clarification
kind: mode
status: release-candidate
user-selectable: true
class: cognitive
default-for:
  - 01-goal-formulation
derived-from:
  - ../../../workflows/machine-of-goals/machine-of-goals-workflow.md
  - ../../../../ideas/machine-of-goals/machine-of-goals-principles.md
---

# Mode: Clarification

## Purpose

Used when the agent must turn an unclear intention into a verifiable goal
without prematurely choosing a path, plan, or execution strategy.

## Behavioral Intent

- separate the user's wish, motivation, constraints, and target state
- identify the subject of the goal and the relevant current state
- make success criteria explicit enough for later validation
- expose hidden assumptions that would change the plan
- keep the goal open until it is clear enough for path discovery

## Typical Inputs

- raw user goal description
- existing goal artifact
- related idea, concept, principle, note, or project context
- known constraints, resources, deadlines, and success evidence

## Expected Outputs

- clarified goal statement
- initial state and target state draft
- success criteria draft
- constraints and resource notes
- open questions that block path discovery

## Stop Conditions

Stop before path discovery when:

- the target state is not verifiable enough
- the subject of the goal is unclear
- the current state is too ambiguous to model a transition
- the user must choose between materially different interpretations of the goal

## Workflow Fit

Primary mode for `01-goal-formulation`. It may also be used later when
validation shows that the original goal itself must be reformulated.
