---
style: double
submodule: machine-of-goals
id: path-options-template
kind: template
status: draft
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
status: draft
produced-by: path-discovery-agent
workflow-version: <workflow-version>
interaction-language: <language-code-or-name-used-for-dialogue>
artifact-language: <language-code-or-name-used-for-this-artifact>
goal-id: <goal-id>
goal-artifact: <path-to-goal-artifact>
derived-from:
  - <goal-artifact-id-or-path>
---

# Path Options: <Goal Title>

## 1. Source Goal

- Goal: <goal-id>
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

### Path: <Path Name>

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
- Recommendation: <candidate|keep-as-alternative|reject|needs-research>

## 4. Comparison

| Path | Fit | Cost | Risk | Uncertainty | Expected Value | Recommendation |
| --- | --- | --- | --- | --- | --- | --- |
| <path-id> | <low/medium/high> | <low/medium/high> | <low/medium/high> | <low/medium/high> | <low/medium/high> | <recommendation> |

## 5. Rejected or Deferred Paths

- <path>: <reason>

## 6. Open Questions

- [ ] <question that blocks or improves plan synthesis>

## 7. Workflow State

- Current step: `02-path-discovery`
- Current mode: `<research|explain|import>`
- Next expected step: `03-plan-synthesis`
- Transition condition: at least one plausible path exists, or the goal is marked blocked, infeasible, or requiring reformulation
```
