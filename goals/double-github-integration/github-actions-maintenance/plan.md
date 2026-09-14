---
id: github-actions-maintenance-plan
kind: plan-artifact
project-id: double
produced-by: plan-synthesis-agent
interaction-language: ru
artifact-language: en
goal-id: github-actions-maintenance
goal-artifact: ./github-actions-maintenance.md
path-options-artifact: ./path-options.md
plan-artifact: ./plan.md
goal-scope: subgoal
plan-execution-style: multi-pass
parent-goal-id: double-github-integration
parent-plan-artifact: ../plan.md
plan-revision: 1
created-at: 2026-07-22T14:16:01Z
updated-at: 2026-09-02T00:00:00Z
derived-from:
  - ./github-actions-maintenance.md
  - ./path-options.md
---

<a id="github-actions-maintenance-plan"></a>

# Plan: GitHub Actions Maintenance

## 1. Plan Summary

This plan defines one transition model for implementing and maintaining
Double's GitHub Actions release workflow and its supporting scripts. It uses
the selected shell-script/workflow-adapter path and keeps local packaging
separate from GitHub publication.

- Source goal: [GitHub Actions Maintenance](./github-actions-maintenance.md#github-actions-maintenance)
- Selected path: [Shell Script with Thin Workflow Adapter](./path-options.md#shell-script-workflow-adapter)
- Parent plan: [Double GitHub Integration](../plan.md#double-github-integration-plan)

### Current State

The parent plan provides the `.github/workflows/` and `scripts/` directories
required for this subgoal.

### Target State

- The YAML file `.github/workflows/release.yml` defines the GitHub Actions
  rules for the release workflow.
- The shell script `scripts/double-release.sh` can be executed locally and in
  GitHub Actions.

### Success Criteria

Local packaging and the hosted workflow produce the declared release behavior;
the package contains only eligible files, checksums match, and publication is
restricted to GitHub Actions.

## 2. State Validation Contract

- Initial state checks: confirm that `.github/workflows/` and `scripts/` exist
  as the directories provided by the parent plan.
- Required intermediate state checks: the S01 contract is explicit; S02 local
  packaging satisfies it; S03 invokes the same interface from GitHub Actions.
- Final state checks: hosted workflow behavior agrees with the local contract
  for representative stable, `rc`, `dev`, no-match, and mismatch cases.
- Evidence requirements: local test output, package and checksum inspection,
  workflow configuration, and authorized hosted-run evidence.
- Stop when validation cannot be completed: do not publish when the package,
  status filter, version check, checksum, or publication boundary diverges.

## 3. Plan Map

| Stage | Kind | Inputs | Outputs | Possible Next Stages | Required Validation |
| --- | --- | --- | --- | --- | --- |
| [S01: Specify the Release Contract](#stage-s01) | stage | goal, path-options, workflow, version knowledge | release-script contract | [S02](#stage-s02) | contract covers local execution, CLI archive creation, tag, status, version, package, warning, and publication rules |
| [S02: Implement and Validate Local Packaging](#stage-s02) | stage | [S01](#stage-s01) | validated local package and checksum behavior | [S03](#stage-s03) | local tests satisfy the S01 contract |
| [S03: Adapt and Validate the GitHub Workflow](#stage-s03) | stage | [S01](#stage-s01), [S02](#stage-s02) | thin autonomous workflow adapter | [S04](#stage-s04) | workflow invokes the final script interface |
| [S04: Validate the Hosted Release Operation](#stage-s04) | validation | [S02](#stage-s02), [S03](#stage-s03) | hosted validation evidence | none | hosted behavior agrees with the accepted contract |

## 4. Stage Details

<a id="stage-s01"></a>

### Stage: Specify the Release Contract

- Stage id: `S01`
- Kind: stage
- Purpose: define one executable contract for
  `scripts/double-release.sh`.
- Input state: goal and path contract, current workflow, and selected
  machine-version knowledge.
- Output state: an approved local shell-script contract that builds a release
  archive from command-line arguments, with separate publication behavior for
  GitHub Actions.
- Preconditions: tag grammar, status classes, version knowledge, and the
  local-publication boundary are identified.
- Actions:
  - define local execution of `scripts/double-release.sh`;
  - define command-line arguments for archive creation, including
    `package --tag <tag>`;
  - define `<machine>-<major>.<minor>.<patch>[-dev|-rc]` parsing and matching
    machine/status selection;
  - obtain the selected machine version from
    `knowledge/<machine>-version/<machine>-version.md` in the tagged tree;
  - make a tag/knowledge mismatch the sole contract-level failure and report
    other specified non-success conditions as warnings;
  - inject the verified version only into distribution copies;
  - define checksums, no-match behavior, prerelease behavior, and the boundary
    that only GitHub Actions may publish.
- Required resources: goal artifact, path-options, current workflow, and
  machine-version knowledge artifacts.
- Possible input stages: none.
- Possible output stages: [S02: Implement and Validate Local Packaging](#stage-s02).
- Related path: [Shell Script with Thin Workflow Adapter](./path-options.md#shell-script-workflow-adapter).
- Validation criteria: the contract explicitly covers local execution,
  command-line archive creation, tag, status, version, package, warning,
  checksum, prerelease, and publication rules.
- Evidence expected: reviewed contract consistent with the goal and path
  options.
- Risks: an incomplete contract can make local and hosted behavior diverge.
- Stop points: stop if the contract conflicts with the goal's release classes
  or publication boundary.

<a id="stage-s02"></a>

### Stage: Implement and Validate Local Packaging

- Stage id: `S02`
- Kind: stage
- Purpose: implement the reusable packager and prove its local behavior.
- Input state: accepted S01 contract.
- Output state: `package --tag <tag>` writes the selected package and checksum,
  warns without an empty package, or fails on tag/knowledge mismatch.
- Preconditions: the release script interface is fixed by S01.
- Actions:
  - implement tag parsing, machine/status selection, version-knowledge lookup,
    generated archive versions, archive creation, and checksums;
  - keep `package` incapable of GitHub publication;
  - test stable, `rc`, and `dev` tags, warning paths, no-match behavior,
    version mismatch, generated archive content, and unchanged source files.
- Required resources: S01 contract, shell utilities, Git, fixture repository,
  and release scripts.
- Possible input stages: [S01: Specify the Release Contract](#stage-s01).
- Possible output stages: [S03: Adapt and Validate the GitHub Workflow](#stage-s03).
- Related path: [Shell Script with Thin Workflow Adapter](./path-options.md#shell-script-workflow-adapter).
- Validation criteria: local tests prove selection, version injection,
  warnings, no-match behavior, checksums, and non-publication.
- Evidence expected: passing local test output and inspected archive contents.
- Risks: nondeterministic archives or an accidental local publication path.
- Stop points: stop if `package` can publish or if a non-version condition
  fails instead of warning.

<a id="stage-s03"></a>

### Stage: Adapt and Validate the GitHub Workflow

- Stage id: `S03`
- Kind: stage
- Purpose: make `.github/workflows/release.yml` a thin autonomous adapter for
  the final script contract.
- Input state: accepted S01 contract and validated S02 package behavior.
- Output state: tag pushes and manual dispatch call
  `scripts/double-release.sh publish --tag <tag>`.
- Preconditions: the local package command and publication boundary are
  validated.
- Actions:
  - forward the same approved tag grammar for push and manual dispatch;
  - retain only `contents: write`, the automatic GitHub token, and the defined
    prerelease behavior;
  - keep 14-day retention for logs and temporary workflow artifacts without
    deleting published release assets;
  - verify the adapter matches the final machine-version contract.
- Required resources: S01 contract, S02 implementation, workflow file, and
  GitHub Actions configuration.
- Possible input stages:
  - [S01: Specify the Release Contract](#stage-s01)
  - [S02: Implement and Validate Local Packaging](#stage-s02)
- Possible output stages: [S04: Validate the Hosted Release Operation](#stage-s04).
- Related path: [Shell Script with Thin Workflow Adapter](./path-options.md#shell-script-workflow-adapter).
- Validation criteria: workflow triggers and manual dispatch pass the same tag
  to the final publication interface with the declared permissions.
- Evidence expected: reviewed workflow configuration and successful local
  adapter checks.
- Risks: workflow-only behavior could drift from the local implementation.
- Stop points: stop before hosted publication if the adapter changes the
  approved interface or permission boundary.

<a id="stage-s04"></a>

### Stage: Validate the Hosted Release Operation

- Stage id: `S04`
- Kind: validation
- Purpose: collect authorized evidence that GitHub-hosted release behavior
  agrees with the accepted local contract.
- Input state: validated S02 package implementation and S03 workflow adapter.
- Output state: hosted validation evidence and any required plan revision.
- Preconditions: authorization exists to inspect representative workflow runs,
  releases, and retention configuration.
- Actions:
  - inspect a representative GitHub Actions run, release assets, warnings,
    checksum, prerelease classification, and retention configuration;
  - compare hosted behavior with stable, `rc`, `dev`, no-match, and version
    mismatch rules;
  - record any needed plan revision.
- Required resources: GitHub Actions, GitHub Releases, repository settings,
  and authorized hosted evidence.
- Possible input stages:
  - [S02: Implement and Validate Local Packaging](#stage-s02)
  - [S03: Adapt and Validate the GitHub Workflow](#stage-s03)
- Possible output stages: none.
- Related path: [Shell Script with Thin Workflow Adapter](./path-options.md#shell-script-workflow-adapter).
- Validation criteria: hosted behavior matches the package, warning,
  prerelease, checksum, permission, and retention contract.
- Evidence expected: representative hosted run and release evidence, or an
  explicit user confirmation accepted as hosted validation.
- Risks: hosted settings or release behavior may differ from local tests.
- Stop points: stop before changing repository settings or published assets
  without explicit confirmation.

## 5. Shared Dependencies

- Internal dependencies: the goal artifact, path-options, release scripts, and
  `.github/workflows/release.yml`.
- External dependencies: GitHub Actions, GitHub Releases, and the repository's
  version knowledge artifacts.
- Decision dependencies: user approval for repository settings and real release
  publication.

## 6. Shared Risks and Controls

- Risk: local and hosted release behavior diverges.
- Impact: an incorrect or incomplete release may be published.
- Mitigation: keep one script interface, validate locally, and compare hosted
  evidence with the same contract.
- Stop condition: package contents, status selection, version verification,
  checksum, warning behavior, or publication boundary diverges.

## 7. Automation Boundaries

- Allowed automatic actions: local parsing, packaging, checksums, tests, and
  warnings.
- Actions requiring confirmation: changing repository settings, creating or
  updating a real GitHub Release, and altering published assets.
- Actions not allowed: local `package` publication or use of repository secrets
  beyond the automatic GitHub token.
- Dry-run required before: the first real GitHub Release publication after
  workflow-adapter changes.

## 8. Revision and Alignment Conditions

- Revise a stage when: local or hosted evidence exposes a mismatch in its
  contract, implementation, or validation.
- Revise the plan when: the shell-script adapter cannot satisfy both local
  testing and autonomous GitHub Actions publication.
- Reformulate the goal when: releases no longer map one tag to one machine and
  maturity class.
- Mark realizations `review-required` when: a registered realization diverges
  from the goal's release contract or its validation evidence.

## 9. Realization and Execution Context

- Current realization decision:
  [Shell-script workflow decision](./realization-decision.md#github-actions-maintenance-realization-decision)
- Registered realization:
  [Double Release Shell and Workflow](./path-options.md#double-release-shell-workflow)
- Retained execution attempts:
  [Run index](./run/index.md#github-actions-maintenance-run-index)
- Current plan revision: `1`; execution decisions must use an immutable VCS
  permalink rather than this mutable current-plan link.

## 10. Open Questions

None currently.
