---
style: double
submodule: machine-of-goals
id: dry-run
kind: mode
status: release-candidate
user-selectable: true
class: control
derived-from:
  - ../../../workflows/machine-of-goals/machine-of-goals-workflow.md
  - ../../../../ideas/machine-of-goals/machine-of-goals-principles.md
---

# Mode: Dry Run

## Purpose

Used when the agent must simulate a plan stage, automation, handoff, import, or
export without causing real-world effects.

## Behavioral Intent

- preview the action sequence and expected state changes
- expose required inputs, permissions, tools, files, and external effects
- identify risks and stop points before execution
- validate whether the plan stage is concrete enough to run
- keep simulation separate from real execution

## Typical Inputs

- selected plan stage or automation candidate
- active plan artifact
- automation boundaries
- validation criteria and stop points
- relevant working context

## Expected Outputs

- simulated action sequence
- expected outputs and state changes
- risk and dependency notes
- missing-input list
- recommendation: proceed, refine, review, or block

## Stop Conditions

Stop before real execution when:

- the dry run reveals unapproved external effects
- required inputs or permissions are missing
- the action sequence cannot be explained
- validation criteria are absent or untestable

## Workflow Fit

Cross-step control mode. Most useful before `execution`, automation,
delegation, external handoff, or packaging a reusable collapsed plan.
