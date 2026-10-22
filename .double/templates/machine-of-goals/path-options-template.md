---
style: double
submodule: machine-of-goals
id: path-options-template
kind: template
status: release-candidate
workflow-stage: path-discovery
interaction-language: en
artifact-language: en
derived-from:
  - ../../workflows/machine-of-goals/machine-of-goals-workflow.md
  - ../../../ideas/machine-of-goals/machine-of-goals-principles.md
---

# Template: Path Options

```md
---
id: <goal-id>-path-options
kind: path-options
template-id: path-options-template
project-id: <stable-project-id>
produced-by: machine-of-goals/path-discovery-agent
interaction-language: <language-code-or-name-used-for-dialogue>
artifact-language: <language-code-or-name-used-for-this-artifact>
goal-id: <goal-id>
goal-artifact: <path-to-goal-artifact>
parent-goal-id: <parent-goal-id-or-null>
derived-from:
  - <goal-artifact-id-or-path>
---

<a id="<goal-id>-path-options"></a>

# Path Options: <Goal Title>

## 1. Source Goal

- Goal: [<goal-title>](./<goal-id>.md#<goal-id>)
- Parent goal: <parent-goal-id-or-null>
- Current state: <summary>
- Target state: <summary>
- Success criteria: <summary>
- Constraints: <summary>

## 2. Discovery Scope

- Mode: `<research|explain|import>`
- Sources inspected:
- Existing analogs checked:
- Known limitations of discovery:

## 3. Path Options

<a id="<path-id>"></a>

### 3.<path-number>. Path: <Path Name>

- Path id: `<path-id>`
- Path type: <direct|minimal|exploratory|long-term|delegated|automated|tool-based|external|reusable-plan|hybrid>
- Description:
- Why it is plausible:
- Required resources:
- Main risks:
- Expected cost:
- Expected value:
- Unknowns:
- Reuse / import opportunity:
- Lifecycle: <discovered|included-in-plan|implemented|exercised|validated|deprecated>
- Plan element: [<plan-element-label>](./plan-<branch>-v<major>.md#<plan-anchor-or-subplan-id>) or none
- Recommendation: <candidate|include-in-plan|keep-as-alternative|reject|needs-research>

## 4. Comparison

| Path | Fit | Cost | Risk | Uncertainty | Expected Value | Recommendation |
| --- | --- | --- | --- | --- | --- | --- |
| [<path-id>](#<path-id>) | <low/medium/high> | <low/medium/high> | <low/medium/high> | <low/medium/high> | <low/medium/high> | <recommendation> |

## 5. Rejected or Deferred Paths

- <path>: <reason-or-removal-decision>

## 6. Open Questions

- [ ] <question that blocks or improves plan synthesis>
```

## Model Link Contract

For manual and interactive execution, a discovered path can be represented
inside a model or become an independently maintained plan branch. Link the
actual branch model and relevant stage or subplan where the path relationship
is described; include more than one link only when the path genuinely spans
models. Before synthesis, use `none` rather than a link to an uncreated file.
Do not turn this path catalog into another realization or evidence index.
The generalized model-link placeholder does not change execution-mode choice
or any automatic action contract.
