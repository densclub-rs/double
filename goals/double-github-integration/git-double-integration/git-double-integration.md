---
id: git-double-integration
kind: goal-artifact
template-id: goal-template
project-id: double
produced-by: machine-of-goals/goal-formulation-agent
owner-id: densclub
interaction-language: ru
artifact-language: en
parent-goal-id: double-github-integration
derived-from:
  - user request to describe git-double and its integration into Double
  - ../../../scripts/git-double
  - ../../../scripts/test-git-double.py
  - ../../../scripts/scripts.md
  - ../double-github-integration.md
---

<a id="git-double-integration"></a>

# Goal: Git Double Integration

## 1. Summary

Provide a single, explicit `git double` interface for agents and contributors
to inspect Double's local document state, machine versions, prepared local
release tags, remote GitHub tags and GitHub Releases. Make discrepancies
visible before release actions, while preserving the existing opt-in draft
visibility behavior.

Document the supported commands in project rules so agents consistently use
this interface and narrowly scoped command permissions can allow routine
inspection without repeated confirmation.

Parent goal: [Double GitHub Integration](../double-github-integration.md#double-github-integration).

## 2. Subject of the Goal

### Subject

- Double contributors and agents working with Markdown artifacts in Git repositories.
- The local Git extension as the agent-facing integration boundary for document
  maturity, version knowledge, Git tags and GitHub release state.

## 3. Motivation

- Replace ad hoc agent shell/API sequences with a stable, inspectable command interface.
- Distinguish local preparation from remote publication and expose discrepancies.
- Enable narrowly scoped standing permission for routine reads while keeping
  mutating operations explicitly controlled.

- Reduce accidental inclusion of unfinished, untracked documents in routine Git work.
- Make release-candidate and stable documents visible for an explicit add/commit decision.
- Apply the same local behavior across Double's document catalogs without
  maintaining shared ignore rules for every draft.
- Preserve user control: document maturity guides visibility, not permission
  to commit, push or publish. Ignoring a draft is not a backup mechanism.

## 4. Current State

The implementation already exists. This goal records its purpose and project
integration; it does not presume that a new implementation must be created.
Source and documentation were inspected on 2026-11-06. No test run or local
configuration change was performed as part of this formulation.

### Known facts

| Existing artifact | Role in Double |
| --- | --- |
| [scripts/git-double](../../../scripts/git-double) | Python 3.9+ Git extension implementing check, sync and watch without third-party dependencies. |
| [scripts/test-git-double.py](../../../scripts/test-git-double.py) | Integration tests using disposable Git repositories. Their presence is not a current passing-test claim. |
| [Script documentation](../../../scripts/scripts.md) | Setup, command semantics, scopes, parsing limitations and exit codes. |

- Default document roots are `.double/`, `ideas/`, `goals/` and `knowledge/`;
  explicit files or directories narrow the scope.
- `check` is read-only. `sync` maintains a dedicated block in Git's local
  `info/exclude`. `watch` periodically synchronizes, with a default two-second interval.
- Untracked `draft` files should be ignored; untracked `release-candidate`
  and `stable` files should be visible. Unknown or missing status is unmanaged.
- Tracked files, including explicitly force-added drafts, are exempt.
- Setup is per clone: direct Python invocation, a local Git alias, or an
  executable on PATH. No installed alias or active watcher is assumed here.

The version/tag/release inspection interface and corresponding project command
rules are desired extensions, not existing capabilities of `check/sync/watch`.
The current script must not be described as already providing them.

<a id="reconstructed-baseline"></a>

### Reconstructed baseline — 2026-11-09

The user reports that the basic implementation stages were completed but their
plan was lost. The following mapping reconstructs their intent from current
artifacts, not the missing original stage numbering, dates or approvals.

| Reconstructed plan stage | Existing result and current evidence | Limitation |
| --- | --- | --- |
| [S01: Local Visibility](./plan.md#stage-s01) | Source inspection confirms check/sync/watch, scoped managed exclusions, tracked-file exemption, literal patterns and conflict reporting. | Historical acceptance and setup in any contributor clone are unknown. |
| [S02: Baseline Contract](./plan.md#stage-s02) | Existing script documentation and `python3 scripts/test-git-double.py`: 8 tests passed, exit 0, on 2026-11-09. Tests use disposable repositories. | This is a current baseline check, not recovered historical validation or complete edge-case coverage. |

The test suite exercises lifecycle/force-add, unrelated rules and conflicts,
literal paths and stale cleanup, read-only check and idempotent sync, status
parsing, malformed blocks, watcher transitions and missing explicit scopes.
No alias, project exclusion rules, permission settings or remote state were
changed by this inspection. Original execution contracts remain unavailable;
no retrospective realization or historical approval has been fabricated.
The proposed continuation is S03 after checking baseline applicability.

### Relevant environment

Local Git repositories, Python 3.9+, Markdown with opening YAML frontmatter,
and contributor workspaces. GitHub receives only documents explicitly committed
and pushed through the ordinary Git workflow.

### Existing related goals or subgoals

- Parent: [Double GitHub Integration](../double-github-integration.md#double-github-integration).
- Sibling: [GitHub Actions Maintenance](../github-actions-maintenance/github-actions-maintenance.md#github-actions-maintenance).
  The tools share artifact status vocabulary but own different boundaries:
  `git-double` controls local untracked-file visibility; release tooling selects
  files from an exact tagged tree. Neither tool establishes the other's validation.

## 5. Target State

- Required result:
  - For `versions`, support the main Double source project and its forks only.
    Resolve and check version knowledge through applicable Double project rules;
    show each machine's local knowledge version and remote version from that
    project's GitHub tags. This is not installed-version inspection in consumer
    projects. Committed/tagged source checks belong to tag/release inspection,
    not a `versions --ref` mode.
  - Inspect local release tags: machine, version/channel, annotation, target
    commit and agreement with the corresponding version/changelog contract.
    A local tag is not proof that a release is prepared or published.
  - Read remote GitHub tags and their target commits without implicitly fetching,
    creating or moving local refs. Compare local and remote tag identities,
    including annotated-tag objects and peeled commits where relevant.
  - Read GitHub Releases separately from tags: tag association, draft/prerelease
    state, URL and published assets. A remote tag alone is not a GitHub Release.
  - Present one comparison per machine, identifying local-only tags, remote-only
    tags, conflicting targets, missing releases and version/channel mismatches.
    Report unavailable/authentication-failed sources as unknown, never absent.
  - Provide stable subcommands, documented exit codes and machine-readable output
    alongside concise human-readable results. Fix exact command names during design.
  - Persist the implemented command catalog and agent usage policy as project
    knowledge under `.double-rules/`, indexed for the relevant agents/machines.
    Record exact invocation, scope, prerequisites, effects and error interpretation.
  - Configure and verify execution of the agreed inspection commands without
    repeated confirmation as a deliverable of this goal. During implementation,
    choose the target agent executors, repository/project scope and exact allowed
    commands with the user, then apply narrowly scoped permission rules and
    verify both allowed commands and excluded operations. These choices do not
    block goal formulation or planning. Read-only inspection must not transitively invoke
    sync, arbitrary shell commands, hooks, push, tag mutation or publication.
    Project Markdown rules guide agents; they do not themselves grant executor
    permissions or bypass sandbox/network/authentication controls.
  - A documented, usable `git double` entry point for local Double contributors.
  - Read-only diagnosis through `check`; scoped synchronization through `sync`;
    optional polling through `watch`, with observable changes and clean interruption.
  - Draft exclusion only for untracked Markdown documents in the selected scope.
  - Managed rules removed when a file becomes ready, tracked, unmanaged or absent;
    managed rules outside a selected scope and unrelated exclusion rules preserved.
  - Conflicts with other Git ignore rules reported rather than silently overridden.
  - No staging, unstaging, deletion, commit, push or hook installation by the tool.
  - Clear documentation that polling has a delay, each clone needs setup, and
    ignored drafts remain local and are not backed up through Git.
  - Existing scripts, tests and instructions stay synchronized as capabilities evolve.
- Optional quality improvements: clearer diagnostics and setup ergonomics without
  weakening the opt-in visibility policy or read/mutation separation.
- Evidence: passing isolated integration tests, observed check/sync behavior in a
  disposable repository, and reviewed setup/documentation matching the CLI.

## 6. Success Criteria

- Minimal success: the unified inspection commands distinguish all four sources
  (local versions, local tags, remote tags, GitHub Releases), expose mismatches,
  and have tested scoped permissions and indexed project usage rules. The agreed
  inspection commands run without repeated confirmation in the selected executor
  and scope, while excluded operations retain their controls. Existing
  documented commands also enforce the specified visibility policy
  for untracked documents while preserving tracked files, index contents and
  unrelated ignore rules, demonstrated by isolated Git integration tests.
- High-quality success: path escaping, scoped synchronization, status transitions,
  watcher behavior and error diagnostics are covered and understandable to users.
- Partial success: the script exists but behavior or integration instructions
  are incomplete, inconsistent or lack applicable validation evidence.
- Failure / not achieved: user content or index changes unexpectedly, unrelated
  rules are overwritten, tracked files become managed, or Git visibility is
  misreported as a guarantee against committing or publishing drafts.

## 7. Constraints

- Time: no fixed deadline or maintenance cadence.
- Attention: provide an integration facade; reuse existing version/release rules
  instead of duplicating release implementation.
- Cost: use local tooling and authenticated GitHub access where needed; account
  for API availability and rate limits. Keep the visibility commands lightweight.
- Technical constraints: preserve the simple top-level status parser; no inherited
  folder statuses, YAML aliases or multiline status values. Do not traverse symlinks;
  reject Markdown filenames containing line breaks. Keep documented path semantics.
- Safety and control: only the managed local exclusion block may change during sync;
  check must remain read-only. No silent repository configuration or watcher startup.
- Other: exit codes 0/1/2 indicate agreement/mismatch/error; they do not block Git.
  Explicit `git add -f` remains possible. Do not treat the tool as a security boundary.

## 8. Resources

- Available resources: the extension, isolated tests, script documentation and
  the Double artifact status conventions.
- Missing resources: design and implementation of remote/version inspection,
  applicable validation and GitHub access. Executor and permission scope will
  be selected during implementation before configuration is applied.
- Tools or systems: Git, Python and disposable test repositories.
- People or organizations: Double contributors and maintainers.

## 9. Open Questions

None blocking goal formulation. The user explicitly deferred selection of agent
executors and the scope of confirmation-free permissions to implementation;
configuring and verifying those permissions remains a required goal outcome.

The requested four inspection capabilities are in scope. Exact subcommand names,
output schema and remote-selection rules remain design decisions. Mutation
commands are not implicitly authorized by the request for routine inspection.


## 10. Boundaries / Non-Goals

- Helper distribution to other projects and systemic integration for project W
  are deferred to a separate goal. This goal does not implement a standalone
  installation/update/removal lifecycle for consumer projects.

- No replacement for Git, release packaging, GitHub Actions or the installer;
  integrate their state and reuse their contracts.
- No automatic add/commit/push, repository-wide hook policy or remote protection.
- No automatic extension to `.double-rules/` or other roots outside the documented
  defaults; explicit path selection remains available.
- No claim that all working documents have a status or should be managed.

## 11. Machine of Goals Artifacts

Path analysis: [Path Options](./path-options.md#git-double-integration-path-options).
The incremental-extension route supplies the requested plan sketch; execution
and acceptance remain separate from planning.

| Plan | Branch | Review revision |
| --- | --- | --- |
| [Git Double Integration](./plan.md#gitclarity) | incremental-inspection | 7 |

The parent's [release-infrastructure plan](../plan.md#githubbridge) retains its
release scope. This subgoal has not been added as an executable parent stage.
Current documented realization: [incremental-inspection, revision 3](./_realizations/2026-11-09T16-21-27/realization.md#gitclarity-2026-11-09t16-21-27),
linked to the [approved main plan](./plan.md#gitclarity). Its stage map owns progress;
no retrospective realization has been created for the lost history.
