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
- output: `path-options`, `path-comparison`, `path-assumptions`, `path-risks`, `open-path-questions`
- supported-modes: `research`, `explain`, `import`
- template: `.double/templates/machine-of-goals/path-options-template.md`
- system-prompt: `.double/prompts/machine-of-goals/system/path-discovery.md`
- interaction-prompt: `.double/prompts/machine-of-goals/interaction/path-discovery.md`
- definition: `.double/agents/machine-of-goals/path-discovery/path-discovery.md`

## Plan Synthesis Agent

- id: `plan-synthesis-agent`
- role: `plan-synthesis-role`
- stage: `03-plan-synthesis`, `04-plan-review-and-decision`
- input: `goal-artifact`, `path-options`, `selected-path-or-candidate-paths`, `constraints-and-resources`, `success-criteria`
- optional-input: `known-risks-and-uncertainties`, `subgoal-artifact`
- output: `plan-artifact`, `realization-decision`, `automation-boundaries`, `validation-strategy`, `subplan-interface`
- supported-modes: `planning`, `review`, `explain`, `dry-run`
- templates: `.double/templates/machine-of-goals/plan-template.md`, `.double/templates/machine-of-goals/realization-decision-template.md`
- system-prompt: `.double/prompts/machine-of-goals/system/plan-synthesis.md`
- interaction-prompt: `.double/prompts/machine-of-goals/interaction/plan-synthesis.md`
- definition: `.double/agents/machine-of-goals/plan-synthesis/plan-synthesis.md`

## Plan Realization Agent

- id: `plan-realization-agent`
- role: `plan-realization-role`
- stage: `05-plan-realization`
- input: `plan-artifact`, `realization-decision`, `selected-plan-stage`, `automation-boundaries`, `stage-validation-criteria`, `working-context`
- optional-input: `plan-stop-points`
- output: `stage-attempt-result`, `updated-plan-artifact`
- optional-output: `implementation-artifact`, `handoff-artifact`, `blocker-or-revision-note`
- supported-modes: `execution`, `explain`, `dry-run`, `planning`
- templates: `.double/templates/machine-of-goals/stage-attempt-result-template.md`, `.double/templates/machine-of-goals/plan-template.md`
- system-prompt: `.double/prompts/machine-of-goals/system/plan-realization.md`
- interaction-prompt: `.double/prompts/machine-of-goals/interaction/plan-realization.md`
- definition: `.double/agents/machine-of-goals/plan-realization/plan-realization.md`

## Plan Validation Agent

- id: `plan-validation-agent`
- role: `plan-validation-role`
- stage: `06-plan-validation`
- input: `stage-attempt-result`, `stage-validation-criteria`, `goal-artifact`, `plan-artifact`, `execution-evidence`
- output: `updated-plan-artifact`, `goal-progress-note`, `revision-or-continuation-decision`
- optional-output: `goal-closure-signal`
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
- optional-input: `execution-history`, `validation-evidence`, `results-artifacts`, `external-plan-or-analog`, `external-plan-implementations`, `export-target-or-intended-reuse`
- output: `imported-plan-adaptation`, `adapted-path-or-plan-fragment`, `exported-plan-package`, `reuse-and-adaptation-notes`
- optional-output: `goal-closure-summary`
- supported-modes: `import`, `export`, `explain`, `validation`
- template: `.double/templates/machine-of-goals/exported-plan-package-template.md`
- system-prompt: `.double/prompts/machine-of-goals/system/plan-exchange.md`
- interaction-prompt: `.double/prompts/machine-of-goals/interaction/plan-exchange.md`
- definition: `.double/agents/machine-of-goals/plan-exchange/plan-exchange.md`
