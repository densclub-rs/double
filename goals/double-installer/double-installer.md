---
id: double-installer
kind: goal-artifact
template-id: goal-template
project-id: double
produced-by: machine-of-goals/goal-formulation-agent
owner-id: double-project
interaction-language: ru
artifact-language: en
goal-scope: main-goal
derived-from:
  - source conversation on 2026-10-13
  - ../../scripts/double-release.sh
  - ../../ideas/double-software-project/double-software-project.md
---

<a id="double-installer"></a>

# Goal: Minimal Double Bash Installer

## 1. Summary

Provide a minimal Bash installer that discovers Double releases on GitHub,
downloads selected releases into an internal local catalog, and uses that
catalog to initialize or update Double machines and other supplied artifacts
in specified project directories. Maintain a persistent registry of machine
installations across integrated projects and support updating all registered
installations when new machine versions become available.

This is a temporary distribution solution for early developers and users,
pending further development of Double Software Project.

## 2. Subject of the Goal

### Subject

- Integrating Double's modules (machines) into projects of first users and developers.
- The Shell-based installer, its internal release catalog, and installation registry.
- Project directories containing installed Double machines and artifacts.

## 3. Motivation

- Make first adoption practical without manual release retrieval and copying.
- Attract early developers and users through a simple installation experience.
- Keep installations across multiple projects discoverable and updatable.
- Deliver useful distribution before the broader software project is complete.

## 4. Current State

### Known facts

- `scripts/double-release.sh` packages machine-specific releases as
  `double-<machine>-<version>.tar.gz` archives containing `.double/` and
  generates `SHA256SUMS.txt` alongside them.
- The Git remote inspected on 2026-10-13 points to `densclub-rs/double` on
  GitHub. Available hosted releases have not been verified during formulation.
- The Bash installer and persistent cross-project registry are implemented;
  S01–S05 are accepted. macOS checks passed historically; S06 remains partial.
- The user explicitly requests a minimal Shell implementation as a temporary
  solution, with release listing, local downloads, project initialization,
  project updates, an installation registry, and updates across all projects.

### Relevant environment

Local developer environments, GitHub releases, an internal local release
catalog, and multiple user-selected project directories. The first version
must support all common operating systems: Linux, macOS, and Windows. One
Bash script serves all three platforms. Windows uses Git Bash supplied by
Git for Windows; WSL is not required.

### Existing related goals or subgoals

- [Podman krunkit Fix](./podman-krunkit-fix/podman-krunkit-fix.md#podman-krunkit-fix)
  — completed accepted invocation on macOS 26.6.2 (25G83) using applehv;
  result handed to S05R, Linux installer testing remains S06 work.

- [Double GitHub Integration](../double-github-integration/double-github-integration.md#double-github-integration)
  — related goal referencing this installer goal as a candidate integration.
  This artifact is a main goal, not an accepted subgoal of that goal.
- [GitHub Actions Maintenance](../double-github-integration/github-actions-maintenance/github-actions-maintenance.md#github-actions-maintenance)
  — related release-packaging and publication goal supplying the distribution
  surface consumed by the installer.
- [Double Software Project](../../ideas/double-software-project/double-software-project.md)
  — related idea; the installer is an interim solution while that idea develops.

## 5. Target State

### Required result

- The resulting installer script is stored in the Double project's `scripts/`
  directory at `scripts/double-installer.sh`.
- One Bash script can retrieve and display the project's GitHub releases on
  Linux, macOS, and Windows through documented environments and prerequisites.
- Windows support requires Git Bash from Git for Windows. No separate
  PowerShell implementation or WSL installation is required.
- Stable releases are selected by default. Release-candidate (`rc`) and
  development (`dev`) releases are available only through explicit user
  selection; bulk updates follow the same rule.
- Bash is the script interpreter even when the user's interactive shell is
  Zsh; direct execution by Zsh is not required.
- Selected release assets are downloaded into an internal local catalog and
  remain available as the source for project installation and updates.
- The first version installs machines and other supplied artifacts only from
  packages published as assets of Double's GitHub Releases. Arbitrary local
  source trees and unpublished artifacts are not installation sources.
- The release catalog, backups, and installation registry share the per-user
  state directory `~/.local/state/double` across all integrated projects,
  as preserved in [Double State Directory](../../knowledge/double-state-directory/double-state-directory.md#double-state-directory).
  On Windows, `~` is resolved by the Git Bash environment.
- Users can initialize or update the Machine of Ideas, Machine of Goals,
  and other supported Double machines or supplied artifacts in specified
  project directories.
- A persistent registry identifies installed machines, their project
  directories, and installed versions.
- The installer provides explicit commands to add a machine to a specified
  project and to remove an installed machine from that project.
- Successful machine addition installs its files and registers the
  project-machine installation and version. Successful removal deletes that
  machine's installed files and removes its active installation entry.
  Removal is an uninstall operation, not merely deregistration.
- Both operations keep the registry consistent with actual project contents;
  failed or partial operations must not be recorded as successful.
- A full uninstallation mode removes all registered machine installations
  from all integrated projects and deletes all installer-owned state under
  `~/.local/state/double`, including downloaded release packages, backups,
  the installation registry, and any other installer-created state. It also
  removes all cron tasks created by the installer.
- Full uninstallation preserves unrelated project files and other Double
  components' state in the shared directory. Installer-created directories
  are removed when empty; the shared state directory is removed only if
  empty after cleanup. Incomplete removal is reported and retains the state
  needed to identify and retry remaining cleanup rather than claiming full
  uninstallation succeeded.
- Users can invoke an update across all registered machine installations in
  all integrated projects when new versions are available.
- Updates support an interactive mode invoked by the user and a background
  automatic mode scheduled through cron.
- The script offers creation of a cron task for automatic release checks and
  updates across registered installations, where cron is available. Task
  creation is explicitly requested by the user, not enabled by default.
- When cron is unavailable, including Windows environments without cron,
  interactive updating remains supported. No alternative Windows scheduler
  integration is required for the first version.
- Scheduled updates run without interactive prompts and follow the same
  release-channel, backup, and registry-consistency rules as interactive
  updates. Backups remain available for explicit user-requested deletion.
- Before replacement, preserve complete machine directories, including local
  modifications and extra nested files. All payload and agent skill backups
  and rollback snapshots operate at directory granularity. Replacement proceeds
  only after the backup succeeds. Registry snapshots remain metadata.
- Initial add selects stable → rc → dev unless a channel is explicit. Installing
  rc/dev requires user confirmation or add --yes. An unregistered machine
  requires separate confirmation before backup, replacement and registration.
- After an interactive update, the installer offers to delete the backups.
  Backups remain available unless the user chooses deletion.
- A separate command lets users request deletion of installer-created backups
  later, independently of an update.
- Registry state reflects actual successful installations and updates; failed
  operations do not claim that a version was installed.
- Instructions explain first installation, release retrieval, the local
  catalog, machine addition and removal, registry inspection, bulk updates, and backup
  creation and deletion, full uninstallation, optional cron task creation,
  and behavior when cron is unavailable.

- The installer itself is published in independent GitHub Releases tagged
  `double-installer-<major>.<minor>.<patch>`, with explicit `-rc`/`-dev`
  prereleases. Each release supplies one universal `double-installer.sh`,
  `SHA256SUMS.txt`. Download/verification/usage instructions remain in the
  project and are linked from release notes; INSTALL.md is not a release asset.
- Publication requires the complete required CI checks to pass for the exact
  tagged commit. Installer release selection is scoped by its tag prefix;
  repository-wide latest release may belong to a different component.
- Executable placement on a user's machine remains owned by the separate
  Double System Installer goal.

### Optional quality improvements

Additional conveniences may be considered later if they preserve the minimal
temporary scope. None are required at formulation time.

### Evidence

A demonstrated installation into multiple project directories, persisted
registry entries, and a subsequent bulk update from newer machine releases,
with observed project contents and versions matching the registry.

## 6. Success Criteria

- Minimal success: the Shell script lists GitHub releases, downloads selected
  assets, installs machines from the internal catalog into at least two project
  directories, persists the installation registry across invocations, and
  updates every applicable registered installation through one bulk operation
  when newer releases are supplied. Updating locally modified machine files
  preserves their previous contents in a backup before replacement, offers
  backup deletion afterward, and supports later deletion through a separate
  user-invoked command.
- Installation lifecycle success: adding and removing machines through the
  respective commands produces matching changes in project files and the
  registry. Removing one machine preserves other machines and unrelated
  project content, and excludes the removed installation from future bulk
  updates.
- Scheduling success: where cron is available, the script can create a
  user-requested task that checks for new releases and updates registered
  installations without prompts while retaining backups. Without cron,
  interactive updates work without requiring another scheduler.
- Full uninstallation success: all registered machines are removed from all
  integrated projects, all installer-created cron tasks are removed, and all
  installer-owned downloads, backups, registry files, and other state are
  deleted. No installer-owned files, empty directories, or scheduled tasks
  remain. Unrelated project content and other components' state are preserved.
- Distribution success: the first explicitly authorized installer release is
  published after exact-commit CI, and its actual downloadable script matches
  the tested source and published SHA-256 checksum.
- High-quality success: the complete first-user flow is documented and
  repeatable, with clear per-project and per-machine results, and failure
  reporting that keeps registry entries consistent with project contents.
- Partial success: release discovery, downloads, or single-project installation
  work, but persistent tracking or bulk updates remain incomplete.
- Failure / not achieved: users still need to retrieve and copy release files
  manually, installations cannot be tracked across projects, or bulk updates
  report installed versions inconsistent with actual project contents.

## 7. Constraints

- Time: no deadline specified; favor a minimal useful first implementation.
- Attention: keep initial setup and routine use simple for early adopters.
- Cost: no budget specified.
- Technical constraints: support all common operating systems (Linux, macOS,
  and Windows); one Bash implementation, with Git Bash required on Windows;
  consume GitHub releases and use an internal local catalog as the
  installation source.
- Dependency constraints: additional tool installations are acceptable when
  necessary. Document required dependencies and installation instructions
  for each supported platform, and check their availability before use.
  Specific dependencies and minimum supported versions are implementation
  details to establish during path discovery and planning.
- Social / legal / ethical constraints: none additionally specified.
- Other: temporary solution pending Double Software Project development;
  updates back up and replace installed files; backup deletion is a user
  choice. Planning must define managed machine files from release package
  contents while preserving unrelated project content.

## 8. Resources

- Available resources: the existing [release script](../../scripts/double-release.sh),
  [release tests](../../tests/test-double-release.sh), and
  [publication workflow](../../.github/workflows/release.yml).
- Available state location: `~/.local/state/double`, shared across all
  integrated projects for the current user.
- Resources to establish during planning: minimum supported versions and
  the concrete utility dependencies needed on each platform.
- Tools or systems: GitHub release distribution, local Shell environments,
  machine archives, and user-specified project directories.
- People or organizations: Double maintainers, early developers, and users.

## 9. Open Questions

None. The goal is sufficiently clarified for path discovery. Concrete
dependency versions, managed-file boundaries, and cleanup mechanics are to
be specified during research and planning.

## 10. Boundaries / Non-Goals

- Completing the broader Double Software Project is outside this goal.
- This goal targets a minimal Shell installer rather than a complete package
  manager or application platform.
- Separate PowerShell and Zsh implementations are outside the first version.
- Changes to machine operating contracts and publication of machine releases
  are not implied by consuming packages. Publishing the installer itself and
  verifying its downloaded assets belong to delegated S06 (CI04–CI06).
- Installing unpublished artifacts or directly from repository branches is
  outside the first version; published GitHub release packages define the
  available installation content.
- Background updates use an optional user-requested cron task. Implementing
  a background service or an alternative scheduler such as Windows Task
  Scheduler is outside the first version.
- Planning must specify the update boundary between installed machine files
  and unrelated project-local content before implementation.

## 11. Machine of Goals Artifacts

- Current step: `04-plan-review-and-decision`.
- Current mode: `planning`.
- Responsible agent: `plan-synthesis-agent`.
- Possible realization paths: [Path options](./path-options.md#double-installer-path-options).
- Plan: [Current plan](./plan.md#double-installer-plan).
- Realization registry: [Registry](./plan.md#realization-registry), interactive REST development registered.
- Current plan revision: [Revision 4](./realizations/plan-revision-4.md#double-installer-plan).
- Retained partial run baseline: [Revision 2](./realizations/plan-revision-2.md#double-installer-plan).
- Decision: [REST development](./realization-decision.md#double-installer-realization-decision).
- Realization: [Interactive REST](./realizations/interactive-rest.md#interactive-rest).
- Execution attempts: [Run index](./run/index.md#double-installer-run-index).
- Computed plan style: single-pass (no automatic realization registered).

Installer documentation: [Double Installer knowledge](../../knowledge/double-installer/double-installer.md#double-installer).

Retained partial continuation: [Revision-3 run](./run/interactive-rest--20261014T161825Z.md#double-installer-run-interactive-rest-20261014T161825Z).

S06 is expanded to GitHub Actions for Linux/macOS/Windows on x86_64 and ARM64.
Historical six-platform hosted evidence exists for published 0.1.1-rc. The
new S05A CLI/global extension needs fresh S06 coverage and real agent-loading
validation; do not reuse old release results for changed source.


Local development validation uses tests/ on the host and available VMs; coverage
is conditional on those environments. See [local availability matrix](./double-installer-validation/plan.md#stage-s06-local).
Each new installer script version must pass the full required GitHub Actions
matrix and integration checks before release; see [release validation](./double-installer-validation/plan.md#stage-s06-release-ci).
Local partial coverage does not relax the release acceptance criteria.

S06 detail is owned by the [validation subgoal](./double-installer-validation/double-installer-validation.md#double-installer-validation)
and its [plan](./double-installer-validation/plan.md#double-installer-validation-plan).

## Approved Extension — 2026-10-16

install aliases download. Explicit --all chooses one latest machine version
by stable → rc → dev priority. add --global installs and integrates;
update --global updates registered installations only. Explicit --agent selects
an adapter; otherwise detected agents are offered for consent with shared-only
as the default. Track global payloads/skills in registry; preserve unrelated content,
back up replacements and remove owned entries during full uninstall.

Current extension run: [S05A — installation consent and directory backups](./run/interactive-rest--20261019T102423Z.md#double-installer-run-interactive-rest-20261019T102423Z).
