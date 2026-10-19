---
id: double-installer-plan
kind: plan-artifact
template-id: plan-template
project-id: double
produced-by: machine-of-goals/plan-synthesis-agent
interaction-language: ru
artifact-language: en
goal-id: double-installer
goal-artifact: ./double-installer.md
path-options-artifact: ./path-options.md
plan-artifact: ./plan.md
goal-scope: main-goal
parent-goal-id: null
parent-plan-artifact: null
plan-execution-style: single-pass
plan-revision: 3
plan-revision-artifact: ./realizations/plan-revision-3.md
created-at: 2026-10-13T14:59:22Z
updated-at: 2026-10-13T16:07:50Z
derived-from:
  - ./double-installer.md
  - ./path-options.md
---

<a id="double-installer-plan"></a>

# Plan: Minimal Double Bash Installer

## 1. Plan Summary

Build one release-consuming Bash installer with a shared local lifecycle
engine. Choose one GitHub transport branch, converge on verified local
packages, then establish installation, update, removal, scheduling, and cleanup.

- Source goal: [Double Installer](.././double-installer.md#double-installer).
- Source paths: [Path options](.././path-options.md#double-installer-path-options).
- Parent plan: none. No path is selected and no implementation is authorized
  by the creation of this draft plan.
- Proposed deliverables: `scripts/double-installer.sh`,
  `scripts/test-double-installer.sh`, and `knowledge/double-installer/double-installer.md` in the
  repository. These files do not yet exist as outputs of this plan.

### Current State

The [release packager](../../../scripts/double-release.sh) emits machine-specific
archives and SHA-256 checksums. The discovery snapshot contains only two
Machine of Ideas `rc` releases. The installer, registry, and lifecycle checks
remain to be built. The separate
[system installer goal](../../double-system-installer/double-system-installer.md#double-system-installer)
owns installation of the executable entry point.

### Target State

One Bash script works on Linux, macOS, and Windows through Git Bash. It
lists/releases downloads, manages machines across projects through a registry,
backs up and replaces files on update, supports optional cron, and removes
all installer-owned machine installations and state on full uninstallation.
State lives under `~/.local/state/double` according to
[Double State Directory](../../../knowledge/double-state-directory/double-state-directory.md#double-state-directory).

### Success Criteria

The [goal criteria](.././double-installer.md#double-installer) are met by
repeatable multi-project lifecycle checks, a real published-package smoke
check, cron checks where available, and actual platform evidence for Linux,
macOS, and Git Bash on Windows. Fixtures establish scenarios unavailable in
current hosted releases; they never count as evidence of hosted publication.

## 2. State Validation Contract

- Initial: inspect existing scripts, packaging contract, working-tree changes,
  dependency availability, chosen transport, and disposable test boundaries.
- Intermediate: each stage proves its output contract before dependent stages
  proceed. Package integrity precedes extraction; backup precedes replacement;
  successful file mutation precedes final registry state.
- Final: exercise two projects and multiple machines, per-machine versions,
  stable/explicit prerelease selection, update, removal, backup cleanup,
  unattended updating, cron creation/removal, and complete cleanup.
- Evidence: commands, exit codes, platform/tool versions, fixture identifiers,
  observed file/registry results, and hosted tag/checksum in the future run.
- Stop: missing dependencies, unsafe payload, invalid registry, unresolved
  ownership, incomplete recovery, or unavailable required platform evidence.
  Report partial validation rather than declaring cross-platform completion.

## 3. Plan Map

- Displayed run: none (revision-2 evidence retained in run index).
- Displayed plan revision: none.
- Progress synchronized at: never.
- `⚪` means not started. Branch selection occurs at review; markers do not
  imply an execution decision or mutable execution state.

| Progress | Stage | Kind | Inputs | Outputs | Possible Next Stages | Required Validation |
| --- | --- | --- | --- | --- | --- | --- |
| ⚪ | [S01: Contracts](../plan.md#stage-s01) | stage | Goal and paths | CLI, state, ownership, platform contracts | S02A or S02B | V01 |
| ⚪ | [S02A: Direct API](../plan.md#stage-s02a) | stage | S01; direct API path | Verified local packages via curl/jq | S03 | V02 |
| ⚪ | [S02B: GitHub CLI](../plan.md#stage-s02b) | stage | S01; gh path | Verified local packages via gh | S03 | V02 |
| ⚪ | [S03: Installation lifecycle](../plan.md#stage-s03) | merge | Selected S02 branch | Add/remove commands and consistent registry | S04 | V03 |
| ⚪ | [S04: Updates and backups](../plan.md#stage-s04) | stage | S03 | Single/bulk updates and backup cleanup | S05 | V04 |
| ⚪ | [S05: Cron and full cleanup](../plan.md#stage-s05) | stage | S04 | Optional scheduling and full uninstall | S05R | V05 |
| ⚪ | [S05R: Restore Podman Linux environment](../plan.md#stage-s05r) | subplan | [Repair subgoal](.././podman-krunkit-fix/podman-krunkit-fix.md#podman-krunkit-fix) | Working Linux runtime and evidence | S06 | V05R |
| ⚪ | [S06: Platform validation and documentation](../plan.md#stage-s06) | validation | S01–S05 plus accepted S05R | Usage guide and goal evidence | End or stage revision | V06 |

### Selectable Paths and Subplans

| Choice | Plan branch | Trade-off | Compatible registered realizations |
| --- | --- | --- | --- |
| [Direct API](.././path-options.md#path-direct-release-api), recommended | S01 → S02A → S03–S06 | curl/jq; own HTTP pagination/errors; no required gh login for public releases | None |
| [GitHub CLI](.././path-options.md#path-github-cli-consumer) | S01 → S02B → S03–S06 | Dedicated client simplifies GitHub access; requires gh setup and unattended credentials | None |

Only one transport is required for version one. Both implement the same
package interface and local lifecycle. Proposed realization of this development
plan is interactive repository implementation with stage validation. The
delivered Bash installer is a product artifact; its existence does not
register an automatic realization of this development plan.

## 4. Stage Details

<a id="stage-s01"></a>

### S01: Establish Installation Contracts

- Input: [goal](.././double-installer.md#double-installer),
  [paths](.././path-options.md#double-installer-path-options), release packager.
- Output: contract sections in the proposed documentation and a CLI skeleton
  with dependency checks, no project mutation yet.
- Actions: specify commands for release listing/download, machine add/remove,
  registry listing, single/bulk update, backup deletion, cron add/remove, and
  full uninstall; distinguish interactive and noninteractive modes.
- State proposal: an installer-owned `installer/` subtree of the shared state
  root with releases, backups, registry, inventories, lock/recovery state,
  and marked scheduling metadata. Other components' state remains untouched.
- Registry proposal: JSON with schema version and records keyed by canonical
  project path plus machine id; track version, tag, channel policy, owned files,
  and created directories. Store canonical POSIX paths in Git Bash; define
  escaping and reject unsupported path characters explicitly.
- Ownership: only packaged machine-scoped files become managed. Preserve
  user `ideas/`, `goals/`, `knowledge/`, and unowned project files. Refuse
  ambiguous preexisting installations and unowned path collisions.
- Platforms: target Bash 3.2-compatible constructs where practical; establish
  tested OS/tool minimums rather than assuming native utilities are identical.
- Resources: Bash, JSON tooling, filesystem utilities, checksum tools;
  transport-dependent requirements become explicit after selection.
- V01: command contracts cover every goal capability, dependency failures are
  actionable, state ownership is unambiguous, and no machine contracts change.
- Evidence: reviewed contract and dependency-check results.
- Risk/stop: unresolved bootstrap ownership or required package layout change;
  resolve the interface before affected mutations.
- Next: [S02A](../plan.md#stage-s02a) or [S02B](../plan.md#stage-s02b), as confirmed at review.

<a id="stage-s02a"></a>

### S02A: Consume GitHub Releases Directly

- Path: [Direct API](.././path-options.md#path-direct-release-api).
- Input: [S01](../plan.md#stage-s01); output: verified local release assets and metadata.
- Actions: implement REST pagination, draft exclusion, per-machine numeric
  version selection, stable default and explicit `rc`/`dev`, curl downloads,
  errors/rate-limit reporting, and release-specific caching using jq.
- Validation V02: fixtures include pagination, mixed machines/channels,
  unavailable stable versions, network errors, bad checksums, and malformed
  archives. Never downgrade an installation implicitly or choose a prerelease
  as fallback. Verify a real explicitly selected published `rc` package.
- Evidence: fixture results and tag/asset/checksum for the live smoke check.
- Risks/stops: HTTP failures and invalid assets must leave project files unchanged.
- Next: [S03](../plan.md#stage-s03).

<a id="stage-s02b"></a>

### S02B: Consume GitHub Releases Through GitHub CLI

- Path: [GitHub CLI](.././path-options.md#path-github-cli-consumer).
- Input: [S01](../plan.md#stage-s01); output: the same verified-package interface as S02A.
- Actions: use gh for metadata and selected asset downloads; ensure complete
  enumeration rather than relying on a default list limit; document required
  credentials and unattended behavior. Retain identical channel/version rules.
- Validation V02: the same scenarios as S02A plus missing gh, unavailable
  credentials, and cron environment behavior. No credential values in logs.
- Evidence: fixture results and live published-package smoke check.
- Risks/stops: client/authentication failures must precede project mutation.
- Next: [S03](../plan.md#stage-s03). The unselected S02 branch is not implemented.

<a id="stage-s03"></a>

### S03: Establish Managed Installation Lifecycle

- Input: selected S02 branch; output: add/remove commands and persistent registry.
- Actions: validate archive paths/types before extraction; prohibit traversal,
  unsafe links and writes outside the selected machine scope. Derive inventories,
  normalize project paths, serialize mutation with a portable lock, and use
  atomic registry replacement. Track partial transactions for recovery.
- Removal affects owned machine files only; prune only installer-created empty
  directories. Do not recursively delete an entire project's `.double/`.
- V03: install two machines into two disposable projects; repeat an operation;
  restart the script; remove one installation and preserve the other machine
  and unrelated content. Test paths with spaces/non-ASCII, ownership collisions,
  failed writes and interruption. Registry must match actual files or clearly
  retain a recoverable partial operation.
- Evidence: file inventories, registry assertions, failure/recovery results.
- Risk/stop: ambiguous ownership, project symlink escape, or inconsistent state.
- Next: [S04](../plan.md#stage-s04).

<a id="stage-s04"></a>

### S04: Establish Updates and Backup Lifecycle

- Input: [S03](../plan.md#stage-s03); output: single/bulk updates and backup cleanup.
- Actions: compare installed and available versions per machine; download into
  the shared catalog; back up old managed contents, including modifications,
  before replacement. Remove obsolete owned files using old/new inventories.
  Update the registry after success; recover or report partial failure honestly.
- Bulk update continues independent installations with per-installation results
  and a failing aggregate exit code if any operation fails. No changes if
  no applicable newer release exists. Persist explicit channel selection so
  unattended checks respect it; do not silently broaden channels.
- Interactive completion offers backup deletion; unattended mode retains
  backups. An explicit cleanup command removes only identified backups.
- V04: newer/unchanged/older versions, channel selection, obsolete files,
  local modifications, backup failure, write failure, interruption, and partial
  bulk failure. Verify backups contain exact previous contents and a failed
  backup prevents replacement.
- Evidence: before/after files, backup contents, registry and aggregate results.
- Risk/stop: missing backup, unsafe paths, inconsistent recovery information.
- Next: [S05](../plan.md#stage-s05).

<a id="stage-s05"></a>

### S05: Establish Optional Scheduling and Complete Cleanup

- Input: [S04](../plan.md#stage-s04); output: cron management and full uninstall.
- Actions: provide explicit creation/removal of marked cron entries, a user
  schedule argument and documented example; use a stable absolute executable
  path, explicit environment, and noninteractive update mode. Repeated creation
  must not duplicate entries. Missing cron preserves interactive usability.
- Full uninstall stops/removes owned scheduling before deleting installations,
  then deletes downloads, backups, registry, logs/recovery files and empty
  owned directories. Preserve unrelated cron entries and other components'
  state. Failures retain the information required to retry remaining work.
- V05: use an isolated crontab adapter for automated tests; verify idempotence,
  unrelated entries, no-cron behavior, overlapping updates, and full cleanup
  with sentinel files in projects and the shared state root. Validate real cron
  behavior only in an explicitly designated disposable environment.
- Evidence: crontab before/after, noninteractive results and remaining-file checks.
- Risk/stop: a running update must be serialized with cleanup; unknown cron
  ownership or failed machine removal prevents a false full-success report.
- Next: [S05R](../plan.md#stage-s05r).

<a id="stage-s05r"></a>

### S05R: Restore the Podman Linux Environment

- Delegated goal: [Podman krunkit Fix](.././podman-krunkit-fix/podman-krunkit-fix.md#podman-krunkit-fix).
- Subgoal plan: not yet created; required before realization of this stage.
- Entry: S05 accepted, Linux startup failure recorded during the earlier S06 attempt.
- Input: host/provider diagnosis and the [supplied solution reference](https://thomasuebel.de/blog/podman-desktop-on-macos/).
- Output: a usable Linux runtime, safe configuration/repair evidence, and a
  repeatable entry point for the installer tests.
- V05R: Podman VM startup and actual Linux command execution succeed; required
  test tooling and invocation are identified. Preserve existing VM data.
- Stop: repair path not reviewed, VM data disposition unknown before deletion,
  unapproved dependency installation or configuration changes.
- Integration: this subgoal owns environment repair; parent S06 owns installer
  validation. Accept the subgoal result before entering/resuming S06.
- Next: [S06](../plan.md#stage-s06).

<a id="stage-s06"></a>

### S06: Validate Platforms and Document Adoption

- Input: [S01–S05](../plan.md#stage-s01) and accepted [S05R](../plan.md#stage-s05r); output: proposed usage guide, repeatable test
  script, and explicit goal-validation evidence.
- Preconditions: the Podman repair subgoal is complete and its Linux entry point
  is accepted. Preserve earlier macOS evidence, but resume S06 only after S05R.
- Actions: run end-to-end fixtures and live published-package smoke checks;
  verify Linux, macOS, and actual Windows Git Bash. Document dependencies,
  bootstrap boundary, commands, state layout, backups, channels, cron, cleanup,
  partial failure handling and current published-release limitations.
- V06: all goal capabilities pass on intended platforms; fixtures cover stable
  and multi-machine cases even if hosted packages remain unavailable. State
  which checks used fixtures and which used real downloads and OS runtimes.
- Existing regression: run the release test script if implementation changes
  packaging/shared code; always run syntax checks and diff checks for changes.
- Evidence: platform matrix, dependency versions and reproducible results in
  the future run. Stage acceptance follows Machine of Goals validation dialogue.
- Risks/stops: lack of Windows/Linux execution access remains incomplete
  validation; do not substitute macOS tests for platform evidence.
- Next: close only after accepted final validation; otherwise revise the
  affected stage and realization alignment.

## 5. Shared Dependencies

- Internal: packaging contract, installed-file ownership, registry schema,
  state convention and stable entry-point interface with the system installer.
- External: GitHub availability, selected transport dependencies, tar/checksum
  utilities, platform execution environments, optional cron.
- Decision: explicit user path selection and development realization approval
  before registration or execution. Publication of new stable packages is
  external work, not an implicit deliverable of this plan.

## 6. Shared Risks and Controls

| Risk | Control | Stop condition |
| --- | --- | --- |
| Unrelated files removed | Validated inventories, ownership checks, sentinel tests | Ambiguous ownership |
| Corrupt payload | Checksum and archive member validation before use | Invalid package |
| Partial mutation or concurrent cron | Lock, backup, recovery records, atomic registry writes | Recovery cannot establish consistent state |
| Platform path/tool differences | Real platform matrix, canonical paths, quoted arguments | Required platform checks unavailable |
| Shared state or cron cleanup too broad | Owned subtree and marked cron entries only | Unknown ownership |
| No stable hosted machine release | Explicit unavailable result; fixtures and explicit rc smoke check | Never silently switch channel |

## 7. Automation Boundaries

- After review approval: repository implementation, fixture creation, checks,
  temporary project lifecycle tests, and public release reads/downloads.
- Real user projects, real cron configuration, dependency installation, and
  system bootstrap changes require an explicitly designated scope before use.
  Fixture tests must use a temporary state root and crontab adapter.
- Product commands perform requested actions; full uninstall is explicit and
  confirms the affected projects/state before deletion. Noninteractive cron
  can update only registered installations and retains backups.
- Not allowed: unrelated user changes, `.double/` process edits, machine
  version changes, automatic scheduler installation, or publication of releases.
- Preview destructive operations and cron changes against disposable targets
  before validating them; do not create a live cron task during development.

## 8. Revision and Alignment Conditions

- Refine a stage when implementation exposes missing command/schema details.
- Revise the transition model if payload ownership, distribution interface,
  cleanup scope, platform coverage, or stage topology materially changes.
- Reformulate the goal if requirements need a package manager, different
  implementation language, or unsupported operating environment.
- Mark registered realizations `review-required` when a semantic plan change
  invalidates their procedure or validation contract.
- Before first registration both revision fields stay null; refine this plan
  without snapshots. After registration semantic revisions require a new
  immutable snapshot before execution. Statistics alone do not create revisions.

## 9. Subgoal Integration Boundaries

[Podman krunkit Fix](.././podman-krunkit-fix/podman-krunkit-fix.md#podman-krunkit-fix)
is an accepted subgoal. Its plan must be synthesized and reviewed before repair.

| Subgoal | Subgoal Plan | Entry Stage | Input Artifact | Output Artifact | Exit Stage | Parent Continuation |
| --- | --- | --- | --- | --- | --- | --- |
| [Podman repair](.././podman-krunkit-fix/podman-krunkit-fix.md#podman-krunkit-fix) | Not yet created | [S05R](../plan.md#stage-s05r) | Subgoal diagnosis and supplied reference | Working Linux entry point and validation evidence, to be produced | Subgoal validation, to be planned | [S06](../plan.md#stage-s06) |

Double System Installer is a separate related
main goal, not a subplan. Its interface supplies a stable executable entry
point; this plan supplies its documented invocation and dependency contract.
Bootstrap-owned executable removal must follow its ownership contract rather
than deleting an arbitrary script path from this installer.

<a id="realization-registry"></a>

## 10. Realization Registry

The user selected Direct API and interactive repository development on
2026-10-13. Start at S01 within the approved boundaries.

| Record | Realization Artifact | Realization | Kind | Selected Path or Subplan | Decision | Plan Revision | Realization Revision | Registration | Readiness | Alignment | Runs | Last Run | Last Result |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---: | --- | --- |
| <a id="interactive-rest"></a>`interactive-rest` | [Interactive REST](.././realizations/interactive-rest.md#interactive-rest) | Interactive repository development | manual | [Direct API](.././path-options.md#path-direct-release-api) | [Decision](.././realization-decision.md#double-installer-realization-decision) | [Revision 2](.././realizations/plan-revision-2.md#double-installer-plan) | [Revision 2](.././realizations/interactive-rest.md#interactive-rest-revision-2) | registered at 2026-10-13T15:03:39Z | ready | review-required | 2 | 2026-10-13T15:31:07Z | partial |

Computed style is `single-pass` because no automatic realization is registered.
The product's cron capability does not itself change this plan's style.
Registration, decision, local revision-1 snapshot and persistent realization
artifact exist after explicit user review; the first run is active. Retain five terminal
runs per future realization; cumulative statistics live here, retained run
links in its realization artifact and the future run index.

The current plan revision 2 changes the documentation output into a knowledge
artifact through Machine of Knowledge. Revision 1 and the existing run stay
pinned and immutable. Realization revision 2 is aligned for S03 continuation.

## 11. Open Questions

The new Podman repair subgoal requires path discovery, its own plan, and a
reviewed realization before S05R execution. Parent S06 resumes only after its
accepted result. Earlier macOS evidence remains valid historical evidence.

Revision 3 inserts the user-requested S05R prerequisite before S06. Prior
revision-2 S06 evidence is retained, not erased. Existing realization alignment
must be reviewed before a new run uses this changed topology.
