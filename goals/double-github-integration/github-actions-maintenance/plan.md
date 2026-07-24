---
id: github-actions-maintenance-plan
kind: plan-artifact
produced-by: machine-of-goals/plan-synthesis-agent
interaction-language: ru
artifact-language: en
goal-id: github-actions-maintenance
goal-artifact: ./github-actions-maintenance.md
plan-role: canonical-community
plan-filename: plan.md
variant-id: canonical
variant-of: null
canonical-plan-artifact: ./plan.md
author: plan-synthesis-agent
device: codex-runtime
created-at: 2026-07-22T16:16:01+02:00
updated-at: 2026-07-24T17:13:52+02:00
imported-from: null
goal-scope: subgoal
parent-goal-id: double-github-integration
selected-paths:
  - shell-script-workflow-adapter
related-plan-variants: []
existing-plan-implementations: []
derived-from:
  - ./github-actions-maintenance.md
  - ./path-options.md
---

# Plan: GitHub Actions Maintenance

## 1. Plan Summary

This canonical plan defines stages to implement and maintain GitHub Actions for Double project. You can use this plan any time you need to make changes in GitHub Actions workflow and/or maintenance scripts.

## 2. Plan Variant Identity

- Plan role: canonical-community
- Plan filename: `plan.md`
- Canonical plan artifact: `./plan.md`
- Variant of: null
- Active selection status: selected

## 3. Plan Map

| Stage | Status | Validation | Inputs | Outputs | Last Attempt | Last Attempt Time |
| --- | --- | --- | --- | --- | --- | --- |
| [S01: Specify the Release Contract](#stage-s01) | ✅ done | ✅ accepted | goal, path options, workflow, version knowledge | [S02](#stage-s02), [S03](#stage-s03) | not retained | — |
| [S02: Implement and Validate Local Packaging](#stage-s02) | ✅ done | ✅ accepted | [S01](#stage-s01) | [S03](#stage-s03), [S04](#stage-s04) | not retained | — |
| [S03: Adapt and Validate the GitHub Workflow](#stage-s03) | ✅ done | ✅ accepted | [S01](#stage-s01), [S02](#stage-s02) | [S04](#stage-s04) | not retained | — |
| [S04: Validate the Hosted Release Operation](#stage-s04) | ✅ done | ✅ accepted | [S02](#stage-s02), [S03](#stage-s03) | none | not retained | — |

## 4. Blocker

- Blocker: none.

## 5. Stage Attempts

- Retained attempt artifacts: none.
- Evidence policy: the plan records compact validation decisions only.

## 6. Stage Details

<a id="stage-s01"></a>

### Stage: Specify the Release Contract

- Stage id: `S01`
- Status: ✅ done
- Purpose: define one executable contract for `scripts/double-release.sh`.
- Input state: goal and path contract, current workflow, and selected
  machine-version knowledge.
- Output state: an approved `package --tag <tag>` / `publish --tag <tag>`
  contract.
- Actions:
  - accept `<machine>-<major>.<minor>.<patch>[-dev|-rc]` tag parsing and the
    corresponding machine and status selection;
  - obtain the selected machine version from
    `knowledge/<machine>-version/<machine>-version.md` in the tagged tree;
  - make a tag/knowledge mismatch the sole failure; report all other specified
    non-success conditions as warnings;
  - inject the verified version only into distribution copies, leaving source
    working files version-free and unchanged;
  - define checksums, no-match behavior, prerelease behavior, and the boundary
    that only GitHub Actions may publish.
- Validation:
  - Status: ✅ accepted
  - Decision: the combined release contract is accepted and implemented by
    S02.

<a id="stage-s02"></a>

### Stage: Implement and Validate Local Packaging

- Stage id: `S02`
- Status: ✅ done
- Purpose: implement the reusable packager and prove its local behavior.
- Input state: accepted S01 contract.
- Output state: `package --tag <tag>` either writes the selected package and
  checksum, warns without an empty package, or fails only on tag/knowledge
  mismatch.
- Actions:
  - implement tag parsing, machine/status selection, version-knowledge lookup,
    generated archive versions, archive creation, and checksums;
  - keep `package` incapable of GitHub publication;
  - test stable, `rc`, and `dev` tags, warning paths, no-match behavior,
    version mismatch, generated archive content, and unchanged source files.
- Validation:
  - Status: ✅ accepted
  - Decision: local packaging satisfies the combined contract; S03 may use the
    unchanged command interface.

<a id="stage-s03"></a>

### Stage: Adapt and Validate the GitHub Workflow

- Stage id: `S03`
- Status: ✅ done
- Purpose: make `.github/workflows/release.yml` a thin autonomous adapter for
  the final script contract.
- Input state: accepted S01 contract and validated S02 package behavior.
- Output state: tag pushes and manual dispatch call
  `scripts/double-release.sh publish --tag <tag>`.
- Actions:
  - forward the same approved tag grammar for push and manual dispatch;
  - retain only `contents: write`, the automatic GitHub token, and the defined
    prerelease behavior;
  - keep 14-day retention for logs and temporary workflow artifacts without
    deleting published release assets;
  - verify the adapter still matches the final machine-version contract.
- Validation:
  - Status: ✅ accepted
  - Decision: the local workflow adapter is accepted; S04 subsequently
    accepted the hosted operation.

<a id="stage-s04"></a>

### Stage: Validate the Hosted Release Operation

- Stage id: `S04`
- Status: ✅ done
- Purpose: collect authorization-backed evidence that the GitHub-hosted release
  behaves like the accepted local contract.
- Input state: accepted S02 package implementation and S03 workflow adapter.
- Actions:
  - inspect a representative GitHub Actions run, release assets, warnings,
    checksum, prerelease classification, and retention configuration;
  - compare hosted behavior with stable, `rc`, `dev`, no-match, and version
    mismatch rules;
  - record any needed plan revision.
- Validation:
  - Status: ✅ accepted
  - Decision: on 2026-07-24, the user explicitly confirmed that the pipeline
    operates successfully in GitHub; this confirmation is accepted as the
    hosted-validation decision for S04.

## 7. Shared Boundaries, Risks, and Revision Conditions

- Allowed automatically: local parsing, packaging, checksums, tests, and
  warnings.
- Require confirmation: changing repository settings; creating or updating a
  real GitHub Release; altering published assets.
- Stop immediately if local packaging attempts GitHub publication, a package
  includes the wrong machine/status, or a non-version condition fails.
- Revise this plan if local or hosted evidence exposes a mismatch in tags,
  status selection, version knowledge, generated versions, packages,
  checksums, warnings, or retention.

## 8. Open Questions

None.
