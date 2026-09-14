---
id: github-actions-maintenance-realization-decision
kind: realization-decision
project-id: double
produced-by: machine-of-goals/plan-synthesis-agent
interaction-language: en
artifact-language: en
goal-id: github-actions-maintenance
plan-id: github-actions-maintenance-plan
path-options-id: github-actions-maintenance-path-options
selected-paths:
  - shell-script-workflow-adapter
selected-realization-id: double-release-shell-workflow
derived-from:
  - ./plan.md
  - ./path-options.md
---

<a id="github-actions-maintenance-realization-decision"></a>

# Realization Decision: GitHub Actions Maintenance

## 1. Decision Summary

- Selected plan: Shell script with thin workflow adapter.
- Source goal: [GitHub Actions Maintenance](./github-actions-maintenance.md#github-actions-maintenance)
- Selected immutable plan revision:
  [plan at `a8ec73d`](https://github.com/densclub-rs/double/blob/a8ec73d5e1d2623a3ec8fbaa216f555ae37cb7bd/goals/double-github-integration/github-actions-maintenance/plan.md)
- Selected path: [Shell Script with Thin Workflow Adapter](./path-options.md#shell-script-workflow-adapter)
- Selected registered realization:
  [Double Release Shell and Workflow](./path-options.md#double-release-shell-workflow)
- Selected immutable realization revisions:
  [release program at `3a86411`](https://github.com/densclub-rs/double/blob/3a86411a7b86d677174a36593d1820444412015d/scripts/double-release.sh)
  and
  [workflow at `1354130`](https://github.com/densclub-rs/double/blob/135413068f8d0f77e99bbd2680bbbc7efe187e04/.github/workflows/release.yml)
- First entry point: [S01: Specify the Release Contract](./plan.md#stage-s01)
- Decision owner: repository owner
- Decision date: 2026-07-19

## 2. Reasoning

- Why this plan or branch: it keeps GitHub Actions as the autonomous release
  executor while making the same package behavior directly testable on a local
  laptop.
- Trade-offs accepted: the project gains a shell-script interface and must keep
  local and GitHub runner behavior aligned.
- Alternatives rejected or deferred: embedded workflow rules remain an
  alternative but do not provide native local testing; a reusable composite
  Action is deferred because it remains GitHub-bound.

## 3. Realization Mode

- Realization mode: partial-automation
- Current default mode: `execution`
- Dry-run required: conditional; required before the first real GitHub Release
  publication after workflow-adapter changes.
- Explanation required before execution: yes, for each selected plan stage.

## 4. Automation Boundaries

- Allowed without confirmation: local tag parsing, machine/status selection,
  packaging, checksum creation, tests, warnings, and no-match completion
  without a package.
- Requires confirmation: starting each plan stage; changing repository Actions
  settings; creating or updating a real GitHub Release; and altering published
  assets.
- Not allowed: local `package` publication, use of repository secrets beyond
  the automatic GitHub token, or deletion of published release assets.
- External effects: repository Actions retention settings and GitHub Releases
  require explicit confirmation before change.

## 5. Validation Strategy

- First stage validation criteria: the S01 contract explicitly covers tag
  grammar, machine/status selection, machine-version knowledge lookup,
  generated distribution versions, warnings, the sole failure condition,
  package/checksum outputs, and the local-publish boundary.
- Evidence expected: approved script contract and local-test specification.
- Who or what validates: repository owner reviews the contract; local shell
  tests and later GitHub Actions runs validate behavior.
- Validation method: compare the S01 specification against the goal and
  path-options artifacts before implementation begins.

## 6. Stop Points

- Before: stop if the S01 contract conflicts with the selected tag, status,
  machine-version knowledge, generated distribution version, warning, or
  publication rules.
- During: stop if local `package` could publish or if any condition other than
  version mismatch fails.
- After: stop before repository-level settings or real release publication
  until explicitly confirmed.

## 7. Revision Conditions

- Continue when: S01 yields an approved contract consistent with the goal.
- Branch when: local testing requires a materially different script interface.
- Revise plan when: the shell-script adapter cannot satisfy both local testing
  and autonomous GitHub Actions release requirements.
- Reformulate goal when: releases no longer map one tag to one machine and
  maturity class.
- Stop or pause when: required GitHub access, retention settings, or release
  safety boundaries cannot be established.
