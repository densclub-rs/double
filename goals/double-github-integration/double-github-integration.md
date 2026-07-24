---
id: double-github-integration
kind: goal-artifact
produced-by: machine-of-goals/goal-formulation-agent
interaction-language: en
artifact-language: en
current-step: 01-goal-formulation
current-mode: clarification
next-expected-step: 02-path-discovery
transition-condition: goal is sufficiently clear to search for paths and has no open questions
goal-catalog: ./goals
goal-directory: ./goals/double-github-integration
goal-artifact: ./goals/double-github-integration/double-github-integration.md
goal-scope: main-goal
parent-goal-id: null
parent-goal-directory: null
subgoal-directory: null
derived-from:
  - source conversation on 2026-07-18
  - ../../.github/workflows/release.yml
  - ../../Double.md
---

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

### Owner

The Double project community, with the user initiating this goal responsible
for goal decisions during formulation.

### Stakeholders

- Double users and readers
- Double contributors and maintainers
- agents that use, maintain, or distribute Double artifacts
- visitors to the Double GitHub site

## 3. Motivation

- Make Double usable, discoverable, and trustworthy in its GitHub home.
- Provide a durable home for the project site, releases, workflows, and
  contribution surfaces.
- Let GitHub-related work be separated into focused subgoals while preserving a
  shared project-level direction.
- Without this goal, GitHub maintenance may remain fragmented and the public
  project experience may be incomplete or inconsistent.

## 4. Current State

Double is hosted in a GitHub repository and already contains GitHub release
automation. The complete desired GitHub integration, project-site contract,
and subgoal structure have not yet been formulated as one maintained goal.

### Known facts

- The Double repository remote is `git@github.com:soliverr/double.git`.
- `.github/workflows/release.yml` defines a tagged-release workflow.
- The release workflow packages project and Machine of Ideas releases and
  publishes GitHub release artifacts with checksums.
- Double contains foundational project material, a `.double/` operating
  catalog, and a `goals/` catalog.
- This goal is intended to be a main goal with multiple subgoals.

### Relevant environment

The Double GitHub organization/repository environment, GitHub Actions, GitHub
Pages or another GitHub-connected publishing surface, and local contributor
workspaces.

### Existing related goals or subgoals

- `double-general-installer` — candidate related goal; it depends on a stable
  GitHub source and release/distribution conventions but is not imported into
  this goal.
- `github-actions-maintenance` — accepted subgoal for creating and maintaining
  Double GitHub Actions workflows.

## 5. Target State

Double has an explicitly defined, reliable, and maintainable GitHub presence.
Its project site and in-scope repository operations provide the agreed
information and functionality; GitHub automation is documented, validated,
and maintained through focused subgoals.

- Required result:
  - a maintained parent goal that governs GitHub-related Double subgoals
  - an agreed and operational GitHub site or GitHub-connected public site for
    Double
  - documented, validated GitHub repository operations within the accepted
    scope
  - clear ownership and integration boundaries between the parent goal and its
    subgoals
  - `.github/workflows/` is the directory for GitHub Actions workflows
  - `.github/workflows/release.yml` configures the release workflow rules
  - `.github/workflows/release.yml` invokes special scripts to test, create and publish releases
- Optional quality improvements: automated quality checks, contribution
  guidance, issue and pull-request workflows, release improvements, project
  analytics, and a custom domain.
- Evidence that would show the target state exists: the public site is
  reachable and reflects its agreed content; in-scope GitHub workflows run as
  documented; each accepted subgoal has validation evidence; and the parent
  goal records how the resulting capabilities are maintained.

## 6. Success Criteria

- Minimal success: an approved GitHub-integration plan exists, the agreed
  GitHub site is operational, and the first essential GitHub-maintenance
  subgoals have completed with recorded validation.
- High-quality success: GitHub-facing operations are reproducible, documented,
  monitored as appropriate, safe for contributors to evolve, and organized as
  reusable, independently validated subgoals.
- Partial success: individual GitHub surfaces or workflows exist but lack a
  coherent parent goal, acceptance criteria, or maintainable operating model.
- Failure / not achieved: Double has no agreed GitHub site or operational
  maintenance model, or its GitHub-facing surfaces are unreliable and
  unvalidated.

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
- Missing resources: accepted site requirements, a subgoal catalog, ownership
  and maintenance policy, and a selected publishing architecture.
- Tools or systems: GitHub repository features, GitHub Actions, GitHub
  Releases, GitHub Pages or an approved alternative, Git, and local tooling.
- People or organizations: the Double project community, maintainers,
  contributors, and future GitHub-site visitors.

## 9. Open Questions


## 10. Boundaries / Non-Goals

- This parent goal does not itself prescribe a site technology, visual design,
  publishing architecture, or complete GitHub governance model.
- It does not silently change existing releases, workflows, repository
  settings, permissions, or public pages.
- It does not replace the separate `double-general-installer` goal.
- It does not make every future Double feature dependent on GitHub; it covers
  the agreed GitHub environment and its integration with the project.

## 11. Related Plan Variants

| Variant | Artifact | Role | Author | Device | Time | Selection Status | Use |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `canonical` | [plan.md](./plan.md) | canonical-community | plan-synthesis-agent | codex-runtime | 2026-07-24T00:04:41+02:00 | selected | active |
