---
id: double-github-integration-plan
kind: plan-artifact
project-id: double
produced-by: plan-synthesis-agent
interaction-language: ru
artifact-language: en
goal-id: double-github-integration
goal-artifact: ./double-github-integration.md
path-options-artifact: ./path-options.md
plan-artifact: ./plan.md
goal-scope: main-goal
plan-execution-style: multi-pass
plan-revision: 1
created-at: 2026-07-24T00:04:41Z
updated-at: 2026-08-30T00:00:00Z
derived-from:
  - ./double-github-integration.md
  - ./github-actions-maintenance/github-actions-maintenance.md
---

<a id="double-github-integration-plan"></a>

# Plan: Double GitHub Integration

## 1. Plan Summary

This plan defines one transition model for the first agreed GitHub Actions
release-infrastructure path. The path creates the required repository
directories and delegates release rules and workflow maintenance to the
accepted `github-actions-maintenance` subgoal.

- Source goal: [Double GitHub Integration](./double-github-integration.md#double-github-integration)
- Source paths: [Path and realization registry](./path-options.md#double-github-integration-path-options)

### Current State

`.github/workflows/` and `scripts/` may exist or not.

### Target State

The required GitHub Actions and scripts directories are available, and release
maintenance is defined by the accepted subgoal.

### Success Criteria

Each stage has the required state and validation evidence; the subgoals' plans are implemented.

## 2. State Validation Contract

- Initial state checks: inspect the repository and confirm that creating the
  required directories will preserve existing workflow and script content.
- Required intermediate state checks: `.github/workflows/` exists as a
  directory, then `scripts/` exists as a directory.
- Final state checks: the `github-actions-maintenance` subgoal artifact and its
  canonical plan are identified as the release implementation path.
- Evidence requirements: directory existence checks and links to the accepted
  subgoal artifacts; later release validation belongs to that subgoal.
- Stop when validation cannot be completed: do not overwrite existing content
  or proceed when the subgoal interface is unavailable.

## 3. Plan Map

| Stage | Kind | Inputs | Outputs | Possible Next Stages | Required Validation |
| --- | --- | --- | --- | --- | --- |
| [S01: Create GitHub Actions Directory](#stage-s01) | stage | goal | `.github/workflows/` directory | [S02](#stage-s02) | `.github/workflows/` exists as a directory |
| [S02: Create Scripts Directory](#stage-s02) | stage | [S01](#stage-s01) | `scripts/` directory | [S03](#stage-s03) | `scripts/` exists as a directory |
| [S03: Invoke GitHub Actions Maintenance](#stage-s03) | subplan | [S02](#stage-s02), [github-actions-maintenance](./github-actions-maintenance/plan.md#stage-s01) | [release-maintenance subplan](./github-actions-maintenance/plan.md#stage-s01) | none | subgoal plan has the required artifacts and all stages are passed and validated |

## 4. Stage Details

<a id="stage-s01"></a>

### Stage: Create GitHub Actions Directory

- Stage id: `S01`
- Kind: stage
- Purpose: create the working directory `.github/workflows/` for GitHub
  Actions workflow files.
- Input state: accepted parent goal and its release-infrastructure target.
- Output state: `.github/workflows/` exists and is available for workflow
  rules.
- Preconditions: inspect the directory and preserve any existing workflow
  files.
- Actions: create the directory only if it does not exist.
- Required resources: repository filesystem and existing `.github/` content.
- Possible input stages: none.
- Possible output stages: [S02: Create Scripts Directory](#stage-s02).
- Related subplan: [GitHub Actions Maintenance plan](./github-actions-maintenance/plan.md#github-actions-maintenance-plan).
- Validation criteria: `.github/workflows/` exists and is a directory.
- Evidence expected: directory existence check confirmed by the user.
- Risks: directory creation could overwrite or obscure existing workflow
  content.
- Stop points: stop if creation would replace existing files.

<a id="stage-s02"></a>

### Stage: Create Scripts Directory

- Stage id: `S02`
- Kind: stage
- Purpose: create the working directory `scripts/` for release and validation
  scripts.
- Input state: S01 has established the GitHub Actions directory.
- Output state: `scripts/` exists and is available for release scripts.
- Preconditions: inspect the directory and preserve any existing scripts.
- Actions: create the directory only if it does not exist.
- Required resources: repository filesystem and existing script content.
- Possible input stages: [S01: Create GitHub Actions Directory](#stage-s01).
- Possible output stages: [S03: Invoke GitHub Actions Maintenance](#stage-s03).
- Related subplan: [GitHub Actions Maintenance plan](./github-actions-maintenance/plan.md#github-actions-maintenance-plan).
- Validation criteria: `scripts/` exists and is a directory.
- Evidence expected: directory existence check confirmed by the user.
- Risks: directory creation could overwrite or obscure existing script content.
- Stop points: stop if creation would replace existing files.

<a id="stage-s03"></a>

### Stage: Invoke GitHub Actions Maintenance

- Stage id: `S03`
- Kind: subplan
- Purpose: delegate release implementation to the accepted
  `github-actions-maintenance` subgoal.
- Input state: S01 and S02 outputs exist; the subgoal artifact and canonical
  plan are available.
- Output state: release maintenance continues under
  [github-actions-maintenance.md](./github-actions-maintenance/github-actions-maintenance.md).
- Preconditions: the subgoal remains accepted and its canonical plan is
  available.
- Actions: invoke the subgoal plan and follow its stage and approval
  boundaries.
- Required resources: the subgoal artifact, its canonical plan, GitHub Actions,
  and GitHub Releases when hosted validation is reached.
- Possible input stages: [S02: Create Scripts Directory](#stage-s02).
- Possible output stages: none in this parent plan.
- Related subgoal: [GitHub Actions Maintenance](./github-actions-maintenance/github-actions-maintenance.md#github-actions-maintenance).
- Related subplan: [GitHub Actions Maintenance plan](./github-actions-maintenance/plan.md#github-actions-maintenance-plan).
- Subplan entry: [S01: Specify the Release Contract](./github-actions-maintenance/plan.md#stage-s01).
- Subplan output: [hosted validation stage](./github-actions-maintenance/plan.md#stage-s04).
- Subplan realization decision: [Shell-script workflow decision](./github-actions-maintenance/realization-decision.md#github-actions-maintenance-realization-decision).
- Subplan execution attempts: [Run index](./github-actions-maintenance/run/index.md#github-actions-maintenance-run-index).
- Validation criteria: the subgoal plan is identified as the only release
  implementation path for this parent stage.
- Evidence expected: linked subgoal artifact and canonical plan, followed by
  validation evidence recorded by that subgoal.
- Risks: release maintenance may diverge from the parent integration contract.
- Stop points: stop for the subgoal's required confirmation before changing
  repository settings or publishing a release.

## 5. Shared Dependencies

- Internal dependencies: `.github/workflows/`, `scripts/`, and the
  `github-actions-maintenance` subgoal.
- External dependencies: GitHub Actions and GitHub Releases once the subgoal
  reaches hosted validation.
- Decision dependencies: the subgoal's explicit approval boundaries.

## 6. Shared Risks and Controls

- Risk: directory creation can overwrite or obscure existing repository files.
- Impact: existing workflow or script behavior could be lost.
- Mitigation: inspect first, create only missing directories, and preserve all
  existing contents.
- Stop condition: an operation would replace an existing file.

## 7. Automation Boundaries

- Allowed automatic actions: inspect and create missing directories.
- Actions requiring confirmation: changes to workflow rules, repository
  settings, or releases.
- Actions not allowed: deleting existing workflow or script content.
