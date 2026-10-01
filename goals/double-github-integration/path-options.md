---
id: double-github-integration-path-options
kind: path-options
template-id: path-options-template
project-id: double
produced-by: machine-of-goals/path-discovery-agent
interaction-language: en
artifact-language: en
goal-id: double-github-integration
goal-artifact: ./double-github-integration.md
goal-scope: main-goal
derived-from:
  - ./double-github-integration.md
  - ./github-actions-maintenance/path-options.md
---

<a id="double-github-integration-path-options"></a>

# Path Options: Double GitHub Integration

## 1. Source Goal

- Goal: [Double GitHub Integration](./double-github-integration.md#double-github-integration)
- Scope: main goal
- Current state: the repository has release infrastructure to preserve and maintain.
- Target state: required directories exist and the maintenance subgoal satisfies its checks.
- Success criteria: parent directory checks and the subgoal's S01–S04 criteria pass.
- Constraints: preserve existing content and delegate release details to the subgoal.

## 2. Discovery Scope

- Mode: `research`
- Sources inspected: [source goal](./double-github-integration.md#double-github-integration),
  [maintenance goal](./github-actions-maintenance/github-actions-maintenance.md#github-actions-maintenance),
  and [maintenance paths](./github-actions-maintenance/path-options.md#github-actions-maintenance-path-options).
- Existing analogs checked: the repository's release-maintenance structure.
- Known limitations of discovery: this catalog covers release infrastructure;
  site publishing and other GitHub concerns remain outside the current plan.

## 3. Path Options

<a id="github-actions-release-infrastructure"></a>

### Path: GitHub Actions Release Infrastructure

- Path id: `github-actions-release-infrastructure`
- Path type: delegated
- Description: establish repository release infrastructure through the
  accepted GitHub Actions Maintenance subgoal.
- Why it is plausible: the accepted subgoal owns the release contract and its checks.
- Required resources: repository filesystem, maintenance plan, local tooling,
  and authorized GitHub access for hosted checks.
- Main risks: parent and subgoal completion criteria may diverge.
- Expected cost: medium
- Expected value: high
- Unknowns: none affecting the current plan structure.
- Reuse / import opportunity: reuse the local maintenance subplan.
- Lifecycle: included-in-plan
- Recommendation: include-in-plan
- Plan element: [S03: Invoke GitHub Actions Maintenance](./plan.md#stage-s03)
- Delegated subgoal: [GitHub Actions Maintenance](./github-actions-maintenance/github-actions-maintenance.md#github-actions-maintenance)
- Delegated plan: [GitHub Actions Maintenance plan](./github-actions-maintenance/plan.md#github-actions-maintenance-plan)

## 4. Comparison

| Path | Fit | Cost | Risk | Uncertainty | Expected Value | Recommendation |
| --- | --- | --- | --- | --- | --- | --- |
| [GitHub Actions Release Infrastructure](#github-actions-release-infrastructure) | high | medium | medium | low | high | include-in-plan |

## 5. Rejected or Deferred Paths

Site publishing and other GitHub integration paths are deferred to separately
formulated subgoals; no alternative release-infrastructure path is proposed.

## 6. Open Questions

None currently.
