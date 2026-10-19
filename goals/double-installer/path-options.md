---
id: double-installer-path-options
kind: path-options
template-id: path-options-template
project-id: double
produced-by: machine-of-goals/path-discovery-agent
interaction-language: ru
artifact-language: en
goal-id: double-installer
goal-artifact: ./double-installer.md
goal-scope: main-goal
parent-goal-id: null
derived-from:
  - ./double-installer.md
  - ../../scripts/double-release.sh
---

<a id="double-installer-path-options"></a>

# Path Options: Minimal Double Bash Installer

## 1. Source Goal

- Goal: [Double Installer](./double-installer.md#double-installer).
- Scope: main-goal; no parent goal.
- Current state: machine packaging exists; the project installer and its
  cross-project registry do not yet have an implementation in this goal.
- Target state: one Bash installer manages release downloads, machine
  installation, updates, removal, backups, optional cron, and full cleanup.
- Success criteria: consistent project files and registry across multiple
  projects, successful bulk updates and removal, and complete installer cleanup.
- Constraints: Linux/macOS and Windows through Git Bash; additional
  dependencies allowed; shared state in `~/.local/state/double`; stable releases
  by default; `rc` and `dev` only by explicit choice.

## 2. Discovery Scope

- Mode: `research`; inspected on 2026-10-13.
- Local sources: [release packager](../../scripts/double-release.sh),
  [release tests](../../tests/test-double-release.sh), and
  [publication workflow](../../.github/workflows/release.yml).
- Related boundary: [Double System Installer](../double-system-installer/double-system-installer.md#double-system-installer)
  owns installation of the distribution entry point. This goal owns downstream
  machine management, not implementation of that bootstrap.
- External sources: [GitHub Releases REST API](https://docs.github.com/en/rest/releases/releases),
  [GitHub CLI release listing](https://cli.github.com/manual/gh_release_list),
  and [release asset downloads](https://cli.github.com/manual/gh_release_download).
- Existing analog: reuse the local packaging contract, not the publishing
  script itself as an installer. No plan import is needed.
- Evidence: the packager emits `double-<machine>-<version>[-rc|-dev].tar.gz`
  and `SHA256SUMS.txt`. Archives contain machine-specific Markdown files under
  `.double/`; machine files are selected by their `/<machine>/` path segment.
  It sets GitHub prerelease status for `rc` and `dev`.
- Hosted evidence: an authorized unauthenticated read of the
  [release inventory](https://api.github.com/repos/densclub-rs/double/releases?per_page=100)
  returned two published prereleases: `machine-of-ideas-0.2.3-rc` and
  `machine-of-ideas-0.2.1-rc`, each with its machine archive and `SHA256SUMS.txt`.
  No stable releases or other machines were present in that response.
- Limitation: inventory is a snapshot, not a package-content validation. No
  downloaded archive or Windows runtime has been validated by this research.

### Shared feasibility findings

Both candidates retain the same Bash implementation medium and meet the same
goal. They differ in the distribution access architecture, not in programming
language or separate plan artifacts.

GitHub offers a release-list REST endpoint with assets and download URLs;
GitHub CLI offers release listing and downloading of selected assets. Either
can feed the existing archive contract without changing machine templates.

The following requirements apply to both paths and must be made concrete in
planning:

- Enumerate releases with pagination and select numeric versions per machine
  and allowed channel, rather than using the repository-wide latest release.
- Report an unavailable machine/channel without silently falling back to a
  prerelease. With the observed inventory, initial live installation requires
  explicit `rc` selection; multi-machine stable scenarios need fixtures until
  matching releases are published.
- Download the package and its checksum into a release-specific directory;
  verify before use. Do not install GitHub's automatic source archive instead
  of the packaged asset.
- Derive an installed-file inventory from validated archive members. Reject
  paths outside the intended machine scope, traversal, and unsafe links.
  Track previous inventories so removed release files do not linger on update.
- Back up managed files, including local modifications, before replacement.
  Preserve unrelated files and refuse unowned path collisions rather than
  silently taking ownership of existing project content.
- Store the project-machine version, canonical project path, and managed-file
  inventory persistently. Update registry state only after successful changes;
  retain enough recovery state for interrupted or partial operations.
- Prevent simultaneous mutations by cron and interactive commands. Use absolute
  executable paths and an explicit environment for cron. Remove only marked
  installer-created cron entries during cleanup.
- Keep downloads, backups, and registry under installer-owned subdirectories
  of the shared state root. Full cleanup must preserve other components' state.
- Verify paths containing spaces and non-ASCII characters, Git Bash path
  normalization, and portable checksum/tar behavior on the three platforms.
- Coordinate bootstrap-owned executable placement and cleanup ownership with
  Double System Installer; do not expand this goal into bootstrap development.

<a id="path-direct-release-api"></a>

## 3. Path Options

### 3.1. Path: Direct Release API Consumer

- Path id: `path-direct-release-api`.
- Path type: minimal.
- Description: consume GitHub release metadata directly using `curl` and `jq`,
  download published assets into the local catalog, and manage project files
  through a persistent registry and per-installation inventories.
- Why it is plausible: the existing packages already provide the payload and
  checksums; the REST API exposes release tags, channel flags, and asset URLs.
- Required resources: Bash, curl, jq, tar, portable filesystem tools, SHA-256
  support, and optional crontab. A JSON registry can reuse jq.
- Main risks: custom pagination, rate-limit and network-error handling; native
  Windows/Git Bash argument differences; interrupted project mutations.
- Expected cost: medium; a small HTTP adapter plus the shared lifecycle engine.
- Expected value: high; a public repository can be accessed without mandatory
  GitHub CLI setup or account login, subject to unauthenticated API limits.
- Unknowns: none blocking comparison; exact versions, state schema, retry
  policy, and cross-platform behavior are planning and validation work.
- Reuse / import opportunity: consume the current release contract unchanged.
- Lifecycle: included-in-plan.
- Plan element: [Direct API branch S02A](./plan.md#stage-s02a).
- Recommendation: include-in-plan as the recommended first-version candidate,
  subject to later user review and selection.

<a id="path-github-cli-consumer"></a>

### 3.2. Path: GitHub CLI Release Consumer

- Path id: `path-github-cli-consumer`.
- Path type: tool-based.
- Description: require GitHub CLI for release metadata and asset downloads;
  keep the same Bash-owned catalog, registry, inventories, backup, cron, and
  cleanup behavior as the direct API candidate.
- Why it is plausible: `gh release list`, `gh release download`, and `gh api`
  provide the required GitHub access operations. The publication script
  already uses gh, although that does not establish its presence for users.
- Required resources: Bash, GitHub CLI with usable credentials/environment,
  tar, filesystem and checksum tools; jq if selected for the registry schema.
- Main risks: an extra client and authentication setup for early users;
  cron must have access to the required credentials and executable paths.
  The local lifecycle engine still needs all the shared safeguards above.
- Expected cost: medium; less direct HTTP code but more setup documentation.
- Expected value: medium to high for developers already using gh.
- Unknowns: none blocking comparison; exact CLI versions and unattended
  credential behavior require validation if this path is selected.
- Reuse / import opportunity: reuse publication-side gh familiarity, not
  publication permissions or workflow credentials.
- Lifecycle: included-in-plan.
- Plan element: [GitHub CLI branch S02B](./plan.md#stage-s02b).
- Recommendation: keep-as-alternative.

## 4. Comparison

| Path | Fit | Cost | Risk | Uncertainty | Expected Value | Recommendation |
| --- | --- | --- | --- | --- | --- | --- |
| [Direct API](#path-direct-release-api) | High | Medium | Medium | Medium | High | Recommend for first version |
| [GitHub CLI](#path-github-cli-consumer) | High | Medium | Medium | Medium | Medium–high | Keep as alternative |

The direct API candidate favors low adoption friction; the GitHub CLI
candidate favors reuse of a dedicated client. Neither choice removes the main
work: reliable project mutation, ownership tracking, backups, and cleanup.
The user selected the direct API path on 2026-10-13; see the
[decision](./realization-decision.md#double-installer-realization-decision) and
[registered realization](./plan.md#interactive-rest). S01 has been submitted
for validation; transport implementation has not started.

## 5. Rejected or Deferred Paths

- A dependency-free Bash implementation that parses JSON using text matching:
  rejected as fragile for release metadata and arbitrary project paths.
- New release manifests or a redesigned distribution service: deferred;
  existing package inventories are sufficient for a first implementation.
- A general package manager, TypeScript agent, separate PowerShell/Zsh
  implementations, or Windows scheduler integration: outside the agreed scope.
- Separate installers per project: rejected because central registration and
  bulk updates are explicit goal requirements.

## 6. Open Questions

None blocking plan synthesis. Hosted package usability remains an explicit
validation requirement, not evidence of a successful installation. The plan
must retain platform checks, inventory verification, interruption recovery,
and the bootstrap integration boundary as work to be validated.

## Approved Distribution Extension — 2026-10-15

Both consumer paths converge on delegated [S06](./plan.md#stage-s06): independent
`double-installer-<version>` releases publish one universal Bash script and
SHA-256 only after complete exact-commit CI. This does not change the selected
Direct API machine-consumption path or register another realization. Executable
placement remains owned by Double System Installer.

2026-10-16: separate S07 superseded by delegated CI04 release preparation,
CI05 end-to-end publication and CI06 acceptance. Consumer path unchanged.
