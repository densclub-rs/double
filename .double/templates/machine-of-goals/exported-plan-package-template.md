---
style: double
submodule: machine-of-goals
id: exported-plan-package-template
kind: template
status: release-candidate
workflow-stage: plan-packaging-export
interaction-language: en
artifact-language: en
derived-from:
  - ../../workflows/machine-of-goals/machine-of-goals-workflow.md
  - ../../../ideas/machine-of-goals/machine-of-goals-principles.md
---

# Template: Exported Plan Package

```md
---
id: <goal-id>-exported-plan-package
kind: exported-plan-package
template-id: exported-plan-package-template
project-id: <stable-project-id>
produced-by: plan-exchange-agent
interaction-language: <language-code-or-name-used-for-dialogue>
artifact-language: <language-code-or-name-used-for-this-artifact>
goal-id: <goal-id>
plan-id: <plan-id>
path-options-id: <path-options-id>
registered-realizations:
  - <realization-record-id-or-artifact>
package-type: <markdown-plan|runbook|checklist|workflow|sdd-spec|script-scaffold|handoff-package|exchange-package>
derived-from:
  - <goal-artifact-id-or-path>
  - <plan-artifact-id-or-path>
  - <path-options-id-or-path>
  - <supporting-evidence-artifact-id-or-path>
---

# Exported Plan Package: <Goal Title>

## 1. Package Summary

- Package type:
- Intended use:
- Intended audience:
- Reuse level: <single-context|adaptable|reusable-fragment|shareable-package>
- Status: <draft|ready-for-review|validated|deprecated>

## 2. Source Context

- Goal: [<goal-title>](<goal-artifact-link>)
- Current state:
- Target state:
- Success criteria:
- Constraints:
- Resources:
- Original plan: [<plan-title>](<plan-artifact-link>)
- Selected paths and subplans: [<path-or-subplan-label>](<path-or-subplan-link>)
- Computed style: <multi-pass>
- Plan realization registry: [<realization-registry-label>](<plan-artifact-link>#realization-registry)
- Realization alignment statuses:
- Aggregate realization statistics:
- Supporting validation evidence:

## 3. Reusable Material

- Reusable stages:
- Reusable subgoals: [<subgoal-title>](<subgoal-artifact-link>)
- Reusable checks:
- Reusable scripts / workflows / specs: [<artifact-label>](<artifact-link>)
- Reusable registered realizations: [<realization-label>](<plan-artifact-link>#<realization-record-id>)
- Persistent realization artifacts: [<realization-label>](<realization-artifact-link>)
- Required adaptations:

## 4. Context-Specific Assumptions

- Assumption:
- Why it matters:
- What must be changed in another context:

## 5. Runbook / Checklist / Workflow

Portable sequence or package outline:

    <portable sequence or package outline>

## 6. Validation and Evidence

- What has been validated:
- What has not been validated:
- Validation decision source: <plan-artifact-stage-validation-blocks>
- Supporting evidence links:
- Known failure modes:

## 7. Import Instructions

- How to adapt this package into another goal:
- Required inputs:
- Required checks:
- Stop conditions:

## 8. Closure Summary

- Goal closure status: <achieved|partially-achieved|paused|transferred|not-achieved|not-closed>
- Remaining work:
- Recommended next use:

## 9. Plan Export Notes

- Exported plan artifact: `plan.md`
- Exported path-options artifact: `path-options.md`
- Exported realization registry: section 10 of `plan.md`
- Exported registered realization records:
- Exported persistent realization artifacts:
- Required validation contracts: initial, intermediate, and final state checks
- Working run logs under `run/` are excluded by default.
- Include a run log only when the user explicitly selects it as temporary
  diagnostic context; it does not become required permanent package history.
```
