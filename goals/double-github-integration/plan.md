---
id: githubbridge
kind: plan-model
template-id: plan-model-template
project-id: double
produced-by: machine-of-goals/plan-synthesis-agent
interaction-language: ru
artifact-language: en
goal-id: double-github-integration
branch: release-infrastructure
plan-revision: 4
derived-from:
  - ./double-github-integration.md
  - ./path-options.md
---

<a id="githubbridge"></a>

# Plan: Double GitHub Integration / release-infrastructure

Goal: [Double GitHub Integration](./double-github-integration.md#double-github-integration)

## Conditions

### Initial State

- The repository is available locally. Existing workflows and scripts must be preserved.
- Directory checks may establish that no creation is needed.

### Target State

- Workflow and script directories are available, and the maintenance subgoal
  supplies a defined and validated machine-release process.

### Success Criteria

- S01 and S02 establish the required directories without destructive changes.
- S03 obtains the maintenance subgoal outputs through S04, including local and
  hosted evidence; merely locating the subgoal plan is insufficient.

## Selection and Control Boundaries

- Included path: [GitHub release infrastructure](./path-options.md#github-actions-release-infrastructure).
- Entry: [S01](#stage-s01). Existing directories satisfy the corresponding checks.
- Later functional extensions belong to [subgoal S05](./github-actions-maintenance/plan.md#stage-s05);
  retain this parent as the integration boundary rather than duplicating extension stages.
- Scope: parent coordination and directory prerequisites; release implementation
  and its detailed checks belong to the maintenance subgoal.
- Preserve workflow/script content. Stop on a file/directory conflict or missing
  subgoal interface; revise the plan if its interface or integration scope changes.
- Repository settings, publication and notifications require their applicable
  authorization. This model and its migration do not authorize execution.
- Prefer documentary evidence; explicit user statements may be identified as
  fallback evidence with the unverified limitations recorded at execution.
- Site publishing and broader governance remain outside this branch.


## Stages

| Stage | Input | Output | Next |
| --- | --- | --- | --- |
| [S01: Ensure Workflow Directory](#stage-s01) | S01-I01 | S01-O01 | [S02](#stage-s02) |
| [S02: Ensure Scripts Directory](#stage-s02) | S02-I01 | S02-O01 | [S03](#stage-s03) |
| [S03: Validate Maintenance Subgoal](#stage-s03) | S03-I01, S03-I02 | S03-O01 | End |

<a id="stage-s01"></a>

## S01: Ensure Workflow Directory

Ensure that the repository has a usable GitHub Actions directory while
preserving every existing workflow file.

The directory artifact for this stage is [`.github/workflows/`](../../.github/workflows/),
which houses the repository’s workflow definitions.

### Input Conditions

#### S01-I01: Repository Available

- Confirm the repository root and inspect `.github/workflows` for conflicts.

### Actions

- Create `.github/workflows/` only if absent. Preserve existing files.
- Stop if the path exists as a non-directory.

### Output Conditions

#### S01-O01: Workflow Directory Available

- Verify [workflow directory](../../.github/workflows/) exists as a directory.
- Inspect the diff to establish that existing workflow content was preserved.

<a id="stage-s02"></a>

## S02: Ensure Scripts Directory

Ensure that the repository has a usable scripts directory while preserving
existing tools and making the prerequisite available to the maintenance subgoal.

The directory artifact for this stage is [`scripts/`](../../scripts/).
Release-specific programs live in its [`double-release/`](../../scripts/double-release/) subdirectory.

### Input Conditions

#### S02-I01: Workflow Prerequisite

- Establish S01-O01 and inspect `scripts` for conflicts.

### Actions

- Create `scripts/` only if absent. Preserve all existing tools.
- Stop on a non-directory conflict.

### Output Conditions

#### S02-O01: Scripts Directory Available

- Verify [scripts directory](../../scripts/) exists as a directory.
- Inspect the diff to establish that existing tools were preserved.

<a id="stage-s03"></a>

## S03: Validate Maintenance Subgoal

Coordinate the release-maintenance subgoal and verify its returned contract,
local checks and hosted evidence against the parent goal’s success criteria.

The linked deliverables are the [maintenance goal](./github-actions-maintenance/github-actions-maintenance.md#github-actions-maintenance),
its [plan](./github-actions-maintenance/plan.md#releaseguard), and the
[accepted validation evidence](./github-actions-maintenance/github-actions-maintenance.md#release-validation-2026-11-06).
The subgoal owns the release programs, workflow and tests described in its stages.

### Input Conditions

#### S03-I01: Parent Prerequisites

- Establish S01-O01 and S02-O01.

#### S03-I02: Subgoal Interface Available

- Read the [maintenance goal](./github-actions-maintenance/github-actions-maintenance.md#github-actions-maintenance)
  and [plan](./github-actions-maintenance/plan.md#releaseguard).
- Confirm entry at its S01 and exit at S04, and review its current control boundaries.

### Actions

- Pass the workflow/scripts directories and their existing content to
  [subgoal S01](./github-actions-maintenance/plan.md#stage-s01).
- Follow the subgoal's review, execution and validation boundaries. Reuse prior
  evidence only when it applies to the candidate being assessed.
- Obtain the contract, local test/package evidence, adapter checks and hosted
  evidence from [subgoal S04](./github-actions-maintenance/plan.md#stage-s04).
- Return to parent S03, compare the outputs to the parent success criteria,
  and stop for revision if the interface or evidence is insufficient.

### Output Conditions

#### S03-O01: Maintenance Outputs Validated

- Establish subgoal S04-O01 and S04-O02 using linked evidence.
- Confirm all S01–S04 checks of the subgoal support the parent target state.
- After parent validation, the current release scope is complete. Later requested
  extensions enter [subgoal S05](./github-actions-maintenance/plan.md#stage-s05)
  and return their validated outputs to this stage for integration review.
