---
id: github-actions-maintenance
kind: goal-artifact
template-id: goal-template
project-id: double
produced-by: machine-of-goals/goal-formulation-agent
owner-id: densclub
interaction-language: ru
artifact-language: en
parent-goal-id: double-github-integration
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

The repository contains a Python release program, pytest coverage and a GitHub
Actions adapter. On 2026-11-06, local tests and existing hosted release evidence
were inspected. The user accepted the reported results as validation evidence
for the existing automation, within the scope recorded below.

### Known facts

- [Release program](../../../scripts/double-release/double-release.py) provides
  `list-machines`, `package --machine <machine>`, `package --tag <tag>` and
  `publish --tag <tag>` through Python 3.11+.
- [Shared rules](../../../scripts/double-release/release_common.py) resolve tag
  classes, machine ownership and version/changelog sources.
- [Release notes](../../../scripts/double-release/double-release-notes.py)
  prepare approved release text; the [pytest suite](../../../tests/double-release/README.md)
  covers packaging, publication, notes, storage and workflow behavior.
- [Workflow](../../../.github/workflows/release.yml) accepts `machine-*` and
  `double-agent-*` tags and manual dispatch. It resolves the exact tag commit,
  checks out tooling separately, tests the candidate, and retains evidence.
- `validation_only=true` skips notes, publication and announcements.
- Python tooling replaced the former shell tooling in commit `bcc07d9`.
  Installer releases remain an independent subsystem.

<a id="release-validation-2026-11-06"></a>

### Accepted Validation Evidence — 2026-11-06

The user accepted the reported verification results with the statement:
“давай так и сделаем, это и есть доказательство валидации”. This accepts the
observed evidence below; it does not retrospectively assert that every plan
stage was executed or every goal condition independently verified.

- Local check, from the repository root:
  `uv run --with-requirements tests/double-release/requirements.txt python -m pytest -c tests/double-release/pytest.ini tests/double-release`.
  Observed result: **130 passed, 1 skipped in 13.37s**, Python 3.14.7,
  pytest 8.3.5. The skipped check was `test_selected_release_tag`, because no
  `--release-tag` was supplied. An initial `python3 -m pytest` attempt failed
  because that interpreter had no pytest; the uv invocation supplied the test
  dependencies. This is a recorded tool-output summary from the conversation,
  not a separately retained local test log.
- [Hosted run 42243821307](https://github.com/densclub-rs/double/actions/runs/42243821307)
  ran on 2026-11-06 for `machine-of-ideas-0.2.8`, commit
  `5a75319f6c8a68d243b8d0d4fa85aedf7535eb96`. The local tag resolves to that
  commit. There was no diff in release tooling, tests or workflow against it.
  The inspected job/step records show successful candidate identity checks,
  tests, approved-note preparation, publication and the announcement step.
- [Published stable release](https://github.com/densclub-rs/double/releases/tag/machine-of-ideas-0.2.8)
  is neither draft nor prerelease. Assets inspected through GitHub API:
  `double-machine-of-ideas-0.2.8.tar.gz` (29,766 bytes) and
  `SHA256SUMS.txt` (103 bytes).
  The downloaded checksum text names the archive with SHA-256
  `7a8c82c2b936a476e0812cf0b50dca6b12297c3eea1a11cd6821216d6f26c5a4`,
  matching GitHub's reported asset digest. The published archive itself was
  not downloaded and independently hashed during this check.
- The existing local archive contained 38 machine-of-ideas Markdown files,
  all with `status: stable` and exported `version: 0.2.8`. Its byte hash was
  `0c1b77da0f1680ff253a6ab884175e49de5caa889298c58a24ab9a0df0bd2c03`;
  it was not the byte-identical published archive and is not evidence of
  published archive membership. No new candidate package was generated.
- The run's evidence artifact `machine-release-validation-42243821307-1`
  was created at `2026-11-06T15:31:52Z` and expires at
  `2026-11-20T15:31:51Z`, consistent with 14-day temporary-artifact retention.
  Its contents/JUnit were not downloaded in this inspection.
- Repository Actions artifact/log retention was independently read as **90
  days** through `GET /repos/densclub-rs/double/actions/permissions/artifact-and-log-retention`.
  This is distinct from the workflow artifact's 14-day override; no setting
  was changed.

Evidence applicability: the local suite covers packaging and workflow rules,
with mocked publication/notification boundaries and fixture cases including
stable, rc, dev, invalid-source, mismatch and no-match behavior. The inspected
live release demonstrates one stable publication; a new validation-only run,
all release classes on GitHub, and independent inspection of the full published
archive were not performed. Acceptance does not imply that those additional
checks occurred. No code change, dispatch, publication or notification was
performed by this verification. Future candidates need their own applicability
check; expiring hosted artifacts must not be assumed permanently available.

### Closure Assessment — 2026-11-06

The accepted evidence supports the goal's minimal-success criterion for the
existing release automation. The user accepted this baseline as achieved on 2026-11-06; this is not
a claim that the approved plan was executed again stage by stage.

| Criterion | Evidence and assessment |
| --- | --- |
| Tag recognition, machine ownership and status filtering | Passing local fixture tests cover stable, rc, dev, mismatch and no-match cases; existing local archive inspection supports the selected-machine scope. |
| Permissions and publication boundaries | Source review and passing workflow/publication tests cover job permissions, nonpublishing package operations and notification gates. |
| Representative real operation | The linked stable hosted run and non-draft release establish actual publication; the published checksum matches GitHub asset metadata. |
| Retention and maintainability | Temporary evidence retention is 14 days; repository retention is separately confirmed as 90 days. Tooling, tests and maintenance responsibilities are documented. |

No observed result establishes the partial-success or failure criteria. The
remaining evidence limitations above do not negate representative validation:
all release classes need not be published live solely for this assessment.
Independent download/hash/membership checks of the published archive would
strengthen assurance but were not performed. Broader high-quality claims, such
as ease of future maintenance, are not independently certified by this check.

The user confirmed minimal success for the current release baseline. The goal
remains open for ongoing functional evolution through [S05](./plan.md#stage-s05). New release candidates still need their normal
checks; this assessment grants no publication or notification authority.

### Relevant environment

Local Python 3.11+, Git and pytest; GitHub Actions, GitHub CLI and GitHub Releases;
optional Telegram configuration for the separate announcement job.

### Existing related goals or subgoals

- Parent: [Double GitHub Integration](../double-github-integration.md#double-github-integration).
- No child goals are required for the current scope.

## 5. Target State

Maintain one locally testable release contract and a GitHub Actions adapter
that packages the intended machine, validates its version and publishes only
with the required evidence and approved release text.

- Required result:
  - Support periodic user-requested functional extensions through plan S05.
    Each request adds concrete substages and evolves goal requirements, the
    existing program and its tests together; no speculative backlog is implied.
  - Keep release tooling in `scripts/double-release/`, tests in
    `tests/double-release/`, and the workflow in `.github/workflows/release.yml`.
  - Tagged packaging reads the exact tag tree. Tags use
    `<machine>-<major>.<minor>.<patch>[-dev|-rc]`, without a `v` prefix.
  - `dev`, `rc` and stable tags select `draft`, `release-candidate` and `stable`
    Markdown files respectively, owned by the selected machine under `.double/`.
  - Excluded files with missing or nonmatching status produce warnings; no-match
    produces neither an empty package nor a release.
  - Resolve version knowledge reproducibly inside the candidate tree using
    indexed project rules, with the historical knowledge path only when allowed.
    Follow the [version-source contract](../../../knowledge/machine-version-and-changelog-locations/machine-version-and-changelog-locations.md#machine-version-and-changelog-locations).
    Reject missing, invalid, broken, conflicting or external-only sources and
    tag/version mismatch. Version mismatch is no longer the only failure case.
  - Add the verified version to distribution copies without modifying source
    files; produce the archive and `dist/SHA256SUMS.txt` with matching SHA-256.
  - Local `package --machine` uses current working files, including untracked
    files and all statuses, and a valid local version. It is not tagged-release
    evidence and must never publish.
  - Tagged `package` is also nonpublishing. `publish` is restricted to GitHub
    Actions and requires approved notes. Stable releases are normal releases;
    `dev` and `rc` releases are prereleases.
  - Verify the tag commit and checkout identity before candidate tests. Run
    pytest and exact-tag packaging before publication. Test failures and failed
    identity checks stop the workflow; a successful job alone is not publication proof.
  - Preserve approved changelog/tag text as release notes. Verify a non-draft
    release URL before reporting publication or allowing an announcement.
  - Preserve `validation_only` as the hosted nonpublishing check. Retain JUnit,
    archive and checksum evidence for 14 days; published assets are not subject
    to that temporary-artifact policy. Verify repository log retention separately.
  - Use job-specific permissions: candidate `contents: read`; release
    `contents: write` and `pull-requests: read`; Telegram no repository permissions.
    GitHub publication uses the automatic GitHub token.
  - Optional Telegram delivery uses its separate secrets and topic variable,
    runs only after verified eligible publication, and cannot fail the release.
    Missing configuration skips delivery; reruns can duplicate notifications.
  - Installer tags use the independent installer workflow. No machine packaging
    change may absorb installer publication or delete published assets.
  - The repository owner reviews maintenance changes when needed; no fixed
    maintenance cadence is required.
- Optional quality improvements: workflow linting, clearer diagnostics and
  reusable components where they improve maintenance without duplicating logic.
- Evidence: local pytest results, inspected package/checksum contents, exact
  candidate identity, hosted validation artifacts and, when publication is
  authorized, the resulting release URL and assets.

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
  reports publication without verified assets. A declared warning/no-match
  or validation-only outcome is not a publication claim.

## 7. Constraints

- Time: not yet specified.
- Attention: begin from the existing release workflow and keep the release
  contract explicit before expanding automation.
- Money: no budget specified; prefer GitHub-native capabilities and freely
  available tooling unless a later decision approves otherwise.
- Technical constraints: tagged releases include only machine-owned Markdown
  files under `.double/` with the required frontmatter status. Local
  `package --machine` intentionally includes all statuses and working files.
  Warn on excluded tagged candidates; create no empty package or release.
  Use least-privilege permissions, protect credentials and preserve source files.
- Social / legal / ethical constraints: make consequential automation behavior
  transparent to maintainers and contributors.
- Other: no workflow, repository setting, secret, permission, or release is
  changed merely by formulating this subgoal.

## 8. Resources

- Available resources: the Double repository, Python release tooling, pytest,
  `.github/workflows/release.yml`,
  the `.double/` machine working files and their frontmatter statuses, GitHub
  Actions, GitHub Releases, repository documentation, and the parent goal.
- Missing resources: none blocking the current representative validation
  assessment. Future candidates require applicable hosted evidence and settings
  checks; the accepted evidence above is scoped to the inspected candidate.
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

Possible paths: [Path options](./path-options.md#github-actions-maintenance-path-options)

| Branch | Review revision | Plan |
| --- | --- | --- |
| release-maintenance | 4 | [releaseguard](./plan.md#releaseguard) |
