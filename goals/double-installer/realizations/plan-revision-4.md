---
id: double-installer-plan
kind: plan-artifact
template-id: plan-template
project-id: double
produced-by: machine-of-goals/plan-synthesis-agent
interaction-language: ru
artifact-language: en
goal-id: double-installer
goal-artifact: ../double-installer.md
path-options-artifact: ../path-options.md
plan-artifact: ../plan.md
goal-scope: main-goal
plan-execution-style: single-pass
plan-revision: 4
plan-revision-artifact: plan-revision-4.md
created-at: 2026-10-13T14:59:22Z
updated-at: 2026-10-15T10:29:19Z
derived-from:
  - ../double-installer.md
  - ../path-options.md
---

<a id="double-installer-plan"></a>

# Plan: Minimal Double Bash Installer

## 1. Plan Summary

Build one release-consuming Bash installer with a shared local lifecycle
engine. Choose one GitHub transport branch, converge on verified local
packages, then establish installation, update, removal, scheduling, and cleanup.

- Source goal: [Double Installer](../double-installer.md#double-installer).
- Source paths: [Path options](../path-options.md#double-installer-path-options).
- Parent plan: none. Direct API and interactive repository development are
  selected; realization revision 3 retains earlier execution evidence and requires
  review against the expanded CI obligations in plan revision 4.
- Proposed deliverables: `scripts/double-installer.sh`,
  `tests/test-double-installer.sh`, and `knowledge/double-installer/double-installer.md` in the
  repository. All three deliverables exist; platform validation remains partial.

### Current State

The [release packager](../../../scripts/double-release.sh) emits machine-specific
archives and SHA-256 checksums. The discovery snapshot contains only two
Machine of Ideas `rc` releases. The installer, registry, and lifecycle fixture checks
are implemented; S01/S02A/S03–S05 are accepted in retained runs. macOS and
published-package evidence exists. Accepted applehv startup enables Linux
validation; Linux installer execution, Windows/Git Bash and real cron remain
unverified. These are evidence limitations, not unimplemented lifecycle commands. The separate
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

The [goal criteria](../double-installer.md#double-installer) are met by
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

- Displayed run: [Revision-3 continuation](../run/interactive-rest--20261014T161825Z.md#double-installer-run-interactive-rest-20261014T161825Z).
- Displayed run baseline: [Revision 3](plan-revision-3.md#double-installer-plan).
- Current plan: revision 4; previous progress remains historical evidence.
- Progress synchronized at: 2026-10-15T10:29:19Z.
- Accepted earlier stages are carried forward by evidence reference. S05R uses
  the accepted delegated result; S06 remains partial. Unselected S02B is not started.

| Progress | Stage | Kind | Inputs | Outputs | Possible Next Stages | Required Validation |
| --- | --- | --- | --- | --- | --- | --- |
| ✅ | [S01: Contracts](#stage-s01) | stage | Goal and paths | CLI, state, ownership, platform contracts | S02A or S02B | V01 |
| ✅ | [S02A: Direct API](#stage-s02a) | stage | S01; direct API path | Verified local packages via curl/jq | S03 | V02 |
| ⚪ | [S02B: GitHub CLI](#stage-s02b) | stage | S01; gh path | Verified local packages via gh | S03 | V02 |
| ✅ | [S03: Installation lifecycle](#stage-s03) | merge | Selected S02 branch | Add/remove commands and consistent registry | S04 | V03 |
| ✅ | [S04: Updates and backups](#stage-s04) | stage | S03 | Single/bulk updates and backup cleanup | S05 | V04 |
| ✅ | [S05: Cron and full cleanup](#stage-s05) | stage | S04 | Optional scheduling and full uninstall | S05R | V05 |
| ✅ | [S05R: Restore Podman Linux environment](#stage-s05r) | subplan | [Repair subgoal](../podman-krunkit-fix/podman-krunkit-fix.md#podman-krunkit-fix) | Startable VM and startup evidence | S06 | V05R |
| 🟡 | [S06: Platform validation and documentation](#stage-s06) | validation | S01–S05 plus accepted S05R | Usage guide and goal evidence | End or stage revision | V06 |

### Selectable Paths and Subplans

| Choice | Plan branch | Trade-off | Compatible registered realizations |
| --- | --- | --- | --- |
| [Direct API](../path-options.md#path-direct-release-api), recommended | S01 → S02A → S03–S06 | curl/jq; own HTTP pagination/errors; no required gh login for public releases | [Interactive REST](#interactive-rest) |
| [GitHub CLI](../path-options.md#path-github-cli-consumer) | S01 → S02B → S03–S06 | Dedicated client simplifies GitHub access; requires gh setup and unattended credentials | None |

Only one transport is required for version one. Both implement the same
package interface and local lifecycle. Proposed realization of this development
plan is interactive repository implementation with stage validation. The
delivered Bash installer is a product artifact; its existence does not
register an automatic realization of this development plan.

## 4. Stage Details

<a id="stage-s01"></a>

### S01: Establish Installation Contracts

- Input: [goal](../double-installer.md#double-installer),
  [paths](../path-options.md#double-installer-path-options), release packager.
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
- Next: [S02A](#stage-s02a) or [S02B](#stage-s02b), as confirmed at review.

<a id="stage-s02a"></a>

### S02A: Consume GitHub Releases Directly

- Path: [Direct API](../path-options.md#path-direct-release-api).
- Input: [S01](#stage-s01); output: verified local release assets and metadata.
- Actions: implement REST pagination, draft exclusion, per-machine numeric
  version selection, stable default and explicit `rc`/`dev`, curl downloads,
  errors/rate-limit reporting, and release-specific caching using jq.
- Validation V02: fixtures include pagination, mixed machines/channels,
  unavailable stable versions, network errors, bad checksums, and malformed
  archives. Never downgrade an installation implicitly or choose a prerelease
  as fallback. Verify a real explicitly selected published `rc` package.
- Evidence: fixture results and tag/asset/checksum for the live smoke check.
- Risks/stops: HTTP failures and invalid assets must leave project files unchanged.
- Next: [S03](#stage-s03).

<a id="stage-s02b"></a>

### S02B: Consume GitHub Releases Through GitHub CLI

- Path: [GitHub CLI](../path-options.md#path-github-cli-consumer).
- Input: [S01](#stage-s01); output: the same verified-package interface as S02A.
- Actions: use gh for metadata and selected asset downloads; ensure complete
  enumeration rather than relying on a default list limit; document required
  credentials and unattended behavior. Retain identical channel/version rules.
- Validation V02: the same scenarios as S02A plus missing gh, unavailable
  credentials, and cron environment behavior. No credential values in logs.
- Evidence: fixture results and live published-package smoke check.
- Risks/stops: client/authentication failures must precede project mutation.
- Next: [S03](#stage-s03). The unselected S02 branch is not implemented.

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
- Next: [S04](#stage-s04).

<a id="stage-s04"></a>

### S04: Establish Updates and Backup Lifecycle

- Input: [S03](#stage-s03); output: single/bulk updates and backup cleanup.
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
- Next: [S05](#stage-s05).

<a id="stage-s05"></a>

### S05: Establish Optional Scheduling and Complete Cleanup

- Input: [S04](#stage-s04); output: cron management and full uninstall.
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
- Next: [S05R](#stage-s05r).

<a id="stage-s05r"></a>

### S05R: Restore the Podman Linux Environment

- Delegated goal: [Podman krunkit Fix](../podman-krunkit-fix/podman-krunkit-fix.md#podman-krunkit-fix).
- Subgoal plan: [Reusable Podman VM Startup](../podman-krunkit-fix/plan.md#podman-krunkit-fix-plan); path/realization review required before execution.
- Entry: S05 accepted, Linux startup failure recorded during the earlier S06 attempt.
- Input: installed Podman, invocation context, host/provider diagnosis and the [supplied solution reference](https://thomasuebel.de/blog/podman-desktop-on-macos/).
- Output: a startable Podman VM, machine/provider identity, startup entry point
  and safe configuration/repair evidence.
- V05R: installed Podman is verified, VM startup succeeds and running state is
  observed. Preserve existing VM data. Installer-specific test tools and Linux
  workload checks belong to S06. The delegated goal is reusable independently
  and as a direct-reference subplan in other plans.
- Stop: repair path not reviewed, VM data disposition unknown before deletion,
  unapproved dependency installation or configuration changes.
- Integration: this subgoal owns environment repair; parent S06 owns installer
  validation. Accept the subgoal result before entering/resuming S06.
- Next: [S06](#stage-s06).

<a id="stage-s06"></a>

### S06: Validate Platforms and Document Adoption

- Input: [S01–S05](#stage-s01) and accepted [S05R](#stage-s05r); output: proposed usage guide, repeatable test
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

### S06 CI Tasks and Acceptance

These tasks refine the owning S06 stage; no separate goal is created.
Local scenarios remain available. GitHub Actions becomes the reproducible
cross-platform execution adapter, invoking the same root tests/ scripts.
Root scripts/ holds repository utilities; the future src/ software project
keeps its own internal tests, per Double Project knowledge.

| Task | Output | Acceptance |
| --- | --- | --- |
| S06-CI01: Prepare scenarios | Portable installer fixtures plus Windows-specific assertions in tests/ | Same test entry points run locally and in CI; shell syntax valid |
| S06-CI02: Implement workflow | Dedicated .github/workflows/installer-tests.yml | Explicit matrix, manual dispatch and relevant pull-request/push checks; read-only repository permissions, timeouts, independent matrix results |
| S06-CI03: Execute matrix | Results for all six OS/architecture combinations below | Each required row passed on the tested commit; no silent skip or optional-failure coverage |
| S06-CI04: Verify real integrations | Separate live GitHub-release smoke and disposable real Linux cron scenario | Actual release tag/checksum and scheduler execution/cleanup evidenced; no fixture results substituted |
| S06-CI05: Consolidate evidence | Job logs/artifacts, tool versions, platform matrix and updated knowledge | Link workflow run/commit/jobs; final user validation; explicit remaining gaps |

### Intended CI Matrix

| OS | Architecture | Candidate runner label |
| --- | --- | --- |
| Linux | x86_64 | ubuntu-24.04 |
| Linux | ARM64 | ubuntu-24.04-arm |
| macOS | x86_64 | macos-15-intel |
| macOS | ARM64 | macos-15 |
| Windows / Git Bash | x86_64 | windows-2025 |
| Windows / Git Bash | ARM64 | windows-11-arm |

Labels verified against [GitHub runner documentation](https://docs.github.com/en/actions/reference/runners/github-hosted-runners)
on 2026-10-15; recheck repository availability and tool setup during CI01/CI02.
This is a finite initial matrix, not a promise to test every historical OS
version or CPU architecture. Record actual OS build, runner image, CPU and
process/tool architecture, Bash/Python/jq/curl/tar/checksum versions per job.
On ARM64 distinguish native tool execution from emulation; do not report native
ARM64 coverage solely from the runner label. Missing required runner/tool
availability blocks that row and requires review, not silent coverage reduction.
The CI macOS image does not revalidate the separate macOS 26.6.2 Podman repair.

### CI Test Boundaries

- All matrix jobs run syntax and installer fixture lifecycle checks using the
  actual scripts/double-installer.sh and tests/test-double-installer.sh.
- Windows jobs explicitly exercise Git Bash (not WSL), native jq CRLF output,
  MSYS argument conversion, spaces/Unicode/apostrophes and persistent registry
  paths, plus interactive/no-cron behavior. Additional tests live in tests/.
- Existing release, Git-helper and navigation suites also get CI execution;
  declare their applicable matrix separately instead of claiming unsupported
  environments passed. Installer coverage is mandatory on all six rows.
- Live-release checks use explicit tag/channel and SHA-256, temporary projects
  and state. They do not publish releases or change real projects; stable
  availability is not assumed from prior rc-only inventory.
- Real cron check runs only in disposable Linux CI scope; prove scheduled
  execution and owned entry removal. Windows cron absence is valid behavior.
- Dependency setup is restricted to disposable runners, with exact versions
  captured. No host package installation follows from this plan amendment.
- Upload logs/results even on failure; bound network waits and job duration.
  No tokens/secrets in logs or fixture payloads; avoid write permissions.
- Preparing workflow is repository work. Hosted execution requires the tested
  checkout to be committed and pushed; record exact commit/run, never claim
  local uncommitted changes were tested by GitHub Actions.
- CI adapters do not automatically register an automatic realization of this
  development plan; computed style remains single-pass.

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

[Podman krunkit Fix](../podman-krunkit-fix/podman-krunkit-fix.md#podman-krunkit-fix)
is an accepted subgoal. Its [plan](../podman-krunkit-fix/plan.md#podman-krunkit-fix-plan) has completed an accepted applehv invocation; the reusable result is ready for caller use.

| Subgoal | Subgoal Plan | Entry Stage | Input Artifact | Output Artifact | Exit Stage | Parent Continuation |
| --- | --- | --- | --- | --- | --- | --- |
| [Podman repair](../podman-krunkit-fix/podman-krunkit-fix.md#podman-krunkit-fix) | [Subgoal plan](../podman-krunkit-fix/plan.md#podman-krunkit-fix-plan) | [S05R](#stage-s05r) | Subgoal diagnosis and supplied reference | [Accepted applehv evidence](../podman-krunkit-fix/run/interactive-applehv--20261014T160319Z.md#podman-krunkit-fix-run-interactive-applehv--20261014T160319Z) | [Subgoal S04](../podman-krunkit-fix/plan.md#stage-s04) | [S06](#stage-s06) |

Double System Installer is a separate related
main goal, not a subplan. Its interface supplies a stable executable entry
point; this plan supplies its documented invocation and dependency contract.
Bootstrap-owned executable removal must follow its ownership contract rather
than deleting an arbitrary script path from this installer.

<a id="realization-registry"></a>

## 10. Realization Registry

The user selected Direct API and interactive repository development on
2026-10-13. On 2026-10-14 the user approved synchronization and a new
revision-3 continuation after accepting the delegated startup result.

| Record | Realization Artifact | Realization | Kind | Selected Path or Subplan | Decision | Plan Revision | Realization Revision | Registration | Readiness | Alignment | Runs | Last Run | Last Result |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---: | --- | --- |
| <a id="interactive-rest"></a>`interactive-rest` | [Interactive REST](interactive-rest.md#interactive-rest) | Interactive repository development | manual | [Direct API](../path-options.md#path-direct-release-api) | [Decision](../realization-decision.md#double-installer-realization-decision) | [Revision 3](plan-revision-3.md#double-installer-plan) | [Revision 3](interactive-rest.md#interactive-rest-revision-3) | registered at 2026-10-13T15:03:39Z | ready | review-required | 3 | 2026-10-14T16:18:25Z | partial |

Computed style is `single-pass` because no automatic realization is registered.
The product's cron capability does not itself change this plan's style.
Registration, decision, local revision-1 snapshot and persistent realization
artifact exist after explicit user review; two partial runs are retained and one revision-3 run is open. Retain five terminal
runs per future realization; cumulative statistics live here, retained run
links in its realization artifact and the future run index.

Plan revision 2 changed the documentation output into a knowledge
artifact through Machine of Knowledge. Revision 1 and the existing run stay
pinned and immutable. Realization revision 2 remains historical; revision 3 incorporates S05R
and resumes platform validation after its accepted delegated result.

## 11. Open Questions

No unresolved planning questions. Required execution evidence remains: Linux
installer tests, actual Windows/Git Bash behavior and real scheduler validation
in an explicitly disposable scope. Goal completion cannot be claimed yet.
Revision-4 CI expansion requires realization alignment before new execution.
Earlier snapshots and run evidence remain pinned.

## Plan Change Log

### 2026-10-14 — S05R reusable input/output clarification

User specified installed Podman as input and a startable VM as output; the
subgoal must support standalone and other-plan reuse. S05R has not started and
has no frozen run contract. Dependency order S05 → S05R → S06 is unchanged;
S01–S05 acceptance and retained S06 evidence remain applicable. Installer-specific
workload/tool setup remains S06's responsibility. Compatible future-stage edit:
no new plan revision/snapshot required under the current revision rule. Existing
review-required realization status from revision 3 remains until its procedure
is aligned; no new host-operation authority is inferred.

### 2026-10-14 — S05R subgoal plan linked

Created the reusable subgoal plan with alternative libkrun/applehv branches,
input/output validation and caller handoff. Parent S05R now links its plan and
exit S04; S05R is unstarted, frozen obligations are unchanged, and earlier
acceptance remains applicable. Future-only documentation/dependency detail:
no new parent revision. Path/realization review is still required; no host
mutation or broader authority follows from this linkage.


### 2026-10-14 — Accepted S05R Subgoal Handoff

The user accepted the completed subgoal S04. [Successful applehv run](../podman-krunkit-fix/run/interactive-applehv--20261014T160319Z.md#podman-krunkit-fix-run-interactive-applehv--20261014T160319Z)
provides double-applehv, explicit applehv provider, rootless default connection,
2 CPUs, 2048 MiB RAM, 20 GiB disk, completed startup and observed running state.
Verified only on the current macOS 26.6.2 (25G83) host with Podman 6.1.0 and
vfkit v0.6.4. [Reusable knowledge](../../../knowledge/podman-applehv-macos-26-6-2/podman-applehv-macos-26-6-2.md#podman-applehv-macos-26-6-2)
is complete, TTL one year. No old VM disk recovery/migration is claimed.
This is a delegated result handoff, not an invented parent run contract or
retroactive parent stage validation. S06 can be resumed in a compatible reviewed
parent run; Linux installer tests and Windows validation remain unperformed here.

### 2026-10-14 — Parent Synchronization and Revision-3 Continuation

User approved synchronization. Carried forward accepted S01/S02A/S03–S05
from retained revision-1/2 runs; accepted S05R by reference to the completed
subgoal, without inventing parent host actions or earlier frozen contracts.
Registered realization revision 3 against existing plan revision 3 and opened
a new run at 2026-10-14T16:18:25Z. S06 retains partial macOS evidence; no new
Linux/Windows/cron tests executed. Changes are status/alignment corrections,
not changed frozen obligations; no new plan snapshot required.

### 2026-10-14 — S06 Linux Fixture Evidence

Current revision-3 run passed syntax and the full isolated suite inside the
Linux aarch64 VM. No dependency installation or real cron/project mutation.
S06 remains partial: Windows/Git Bash and actual scheduler evidence missing;
Linux live-package smoke not performed. See displayed run for exact command
and tool versions. Historical macOS evidence remains retained.


### 2026-10-15 — Test Scenario Directory Convention

User selected root tests/ for test scenarios, separate from scripts/ outputs,
and recorded the rule in Double Project knowledge. Current fixture entry point
is tests/test-double-installer.sh. Four local suites passed after relocation;
release workflow calls tests/test-double-release.sh. File-location adaptation
preserves stage contracts and realization alignment; no new frozen obligations
or plan revision. Prior run commands remain historical; new runs use the new
layout. Cross-platform CI matrix is not implemented by this move.

### 2026-10-15 — Expand S06 to GitHub Actions

User explicitly requested cross-platform/OS CI tasks after local Linux/macOS
validation. S06 now requires the finite six-row matrix and durable hosted
execution evidence. This changes frozen S06 actions/output/evidence, so revision
4 is frozen before further execution. Revision-3 run is closed partial with
accepted earlier results retained; realization marked review-required. Next:
review CI procedure, align realization and decision, then create a new run with
fresh S06 contract. No workflow, remote push or hosted jobs executed here.
