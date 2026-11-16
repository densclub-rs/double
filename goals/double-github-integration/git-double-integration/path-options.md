---
id: git-double-integration-path-options
kind: path-options
template-id: path-options-template
project-id: double
produced-by: machine-of-goals/path-discovery-agent
interaction-language: ru
artifact-language: en
goal-id: git-double-integration
goal-artifact: ./git-double-integration.md
parent-goal-id: double-github-integration
derived-from:
  - ./git-double-integration.md
  - ../../../scripts/git-double
  - ../../../scripts/test-git-double.py
  - ../../../scripts/scripts.md
---

<a id="git-double-integration-path-options"></a>

# Path Options: Git Double Integration

## 1. Source Goal

- Goal: [Git Double Integration](./git-double-integration.md#git-double-integration).
- Parent: [Double GitHub Integration](../double-github-integration.md#double-github-integration).
- Current state: local visibility commands exist; version/tag/Release inspection is absent.
- Target: unified inspection, preserved visibility behavior, indexed usage rules
  and verified narrow executor permissions.
- Constraints: reuse release contracts; no implicit fetch, ref mutation or publication.

## 2. Discovery Scope

- Mode: `research`, as preparation for the requested plan sketch.
- Inspected the existing script, all eight integration tests, script documentation,
  goal, parent plan and project version/changelog knowledge.
- Existing analog: the local check/sync/watch facade and release tooling contracts.
- Limits: no remote inventory, executor configuration or historical approval recovery.

## 3. Path Options

<a id="incremental-extension"></a>

### 3.1. Path: Incremental Extension

- Path id: `incremental-extension`; type: `direct`.
- Extend the existing script with explicitly read-only inspection commands.
- Plausibility: preserves the current entry point and regression suite.
- Resources: Python, Git, selected GitHub read transport and executor access.
- Risk: growing CLI complexity and accidentally coupling reads to mutations.
- Cost: medium; value: high; unknowns: exact CLI/schema/transport design.
- Reuse: existing visibility implementation, tests and release source contracts.
- Lifecycle: included-in-plan.
- Plan element: [gitclarity](./plan.md#gitclarity), with contract design at [S03](./plan.md#stage-s03).
- Recommendation: include-in-plan; selection remains subject to review.

<a id="composed-facade"></a>

### 3.2. Path: Composed Facade

- Path id: `composed-facade`; type: `tool-based`.
- Keep `git double` as a facade over separately maintained read-only inspectors.
- Plausibility: separates visibility and release-state concerns while preserving one interface.
- Resources: Git/Python, explicit helper contracts and selected remote transport.
- Risk: transitive permission checks, installation and cross-tool schema drift.
- Cost: medium to high; value: medium; unknowns: safe reusable helper boundaries.
- Reuse: release lookup/parsing logic only after checking for side effects.
- Lifecycle: discovered; plan element: none.
- Recommendation: keep-as-alternative; no independent plan requested yet.

## 4. Comparison

| Path | Fit | Cost | Risk | Uncertainty | Expected Value | Recommendation |
| --- | --- | --- | --- | --- | --- | --- |
| [Incremental extension](#incremental-extension) | High | Medium | Medium | Medium | High | Proposed plan |
| [Composed facade](#composed-facade) | High | Medium–high | Medium–high | Medium | Medium | Alternative |

## 5. Rejected or Deferred Paths

- Visibility-only closure cannot satisfy the four-source inspection and permission criteria.
- Full rewrite has no demonstrated benefit over the reusable baseline.
- Helper distribution and systemic integration for project W belong to a separate goal.
- Publication automation is outside this goal's read-only inspection scope.

## 6. Open Questions

None blocking synthesis. Exact command/schema/transport choices belong to S03;
user selection of executor, scope and allowed invocations belongs to S06 before
permission configuration. Neither is silently decided by this sketch.
