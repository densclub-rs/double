---
id: releaseguard
kind: plan-model
template-id: plan-model-template
project-id: double
produced-by: machine-of-goals/plan-synthesis-agent
interaction-language: ru
artifact-language: en
goal-id: github-actions-maintenance
branch: release-maintenance
plan-revision: 4
derived-from:
  - ./github-actions-maintenance.md
  - ./path-options.md
---

<a id="releaseguard"></a>

# Plan: GitHub Actions Maintenance / release-maintenance

Goal: [GitHub Actions Maintenance](./github-actions-maintenance.md#github-actions-maintenance)

## Conditions

### Initial State

- The parent supplies workflow and scripts directories with existing contents preserved.
- Python release tooling, pytest coverage and a workflow adapter are available
  for inspection and maintenance; their presence does not establish acceptance.

### Target State

- One shared release contract supports local packaging and controlled GitHub
  publication with exact candidate identity, verified version sources, approved
  notes, checksums and retained evidence.

### Success Criteria

- S01 establishes a complete contract; S02 checks local behavior; S03 checks
  the workflow adapter; S04 verifies hosted behavior against the same contract.
- Warning/no-match outcomes are distinguished from verified publication.
- Installer releases and optional notification delivery remain separate.

## Selection and Control Boundaries

- Included path: [Shared release program](./path-options.md#shared-script-workflow-adapter).
  Embedded workflow logic remains an unselected alternative; a composite action
  is deferred. The shared program favors local tests and one contract over
  workflow-only convenience. Python is the current implementation language.
- Entry: [S01](#stage-s01). Parent context: [parent S03](../plan.md#stage-s03).
  Return after S04 with contract, local checks and hosted evidence; the parent
  then validates its S03 and completes its branch.
- Explain each stage and obtain the required start approval. Local parsing,
  packaging and tests are within an authorized stage; publication, repository
  settings, workflow-rule changes and external notifications require approval.
- Never publish through `package`, expose secrets, delete existing tooling or
  published assets, or replay publication/notification merely to gather evidence.
- Use hosted `validation_only=true` before publication after adapter changes.
  A published workflow may run autonomously under its separately approved triggers.
- Prefer documentary evidence; an explicit user confirmation is an identified
  fallback, not a substitute silently inferred from source code.
- Revise affected conditions when evidence exposes a mismatch; revise this plan
  when the shared contract or parent interface changes. Reformulate the goal if
  releases no longer map a tag to a machine and maturity class.


## Ongoing Functional Evolution

[S05](#stage-s05) is the persistent entry for user-requested extensions after
the initial release baseline. It is dormant without a concrete request, not
an endless execution. Each return adds only requested substages under S05;
keep their stable IDs and condition IDs and preserve earlier work/evidence.
Do not prepopulate speculative functionality. A completed extension returns to
maintenance; it does not exhaust the goal or authorize another extension.

## Stages

| Stage | Input | Output | Next |
| --- | --- | --- | --- |
| [S01: Specify Release Contract](#stage-s01) | S01-I01, S01-I02 | S01-O01 | [S02](#stage-s02) |
| [S02: Validate Local Packaging](#stage-s02) | S02-I01, S02-I02 | S02-O01, S02-O02 | [S03](#stage-s03) |
| [S03: Validate Workflow Adapter](#stage-s03) | S03-I01, S03-I02 | S03-O01 | [S04](#stage-s04) |
| [S04: Validate Hosted Operation](#stage-s04) | S04-I01, S04-I02 | S04-O01, S04-O02 | End baseline; [S05](#stage-s05) on a new request |
| [S05: Evolve Release Functionality](#stage-s05) | S05-I01, S05-I02 | S05-O01, S05-O02 | Return to maintenance; re-enter S05 on a new request |

<a id="stage-s01"></a>

## S01: Specify Release Contract

Define a reviewable contract for local packaging and GitHub publication,
including version provenance, validation requirements and control boundaries.

The contract is expressed in the [goal requirements](./github-actions-maintenance.md#github-actions-maintenance),
the CLI in [`double-release.py`](../../../scripts/double-release/double-release.py),
the shared tag/version rules in [`release_common.py`](../../../scripts/double-release/release_common.py),
and the [release validation instructions](../../../tests/double-release/README.md).

### Input Conditions

#### S01-I01: Goal and Tooling Available

- Read the [goal](./github-actions-maintenance.md#github-actions-maintenance),
  [release program](../../../scripts/double-release/double-release.py),
  [shared rules](../../../scripts/double-release/release_common.py),
  [notes generator](../../../scripts/double-release/double-release-notes.py), and
  [workflow](../../../.github/workflows/release.yml).

#### S01-I02: Version Sources Identified

- Inspect the [version/changelog storage contract](../../../knowledge/machine-version-and-changelog-locations/machine-version-and-changelog-locations.md#machine-version-and-changelog-locations)
  and the candidate tree sources. Reject ambiguous or unreproducible sources.

### Actions

- Specify `list-machines`, local `package --machine`, tagged `package --tag`
  and Actions-only `publish --tag` for the Python entry point.
- Define tag grammar, status classes, machine ownership, exact-tree packaging,
  source-version validation, export-only version injection and SHA-256 outputs.
- Distinguish fatal version/source/identity/test failures from warning/no-match
  and publication-skipped outcomes; do not retain the obsolete sole-failure rule.
- Specify approved notes, prerelease classification, permissions, evidence
  retention, validation-only behavior and optional announcement gating.
- Keep installer releases independent. Stop if the proposed interface conflicts
  with the goal or permits local publication.

### Output Conditions

#### S01-O01: Contract Reviewable

- The goal requirements are mapped to the CLI, workflow and local/hosted checks.
- Obtain repository-owner review of the contract and test specification before S02.
- Include stable, rc, dev, no-match, invalid-source and version-mismatch cases.

<a id="stage-s02"></a>

## S02: Validate Local Packaging

Verify the shared release program locally and inspect an exact candidate
package, establishing its contents, checksum and nonpublishing behavior.

The existing deliverables are the packaging/publication program
[`double-release.py`](../../../scripts/double-release/double-release.py),
its shared rules [`release_common.py`](../../../scripts/double-release/release_common.py),
and the [packaging](../../../tests/double-release/test_package.py) and
[publication](../../../tests/double-release/test_publication.py) tests.
Package outputs are a machine archive and `SHA256SUMS.txt` under `dist/`.

### Input Conditions

#### S02-I01: Contract Available

- Establish S01-O01 and identify the candidate under test.

#### S02-I02: Local Test Environment

- Provide Python 3.11+, Git and dependencies from
  [test requirements](../../../tests/double-release/requirements.txt).
- Use disposable fixtures for mutation and mocked GitHub responses.

### Actions

- Maintain the shared tooling as needed within the reviewed contract.
- Follow the [pytest instructions](../../../tests/double-release/README.md),
  running the local suite without publication or notification.
- Test tagged status/ownership filtering, grouped/default version sources,
  invalid/conflicting sources, no-match, checksum, export versions and unchanged sources.
- Test local all-status working/untracked-file packaging separately from tags.
- Check approved-note handling and publication gates with mocks.
- For an authorized existing candidate tag, run the documented candidate check
  and inspect the resulting archive/checksum. Stop on unexplained failures.

### Output Conditions

#### S02-O01: Local Behavior Verified

- Retain passing pytest output and any expected skips with reasons.
- Confirm no local publication or external notifications occurred.

#### S02-O02: Candidate Package Verified

- Record candidate tag/commit, package membership and matching checksum.
- Verify source files remain unchanged and invalid-source/mismatch/no-match
  fixtures have the specified failure or warning outcomes.

<a id="stage-s03"></a>

## S03: Validate Workflow Adapter

Verify that GitHub Actions applies the reviewed release contract to the exact
candidate and enforces publication, evidence and notification boundaries.

The existing deliverables are the GitHub Actions adapter
[`release.yml`](../../../.github/workflows/release.yml), the approved-note generator
[`double-release-notes.py`](../../../scripts/double-release/double-release-notes.py),
and the [workflow](../../../tests/double-release/test_workflow.py) and
[release-note](../../../tests/double-release/test_notes.py) tests.

### Input Conditions

#### S03-I01: Local Contract Verified

- Establish S01-O01, S02-O01 and S02-O02.

#### S03-I02: Workflow Scope Approved

- Inspect the current workflow and obtain approval for any rule or permission changes.

### Actions

- Verify supported tag push/manual-dispatch inputs and rejection of installer tags.
- Check exact tag resolution, checkout identity, tooling checkout separation and
  candidate pytest/package checks before notes or publication.
- Check job-specific permissions, automatic GitHub token usage, approved-note
  preparation and non-draft release URL verification.
- Verify `validation_only` skips publication and notifications, and evidence
  artifacts use 14-day retention even when validation fails.
- Verify the optional Telegram job has no repository permissions, uses separate
  configuration, requires eligible verified publication and tolerates delivery failure.
- Stop before hosted effects if the interface, authorization or candidate identity diverges.

### Output Conditions

#### S03-O01: Adapter Contract Verified

- Review the [workflow](../../../.github/workflows/release.yml) and
  [workflow tests](../../../tests/double-release/test_workflow.py) against S01.
- Establish that tag/manual dispatch share the checked candidate and contract.
- Document rerun risks, especially duplicate notifications and asset replacement.

<a id="stage-s04"></a>

## S04: Validate Hosted Operation

Verify the candidate’s hosted behavior using attributable run and artifact
evidence, then return the checked results and limitations to the parent plan.

The concrete evidence artifacts are [hosted run 42243821307](https://github.com/densclub-rs/double/actions/runs/42243821307)
and the [machine-of-ideas 0.2.8 release](https://github.com/densclub-rs/double/releases/tag/machine-of-ideas-0.2.8),
including its archive and `SHA256SUMS.txt`. Their inspection and acceptance
basis, retention and limitations are recorded in the
[goal’s validation evidence](./github-actions-maintenance.md#release-validation-2026-11-06).

### Input Conditions

#### S04-I01: Local and Adapter Checks Available

- Establish S02-O01, S02-O02 and S03-O01 for the candidate/tooling combination.

#### S04-I02: Hosted Scope Authorized

- Identify accessible hosted evidence and authorization for any new dispatch.
- A validation-only check does not authorize publication or settings changes.

### Actions

- Inspect or, when authorized, dispatch a representative validation-only run
  for an existing machine tag using the documented workflow input.
- Inspect checkout identity, pytest/JUnit, archive and checksum evidence.
- Compare stable/rc/dev, no-match and mismatch behavior to the contract, using
  fixture evidence for cases that must not create live releases.
- Verify 14-day temporary-artifact retention and separately inspect repository
  log retention; request correction only when authorized.
- For separately authorized publication, inspect approved notes, release assets,
  checksum, prerelease classification and verified non-draft URL. Inspect optional
  notification gating without replaying delivery solely for validation.
- State evidence gaps explicitly; neither source presence nor a green skipped
  publication step proves that a release exists.

### Output Conditions

#### S04-O01: Hosted Behavior Verified

- Link the actual hosted run and artifacts to the exact candidate/tooling identity.
- Establish covered cases and identify fixture-only or user-confirmed evidence.
- Distinguish validation-only success, verified publication and warning/no-match.
- If required evidence or retention confirmation is unavailable, leave the
  corresponding result unresolved rather than declaring completion.

#### S04-O02: Parent Handoff Ready

- Return S01 contract, S02 local/package evidence, S03 adapter checks and
  S04 hosted evidence to [parent S03](../plan.md#stage-s03).
- Confirm the goal success criteria and any remaining limitations explicitly.

<a id="stage-s05"></a>

## S05: Evolve Release Functionality

Extend the existing release program in response to concrete user requests,
evolving the goal, contract and tests together while preserving validated behavior.

The extension baseline is the existing [release tooling](../../../scripts/double-release/),
[test suite](../../../tests/double-release/) and [workflow](../../../.github/workflows/release.yml).
Each requested substage will identify the specific files it changes or produces;
no additional extension deliverables are claimed before that work occurs.

### Input Conditions

#### S05-I01: Extension Requested

- Identify the requested capability, motivation, boundaries and success criteria.
- Confirm it belongs to this goal; unrelated GitHub work requires its own subgoal.

#### S05-I02: Baseline and Scope Established

- Identify the existing program and applicable accepted validation evidence.
- Inspect current dependencies and affected behavior before planning changes.
- Preserve affected historical records under the workflow's structural-change
  rule before adding substages; never rewrite earlier observed results.

### Actions

- Clarify the request and update the goal's target state and success criteria
  when they change. Update path options only when architectural choices change.
- Add concrete substages under S05 with stable IDs, purpose, input conditions,
  actions, output conditions and checks. Preserve existing IDs and completed scope.
- Increment the plan revision, synchronize the goal's plan table and review
  the revised contents before execution. A request to plan an extension alone
  does not authorize implementation or publication.
- Implement the authorized extension in the existing Python program and adjust
  tests, documentation and the workflow adapter where required.
- Apply the relevant S01–S04 checks to the changed scope, including regression
  coverage and hosted verification where local evidence is insufficient.
- Validate the extension with the user, preserve evidence under the applicable
  manual or automatic contract, and return the result to parent S03.
- Return to maintenance after the requested scope is accepted; await a new request.

### Output Conditions

#### S05-O01: Extension Validated

- The requested capability meets its explicit substage output conditions.
- Applicable regression checks pass and compatibility changes are documented.
- Publication and external effects remain subject to their separate boundaries.

#### S05-O02: Goal and Program Synchronized

- Goal requirements, plan, program interface, tests and documentation describe
  the same resulting capability; actual results remain in their evidence context.
- Parent S03 receives the validated extension and any changed integration boundary.
- No further work is implied until the user requests another extension.
