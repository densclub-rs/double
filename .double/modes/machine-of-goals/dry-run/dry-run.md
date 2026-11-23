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

## Mandatory Conditions

- preview the action sequence and expected state changes
- expose required inputs, permissions, tools, files, and external effects
- identify risks and stop points before execution
- validate whether the plan stage is concrete enough to run
- verify that selected plan, realization, path, and external artifact links
  resolve before real execution
- keep simulation separate from real execution

## Typical Inputs

- selected plan stage or automation candidate
- plan artifact and selected path or subplan
- existing documented realization or skill/action when simulating its behavior
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

## Role, Mode, and Style Boundary

Follow [Style Application Protocol](../../../workflows/machine-of-goals/machine-of-goals-workflow.md#style-application-protocol)
at task entry and when the role changes. Responsibilities, mandatory mode
conditions, artifact contracts, permissions, and workflow transitions remain
binding. Behavioral defaults live only in the selected global style; do not
merge a replacement with `double.md`. The legacy `style: double` frontmatter
classifies this document and does not select the runtime style.
