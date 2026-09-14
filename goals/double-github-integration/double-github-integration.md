---
id: double-github-integration
kind: goal-artifact
project-id: double
produced-by: goal-formulation-agent
owner-id: double-project
interaction-language: en
artifact-language: en
goal-scope: main-goal
derived-from:
  - source conversation on 2026-07-18
  - ../../.github/workflows/release.yml
  - ../../Double.md
---

<a id="double-github-integration"></a>

# Goal: Double GitHub Integration

## 1. Summary

Establish and maintain Double as a well-operated GitHub project and GitHub
site, with clear, reliable, and maintainable GitHub-based surfaces for people,
contributors, and agents. This is a main goal that will coordinate multiple
independently formulated GitHub-related subgoals.

## 2. Subject of the Goal

### Subject

- The Double GitHub repository and its GitHub-facing project surfaces.
- GitHub workflows, releases, documentation, project-site publishing, and
  contributor-facing repository operations.

## 3. Motivation

- Make Double usable, discoverable, and trustworthy in its GitHub home.
- Provide a durable home for the project site, releases, workflows, and
  contribution surfaces.
- Let GitHub-related work be separated into focused subgoals while preserving a
  shared project-level direction.
- Without this goal, GitHub maintenance may remain fragmented and the public
  project experience may be incomplete or inconsistent.

## 4. Current State

Double is hosted in a GitHub repository and has a maintained parent goal,
canonical integration plan, and an accepted release-maintenance subgoal. The
GitHub site contract, publishing architecture, and remaining GitHub-related
subgoals are not yet fully established.

### Known facts

- The Double repository remote is `git@github.com:soliverr/double.git`.
- `.github/workflows/release.yml` defines a machine-tag release workflow and
  delegates testing and publication to the release-maintenance subgoal.
- The release-maintenance subgoal packages selected machine files and
  publishes GitHub release artifacts with checksums.
- Double contains foundational project material, a `.double/` operating
  catalog, and a `goals/` catalog.
- This goal is a main goal with an accepted `github-actions-maintenance`
  subgoal and room for additional focused subgoals.

### Relevant environment

The Double GitHub organization/repository environment, GitHub Actions, GitHub
Pages or another GitHub-connected publishing surface, and local contributor
workspaces.

### Existing related goals or subgoals

- `double-general-installer` — candidate; not imported into this goal. It
  depends on a stable GitHub source and release/distribution conventions.
- [GitHub Actions Maintenance](./github-actions-maintenance/github-actions-maintenance.md#github-actions-maintenance)
  — imported accepted subgoal for creating and maintaining Double GitHub
  Actions workflows.

## 5. Target State

The GitHub Actions rules and workflow for Double, together with their
maintenance, are defined by the `github-actions-maintenance` subgoal.

- Required result:
  - `.github/workflows/` exists and is available for GitHub Actions workflow
    rules
  - `scripts/` exists and is available for release and validation scripts
  - GitHub Actions rules and a workflow for maintaining them, fully defined by
    [github-actions-maintenance.md](./github-actions-maintenance/github-actions-maintenance.md) subgoal

## 6. Success Criteria

- Minimal success: the accepted `github-actions-maintenance` subgoal defines
  the GitHub Actions rules and maintenance workflow.
- High-quality success: those rules and the workflow are reproducible,
  documented, validated, and maintainable.
- Partial success: the subgoal exists but its rules or maintenance workflow are
  incomplete or not validated.
- Failure / not achieved: no accepted subgoal defines the GitHub Actions rules
  and workflow for maintaining them.

## 7. Constraints

- Time: not yet specified.
- Attention: formulate and realize the work incrementally through focused
  subgoals; do not turn the parent goal into a single unbounded task list.
- Money: no budget specified; prefer GitHub-native and freely available tools
  unless a later decision approves otherwise.
- Technical constraints: preserve the existing repository and release behavior
  unless a subgoal explicitly changes it; make publishing and automation
  reproducible; avoid exposing credentials or secrets.
- Social / legal / ethical constraints: use accessible, transparent public
  project information; respect contributor consent, licensing, and privacy.
- Other: a subgoal must define its own target state, plan, validation evidence,
  and interface back to this parent goal.

## 8. Resources

- Available resources: the Double repository, its GitHub remote, existing
  `.github/` configuration, release workflow, project documentation, and the
  Machine of Goals workflow.
- Missing resources: accepted site requirements, a selected publishing
  architecture, and the remaining ownership and maintenance policies.
- Tools or systems: GitHub repository features, GitHub Actions, GitHub
  Releases, GitHub Pages or an approved alternative, Git, and local tooling.
- People or organizations: the Double project community, maintainers,
  contributors, and future GitHub-site visitors.

## 9. Open Questions

None currently.

## 10. Boundaries / Non-Goals

- This parent goal does not itself prescribe a site technology, visual design,
  publishing architecture, or complete GitHub governance model.
- It does not silently change existing releases, workflows, repository
  settings, permissions, or public pages.
- It does not replace the separate `double-general-installer` goal.
- It does not make every future Double feature dependent on GitHub; it covers
  the agreed GitHub environment and its integration with the project.

## 11. Machine of Goals Artifacts

- Path and realization registry: [Double GitHub Integration paths](./path-options.md#double-github-integration-path-options)
- Plan: [Double GitHub Integration plan](./plan.md#double-github-integration-plan)
- Retained execution attempts: [Run index](./run/index.md#double-github-integration-run-index)
- Computed plan style: `multi-pass` because the delegated maintenance subplan
  has a registered automatic realization.
