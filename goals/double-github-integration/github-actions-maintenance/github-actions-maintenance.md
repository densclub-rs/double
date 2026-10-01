---
id: github-actions-maintenance
kind: goal-artifact
template-id: goal-template
project-id: double
produced-by: machine-of-goals/goal-formulation-agent
owner-id: double-project
interaction-language: en
artifact-language: en
goal-scope: subgoal
parent-goal-id: double-github-integration
parent-goal-directory: ..
subgoal-directory: .
derived-from:
  - source conversation on 2026-07-19
  - ../../../.github/workflows/release.yml
  - ../double-github-integration.md
---

<a id="github-actions-maintenance"></a>

# Goal: GitHub Actions Maintenance

## 1. Summary

Create and maintain Double's GitHub Actions release workflow so that releases
of individual Double machines are reliable, status-filtered, understandable,
and verifiable over time.

## 2. Subject of the Goal

### Subject

- The GitHub Actions release workflow and its supporting repository
  configuration for the Double project.
- Module-specific release packages assembled from working files in `.double/`.

## 3. Motivation

- Make the release of each Double machine dependable and reproducible.
- Publish a release payload that matches the intended maturity of its tagged
  release class.
- Keep release behavior clear enough to review, operate, and improve safely.
- Reduce manual mistakes and undocumented behavior around releases.

## 4. Current State

The release lifecycle defined by this goal is implemented. The repository has
a reusable release program at `scripts/double-release.sh`, local validation at
`scripts/test-double-release.sh`, and a thin GitHub Actions adapter at
`.github/workflows/release.yml`.

A pushed tag or manual-dispatch input selects one Double machine and one
maturity class. The same release contract is exercised locally and in GitHub
Actions: the selected machine version is verified, matching working files are
packaged from `.double/`, a checksum is generated, and publication remains
restricted to GitHub Actions.

### Known facts

- `scripts/double-release.sh` implements the shared `package --tag <tag>` and
  `publish --tag <tag>` release interface.
- `scripts/test-double-release.sh` validates representative local packaging
  behavior and can additionally package a supplied release tag.
- `.github/workflows/release.yml` tests the selected tag and then invokes the
  release program as a thin publication adapter.
- The workflow handles machine release tags matching `machine-*`; the release
  program applies the accepted machine tag grammar below.
- The workflow uses GitHub Actions checkout and the automatic repository GitHub
  token to create or update releases.
- This subgoal is an accepted subgoal of `double-github-integration`, and its
  release behavior is the existing maintenance baseline.
- Double has multiple machines, including Machine of Ideas and Machine of
  Goals.
- A machine tag, such as `machine-of-ideas` or `machine-of-goals`, identifies
  the machine whose `.double/` working files are eligible for the release.
- A selected machine's working files are Markdown files with frontmatter under
  any `.double/` directory path containing that machine's name; the selection
  pattern is `.double/**/<machine-name>/**/*.md`.
- Every release tag includes a dot-separated numeric version without a `v`
  prefix: `<machine>-<major>.<minor>.<patch>`.
- The accepted tag forms are `<machine>-<major>.<minor>.<patch>-dev`,
  `<machine>-<major>.<minor>.<patch>-rc`, and
  `<machine>-<major>.<minor>.<patch>` for stable releases.
- A `dev` suffix selects only files with `status: draft`.
- An `rc` suffix selects only files with `status: release-candidate`.
- No suffix selects only files with `status: stable`.
- `dev` and `rc` tags create GitHub prereleases; a tag without either suffix
  creates a normal GitHub release.
- A release must include only the selected machine's matching-status working
  files from `.double/`.
- A selected machine file without the required release-class status, including
  a file with no `status`, is excluded and reported as a workflow warning.
- When no files match the selected machine and release-class status, the
  workflow does not fail and creates neither a package nor a GitHub Release; it
  prints a final warning that records this result.
- Manual dispatch accepts a release-tag input using the same
  `<machine>-<major>.<minor>.<patch>[-dev|-rc]` grammar and applies the same
  machine, status, prerelease, package, and no-match rules as a tag-triggered
  release.
- The release workflow runs autonomously in GitHub Actions after a supported
  tag trigger or manual dispatch. It has no separate manual review or
  validation gate; its final workflow result, logs, warnings, and published
  release artifacts are the validation evidence.
- The workflow uses `contents: write` as its only GitHub Actions permission.
- The workflow uses no repository secrets beyond the automatic GitHub token.
- GitHub Actions logs and temporary workflow artifacts are retained for 14
  days. Published GitHub Release assets remain available.
- The repository Artifact and log retention setting is 14 days; any uploaded
  temporary workflow artifact also specifies `retention-days: 14`.
- The only release-failing condition is a mismatch between the version in the
  release tag and the selected machine's version knowledge artifact at
  `knowledge/<machine>-version/<machine>-version.md`. All other non-success
  conditions defined by this goal are GitHub Actions warnings.
- Working files do not need a frontmatter `version`. The packager adds the
  verified tag version to each exported working-file copy in the distribution.
- The repository owner owns ongoing release-workflow maintenance and reviews
  release-workflow changes.
- No fixed review or maintenance cadence is required for now; the repository
  owner acts when a relevant release-workflow change arises.

### Relevant environment

The Double GitHub repository, GitHub Actions, GitHub Releases, repository
secrets and permissions, and local contributor workspaces.

### Existing related goals or subgoals

- Parent goal: [Double GitHub Integration](../double-github-integration.md#double-github-integration).
- No child goals are identified at this stage.

## 5. Target State

Double has a maintained GitHub Actions release workflow that creates
module-specific GitHub release packages safely and predictably. It selects the
machine and maturity class from the release tag, packages only matching working
files from `.double/`, and records its behavior and maintenance responsibilities
in documentation supported by reproducible validation.

- Required result:
  - `scripts/` is the working directory for the release program
  - `scripts/double-release.sh` is the release program in that directory
  - `.github/workflows/` is the directory for GitHub Actions workflows
  - `.github/workflows/release.yml` configures the release workflow rules
  - `.github/workflows/release.yml` invokes special scripts to test, create
    and publish releases
  - `scripts/test-double-release.sh` validates the selected release tag before
    publication; `.github/workflows/release.yml` invokes it as
    `scripts/test-double-release.sh --tag "$RELEASE_TAG"`
  - accepted tags use the form
    `<machine>-<major>.<minor>.<patch>[-dev|-rc]`, where no suffix selects a
    stable release
  - a `dev` release includes only `status: draft` working files for the
    selected machine from `.double/`
  - an `rc` release includes only `status: release-candidate` working files for
    the selected machine from `.double/`
  - a stable release includes only `status: stable` working files for the
    selected machine from `.double/`
  - machine files are selected only from `.double/**/<machine-name>/**/*.md`
  - excluded candidate files with a nonmatching or missing `status` produce
    workflow warnings
  - a no-match result succeeds without an empty package or GitHub Release and
    prints a final workflow warning
  - manual dispatch validates and applies the same release-tag grammar and
    release rules as a pushed tag
  - autonomous GitHub Actions runs record the final release result, logs,
    warnings, and artifacts as validation evidence
  - the workflow requests only the `contents: write` permission
  - the workflow requires no repository secrets beyond the automatic GitHub
    token
  - GitHub Actions logs and temporary workflow artifacts have a 14-day
    retention period; published GitHub Release assets remain available
  - the repository Artifact and log retention setting and every uploaded
    temporary workflow artifact use a 14-day retention period
  - the release fails only when the tag version does not equal the selected
    machine's version knowledge value at
    `knowledge/<machine>-version/<machine>-version.md`
  - working-file frontmatter does not require `version`; the verified tag
    version is generated into each exported working-file copy
  - all other non-success conditions produce GitHub Actions warnings
  - the repository owner maintains and reviews release-workflow changes
  - no fixed review or maintenance cadence is required for now
  - `dev` and `rc` releases are marked as GitHub prereleases; stable releases
    are not marked as prereleases
  - the workflow creates the corresponding GitHub release package and checksum
  - triggers, permissions, secrets, package contents, failure behavior, and
    maintenance ownership are documented
  - reproducible validation evidence exists for representative release runs
- Optional quality improvements: workflow linting, reusable release components,
  status reporting, and automated failure notifications.
- Evidence that would show the target state exists: representative tagged
  releases contain only the intended machine's files with the required status,
  their checksums match the package, and GitHub Actions runs complete or fail as
  the declared contract requires.

## 6. Success Criteria

- Minimal success: the release workflow recognizes the approved module tags,
  packages only the selected machine's `.double/` working files with the
  required status, uses only required permissions and inputs, and has
  successful representative validation evidence.
- High-quality success: the workflow is easy to review and modify, protects
  secrets and repository access, provides useful diagnostics, and has a clear
  maintenance and change-review practice.
- Partial success: the workflow releases some machine files but does not
  reliably enforce the machine or status filter, or its contract is
  undocumented.
- Failure / not achieved: a release includes files for the wrong machine or
  status; the tag version does not equal the selected machine's version
  knowledge value; required automation is absent or unreliable; or the workflow
  reports success while failing to produce its declared package.

## 7. Constraints

- Time: not yet specified.
- Attention: begin from the existing release workflow and keep the release
  contract explicit before expanding automation.
- Money: no budget specified; prefer GitHub-native capabilities and freely
  available tooling unless a later decision approves otherwise.
- Technical constraints: package only Markdown working files with frontmatter
  from `.double/**/<machine-name>/**/*.md`; filter package contents by the
  release-class status and warn for each excluded nonmatching or missing-status
  candidate; do not create an empty package or GitHub Release when no files
  match; use least-privilege permissions; do not expose credentials, secrets,
  or sensitive artifacts; keep automation reproducible.
- Social / legal / ethical constraints: make consequential automation behavior
  transparent to maintainers and contributors.
- Other: no workflow, repository setting, secret, permission, or release is
  changed merely by formulating this subgoal.

## 8. Resources

- Available resources: the Double repository, `.github/workflows/release.yml`,
  the `.double/` machine working files and their frontmatter statuses, GitHub
  Actions, GitHub Releases, repository documentation, and the parent goal.
- Missing resources: none currently identified; future release-contract
  changes may require fresh local and hosted validation evidence.
- Tools or systems: GitHub Actions, GitHub repository settings, Git, local
  validation tools, and any approved workflow-specific tooling.
- People or organizations: the Double project community, maintainers, and
  contributors.

## 9. Open Questions

None currently.

## 10. Boundaries / Non-Goals

- This subgoal covers the release workflow, not the complete future GitHub
  Actions workflow set.
- It does not change existing workflows, GitHub repository settings,
  permissions, secrets, or releases without later explicit approval.
- It does not own the GitHub site, general repository governance, or
  `double-general-installer`; those remain separate parent-goal concerns or
  goals.

## 11. Machine of Goals Artifacts

- Possible achievement paths: [Path options](./path-options.md#github-actions-maintenance-path-options)
- Plan: [Current plan](./plan.md#github-actions-maintenance-plan)
- Plan registry: [Registry](./plan.md#realization-registry)
- Computed plan style: `single-pass`
