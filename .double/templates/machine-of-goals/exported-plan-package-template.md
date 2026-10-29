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

Keep editable models and historical execution plans distinct. Omit optional
execution links when no realization has started. Import reusable content as a
local model; no new local execution plan is created until authorized step 05.
Package the goal/model alone or selected documented realizations with their
frozen plans and evidence. A reusable skill/action is optional existing material;
exporting or invoking it creates no Machine of Goals execution history.

```md
---
id: <goal-id>-exported-plan-package
kind: exported-plan-package
template-id: exported-plan-package-template
project-id: <stable-project-id>
produced-by: machine-of-goals/plan-exchange-agent
interaction-language: <language-code-or-name-used-for-dialogue>
artifact-language: <language-code-or-name-used-for-this-artifact>
goal-id: <goal-id>
plan-id: <plan-id>
path-options-id: <path-options-id>
documented-realizations:
  - <selected-existing-realization-path>
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
- Source model: [<model-title>](<plan-model-artifact-link>)
- Historical frozen plan: [<plan-title>](<plan-artifact-link>) when one exists
- Selected paths and subplans: [<path-or-subplan-label>](<path-or-subplan-link>)
- Supporting validation evidence:

## 3. Reusable Material

- Reusable stages:
- Reusable subgoals: [<subgoal-title>](<subgoal-artifact-link>)
- Reusable checks:
- Reusable scripts / workflows / specs: [<artifact-label>](<artifact-link>)
- Optional existing skill/action: [<mechanism-label>](<mechanism-link>)
- Selected documented realizations: [<realization-label>](<realization-artifact-link>)
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
- Validation decision source: <realization-result-or-stage-record>
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

- Exported editable plan: `plan.md` with its original stable plan ID and anchor
- Exported frozen plans: <existing-plan-paths-and-source-identities-only>
- Exported path-options artifact: `path-options.md`
- Selected documented realizations and stage evidence:
- Required validation contracts: initial, intermediate, and final state checks
- Include only the walkthroughs and evidence selected for this package.
- Preserve source identities and facts; importing experience does not establish
  execution in the receiving context. A requested new manual start freezes its
  own approved plan; invocation of a collapsed mechanism creates no execution record.
```
