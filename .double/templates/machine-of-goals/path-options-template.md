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
project-id: <stable-project-id>
produced-by: path-discovery-agent
interaction-language: <language-code-or-name-used-for-dialogue>
artifact-language: <language-code-or-name-used-for-this-artifact>
goal-id: <goal-id>
goal-artifact: <path-to-goal-artifact>
goal-scope: <main-goal|subgoal>
parent-goal-id: <parent-goal-id-or-null>
derived-from:
  - <goal-artifact-id-or-path>
---

<a id="<goal-id>-path-options"></a>

# Path Options: <Goal Title>

## 1. Source Goal

- Goal: [<goal-title>](./<goal-id>.md#<goal-id>)
- Scope: <main-goal|subgoal>
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
- Lifecycle: <discovered|included-in-plan|implemented|exercised|validated|deprecated>
- Plan element: [<plan-element-label>](./plan.md#<plan-anchor-or-subplan-id>) or none
- Recommendation: <candidate|include-in-plan|keep-as-alternative|reject|needs-research>

## 4. Comparison

| Path | Fit | Cost | Risk | Uncertainty | Expected Value | Recommendation |
| --- | --- | --- | --- | --- | --- | --- |
| <path-id> | <low/medium/high> | <low/medium/high> | <low/medium/high> | <low/medium/high> | <low/medium/high> | <recommendation> |

## 5. Rejected or Deferred Paths

- <path>: <reason-or-removal-decision>

## 6. Computed Plan Style

- Computed style: <single-pass|multi-pass>
- Computed from: <no-registered-automatic-realization|registered-automatic-realization-id>
- Last recomputed at: <YYYY-MM-DDTHH:MM:SSZ>
- Rule: registration of an automatic realization changes the style to
  `multi-pass`; file creation and successful validation are not transition
  points.

<a id="registered-realizations"></a>

## 7. Registered Realizations

| Realization | Kind | Definition / Implementation | Revision | Supported Paths / Subplans | Registration | Readiness | Alignment | Runs | Last Run | Last Result |
| --- | --- | --- | --- | --- | --- | --- | --- | ---: | --- | --- |
| <a id="<realization-id>"></a>`<realization-id>` | <manual|shell|python|workflow|agentic|external> | [<artifact-label>](<artifact-link>) | [<exact-revision>](<immutable-revision-link>) or `current` before decision | [<path-or-subplan>](./plan.md#<path-or-subplan-id>) | <registered|retired> | <draft|ready|unvalidated|failed> | <aligned|review-required|incompatible> | <count> | <YYYY-MM-DDTHH:MM:SSZ-or-never> | <running|succeeded|partial|failed|blocked|cancelled|precondition-failed|never> |

Statistics are cumulative and remain after bounded run files are removed.
Individual files under `run/` are identified by naming convention and are not
linked from this table.

When a run is created, increment `Runs`, set `Last Run` to the UTC start time,
and set `Last Result` to `running`. Terminal validation replaces `Last Result`
without incrementing `Runs` again.

## 8. Run Retention

- Retained runs: [Run index](./run/index.md#<goal-id>-run-index)
- Filename: `<realization-id>--<YYYYMMDDTHHMMSSZ>.md`
- Maximum terminal runs per realization: <3|4|5, default 5>
- Active runs count toward limit: no
- Remove oldest unpinned terminal run after statistics update: yes

## 9. Open Questions

- [ ] <question that blocks or improves plan synthesis>
```
