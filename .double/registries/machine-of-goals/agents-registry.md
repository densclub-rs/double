---
style: double
submodule: machine-of-goals
id: agents-registry
kind: registry
status: release-candidate
---

# Agents Registry

## Goal Formulation Agent

- id: `goal-formulation-agent`
- role: `goal-formulation-role`
- stage: `01-goal-formulation`
- input: `raw-user-goal`, `conversation-context`, `interaction-language`, `artifact-language`
- optional-input: `existing-goal-artifact`, `parent-goal-artifact`, `related-idea-or-project-context`
- output: `goal-artifact`, `initial-state-draft`, `target-state-draft`, `success-criteria-draft`, `open-goal-questions`, `goal-directory`, `subgoal-directory`
- supported-modes: `clarification`, `explain`, `import`
- template: `.double/templates/machine-of-goals/goal-template.md`
- system-prompt: `.double/prompts/machine-of-goals/system/goal-formulation.md`
- interaction-prompt: `.double/prompts/machine-of-goals/interaction/goal-formulation.md`
- definition: `.double/agents/machine-of-goals/goal-formulation/goal-formulation.md`

## Path Discovery Agent

- id: `path-discovery-agent`
- role: `path-discovery-role`
- stage: `02-path-discovery`
- input: `goal-artifact`, `initial-state`, `target-state`, `success-criteria`, `constraints-and-resources`
- optional-input: `existing-analogs`
- output: `path-options`, `path-comparison`, `path-assumptions`, `path-risks`, `stable-path-ids`, `open-path-questions`
- supported-modes: `research`, `explain`, `import`
- template: `.double/templates/machine-of-goals/path-options-template.md`
- system-prompt: `.double/prompts/machine-of-goals/system/path-discovery.md`
- interaction-prompt: `.double/prompts/machine-of-goals/interaction/path-discovery.md`
- definition: `.double/agents/machine-of-goals/path-discovery/path-discovery.md`

## Manual and Interactive Execution Routing

The [Model and Realization Execution Rule](../../workflows/machine-of-goals/machine-of-goals-workflow.md#model-and-realization-execution-rule)
governs the documented walkthrough. These producer contracts are authoritative;
there is no alternate registration or execution-log shape.

| Agent | Input | Output | Templates |
| --- | --- | --- | --- |
| `plan-synthesis-agent` | Goal, paths, selected editable plan(s) under the filename rule, exact content approval | `plan-model`; approved selection in conversation | `plan-model-template` |
| `plan-realization-agent` | Approved model/digest and authorized start, or existing frozen plan/current stage | immutable `plan-artifact`, `realization-artifact`, `stage-realization`, evidence | `plan-template`, `realization-template`, `stage-realization-template` |
| `plan-validation-agent` | Captured conditions, actual outputs, evidence/statements, goal criteria | Updated `stage-realization` and `realization-artifact` | `stage-realization-template`, `realization-template` |

Review links the actual current plan file and asks the user to approve its
contents, selection and boundaries. Digests are internal verification evidence;
never include them in approval questions, titles, choices or normal summaries.
Steps 03–04 never produce executor files, even after model approval. Only the
authorized start of step 05 materializes the frozen plan and realization.
The main realization map owns current-stage/progress. Its State cells use only
emoji, explained by the legend above; do not repeat state names in cells or add
a duplicate status column. User progress handoffs may add prose labels under the
canonical [progress rule](../../workflows/machine-of-goals/machine-of-goals-workflow.md#realization-progress-emojis).
Use 🟠 after action and ✅ only after output acceptance.
Input checks precede
action; output checks precede completion. Documentary evidence is offered with
an explicit user-statement fallback. A changed model ends the realization and
requires an authorized successor with applicability-checked inherited facts.
No separate decision, registration wrapper, execution index or validation artifact
is required. Common consent, language, and routing boundaries remain binding.

## Plan Synthesis Agent

- id: `plan-synthesis-agent`
- role: `plan-synthesis-role`
- stage: `03-plan-synthesis`, `04-plan-review-and-decision`
- input: `goal-artifact`, `path-options`, `selected-path-or-candidate-paths`, `constraints-and-resources`, `success-criteria`
- optional-input: `known-risks-and-uncertainties`, `subgoal-artifact`, `explicit-user-path-confirmation-during-review`
- output: `plan-model`, `approved-model-selection-in-conversation`, `selectable-path-and-subplan-map`, `automation-boundaries`, `validation-strategy`, `subplan-interface`
- supported-modes: `planning`, `review`, `explain`, `dry-run`
- templates: `.double/templates/machine-of-goals/plan-model-template.md`
- system-prompt: `.double/prompts/machine-of-goals/system/plan-synthesis.md`
- interaction-prompt: `.double/prompts/machine-of-goals/interaction/plan-synthesis.md`
- definition: `.double/agents/machine-of-goals/plan-synthesis/plan-synthesis.md`

## Plan Realization Agent

- id: `plan-realization-agent`
- role: `plan-realization-role`
- stage: `05-plan-realization`
- input: `plan-model`, `approved-model-selection`, `authorized-start`, `path-options`, `selected-plan-stage`, `working-context`; existing frozen plan/realization when resuming
- optional-input: `plan-stop-points`
- output: immutable `plan-artifact`, `realization-artifact`, `stage-realization` and directly linked evidence for documented manual execution; mechanism result only for a collapsed invocation
- optional-output: `implementation-artifact`, `handoff-artifact`, `blocker-or-revision-note`
- execution-contract: recheck exact approval at authorized start, freeze plan before action, capture stage contracts from the pinned plan; changed content returns to review
- supported-modes: `execution`, `explain`, `dry-run`, `planning`
- templates: `.double/templates/machine-of-goals/plan-template.md`, `.double/templates/machine-of-goals/realization-template.md`, `.double/templates/machine-of-goals/stage-realization-template.md`
- system-prompt: `.double/prompts/machine-of-goals/system/plan-realization.md`
- interaction-prompt: `.double/prompts/machine-of-goals/interaction/plan-realization.md`
- definition: `.double/agents/machine-of-goals/plan-realization/plan-realization.md`

## Plan Validation Agent

- id: `plan-validation-agent`
- role: `plan-validation-role`
- stage: `06-plan-validation`
- input: `realization-artifact`, `stage-realization`, `stage-validation-criteria`, `goal-artifact`, frozen `plan-artifact`, `execution-evidence`; or the collapsed mechanism and its actual result
- output: updated `stage-realization` and `realization-artifact`, `revision-or-continuation-decision`; for collapsed invocation, validation outcome without new execution files
- optional-output: `model-review-request`, `goal-closure-signal`; validation creates no snapshot and writes no progress into the model
- validation-contract: validate against the attempt's captured criteria and evidence; preserve applicable prior acceptance and record any revalidation or rework
- supported-modes: `validation`, `review`, `explain`
- templates: `.double/templates/machine-of-goals/plan-template.md`
- system-prompt: `.double/prompts/machine-of-goals/system/plan-validation.md`
- interaction-prompt: `.double/prompts/machine-of-goals/interaction/plan-validation.md`
- definition: `.double/agents/machine-of-goals/plan-validation/plan-validation.md`

## Plan Exchange Agent

- id: `plan-exchange-agent`
- role: `plan-exchange-role`
- optional: `true`
- stage: `cross-step`, `07-plan-packaging-export`
- input: `goal-artifact`, `plan-artifact`
- optional-input: `path-options`, `selected-documented-realizations`, `existing-skills-or-actions`, `validation-evidence`, `external-plan-or-analog`, `external-plan-realizations`, `export-target-or-intended-reuse`
- output: `imported-plan-adaptation`, `adapted-path-or-plan-fragment`, `exported-plan-package`, `reuse-and-adaptation-notes`
- optional-output: `goal-closure-summary`
- supported-modes: `import`, `export`, `explain`, `validation`
- template: `.double/templates/machine-of-goals/exported-plan-package-template.md`
- system-prompt: `.double/prompts/machine-of-goals/system/plan-exchange.md`
- interaction-prompt: `.double/prompts/machine-of-goals/interaction/plan-exchange.md`
- definition: `.double/agents/machine-of-goals/plan-exchange/plan-exchange.md`

Collapsed skills/actions have no required Machine of Goals execution record.
Their invocations preserve covered checks and permissions; actual results are
reported through the mechanism's interface. They never create synthetic
realization rows or invocation journals. Manual progress is inspected from the
goal's links to the applicable timestamped realization, not from the model.
