---
id: double-github-integration-plan
kind: plan-artifact
produced-by: machine-of-goals/plan-synthesis-agent
interaction-language: ru
artifact-language: en
goal-id: double-github-integration
goal-artifact: ./double-github-integration.md
plan-role: canonical-community
plan-filename: plan.md
variant-id: canonical
variant-of: null
canonical-plan-artifact: ./plan.md
author: plan-synthesis-agent
device: codex-runtime
created-at: 2026-07-24T00:04:41+02:00
updated-at: 2026-07-24T00:08:33+02:00
imported-from: null
goal-scope: main-goal
parent-goal-id: null
parent-plan-artifact: null
selected-paths:
  - github-actions-release-infrastructure
related-plan-variants: []
existing-plan-implementations: []
derived-from:
  - ./double-github-integration.md
  - ./github-actions-maintenance/github-actions-maintenance.md
---

# Plan: Double GitHub Integration

## 1. Plan Summary

This canonical plan records the first agreed path for GitHub Actions release
infrastructure. It contains no alternative plan variants.

- Goal artifact: `./double-github-integration.md`
- Selected path: `github-actions-release-infrastructure`
- Current state: S01 and S02 are accepted; S03 has invoked the
  `github-actions-maintenance` subgoal and is in progress. Broader site and
  governance questions remain open.
- Target state: the GitHub Actions and scripts directories are created, then
  release maintenance proceeds through the accepted subgoal.
- Success criteria: all three stages have an explicit validation decision.

## 2. Plan Variant Identity

- Plan role: canonical-community
- Plan filename: `plan.md`
- Canonical plan artifact: `./plan.md`
- Variant of: null
- Author: `plan-synthesis-agent`
- Device / runtime: `codex-runtime`
- Created at: 2026-07-24T00:04:41+02:00
- Imported from: null
- Active selection status: selected

## 3. Plan Map

| Stage | Status | Validation | Inputs | Outputs | Last Attempt | Last Attempt Time |
| --- | --- | --- | --- | --- | --- | --- |
| [S01: Create GitHub Actions Directory](#stage-s01) | ✅ done | ✅ accepted | parent goal | [S02](#stage-s02) | not retained | 2026-07-24T00:08:33+02:00 |
| [S02: Create Scripts Directory](#stage-s02) | ✅ done | ✅ accepted | [S01](#stage-s01) | [S03](#stage-s03) | not retained | 2026-07-24T00:08:33+02:00 |
| [S03: Invoke GitHub Actions Maintenance](#stage-s03) | 🔵 in-progress | ⚪ not-validated | [S02](#stage-s02), [github-actions-maintenance](./github-actions-maintenance/github-actions-maintenance.md) | subgoal realization | not retained | 2026-07-24T00:08:33+02:00 |

## 4. Blocker

- Blocker: none for these first three stages.
- Owner: user.
- Needed decision: none before S01; the subgoal owns its own release and
  hosted-validation decisions.
- Unblock condition: not applicable.

## 5. Stage Attempts

- Save attempt artifacts after plan update: ask-user
- Current attempt count: 0
- Retention threshold: 10
- Cleanup decision when attempts exceed threshold: ask-user
- Attempt artifact directory: `./results/`

## 6. Stage Details

<a id="stage-s01"></a>

### Stage: Create GitHub Actions Directory

- Stage id: `S01`
- Status: ✅ done
- Automation level: partial
- Purpose: create the working directory `.github/workflows/` for GitHub Actions
  workflow files.
- Input state: accepted parent goal and its release-infrastructure target.
- Output state: `.github/workflows/` exists and is available for workflow
  rules.
- Actions: create the directory if it does not exist; preserve existing
  workflow files.
- Validation criteria: `.github/workflows/` exists and is a directory.
- Validation:
  - Status: ✅ accepted
  - Confirmed by: user
  - Confirmed at: 2026-07-24T00:08:33+02:00
  - Evidence: `.github/workflows/` exists as a directory.
  - Decision: S01 is complete; S02 may proceed.
- Stop points: stop if creation would overwrite existing workflow content.

<a id="stage-s02"></a>

### Stage: Create Scripts Directory

- Stage id: `S02`
- Status: ✅ done
- Automation level: partial
- Purpose: create the working directory `scripts/` for release and validation
  scripts.
- Input state: S01 is complete.
- Output state: `scripts/` exists and is available for release scripts.
- Actions: create the directory if it does not exist; preserve existing scripts.
- Validation criteria: `scripts/` exists and is a directory.
- Validation:
  - Status: ✅ accepted
  - Confirmed by: user
  - Confirmed at: 2026-07-24T00:08:33+02:00
  - Evidence: `scripts/` exists as a directory.
  - Decision: S02 is complete; S03 may proceed.
- Stop points: stop if creation would overwrite existing script content.

<a id="stage-s03"></a>

### Stage: Invoke GitHub Actions Maintenance

- Stage id: `S03`
- Status: 🔵 in-progress
- Automation level: interactive
- Purpose: hand release implementation to the accepted
  `github-actions-maintenance` subgoal.
- Input state: S01 and S02 are accepted; the subgoal artifact and its canonical
  [plan](./github-actions-maintenance/plan.md) are available.
- Output state: realization continues under
  [github-actions-maintenance.md](./github-actions-maintenance/github-actions-maintenance.md).
- Actions: invoke the subgoal's canonical plan and follow its stage and
  approval boundaries. Invocation is in progress.
- Related subgoal artifacts:
  - [GitHub Actions Maintenance](./github-actions-maintenance/github-actions-maintenance.md)
- Validation criteria: the subgoal plan is identified as the only release
  implementation path for this parent stage.
- Validation:
  - Status: ⚪ not-validated
  - Confirmed by: none
  - Confirmed at: null
  - Evidence: none
  - Decision: none
- Stop points: stop for the subgoal's required confirmation before changing
  repository settings or publishing a release.

## 7. Shared Dependencies

- Internal dependencies: `.github/workflows/`, `scripts/`, and the
  `github-actions-maintenance` subgoal.
- External dependencies: GitHub Actions and GitHub Releases, once the subgoal
  reaches its hosted-validation stage.
- Decision dependencies: the subgoal's explicit approval boundaries.

## 8. Shared Risks and Controls

- Risk: directory creation can overwrite or obscure existing repository files.
- Mitigation: create only missing directories and preserve existing contents.
- Stop condition: an operation would replace an existing file.

## 9. Automation Boundaries

- Allowed automatic actions: inspect and create missing directories.
- Actions requiring confirmation: changes to workflow rules, repository
  settings, or releases.
- Actions not allowed: deleting existing workflow or script content.

## 10. Revision Conditions

- Revise stage when: the selected directories or the subgoal interface changes.
- Rebuild plan when: release maintenance no longer fits the delegated subgoal.
- Reformulate goal when: the parent goal's GitHub scope changes materially.

## 11. Open Questions

- [ ] The parent goal's broader site and governance questions remain open; they
  are outside this first release-infrastructure path.
