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
parent-plan-artifact: ../plan.md
plan-execution-style: single-pass
plan-revision: 1
plan-revision-artifact: plan-revision-1.md
created-at: 2026-10-15
updated-at: 2026-10-15
---

<a id="double-installer-validation-plan"></a>

# Plan: Double Installer Validation

## 1. Summary and Integration

[Goal](../double-installer-validation.md#double-installer-validation),
[path](../path-options.md#double-installer-validation-path-options),
[parent S06](../../plan.md#stage-s06). Local development checks depend on available
hosts/VMs; every new installer release requires complete hosted CI evidence.
Entry: current installer/tests, accepted lifecycle results and Podman handoff.
Exit: accepted CI matrix/integration evidence and documented release gate.
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
Imported evidence remains historical; CI01 is now in progress. Original S06-prefixed task IDs are retained for continuity.

| Progress | Stage | Kind | Inputs | Outputs | Possible Next Stages | Required Validation |
| --- | --- | --- | --- | --- | --- | --- |
| 🟡 | [S06-LOCAL: Development-time local validation](#stage-s06-local) | validation | Current working tree; host and available VMs | Results and availability gaps per local OS/architecture | Repeat during development; S06-CI05 | Executed local checks pass; unavailable environments explicit |
| ⚪ | [S06-RELEASE-CI: Release-time full validation](#stage-s06-release-ci) | validation group | Candidate commit; shared tests/ scenarios | Full CI evidence required before a new script version release | S06-CI01 → S06-CI05 | All required CI jobs pass for the exact candidate |
| 🔄 | [S06-CI01: Prepare scenarios](#stage-s06-ci01) | stage | Existing tests/ and platform requirements | Portable fixtures and Windows-specific assertions | S06-CI02 | Shared local/CI entry points; syntax checks |
| ⚪ | [S06-CI02: Implement workflow](#stage-s06-ci02) | stage | S06-CI01; intended runner matrix | Workflow, triggers, release gate and evidence artifacts | S06-CI03 and S06-CI04 | Explicit six-row matrix; isolation, permissions and timeouts |
| ⚪ | [S06-CI03: Execute matrix](#stage-s06-ci03) | validation | S06-CI02; exact candidate commit | Linux/macOS/Windows × x86_64/ARM64 job evidence | S06-CI05 | All six required installer rows pass; no silent skips |
| ⚪ | [S06-CI04: Verify real integrations](#stage-s06-ci04) | validation | S06-CI02; explicit release and disposable Linux scope | Published-package smoke and real cron execution/cleanup evidence | S06-CI05 | Actual tag/checksum and scheduler results |
| ⚪ | [S06-CI05: Consolidate evidence](#stage-s06-ci05) | validation | S06-CI03 and S06-CI04; local evidence and gaps | Platform matrix, logs, updated knowledge and user decision | End or affected-stage revision | V06; complete release evidence and user acceptance |

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

### S06 CI Tasks and Acceptance

These tasks belong to this validation subgoal, delegated by parent S06.
Local scenarios remain available. GitHub Actions becomes the reproducible
cross-platform execution adapter, invoking the same root tests/ scripts.
Root scripts/ holds repository utilities; the future src/ software project
keeps its own internal tests, per Double Project knowledge.

| Task | Output | Acceptance |
| --- | --- | --- |
| <a id="stage-s06-ci01"></a>S06-CI01: Prepare scenarios | Portable installer fixtures plus Windows-specific assertions in tests/ | Same test entry points run locally and in CI; shell syntax valid |
| <a id="stage-s06-ci02"></a>S06-CI02: Implement workflow | Dedicated .github/workflows/installer-tests.yml | Explicit matrix, manual dispatch, relevant pull-request/push checks and enforced full pre-release validation; read-only repository permissions, timeouts, independent matrix results |
| <a id="stage-s06-ci03"></a>S06-CI03: Execute matrix | Results for all six OS/architecture combinations below | Each required row passed on the tested commit; no silent skip or optional-failure coverage |
| <a id="stage-s06-ci04"></a>S06-CI04: Verify real integrations | Separate live GitHub-release smoke and disposable real Linux cron scenario | Actual release tag/checksum and scheduler execution/cleanup evidenced; no fixture results substituted |
| <a id="stage-s06-ci05"></a>S06-CI05: Consolidate evidence | Job logs/artifacts, tool versions, platform matrix and updated knowledge | Link workflow run/commit/jobs; final user validation; explicit remaining gaps |

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
| <a id="interactive-ci"></a>interactive-ci | [Interactive CI](interactive-ci.md#interactive-ci) | [Shared tests/CI](../path-options.md#path-shared-tests-ci) | [1](plan-revision-1.md#double-installer-validation-plan) | [1](interactive-ci.md#interactive-ci-revision-1) | ready | aligned | 1 | running |

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
