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
produced-by: plan-exchange-agent
interaction-language: <language-code-or-name-used-for-dialogue>
artifact-language: <language-code-or-name-used-for-this-artifact>
goal-id: <goal-id>
plan-id: <plan-id>
plan-artifacts:
  - <plan-artifact-id-or-path>
results-artifacts:
  - <results-artifact-id-or-path>
package-type: <markdown-plan|runbook|checklist|workflow|sdd-spec|script-scaffold|handoff-package|exchange-package>
derived-from:
  - <goal-artifact-id-or-path>
  - <plan-artifact-id-or-path>
  - <plan-validation-summary-in-plan-artifact>
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

- Goal:
- Current state:
- Target state:
- Success criteria:
- Constraints:
- Resources:
- Original plan:
- Plan variants:
- Plan execution state:
- Results artifacts:
- Validation decisions in plan:
- Supporting validation evidence:

## 3. Reusable Material

- Reusable stages:
- Reusable subgoals:
- Reusable checks:
- Reusable scripts / workflows / specs:
- Reusable execution traces:
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

- Exported plan artifacts:
- Canonical plan naming rule: the Double community plan for a goal is
  `plan.md`.
- Plan variant export naming rule: exported or imported non-canonical
  `plan-artifact` names must include `author`, `device`, and
  second-precision `time` labels.
- Example plan variant export name:
  `plan--author-<author>--device-<device>--time-<YYYYMMDDTHHMMSS>.md`
- Exported execution state: include the active plan artifact and relevant
  `results/` artifacts.
- Results artifact rule: working and intermediate execution files remain under
  `<goal-directory>/results/` unless the export package intentionally copies or
  bundles them.
```
