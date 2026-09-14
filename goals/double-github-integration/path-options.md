---
id: double-github-integration-path-options
kind: path-options
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
- Current selected scope: GitHub release infrastructure

## 2. Path Options

<a id="github-actions-release-infrastructure"></a>

### Path: GitHub Actions Release Infrastructure

- Path id: `github-actions-release-infrastructure`
- Path type: delegated
- Description: establish repository release infrastructure through the
  accepted GitHub Actions Maintenance subgoal.
- Lifecycle: validated
- Plan element: [S03: Invoke GitHub Actions Maintenance](./plan.md#stage-s03)
- Delegated subgoal: [GitHub Actions Maintenance](./github-actions-maintenance/github-actions-maintenance.md#github-actions-maintenance)
- Delegated plan: [GitHub Actions Maintenance plan](./github-actions-maintenance/plan.md#github-actions-maintenance-plan)

## 3. Computed Plan Style

- Computed style: `multi-pass`
- Computed from: the registered automatic realization of the delegated
  maintenance subplan.

<a id="registered-realizations"></a>

## 4. Registered Realizations

<a id="github-actions-maintenance-realization"></a>

### Realization: GitHub Actions Maintenance Subplan

- Realization id: `github-actions-maintenance-realization`
- Kind: workflow
- Definition: [registered subgoal realization](./github-actions-maintenance/path-options.md#double-release-shell-workflow)
- Supported path: [GitHub Actions Release Infrastructure](#github-actions-release-infrastructure)
- Decision: [Shell-script workflow decision](./github-actions-maintenance/realization-decision.md#github-actions-maintenance-realization-decision)
- Registration: registered
- Readiness: ready
- Alignment: aligned
- Runs: `0` parent-plan run artifacts

## 5. Run Retention

- Retained parent-plan runs: [Run index](./run/index.md#double-github-integration-run-index)
- Individual run files are not linked from this registry.

## 6. Open Questions

None currently.
