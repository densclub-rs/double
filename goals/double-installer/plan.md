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
plan-execution-style: single-pass
plan-revision: 12
plan-revision-artifact: ./realizations/plan-revision-12.md
created-at: 2026-10-13T14:59:22Z
updated-at: 2026-10-19
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

- Source goal: [Double Installer](./double-installer.md#double-installer).
- Source paths: [Path options](./path-options.md#double-installer-path-options).
- Parent plan: none. Direct API and interactive repository development are
  selected; realization revision 10 executes revised S05A under revision 12,
  preserving earlier release evidence and requiring fresh S06 validation.
- Proposed deliverables: `scripts/double-installer.sh`,
  `tests/test-double-installer.sh`, and `knowledge/double-installer/double-installer.md` in the
  repository, plus a versioned installer release with checksum and download instructions.
  Repository deliverables exist; validation handoff and installer publication remain pending.

### Current State

The [release packager](../../scripts/double-release.sh) emits machine-specific
archives and SHA-256 checksums. The discovery snapshot contains only two
Machine of Ideas `rc` releases. The installer, registry, and lifecycle fixture checks
are implemented; S01/S02A/S03–S05 are accepted in retained runs. macOS and
published-package evidence exists. Accepted applehv startup enables Linux
validation. The delegated CI run now records passing six-row matrix and
real integration jobs; CI01–CI03 are accepted, while the refactored CI04–CI06 remain pending. These are evidence limitations, not unimplemented lifecycle commands. The separate
[system installer goal](../double-system-installer/double-system-installer.md#double-system-installer)
owns installation of the executable entry point.

### Target State

One Bash script works on Linux, macOS, and Windows through Git Bash. It
lists/releases downloads, manages machines across projects through a registry,
backs up and replaces files on update, supports optional cron, and removes
all installer-owned machine installations and state on full uninstallation.
The installer itself is distributed as a versioned GitHub Release asset after
required tests pass for the exact release candidate commit.
State lives under `~/.local/state/double` according to
[Double State Directory](../../knowledge/double-state-directory/double-state-directory.md#double-state-directory).

### Success Criteria

The [goal criteria](./double-installer.md#double-installer) are met by
repeatable multi-project lifecycle checks, a real published-package smoke
check, cron checks where available, and actual platform evidence for Linux,
macOS, and Git Bash on Windows. Fixtures establish scenarios unavailable in
current hosted releases; they never count as evidence of hosted publication.
Completion also requires the published installer asset and checksum to be
downloaded and verified against the tested candidate within delegated S06.

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

- Displayed run: [Release consent and directory backups](./run/interactive-rest--20261019T102423Z.md#double-installer-run-interactive-rest-20261019T102423Z).
- Displayed run baseline: [Revision 12](./realizations/plan-revision-12.md#double-installer-plan).
- Current plan: revision 6; previous progress remains historical evidence.
- Progress synchronized at: 2026-10-16.
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
| ✅ | [S05R: Restore Podman Linux environment](#stage-s05r) | subplan | [Repair subgoal](./podman-krunkit-fix/podman-krunkit-fix.md#podman-krunkit-fix) | Startable VM and startup evidence | S05A | V05R |
| ✅ | [S05A: Bulk download, installation consent and agent integration](#stage-s05a) | stage | Approved CLI extension; existing lifecycle | install alias, priority bulk download, discovered agent integrations and registry/cleanup | S06 revalidation | V05A; isolated lifecycle/security tests |
| 🔄 | [S06: Platform validation and documentation](#stage-s06) | subplan | S01–S05 plus accepted S05R | [Accepted validation evidence](./double-installer-validation/plan.md#double-installer-validation-plan) | Final validation or affected-stage rework | V06; accepted subgoal handoff |

S06 delegates its detailed stages to the validation subgoal.
S06 is running for the newly authorized 0.1.2-rc candidate; older evidence alone
does not accept the new source.
CI01–CI03 retain accepted evidence. New CI04 prepares installer publication;
CI05 executes the complete release chain; CI06 consolidates final evidence.
Separate S07 is superseded by these delegated stages; no release is published.

### Selectable Paths and Subplans

| Choice | Plan branch | Trade-off | Compatible registered realizations |
| --- | --- | --- | --- |
| [Direct API](./path-options.md#path-direct-release-api), recommended | S01 → S02A → S03–S06 | curl/jq; own HTTP pagination/errors; no required gh login for public releases | [Interactive REST](#interactive-rest) |
| [GitHub CLI](./path-options.md#path-github-cli-consumer) | S01 → S02B → S03–S06 | Dedicated client simplifies GitHub access; requires gh setup and unattended credentials | None |

Only one transport is required for version one. Both implement the same
package interface and local lifecycle. Proposed realization of this development
plan is interactive repository implementation with stage validation. The
delivered Bash installer is a product artifact; its existence does not
register an automatic realization of this development plan.

## 4. Stage Details

<a id="stage-s01"></a>

### S01: Establish Installation Contracts

- Input: [goal](./double-installer.md#double-installer),
  [paths](./path-options.md#double-installer-path-options), release packager.
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

- Path: [Direct API](./path-options.md#path-direct-release-api).
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

- Path: [GitHub CLI](./path-options.md#path-github-cli-consumer).
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

- Delegated goal: [Podman krunkit Fix](./podman-krunkit-fix/podman-krunkit-fix.md#podman-krunkit-fix).
- Subgoal plan: [Reusable Podman VM Startup](./podman-krunkit-fix/plan.md#podman-krunkit-fix-plan); path/realization review required before execution.
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
- Next: [S05A](#stage-s05a).

<a id="stage-s05a"></a>

### S05A: Bulk Download, Installation Consent and Agent Integration

User approved implementation after local review of release 0.1.1-rc.
- install is an exact alias of download, not project integration.
- download/install without options or with --all selects one latest numeric
  version per machine with stable → rc → dev priority.
  It excludes installer/non-machine assets, verifies caches and reports failures.
- add --project DIR --machine ID [--agent codex|claude] installs project files
  and one shared skill in DIR/.agents/skills. Without --agent, list detected
  agents and ask whether to integrate all; consent additionally enables dedicated
  roots where required. Explicit --agent bypasses this list/question.
- add --global [--agent codex|claude] [--machine ID] installs global payloads and
  creates shared skills by default; --agent requests an agent adapter.
  update --global only updates registered machines.
- Every agent operation is independent: retain payload/successful connections,
  rollback only the failed agent, continue others, and report partial failure.
  Repeat add retries integration without reinstalling/upgrading the payload.
- Canonical payload remains in installer-owned shared state; user skills in
  ~/.agents/skills (Codex) and ${CLAUDE_CONFIG_DIR:-~/.claude}/skills (Claude)
  direct agents to operating materials while user artifacts stay in projects.
- Registry tracks agent entry points, ownership and created directories.
  Preserve foreign skills; backup replacements, support global removal,
  bulk updates and full uninstall without deleting foreign files/settings.
- Default add uses stable → rc → dev with prerelease consent; unregistered
  machines require separate adoption consent. add --yes acknowledges both.
  Persistent backups and rollback snapshots capture whole machine/skill
  directories. Adoption replaces only the selected machine roots.
- V05A: isolated HOME/state/CLI fixtures prove alias, priority, discovery,
  explicit-agent targeting, repeat/update, backups, collisions and removal.
  Real agent execution/session discovery and six-platform CI remain separate
  validation requirements; do not mutate the developer's actual agent setup.
- Next: fresh S06 validation for changed product; no publication authorized.

<a id="stage-s06"></a>

### S06: Delegate Installer Validation and Accept the Result

- Subgoal: [Double Installer Validation](./double-installer-validation/double-installer-validation.md#double-installer-validation).
- Plan: [Local validation and release CI](./double-installer-validation/plan.md#double-installer-validation-plan).
- Input: current installer/test scenarios, accepted S01–S05/S05R evidence
  and accepted S05A extension, with fresh required checks on changed source.
- Output: accepted local coverage report, full required hosted OS/architecture
  matrix, real cron evidence, a tested published installer release, checksums,
  release gate, downloaded-asset verification and usage knowledge.
- V06: validate the subgoal's accepted evidence against parent goal criteria;
  unavailable local environments are explicit, required CI failures/missing
  results block release and goal completion. Local evidence alone is insufficient.
- Integration: subgoal owns test scenarios, workflow, matrices and evidence;
  parent owns installer behavior and final goal-achievement decision.
- Status: delegated CI01–CI03 accepted; CI04 accepted; CI05 release verification complete, acceptance pending; CI06 unstarted. Earlier
  parent runs retain their original baselines and results.
- Integration: CI04 prepares installer release tooling; CI05 runs mandatory
  exact-commit CI, publishes an authorized prerelease, downloads its assets and
  verifies checksum, source identity, disposable project lifecycle and Linux
  cron execution/cleanup. CI06 consolidates evidence and user acceptance.
- Next: parent final validation after accepted CI06, or affected-stage rework.


## 5. Shared Dependencies

- Internal: packaging contract, installed-file ownership, registry schema,
  state convention and stable entry-point interface with the system installer.
- External: GitHub availability, selected transport dependencies, tar/checksum
  utilities, platform execution environments, optional cron.
- Decision: explicit user path selection and development realization approval
  before registration or execution. Installer publication belongs to delegated S06;
  publication of new machine packages remains external to this plan.

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
  version changes or automatic scheduler installation. Installer release
  publication is confined to delegated CI05 and its explicit first-publication decision.
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

[Podman krunkit Fix](./podman-krunkit-fix/podman-krunkit-fix.md#podman-krunkit-fix)
is an accepted subgoal. Its [plan](./podman-krunkit-fix/plan.md#podman-krunkit-fix-plan) has completed an accepted applehv invocation; the reusable result is ready for caller use.

| Subgoal | Subgoal Plan | Entry Stage | Input Artifact | Output Artifact | Exit Stage | Parent Continuation |
| --- | --- | --- | --- | --- | --- | --- |
| [Podman repair](./podman-krunkit-fix/podman-krunkit-fix.md#podman-krunkit-fix) | [Subgoal plan](./podman-krunkit-fix/plan.md#podman-krunkit-fix-plan) | [S05R](#stage-s05r) | Subgoal diagnosis and supplied reference | [Accepted applehv evidence](./podman-krunkit-fix/run/interactive-applehv--20261014T160319Z.md#podman-krunkit-fix-run-interactive-applehv--20261014T160319Z) | [Subgoal S04](./podman-krunkit-fix/plan.md#stage-s04) | [S06](#stage-s06) |
| [Installer validation](./double-installer-validation/double-installer-validation.md#double-installer-validation) | [Validation plan](./double-installer-validation/plan.md#double-installer-validation-plan) | [S06](#stage-s06) | Installer/tests and accepted prior stages | Accepted local/CI matrix, integration evidence and release gate | [CI06](./double-installer-validation/plan.md#stage-s06-ci06) | Parent final validation |

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
| <a id="interactive-rest"></a>`interactive-rest` | [Interactive REST](./realizations/interactive-rest.md#interactive-rest) | Interactive repository development | manual | [Direct API](./path-options.md#path-direct-release-api) | [Decision](./realization-decision.md#double-installer-realization-decision) | [Revision 12](./realizations/plan-revision-12.md#double-installer-plan) | [Revision 10](./realizations/interactive-rest.md#interactive-rest-revision-10) | registered at 2026-10-13T15:03:39Z | ready | aligned | 10 | 2026-10-19T10:24:23Z | running |

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

No unresolved planning questions. Required acceptance remains: CI04–CI06
release preparation, end-to-end publication and final handoff. The first installer
version and publication decision are resolved in CI04/CI05 before release. Goal
completion cannot be claimed yet.
Revision-5 release integration requires realization alignment before new execution.
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

The user accepted the completed subgoal S04. [Successful applehv run](./podman-krunkit-fix/run/interactive-applehv--20261014T160319Z.md#podman-krunkit-fix-run-interactive-applehv--20261014T160319Z)
provides double-applehv, explicit applehv provider, rootless default connection,
2 CPUs, 2048 MiB RAM, 20 GiB disk, completed startup and observed running state.
Verified only on the current macOS 26.6.2 (25G83) host with Podman 6.1.0 and
vfkit v0.6.4. [Reusable knowledge](../../knowledge/podman-applehv-macos-26-6-2/podman-applehv-macos-26-6-2.md#podman-applehv-macos-26-6-2)
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


### 2026-10-15 — Local Availability and Release CI Clarification

User clarified that local development validation depends on host OS and
available VMs, while each new script version release requires all required
GitHub Actions tests. Added S06-LOCAL availability matrix and S06-RELEASE-CI
release-gating contract. This clarifies unexecuted revision-4 CI tasks; no new
run or frozen execution contract exists for those tasks. Keep revision 4 snapshot
unchanged and record this applicable future-only clarification in the current
plan. Existing review-required alignment remains; no tests or releases executed.

### 2026-10-15 — Expanded Plan Map

Added S06-LOCAL, S06-RELEASE-CI and CI01–CI05 to the map with links,
dependencies and validation criteria. Visibility-only synchronization; no task
execution or new acceptance inferred. Group rows aggregate their child tasks.


### 2026-10-15 — Extract S06 Validation Subgoal

User requested reducing parent complexity. Moved local/CI stage details,
matrices and task map to double-installer-validation; parent S06 retains only
its delegation/input/output/V06 interface. Existing evidence and snapshots
remain in place. This is future-only ownership decomposition of unexecuted
revision-4 CI work; no frozen execution contract is changed or rebound.
Current revision-4 snapshot stays immutable; change is logged as applicable
clarification. Realization alignment remains review-required. Subgoal plan has
null revision until its first realization is approved; no tests/jobs executed.

2026-10-15: validation subgoal realization/baseline 1 registered; first run
prepares CI01 scenarios. Shared local/CI runner passes available macOS checks;
CI01 acceptance pending, no hosted jobs or workflow implemented yet.

2026-10-15: delegated CI01 accepted; CI02 workflow and release gate prepared
with local checks passed. No remote push, hosted execution or publication.

### 2026-10-15 — Installer Distribution Stage Approved

User accepted independent `double-installer-<version>` tags and publication
after exact-commit validation. Added future stage S07, its map/dependencies,
asset/checksum contract and download verification. S06 hands tested candidate
evidence to S07; accepted CI01–CI03 and existing snapshots/runs remain intact.
This is a future-only addition: no executed/frozen stage acceptance criterion
is changed; current revision 4 remains, with its immutable snapshot preserved.
CI05 is unexecuted and gains handoff detail only. Parent realization remains
review-required and must incorporate S07 before a new parent execution; freeze
a new revision if alignment changes any frozen obligations. No tag, release,
workflow implementation or publication is performed by this planning change.

### 2026-10-16 — Combine Validation and Installer Publication

User approved CI04 release preparation → CI05 end-to-end release execution →
CI06 consolidation, replacing separate S07. Parent revision 5 and child
revision 2 freeze the changed contracts; old snapshots and run baselines remain
immutable. Accepted CI01–CI03 are retained as historical evidence, not proof
for a changed release candidate. The candidate must pass all mandatory CI.
Existing realizations require alignment before execution. Planning does not
create/push tags or publish a release. The user retracted the drafts copy;
only the generated drafts/double-installer-plan.md is removed.

2026-10-16: delegated CI04 accepted. CI05 published installer prerelease
double-installer-0.1.0-rc after full required prepublication CI; corrected
postpublication harness passed all six targets without changing release
assets. CI05 awaits acceptance, CI06 handoff remains pending. S06 and parent
goal remain incomplete; original run failures are retained in child evidence.

2026-10-16: installer 0.1.1-rc published with --help guide URL and exactly
script/checksum assets. Mandatory prepublication matrix passed on cf7f726;
postpublication six-target verification passed with CI-only authenticated API
adapter in run 38925798842. CI05 acceptance and CI06 handoff remain pending.

2026-10-16: user approved S05A CLI/global integrations. Revision 6 freezes new
obligations; historical releases/tests remain pinned. Earlier S01–S05 evidence
is retained, changed lifecycle aspects need revalidation. No new release.

2026-10-16: revision-6 navigation synchronized to new parent run and S05A
continuation; old snapshots remain unchanged. S05A implementation/isolated
macOS checks are ready for acceptance. Prior child CI05 run is closed partial
after user expanded requirements, not declared a failed release. Fresh S06
procedure/baseline alignment is required for global integration coverage.

## Current Implementation Alignment — 2026-10-16

S05A — Extend installer CLI and global agent integration: install aliases download;
--all chooses one version per machine with stable → rc → dev priority; status
replaces list. Global add discovers supported installed agents unless explicitly
targeted, tracks payloads and skill entry points, and uses backups/owned cleanup.
S06 — Validate and release delegates CI02R — Consolidate installer workflow to
the validation subgoal. double-installer.yml owns tests, gated installer publication
and gated publication; release.yml independently owns machine/Double Agent
package validation and publication. Changed source still needs fresh hosted CI03
— Six-platform validation and CI05 — Publish tested installer. Existing
0.1.1-rc evidence is historical; no new release is authorized or published here.

2026-10-17: user removed post-publication verification entirely. Delegated
CI02R/CI05 now implement required tests → gate → publication. No second matrix
or manual recheck of installer releases remains. Existing historical evidence
is retained; fresh prepublication hosted tests remain required.

2026-10-17: S05A — Extend installer CLI: status must include locally downloaded
machine archives, their machine/version/channel/path, alongside registered
installations. This is local inventory, without network requests or checksum
revalidation. Missing archives and staging directories are not listed.

2026-10-17: S05A — Status archive inventory uses a human-readable aligned table
(MACHINE, VERSION, CHANNEL, ARCHIVE), replacing per-archive JSON. Registered
installation output is unchanged. No additional utility dependency is required.

2026-10-17: S05A — Status presentation adds cyan headings and channel colors
(stable green, rc yellow, dev magenta). ANSI styling is enabled only for terminal
stdout, disabled for TERM=dumb or when NO_COLOR is set, including an empty value.

2026-10-17: S05A — Status adds optional --json. Emit one object containing
archives and installations arrays, preserving registered installation fields.
Empty collections use []; no human headings or ANSI colors in JSON mode.
Default status output remains unchanged. Reject other or repeated options.

2026-10-17: S05A — Correct default bulk download: download/install without
parameters use the same per-machine stable → rc → dev selection as --all.
Explicit targeting and invalid option-combination guards remain in force.

2026-10-17: S05A — Built-in explanations: explain documents the installer and
every command; COMMAND --help/--explain documents only that command and never
executes it. Cover every public command including aliases and destructive
commands; retain concise global help. No new runtime dependencies.

2026-10-17: S05A — Explain presentation adds cyan command/section headings,
green usage lines and yellow option names. Both explain and per-command
--help/--explain use the formatter. Redirected output, NO_COLOR (including empty)
and TERM=dumb stay plain; explanatory content is unchanged.

## S05A Revised Contract — Project/Global Agent Installation (2026-10-17)

User explicitly requires add to own installation and integration in both scopes.
- add --project DIR --machine ID [--agent codex|claude]: default registers skills
  with every detected supported agent in that project. Explicit --agent selects
  one. No detected agent permits payload-only installation. Project roots are
  DIR/.agents/skills and DIR/.claude/skills; no home skill writes for project add.
- add --global [--agent codex|claude] [--machine ID] [--channel CHANNEL]: owns
  global first installation and agent discovery. Repeating add can attach/repair
  selected skills but does not implicitly update installed payloads.
- update --global updates existing registered global installations only. No new
  machine/agent registration. update-all preserves scope and refreshes registered
  project/global wrappers. Existing channel/version and backup rules remain.
- Registry tracks project/global skills, owned directories and roots. Every
  agent operation has independent rollback; failures retain payload and other
  successful agent registrations. Project remove and uninstall-all
  delete tracked skills while preserving foreign files and other projects.
- Refresh help/explain/knowledge and portable fixtures. Validate explicit/default
  agent discovery, scope isolation, collisions, rollback, update/remove/full cleanup.
  Use disposable state/projects only; no host agent configuration or new release.

Baseline 7 / realization 5 supersede the active baseline-6 extension run. Earlier
runs and snapshots remain unchanged as historical evidence. Fresh S06 hosted
validation of changed product remains pending.

## S05A Agent Independence Clarification — 2026-10-17

User explicitly requires independent agent operations. Supersede baseline-7
all-agent rollback: commit payload separately, then each agent registration or
detach separately. Failed writes restore only that agent's prior skill; continue
other agents and preserve successful outcomes in registry. Return nonzero for
partial failure with per-agent results. Repeat add retries/repairs integrations
without reinstalling or upgrading an existing machine. On removal retain payload
while any detach failed; successful detaches remain committed. No new release.
Baseline 8 / realization 6 capture this changed obligation; prior run is partial.

## S05A Shared Default and Pi Research — 2026-10-17

User requests shared skill directories by default, with agent-specific directories
only on explicit --agent. Project default: DIR/.agents/skills; global default:
~/.agents/skills. No CLI/config discovery or installed-agent prerequisite.
Registry records one shared integration, not unverified per-agent success.
Explicit codex uses its standard shared root; explicit claude uses .claude/skills
and its configured global root. Claude shared-root discovery is not documented,
so default installation must not claim Claude is connected. Preserve earlier
explicit records; adding a shared record may reuse an already owned Codex file.
Reference-count shared paths: detaching one logical connection must not remove a
file another recorded connection still uses. Retain per-agent independent failure.

Pi research: official earendil-works/pi skills documentation supports project
.agents/skills and ~/.agents/skills, so default output is format/path compatible.
Pi-specific paths are .pi/skills and ~/.pi/agent/skills (agent directory override
PI_CODING_AGENT_DIR). A dedicated --agent pi adapter and live Pi acceptance are
not implemented by this research step. Record sources in installer knowledge.
Baseline 9 / realization 7 supersede baseline 8 for this changed default.

## S05A Doctor Agent Inventory — 2026-10-17

User explicitly requests doctor discovery for the selected eight candidates:
Codex, Claude Code, Cursor, GitHub Copilot, Gemini CLI, OpenCode,
Cascade/Windsurf/Devin Desktop and Pi. Show each even when absent, with ID,
name, DETECTED/NOT FOUND and CLI/config/application/extension evidence.
Use executable lookup and known locations only; never launch agent binaries,
read credentials, authenticate, mutate config or install dependencies.
Configuration alone is a heuristic; missing known evidence is not proof of
absence. Absence of agents is informational and does not fail doctor; existing
required-dependency exit semantics remain. Discovery does not change shared add
behavior or silently add --agent adapters. Account for existing config overrides
and Git Bash native Windows environment paths. Validate fake CLI/config/extension
signals, no execution or state mutation, and existing lifecycle/release fixtures.
Baseline 10 / realization 8 retain the same selected development path.

2026-10-17: S05A — Doctor presentation: cyan headings, green successful
checks/detected agents, yellow absent agents/optional cron, red missing required
dependencies. Preserve column alignment, text, streams and exit codes. NO_COLOR
(including empty), TERM=dumb or redirected stdout disable styling; redirected
stderr never receives ANSI. Compatible presentation change under baseline 10.

## S05A Add Discovery and Consent — 2026-10-17

User explicitly requires add without --agent to list found agents and ask whether
to add integrations for all. Reuse doctor evidence, not separate detection rules.
Always select one shared .agents/skills registration. If terminal user answers yes,
use that common root for discovered compatible Codex/Cursor/Copilot/Gemini/
OpenCode/Cascade/Pi, and add a dedicated Claude registration only when Claude is
found. No/empty/EOF selects shared-only; no detected agents or non-terminal input
also selects shared-only without blocking. Explicit --agent bypasses list/prompt.
Apply once per project add or global add invocation, not once per machine/agent.
Preserve independent per-agent commits, partial failures/retry, registered-only
updates, shared file references and cleanup. Show heuristic-detection caveat.
No agent execution, credentials, automatic configuration edits or new adapters.
Validate yes/no/project/global/explicit behavior using PTY input on POSIX, plus
portable non-terminal behavior and existing independent rollback fixtures.
Baseline 11 / realization 9 capture this change under the same selected path.

2026-10-17: S05A — Confirm minimal CLI flow [doctor] → releases → add.
Standalone download/install is optional pre-caching, not an add prerequisite.
Existing add already shares download_release when the selected archive is absent;
retain that mechanism and checksum/archive verification. Add explicit messages
for cache miss/download vs cache reuse. Portable smoke now starts with releases,
adds from an empty cache, then installs into a second project while rejecting
asset HTTP requests to prove cache reuse. This clarifies existing behavior under
baseline 11; no new eligibility/version/channel rule or realization is introduced.

2026-10-19: S05A — Releases presentation: cyan header, green stable, yellow rc,
magenta dev. Terminal-only styling honors NO_COLOR (even empty) and TERM=dumb;
redirected TSV remains byte-identical. Compatible presentation-only change under
baseline 11; release discovery/selection and exit behavior are unchanged.

2026-10-19: S05A — Human status installation inventory groups by project and
lists machine/version/channel beneath each path, sorted by project and machine.
No detailed registry JSON appears in default output; status --json retains full
archive/installation objects. Preserve channel colors and plain redirection.
Compatible presentation-only change under baseline 11.

2026-10-19: S05A — Add/update/update-all terminal styling: cyan progress and
selection, green successful install/update/integration/no-op, yellow backup and
warning messages, red failures. Preserve prompts, streams, exit codes and
independent-agent behavior. NO_COLOR (even empty), TERM=dumb or redirected stdout
disables action colors; redirected stderr stays plain. update-all child updates
inherit terminal capability naturally. Compatible presentation under baseline 11.

2026-10-19: S05A — Refine action presentation at user request: add/update/
update-all use status labels [INFO]/[OK]/[WARN]/[ERROR]. Only the label receives
ANSI color; reset precedes the message body. Keep readable labels in redirected/
NO_COLOR/TERM=dumb output. Other command formats and operational semantics stay
unchanged. This supersedes full-line action coloring under baseline 11.

## S05A Release Consent and Directory Backups — 2026-10-19

Default add selects stable, otherwise rc, otherwise dev; newest numeric version
within the chosen channel. Installing a prerelease requires affirmative terminal
consent or add --yes, including explicit prerelease selection. Download remains
cache-only. Existing registered updates keep their approved channel. Unregistered
machine directories require separate adoption consent before replacement and
registration. Non-terminal input never implicitly authorizes either operation.
add --yes acknowledges prerelease/adoption only, never all-agent integration.

Snapshot complete machine directories .double/<category>/<machine>, and complete
agent skill directories, including extra nested files. Apply directory snapshots
to persistent backups and transaction rollback. Registry JSON remains metadata.
Adoption replaces only selected machine roots after backup; rollback restores
whole original directories. Preserve other machines and independent agent commits.
Validate consent accept/reject, fallback priority, full directory preservation,
adoption rollback and existing lifecycle/release fixtures in isolated projects.
Baseline 12 / realization 10 supersede affected S05A obligations. S06 requires
fresh validation; hosted runs and publication remain outside this action.
