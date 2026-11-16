---
id: gitclarity
kind: plan-model
template-id: plan-model-template
project-id: double
produced-by: machine-of-goals/plan-synthesis-agent
interaction-language: ru
artifact-language: en
goal-id: git-double-integration
branch: incremental-inspection
plan-revision: 7
derived-from:
  - ./git-double-integration.md
  - ./path-options.md
  - ../../../scripts/git-double
  - ../../../scripts/test-git-double.py
  - ../../../scripts/scripts.md
---

<a id="gitclarity"></a>

# Plan: Git Double Integration / incremental-inspection

Goal: [Git Double Integration](./git-double-integration.md#git-double-integration)

## Conditions

### Initial State

- A local Git checkout, Python 3.9+ and the existing script, tests and instructions
  are available. Preserve working changes and the document visibility policy.
- S01–S02 model the baseline capabilities whose original plan was lost.
  Their reconstruction basis and current observations are recorded in the
  [goal's Current State](./git-double-integration.md#reconstructed-baseline).
  Missing historical dates, approvals and execution contracts remain unknown.
- Version, tag and GitHub Release inspection and executor permission integration
  require design and implementation.

### Target State

- One usable `git double` entry point covers document visibility and read-only
  comparison of local versions, local tags, remote tags and GitHub Releases.
- Indexed project knowledge documents exact commands and effects; agreed
  inspection commands have verified narrow executor permissions.

### Success Criteria

- All required outcomes in goal sections 5–6 have applicable evidence, including
  unknown-source handling, tag identity comparison, permission boundaries and
  preservation of existing visibility behavior.
- Use isolated integration tests, reviewed CLI examples and selected-executor
  checks. Identify explicit user statements when documentary evidence is unavailable.

## Selection and Control Boundaries

- Proposed path: [incremental extension](./path-options.md#incremental-extension).
  A composed facade remains an alternative; choosing it requires model review.
- Full entry is [S01](#stage-s01). Recommended continuation is [S03](#stage-s03)
  after checking applicability of the reconstructed S01–S02 outputs. Reuse
  existing outputs instead of recreating code or inventing historical execution.
- Planning does not install an alias, start a watcher, configure permissions,
  modify local refs, fetch, push or publish. Network/authentication controls remain applicable.
- At execution, validate each observed stage output before proceeding. Stop on
  ambiguous version sources, unsupported repository selection, missing required
  access or a permission policy broader than the agreed commands.
- Executor, project scope and exact allowed invocations are selected with the
  user in S06 before configuration. No broad shell/interpreter permission.
- Release preparation/publication remains owned by the existing release process.
  Reuse [version/changelog rules](../../../knowledge/machine-version-and-changelog-locations/machine-version-and-changelog-locations.md#machine-version-and-changelog-locations).
- Distribution of the helper to other projects and systemic integration for
  project W are outside this plan; they require a separate goal.
- Parent context: [release-infrastructure plan](../plan.md#githubbridge).
  This plan does not insert a new executable stage into that parent. A future
  integration must explicitly agree its entry, returned outputs and continuation.

## Stages

| Stage | Input | Output | Next |
| --- | --- | --- | --- |
| [S01: Local Visibility](#stage-s01) | Local Git/document scope | Opt-in check/sync/watch implementation | [S02](#stage-s02) |
| [S02: Baseline Contract](#stage-s02) | S01 outputs | Isolated regression checks and setup instructions | [S03](#stage-s03) |
| [S03: Inspection Contract](#stage-s03) | Applicable baseline and release rules | CLI, source and comparison contracts | [S04](#stage-s04) |
| [S04: Local Release Inspection](#stage-s04) | S03 contract | Local versions and tags inspection | [S05](#stage-s05) |
| [S05: Remote Comparison](#stage-s05) | S04 outputs | Remote tags, Releases and discrepancy report | [S06](#stage-s06) |
| [S06: Agent Integration](#stage-s06) | Stable inspection commands | Indexed rules, usable entry point and scoped permissions | [S07](#stage-s07) |
| [S07: Goal Acceptance](#stage-s07) | S01–S06 evidence | Goal-wide validation and documented limits | End |

<a id="stage-s01"></a>

## S01: Local Visibility

Provide local maturity-based visibility without changing document contents or the index.

### Input Conditions

#### S01-I01: Local Repository

- Establish the selected Git root, document scopes and opening-frontmatter status policy.

### Actions

- Provide read-only `check`, scoped `sync` and optional polling `watch` in
  [git-double](../../../scripts/git-double); reuse applicable existing code.
- Manage only the dedicated local exclusion block, preserve outside-scope rules
  and exempt tracked files. Report conflicting external ignore rules.
- Preserve the simple parser, literal path handling and documented limitations.

### Output Conditions

#### S01-O01: Visibility Boundary

- Verify draft/ready transitions, tracked exemptions, stale rule cleanup and read-only check; verify no content, staging or unrelated ignore-rule changes.

<a id="stage-s02"></a>

## S02: Baseline Contract

Establish reproducible checks and contributor instructions for the visibility interface.

### Input Conditions

#### S02-I01: Visibility Available

- Establish S01-O01 against the candidate script and inspect existing tests and documentation.

### Actions

- Reuse and, where needed, complete the [isolated integration tests](../../../scripts/test-git-double.py).
- Check setup choices, default roots, explicit paths, exit codes, idempotence,
  malformed blocks, polling and clean interruption against the script.
- Keep [script documentation](../../../scripts/scripts.md) aligned; explain
  per-clone setup, polling delay, force-add and lack of Git backup for ignored drafts.

### Output Conditions

#### S02-O01: Reproducible Baseline

- Run `python3 scripts/test-git-double.py` in the project root; inspect actual test coverage and documentation. Record gaps rather than treating passing tests as proof of every edge case.

<a id="stage-s03"></a>

## S03: Inspection Contract

Define the complete helper command interface: preserve existing document-ignore
commands and design new read-only version/release inspection commands.

### Input Conditions

#### S03-I01: Applicable Baseline

- Establish S01-O01 and S02-O01; read goal criteria and existing version, tag, changelog and packaging contracts.

### Actions

Describe each existing or proposed command as a separate review item within S03. These items
expand the existing design action; they are not new execution stages. For each,
specify invocation/options, source provenance, human/JSON output, errors, exit
codes, read/write boundaries and acceptance fixtures. Review items independently;
all eight feed the common S03-O01 contract. Their observed design/review progress
belongs in the [S03 realization record](./_realizations/2026-11-09T16-21-27/s03-inspection-contract.md#command-design-review).

1. **`check` — Ignore Inspection.** Preserve the existing read-only check of
   Git visibility against document status: untracked drafts should be ignored,
   release-candidate/stable documents visible, tracked files exempt. Specify
   scope, mismatch diagnostics and existing exit codes from the actual script.
2. **`sync` — Ignore Management.** Preserve the existing command that adds
   untracked draft paths to the managed block in local `info/exclude` and removes
   obsolete entries when status/tracking/existence changes. Preserve unrelated
   rules and out-of-scope entries; do not alter the index or document contents.
3. **`watch` — Continuous Ignore Management.** Preserve optional polling sync,
   explicit scope, `--interval`, transition reporting and Ctrl-C interruption.
   It changes local exclusions like sync; do not classify it as read-only.
4. **`versions` — Local and Remote Machine Versions.** Limit this command to
   the main Double source project and its forks. Resolve each machine's current
   version knowledge through applicable Double project rules, verify that the
   knowledge exists and is usable, and show two entries per machine: local
   knowledge version and remote version from the selected project's GitHub tags.
   Report missing knowledge, missing tags and unavailable remote access distinctly.
   Do not inspect installed consumer-project machines or add a `--ref` mode.
   Show the latest stable and additionally the latest RC when numerically newer
   than stable (or when no stable exists); exclude dev from this summary.
5. **`tags` — Local Tags.** Define local tag inventory, annotation and tag-object
   identity, peeled commits and strict tagged version/changelog checks.
6. **`remote-tags` — Remote Tags.** Define explicit remote selection, supported
   read transports/authentication, direct/peeled identities and unavailable
   sources, without fetching or changing local refs.
7. **`releases` — GitHub Releases.** Define repository selection, authentication,
   pagination, draft/prerelease visibility, URLs/assets and source errors.
8. **`compare` — Source Comparison.** Combine the four source contracts into
   one comparison per machine; specify discrepancy codes, partial results,
   unknown prerequisites and aggregate exit status. Review after items 4–7.

The existing ignore interface is reused from S01–S02, not implemented again.
Ignoring affects untracked file visibility during ordinary Git add/commit work;
tracked files remain exempt and force-add remains possible. No separate new
`ignore` command or commit hook is implied.

Keep the new inspection commands consistent in human/JSON schema and 0/1/2
exit-code rules. Preserve existing ignore command syntax/output; do not assume
these commands already support JSON. Unknown is not absent. Keep check/sync/watch lightweight and do not
execute release tooling merely to inspect state.

### Output Conditions

#### S03-O01: Inspection Specification

- Review a complete CLI/output contract covering existing check/sync/watch,
  their distinct read/write effects and regression checks, plus all four new
  inspection sources, mismatches, unavailable sources and unsupported inputs. Resolve design choices before implementation; return model changes to review.

<a id="stage-s04"></a>

## S04: Local Release Inspection

Expose local machine versions and release tag identity with reproducible source checks.

### Input Conditions

#### S04-I01: Local Contract

- Establish S03-O01 and available fixture repositories/version knowledge.

### Actions

- Implement resolved machine versions with source paths and working-tree versus
  committed/tagged provenance, reusing ordinary lookup and strict release rules appropriately.
- Inspect local annotated/lightweight tags, tag objects, peeled commits, channels
  and annotations. Compare the corresponding tagged version and changelog contract.
- Keep local preparation claims limited to the checks actually made.

### Output Conditions

#### S04-O01: Local Inspection Evidence

- Use isolated fixtures for valid and conflicting version sources, dirty worktrees, missing/incorrect annotations, channel mismatches and tagged-tree differences. Verify reads preserve refs, index and configuration.

<a id="stage-s05"></a>

## S05: Remote Comparison

Compare remote tag identity and GitHub Release state with local machine state.

### Input Conditions

#### S05-I01: Local Inspection

- Establish S04-O01 and the S03 repository, transport and availability contract.

### Actions

- Read remote tags without fetching or changing local refs; retain annotated
  tag-object and peeled-commit identities.
- Read GitHub Releases separately, including tag association, draft/prerelease,
  URL and published asset inventory; handle all pages.
- Produce one comparison per machine: local-only/remote-only tags, conflicting
  identities/targets, missing Releases and version/channel discrepancies.
- Preserve useful partial results while reporting authentication, network and
  rate-limit errors as unavailable/unknown sources with appropriate error exit codes.

### Output Conditions

#### S05-O01: Four Source Comparison

- Test deterministic transport fixtures for agreement, all discrepancy classes, pagination and failures; check human/structured output and exit codes. Perform an authorized read-only live smoke check when access is available; unavailable live evidence remains an explicit limitation.

<a id="stage-s06"></a>

## S06: Agent Integration

Make the inspected interface usable by contributors and agents under an agreed permission boundary.

### Input Conditions

#### S06-I01: Stable Commands

- Establish S05-O01 and updated command documentation; obtain the user selection of executors, project scope and exact inspection invocations.

### Actions

- Document exact commands, scopes, prerequisites, effects and errors as project
  knowledge under `.double-rules/`, indexed for applicable agents/machines using
  the Machine of Knowledge contract when that work is undertaken.
- Provide and verify the chosen `git double` setup; do not assume an alias already exists.
- Apply only the selected executor's narrowly scoped policy after the required choices.
  Test the actual entry point and transitive operations, including alias resolution.
- Verify allowed inspection commands run without repeated confirmation and that
  sync/watch, arbitrary shell/hooks, ref mutation, push and publication are outside the grant.
  Use policy inspection, dry runs or disposable fixtures for negative checks.

### Output Conditions

#### S06-O01: Usable Scoped Integration

- Provide indexed usage knowledge, setup evidence and selected-executor permission checks. Markdown instructions alone and repeated sandbox escalation do not establish confirmation-free execution. Stop if the executor cannot express the required boundary.

<a id="stage-s07"></a>

## S07: Goal Acceptance

Validate the combined behavior against the goal rather than assuming individual features establish completion.

### Input Conditions

#### S07-I01: Integrated Evidence

- Establish applicable S01-O01 through S06-O01 and identify the exact candidate and executor configuration.

### Actions

- Run the baseline and new inspection regression suites, compare CLI help/examples
  with documentation, and review evidence for every required target and success criterion.
- Verify scope preservation, read/mutation separation, unknown-source handling,
  per-machine comparisons and permissions against the final candidate.
- Record unresolved gaps, evidence limits and the final validation decision in
  the authorized realization; return changed requirements or boundaries to review.

### Output Conditions

#### S07-O01: Goal Criteria Decision

- Require applicable local test evidence, inspection/comparison evidence, usable setup, indexed rules and positive/negative executor checks. A script or successful network call alone is insufficient; incomplete required outcomes leave the goal unaccepted.
