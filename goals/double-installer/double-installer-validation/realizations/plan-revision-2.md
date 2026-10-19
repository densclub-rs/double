---
id: double-installer-validation-plan
kind: plan-artifact
template-id: plan-template
project-id: double
produced-by: machine-of-goals/plan-synthesis-agent
interaction-language: ru
artifact-language: en
goal-id: double-installer-validation
goal-artifact: ../double-installer-validation.md
path-options-artifact: ../path-options.md
plan-artifact: ../plan.md
goal-scope: subgoal
parent-goal-id: double-installer
parent-plan-artifact: ../../plan.md
plan-execution-style: single-pass
plan-revision: 2
plan-revision-artifact: plan-revision-2.md
created-at: 2026-10-15
updated-at: 2026-10-16
---

<a id="double-installer-validation-plan"></a>

# Plan: Double Installer Validation

## 1. Summary and Integration

[Goal](../double-installer-validation.md#double-installer-validation),
[path](../path-options.md#double-installer-validation-path-options),
[parent S06](../../plan.md#stage-s06). Local development checks depend on available
hosts/VMs; every new installer release requires complete hosted CI evidence.
Entry: current installer/tests, accepted lifecycle results and Podman handoff.
Exit: accepted CI matrix/integration evidence and documented release gate,
including an authorized installer prerelease and verification of its downloaded assets.
No implementation is executed or automatic realization registered by extraction.

## 2. Evidence and Acceptance

Retain [parent revision-2 run](../../run/interactive-rest--20261013T153107Z.md#double-installer-run-interactive-rest-20261013T153107Z)
and [revision-3 run](../../run/interactive-rest--20261014T161825Z.md#double-installer-run-interactive-rest-20261014T161825Z)
as historical evidence. macOS/Linux local suites passed; hosted matrix and
real scheduler coverage are not established. These runs remain owned by the
parent and are not copied/rebound as subgoal executions. New work requires
reviewed realization, first immutable baseline and a new subgoal run.

## 3. Plan Map

Displayed run: [First application](../run/interactive-ci--20261015T104854Z.md#double-installer-validation-run-interactive-ci--20261015T104854Z).
CI01–CI03 retain accepted evidence from baseline 1; CI04–CI06 use revision 2 after realization alignment. Original S06-prefixed task IDs are retained for continuity.

| Progress | Stage | Kind | Inputs | Outputs | Possible Next Stages | Required Validation |
| --- | --- | --- | --- | --- | --- | --- |
| 🟡 | [S06-LOCAL: Development-time local validation](#stage-s06-local) | validation | Current working tree; host and available VMs | Results and availability gaps per local OS/architecture | Repeat during development; S06-CI05 | Executed local checks pass; unavailable environments explicit |
| ⚪ | [S06-RELEASE-CI: Release-time full validation](#stage-s06-release-ci) | validation group | Candidate commit; shared tests/ scenarios | Full CI evidence required before a new script version release | S06-CI01 → S06-CI05 | All required CI jobs pass for the exact candidate |
| ✅ | [S06-CI01: Prepare scenarios](#stage-s06-ci01) | stage | Existing tests/ and platform requirements | Portable fixtures and Windows-specific assertions | S06-CI02 | Shared local/CI entry points; syntax checks |
| ✅ | [S06-CI02: Implement workflow](#stage-s06-ci02) | stage | S06-CI01; intended runner matrix | Workflow, triggers, release gate and evidence artifacts | S06-CI03 and S06-CI04 | Explicit six-row matrix; isolation, permissions and timeouts |
| ✅ | [S06-CI03: Execute matrix](#stage-s06-ci03) | validation | S06-CI02; exact candidate commit | Linux/macOS/Windows × x86_64/ARM64 job evidence | S06-CI05 | All six required installer rows pass; no silent skips |
| ⚪ | [S06-CI04: Prepare installer release](#stage-s06-ci04) | stage | CI01–CI03 evidence; approved distribution contract | Version/tag convention, packaging, checksum and gated publication tooling | S06-CI05 | Local package identity; required-test failure blocks publishing |
| ⚪ | [S06-CI05: Execute end-to-end release](#stage-s06-ci05) | validation | CI04; exact candidate; first-publication authorization | Mandatory CI → installer release → downloaded-asset and cron checks | S06-CI06 | All required tests pass on tagged commit; actual release verified |
| ⚪ | [S06-CI06: Consolidate evidence](#stage-s06-ci06) | validation | CI05; local evidence and remaining gaps | Run/release links, matrix, knowledge and final user decision | Parent final validation or rework | V06; end-to-end evidence and acceptance |

## 4. Stage Details

<a id="stage-s06"></a>

### S06: Validate Platforms and Document Adoption

- Input: [S01–S05](../../plan.md#stage-s01) and accepted [S05R](../../plan.md#stage-s05r); output: proposed usage guide, repeatable test
  script, and explicit goal-validation evidence.
- Preconditions: the Podman repair subgoal is complete and its Linux entry point
  is accepted. Preserve earlier macOS evidence, but resume S06 only after S05R.
- Actions: run local end-to-end fixtures on available development-host/VM
  environments, then require full GitHub Actions validation for a new script
  version release. Verify Linux, macOS and actual Windows Git Bash in CI.
  Document dependencies,
  bootstrap boundary, commands, state layout, backups, channels, cron, cleanup,
  partial failure handling and current published-release limitations.
- V06: all goal capabilities pass on intended platforms; fixtures cover stable
  and multi-machine cases even if hosted packages remain unavailable. State
  which checks used fixtures and which used real downloads and OS runtimes.
- Existing regression: run the release test script if implementation changes
  packaging/shared code; always run syntax checks and diff checks for changes.
- Evidence: platform matrix, dependency versions and reproducible results in
  the future run. Stage acceptance follows Machine of Goals validation dialogue.
- Risks/stops: an unavailable local OS is an explicit local coverage gap,
  not a requirement to install every OS on a developer host. Missing required
  CI matrix evidence blocks release; local success cannot replace it.
- Next: close only after accepted final validation; otherwise revise the
  affected stage and realization alignment.

<a id="stage-s06-local"></a>

### S06-LOCAL: Development-Time Local Validation

Run shared test entry points from root tests/ against the current working tree
on the development host and available VMs. Local coverage depends on host OS,
installed tools and configured VM access; developers need not provide the
entire release matrix locally. Record actual tested OS/build/architecture and
versions, plus unavailable targets, without treating missing local environments
as successful tests. Local failures on executed targets require investigation.

| Development host | Local Linux tests | Local macOS tests | Local Windows / Git Bash tests |
| --- | --- | --- | --- |
| Linux | Native; additional Linux VM/container if available | Only through access to a separately available compatible macOS host/VM | Separate Windows VM/host with Git Bash, if available |
| macOS | Available Linux VM/container, such as the accepted Podman VM | Native; additional macOS VM if available | Separate Windows VM/host with Git Bash, if available |
| Windows | Available Linux VM or WSL; counts only as Linux evidence | Only through access to a separately available compatible macOS host/VM | Native Git Bash; additional Windows VM if available |

The table describes possible execution routes, not installed environments or
verified compatibility. Linux containers do not count as Windows/macOS tests.
Each local architecture is reported as actually executed; CPU emulation must
be identified. The current observed local evidence is macOS plus Linux aarch64
inside the Podman VM; local Windows remains unavailable. Repository utility
tests are distinct from the future src/ project's internal test structure.

<a id="stage-s06-release-ci"></a>

### S06-RELEASE-CI: Release-Time Full Validation

Every new installer script version must pass all required tests in GitHub
Actions before release. Run the full six-row installer matrix below regardless
of which local host/VMs the developer used. Include applicable repository
regressions, Windows-specific checks, live-release smoke and disposable Linux
cron checks. No required row may be skipped or marked optional to permit release.
Bind evidence to the exact candidate commit; changed scripts/tests/workflows
require fresh applicable CI validation. Earlier successful runs do not approve
an untested release candidate. CI trigger and release gate must enforce this
rule, rather than relying only on an optional manual workflow invocation.
Implementing validation/gating does not authorize publication of a release.
Installer distribution now belongs to CI04–CI06 in this subgoal. Previous
machine-release smoke evidence remains useful but does not prove publication
of the installer itself. Every release candidate must pass complete required CI.

### S06 CI Tasks and Acceptance

These tasks belong to this validation subgoal, delegated by parent S06.
Local scenarios remain available. GitHub Actions becomes the reproducible
cross-platform execution adapter, invoking the same root tests/ scripts.
Root scripts/ holds repository utilities; the future src/ software project
keeps its own internal tests, per Double Project knowledge.

| Task | Output | Acceptance |
| --- | --- | --- |
| <a id="stage-s06-ci01"></a>S06-CI01: Prepare scenarios | Portable installer fixtures plus Windows-specific assertions in tests/ | Same test entry points run locally and in CI; shell syntax valid |
| <a id="stage-s06-ci02"></a>S06-CI02: Implement workflow | Dedicated .github/workflows/double-installer-tests.yml | Explicit matrix, manual dispatch, relevant pull-request/push checks and enforced full pre-release validation; read-only repository permissions, timeouts, independent matrix results |
| <a id="stage-s06-ci03"></a>S06-CI03: Execute matrix | Results for all six OS/architecture combinations below | Each required row passed on the tested commit; no silent skip or optional-failure coverage |
| <a id="stage-s06-ci04"></a>S06-CI04: Prepare installer release | Installer packaging and gated release workflow | Exact source/checksum; independent tags/channels; fail-closed gate; reviewable release candidate |
| <a id="stage-s06-ci05"></a>S06-CI05: Execute end-to-end release | Full candidate matrix, published installer, downloaded-asset/project/cron evidence | Tag/commit/source/checksum identity; actual published script tested; cleanup proven |
| <a id="stage-s06-ci06"></a>S06-CI06: Consolidate evidence | Job logs, release assets, versions, matrix and updated knowledge | Final user acceptance; explicit gaps and parent handoff |

### CI04–CI06 Release Contract

- CI04: establish independent `double-installer-<major>.<minor>.<patch>` tags
  with explicit `-rc`/`-dev` channels. Prepare one universal Bash script,
  `SHA256SUMS.txt`, and download/dependency/verification/usage instructions.
  Extend release tooling and tag routing while preserving machine versions
  and existing machine release contracts. Select installer releases by prefix
  and numeric version/channel, never repository-wide `releases/latest`.
- CI04 checks: package exact candidate bytes locally, verify checksum and
  publication dependency on every required CI job. Reject tag/commit mismatch,
  missing/failed checks and conflicting existing release assets.
- CI05: use a reviewed explicit first prerelease (proposed
  `double-installer-0.1.0-rc`, not created by this plan change). Resolve its
  tag to an immutable commit; run all required platform/regression/integration
  checks; publish assets from that same commit only after success. Give write
  permissions only to the publication job.
- After publication, download the actual release script and checksum into
  disposable storage, verify checksum and byte identity with the tested source,
  then use that downloaded script for real machine-release installation,
  registry inspection, removal and cleanup in temporary projects. Cover the
  six supported OS/architecture rows with the shared release smoke scenario.
- On disposable Linux, use the downloaded script to create a real cron task,
  observe execution, check idempotence and remove owned tasks/state while
  preserving unrelated entries. Explicitly record whether execution is a no-op
  or a real version update; do not substitute fixture evidence for real cron.
- A post-publication failure is a failed release validation, not a successful
  goal. Record the published tag/assets and failure; do not silently overwrite
  assets, delete releases or assert that publication was rolled back.
- CI06: consolidate pre-publication and post-publication run/job/commit/tag
  evidence, asset hashes, platform/tool versions, cleanup and limitations;
  update knowledge and obtain final user acceptance before parent handoff.
- Repository preparation is authorized; the exact first tag/version and
  publication decision must be explicit before creating/pushing the tag or
  publishing. Executable placement remains Double System Installer's scope.

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


## 5. Realization Registry

User approved combined local/CI path and interactive implementation on
2026-10-15. Computed style remains single-pass; retain five terminal runs.

| Record | Realization | Path | Plan revision | Realization revision | Readiness | Alignment | Runs | Last result |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| <a id="interactive-ci"></a>interactive-ci | [Interactive CI](interactive-ci.md#interactive-ci) | [Shared tests/CI](../path-options.md#path-shared-tests-ci) | [1](plan-revision-1.md#double-installer-validation-plan) | [1](interactive-ci.md#interactive-ci-revision-1) | ready | review-required | 1 | running |

[Decision](../realization-decision.md#double-installer-validation-realization-decision),
[run index](../run/index.md#double-installer-validation-run-index).

## 6. Open Questions

No unresolved goal requirements. During implementation verify runner access,
exact release-trigger/gating integration and live test tag availability; stop
for unapproved external mutations or unavailable required evidence. User
review of the realization is required before implementation.

## 7. Change Log

2026-10-15: extracted from parent S06 at user request. Existing criteria,
matrices and task dependencies preserved; no new tests or CI jobs executed.

2026-10-15: CI01 shared runner and platform smoke created; macOS syntax,
platform smoke and comprehensive fixtures pass. User acceptance pending;
Windows execution remains CI03 evidence. No new frozen stage obligations.

2026-10-15: CI01 accepted. CI02 reusable workflow/release dependency and
referenced integration entry points prepared; local checks pass, user acceptance
pending. CI03/CI04 hosted executions remain unstarted.

CI02 accepted; CI03 actual hosted matrix started on isolated
codex/double-installer-validation branch. Linux/macOS installer rows passed;
Windows defects/harness adaptations are being validated. Exact commits/runs
and real integration observations are retained in the current run.

2026-10-15: user accepted CI03 using successful timestamped run 38809366251
and requested stopping the wait for final layout-only run 38810724139. Latest
candidate outcome is not confirmed; artifact-upload failure and pending final
status remain explicit in run. CI04 is next; no release gate bypass authorized.

2026-10-15: approved parent S07 owns installer release distribution. Added
future CI05 handoff detail without changing accepted CI01–CI03 or frozen
validation criteria. Baseline 1 and its run remain pinned; no release executed.

2026-10-16: user approved combining publication with validation. Revision 2
replaces old CI04/CI05 with release preparation, end-to-end CI05 and final
CI06; no old run is rebound. Revision-1 realization is review-required.
Accepted CI01–CI03 persist, but new candidate CI and published-asset evidence
are mandatory. Existing machine-release/cron observations are retained, not
accepted as a published-installer test. No tag or release created.
