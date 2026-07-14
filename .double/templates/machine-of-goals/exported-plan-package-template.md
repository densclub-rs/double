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
current-step: 07-plan-packaging-export
current-mode: <export|validation|explain>
next-expected-step: <end>
transition-condition: goal is closed, paused, transferred, exported, or intentionally left without export
goal-id: <goal-id>
plan-id: <plan-id>
plan-artifacts:
  - <plan-artifact-id-or-path>
plan-state-artifacts:
  - <plan-state-id-or-path>
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
- Plan variants:
- Plan state artifacts:
- Validation evidence:

## 3. Reusable Material

- Reusable stages:
- Reusable subgoals:
- Reusable checks:
- Reusable scripts / workflows / specs:
- Reusable plan state traces:
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

## 9. Plan State Export Notes

- Exported plan artifacts:
- Canonical plan naming rule: the Double community plan for a goal is
  `plan.md`.
- Plan variant export naming rule: exported or imported non-canonical
  `plan-artifact` names must include `author`, `device`, and
  second-precision `time` labels.
- Example plan variant export name:
  `plan--author-<author>--device-<device>--time-<YYYYMMDDTHHMMSS>.md`
- Exported plan state artifacts:
- Export naming rule: exported `plan-state` artifact names must include
  `author`, `device`, and second-precision `time` labels.
- Example plan state export name:
  `<goal-id>-plan-state--author-<author>--device-<device>--time-<YYYYMMDDTHHMMSS>.md`
```
