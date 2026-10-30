---
id: installdouble
kind: plan-model
status: release-candidate
template-id: plan-model-template
project-id: double
produced-by: machine-of-goals/plan-synthesis-agent
interaction-language: ru
artifact-language: en
goal-id: double-installer
branch: main
plan-revision: 16
derived-from:
  - ./double-installer.md
  - ./path-options.md
---

<a id="installdouble"></a>

# Plan: Minimal Double Bash Installer / main

Goal: [Minimal Double Bash Installer](./double-installer.md#double-installer).
Paths: [Path options](./path-options.md#double-installer-path-options).

## Model

- Initial state: an installer and test suite exist. Inspect the current implementation, release behavior and environment before deciding which changes are needed.
- Target state and success criteria: see the linked goal; verify all applicable conditions before acceptance.
- Evidence: prefer documentary evidence; an explicit user statement may be recorded as a fallback.

## Selection and Control Boundaries

- Review this model and select any applicable path and entry before execution.
- Stop for missing inputs, unsafe operations, unavailable evidence or actions outside the authorized scope.
- Publication, host changes and real installations require explicit authorization.

- Inspect the existing GitHub release transport first. Retain or change it only after reviewing [direct API](./path-options.md#path-direct-release-api) and [GitHub CLI](./path-options.md#path-github-cli-consumer) against the desired change; both converge at S03.
- S05R is optional: invoke the Podman subgoal only if Podman is selected and its VM needs preparation. Supply its readiness evidence to S06; other suitable Linux environments do not require S05R. S06 delegates validation and returns evidence and any gaps for the parent decision.

## Stages

| Stage | Input | Output | Next |
| --- | --- | --- | --- |
| [S01: Establish installation contracts](#stage-s01) | The goal, path options and packaging interface are available for review. | The contracts cover the goal capabilities and identify ownership, dependencies and stop conditions. | S02A or S02B |
| [S02A: Consume releases through the direct API](#stage-s02a) | S01 contracts and selection of the direct API path are available. | Fixtures verify pagination, Stable preference, RC fallback with notification and permission, unattended denial without prior permission, channels, errors and checksums; a selected published package can be checked without project mutation. | S03 |
| [S02B: Consume releases through GitHub CLI](#stage-s02b) | S01 contracts and selection of the GitHub CLI path are available. | Equivalent channel, integrity and failure checks pass, including missing client or credentials. | S03 |
| [S03: Establish managed installation lifecycle](#stage-s03) | S01 and either S02A or S02B provide a verified package interface. | Disposable multi-project tests demonstrate correct ownership, collision handling, removal and recoverable failure. | S04 |
| [S04: Establish updates and backups](#stage-s04) | S03 provides managed installations and inventories. | Tests verify backups, no implicit downgrade, registry consistency and partial failure reporting. | S05 |
| [S05: Establish scheduling and cleanup](#stage-s05) | S04 provides the update and backup lifecycle. | Isolated tests establish idempotent scheduling, preservation of unrelated content and recoverable cleanup. | S05A |
| [S05R: Prepare the Linux validation environment](#stage-s05r) | Podman is selected as an available validation environment and its host context is known. | The selected Podman environment is usable and its startup evidence is available; otherwise the limitation is explicit and that environment is not treated as ready. | S06 |
| [S05A: Provide download and agent integration](#stage-s05a) | The release and managed-installation interfaces are specified. | Isolated tests cover download selection, consent, agent discovery, collision handling, updates and removal. | S05R if needed, otherwise S06 |
| [S06: Validate and document the installer](#stage-s06) | The candidate installer, scenarios and applicable environment are available. | Required platform, lifecycle, release and documentation evidence satisfies the goal criteria, or gaps are recorded. | End |

<a id="stage-s01"></a>

## S01: Establish installation contracts

Stage slug: `installation-contract`

### Input Conditions

- S01-I01: The goal, path options and packaging interface are available for review. Check the applicable goal, prior outputs and authorization.

### Actions

Inspect the existing installer and test suite. Compare CLI, dependency, platform, release channels, state, registry, ownership and recovery contracts with the goal; identify intended changes and preserve unmanaged content. Apply the Stable-first, RC-fallback policy: notify the user and obtain explicit permission before selecting RC; without permission, stop rather than select it.

### Output Conditions

- S01-O01: The contracts cover the goal capabilities and identify ownership, dependencies and stop conditions. Verify against documented results or an explicit user statement.

<a id="stage-s02a"></a>

## S02A: Consume releases through the direct API

Stage slug: `direct-release-api`

### Input Conditions

- S02A-I01: S01 contracts and selection of the direct API path are available. Check the applicable goal, prior outputs and authorization.

### Actions

Assess and, where required by the reviewed change, update paginated release discovery, per-machine version and channel selection, verified asset downloads and caching using curl and jq.

### Output Conditions

- S02A-O01: Fixtures verify pagination, Stable preference, RC fallback with notification and permission, unattended denial without prior permission, channels, errors and checksums; a selected published package can be checked without project mutation. Verify against documented results or an explicit user statement.

<a id="stage-s02b"></a>

## S02B: Consume releases through GitHub CLI

Stage slug: `github-cli`

### Input Conditions

- S02B-I01: S01 contracts and selection of the GitHub CLI path are available. Check the applicable goal, prior outputs and authorization.

### Actions

If this alternative is selected, implement complete release enumeration and verified downloads with explicit authentication and unattended-operation requirements.

### Output Conditions

- S02B-O01: Equivalent channel, integrity and failure checks pass, including missing client or credentials. Verify against documented results or an explicit user statement.

<a id="stage-s03"></a>

## S03: Establish managed installation lifecycle

Stage slug: `managed-lifecycle`

### Input Conditions

- S03-I01: S01 and either S02A or S02B provide a verified package interface. Check the applicable goal, prior outputs and authorization.

### Actions

Validate archive scope and links, manage owned file inventories and registry, serialize changes and provide recoverable installation and removal.

### Output Conditions

- S03-O01: Disposable multi-project tests demonstrate correct ownership, collision handling, removal and recoverable failure. Verify against documented results or an explicit user statement.

<a id="stage-s04"></a>

## S04: Establish updates and backups

Stage slug: `updates-backups`

### Input Conditions

- S04-I01: S03 provides managed installations and inventories. Check the applicable goal, prior outputs and authorization.

### Actions

Implement per-machine and bulk updates, preserve channel policy, back up managed content and remove obsolete owned files safely.

### Output Conditions

- S04-O01: Tests verify backups, no implicit downgrade, registry consistency and partial failure reporting. Verify against documented results or an explicit user statement.

<a id="stage-s05"></a>

## S05: Establish scheduling and cleanup

Stage slug: `scheduling-cleanup`

### Input Conditions

- S05-I01: S04 provides the update and backup lifecycle. Check the applicable goal, prior outputs and authorization.

### Actions

Implement optional marked cron scheduling and complete removal of installer-owned installations and state.

### Output Conditions

- S05-O01: Isolated tests establish idempotent scheduling, preservation of unrelated content and recoverable cleanup. Verify against documented results or an explicit user statement.

<a id="stage-s05r"></a>

## S05R: Prepare the Linux validation environment

Stage slug: `podman-readiness`

### Input Conditions

- S05R-I01: Podman is selected as an available validation environment and its host context is known. Check the applicable goal, prior outputs and authorization.

### Actions

Use the [Podman subgoal](./podman-krunkit-fix/plan.md#podstart) where needed, subject to its own review and authorization.

### Output Conditions

- S05R-O01: The selected Podman environment is usable and its startup evidence is available; otherwise the limitation is explicit and that environment is not treated as ready. Verify against documented results or an explicit user statement.

<a id="stage-s05a"></a>

## S05A: Provide download and agent integration

Stage slug: `agent-integration`

### Input Conditions

- S05A-I01: The release and managed-installation interfaces are specified. Check the applicable goal, prior outputs and authorization.

### Actions

Implement bulk download, installation consent and project/global agent integration, respecting shared skill ownership, backups and independent failure handling.

### Output Conditions

- S05A-O01: Isolated tests cover download selection, consent, agent discovery, collision handling, updates and removal. Verify against documented results or an explicit user statement.

<a id="stage-s06"></a>

## S06: Validate and document the installer

Stage slug: `installer-validation`

### Input Conditions

- S06-I01: The candidate installer, scenarios and applicable environment are available. Check the applicable goal, prior outputs and authorization.

### Actions

Delegate to the [validation plan](./double-installer-validation/plan.md#installproof); integrate its evidence and assess the goal criteria.

### Output Conditions

- S06-O01: Validation results and gaps are reported against the applicable goal criteria. Goal completion requires all applicable criteria to be accepted; gaps alone do not establish success. Verify against documented results or an explicit user statement.
