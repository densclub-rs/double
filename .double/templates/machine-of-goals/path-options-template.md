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
- Plan element: [<plan-element-label>](./plan.md#<model-anchor-or-subplan-id>) or none
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

A discovered path can become a path/subplan inside one plan or an independently
developed parallel plan. Record that need during discovery; create plans only
at step-03 synthesis. Ordinary plans use `plan.md`, parallel variants use
`plan-<id>.md`, and author variants use `plan<owner_id>.md`, without a hyphen
after `plan`. No prior ordinary plan or major divergence is required.
Each plan has only `id` in frontmatter, generated as one short human-readable
word derived from the plan's context: jointly express its subject, core meaning
and goal in a single word. Its root anchor equals `id`; generation/collision
rules preserve all three concepts and use no numeric suffix. Plan IDs, path IDs
and logical revision branches are distinct; parallel stages alone do not create
separate plans. Link actual file/stage anchors and goal-table rows only.
Before synthesis use `none` for an uncreated plan. Keep this catalog separate
from realization registration and evidence.
This link names an editable model, not a fixed execution plan. Its approval
alone creates no plan/realization files. At execution, the realization links
its own immutable plan. Do not create executor files during path discovery,
synthesis or deferred review. Apply the same boundary to the default plan and
every actual parallel or author variant without changing the automation mechanism.
