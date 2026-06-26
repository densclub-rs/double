---
style: double
submodule: machine-of-goals
id: exported-plan-package-template
kind: template
status: draft
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
status: draft
produced-by: plan-exchange-agent
workflow-version: <workflow-version>
interaction-language: <language-code-or-name-used-for-dialogue>
artifact-language: <language-code-or-name-used-for-this-artifact>
goal-id: <goal-id>
plan-id: <plan-id>
package-type: <markdown-plan|runbook|checklist|workflow|sdd-spec|script-scaffold|handoff-package|exchange-package>
derived-from:
  - <goal-artifact-id-or-path>
  - <plan-artifact-id-or-path>
  - <validation-result-id-or-path>
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
- Validation evidence:

## 3. Reusable Material

- Reusable stages:
- Reusable subgoals:
- Reusable checks:
- Reusable scripts / workflows / specs:
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
- Evidence links:
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

## 9. Workflow State

- Current step: `07-plan-packaging-export`
- Current mode: `<export|validation|explain>`
- Next expected step: `<end>`
- Transition condition: goal is closed, paused, transferred, exported, or intentionally left without export
```
