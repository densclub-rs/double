---
id: double-installer-validation-run-interactive-ci--20261015T104854Z
kind: plan-run
template-id: plan-run-template
produced-by: machine-of-goals/plan-realization-agent
project-id: double
goal-id: double-installer-validation
interaction-language: ru
artifact-language: en
plan-revision: 1
plan-revision-artifact: ../realizations/plan-revision-1.md
realization-id: interactive-ci-procedure
realization-record-id: interactive-ci
realization-artifact: ../realizations/interactive-ci.md
realization-revision: 1
selected-paths:
  - path-shared-tests-ci
started-at: 2026-10-15T10:48:54Z
finished-at: 2026-10-16T09:49:55Z
result: partial
pinned: no
---
<a id="double-installer-validation-run-interactive-ci--20261015T104854Z"></a>
# Validation Run: Shared Tests and CI

[Baseline](../realizations/plan-revision-1.md#double-installer-validation-plan),
[realization](../realizations/interactive-ci.md#interactive-ci-revision-1).
Parent local results are historical references in the plan, not new executions.

## CI01 Effective Contract — Attempt 1

Input: current installer and tests/, user-authorized subplan. Actions: prepare
shared local/CI platform checks, including Git Bash-specific path/native jq
behavior; retain comprehensive fixture suite and actual implementation.
Output: shared test entry points/documentation, syntax and available local
regressions pass. Windows cannot be declared validated on macOS; platform
assertions run on Windows CI later. Scope repository and disposable fixtures;
no host dependencies, real network/cron/project mutation or release publication.
Stop for test failure, unapproved scope or stage result ready for user validation.
Acceptance: meaningful Windows-targeted scenarios present, common entry points,
syntax/local checks pass; CI03 owns actual Windows execution evidence.


## CI01 Technical Result

Created tests/run-installer-tests.sh as the shared local/CI entry point and
tests/test-double-installer-platform.sh as shell-based platform lifecycle smoke.
The smoke uses actual jq/tar/filesystem operations with fake curl/crontab;
checks spaces/Unicode/apostrophe/percent canonical paths, registry consistency,
no-op update, removal, full cleanup and unowned sentinel preservation. Windows
branch requires cygpath and prints native jq raw output bytes; no test-side
CRLF normalization hides installer defects. Comprehensive fixture suite retained.
Tests documentation describes shared entry point and unvalidated Windows scope.
No product script or workflow implementation changed during CI01.

Successful reusable validation commands, repository root on current macOS host:
```bash
bash -n tests/test-double-installer-platform.sh
bash tests/test-double-installer-platform.sh
bash tests/run-installer-tests.sh
git diff --check
```
All final invocations succeeded, exit 0. Common runner reports Darwin 25.6.0
arm64, Bash 3.2.57, Python 3.14.7, jq 1.7.1-apple. Platform smoke and all four
comprehensive fixture groups passed. Exact OS release is not refreshed here;
Darwin uname is the observed kernel identifier, not a substitute for OS version.
Replay: requires installer runtime tools and Python for comprehensive fixtures;
uses disposable directories, no real network/cron/project mutation. Development
attempt failures are not retained as successful reusable commands.

CI01 prepared scenarios technically pass on available host; Windows/ARM native
behavior remains for actual CI03 execution and may require further adaptation
of the preexisting Python fixture harness. Do not claim all platforms portable
until those rows pass. Links/anchors and diff checks passed. Stage result is
ready for user acceptance; CI02 not started, no workflow/push/publication.


## CI01 Acceptance and CI02 Effective Contract — Attempt 1

User accepted CI01 with “ok”. CI02 input: shared tests/ entry points, finite
six-row matrix and accepted CI01. Actions: define reusable/manual/push/PR CI
workflow, per-row logs/versions, applicable regressions and release dependency;
define disposable Linux live-release/cron job entry points for later CI04
execution. Output: concrete reviewable workflow/gate with complete referenced
files, no required optional-failure jobs, isolated fixtures and bounded execution.
V02: YAML/structure, referenced paths and available local script syntax/regressions
pass; actual hosted results remain CI03/CI04. Existing release publication must
wait for required validation against exact resolved candidate commit. Scope
repository edits and local fixture checks only; no push, live scheduled task,
host dependencies or publication. User validates stage result before CI03.


## CI02 Technical Result

Prepared .github/workflows/installer-tests.yml with six required installer
rows (Linux/macOS/Windows Git Bash x64+ARM64), fail-fast false, explicit
Python 3.13 architecture, environment/binary evidence, 20-minute job bounds
and always-uploaded 14-day logs. Repository regressions are explicitly scoped
to ubuntu-24.04 and macos-15. No optional-failure installer coverage.

Reusable workflow also defines disposable Linux live-package and real cron
jobs. Added test entry points and environment capture under tests/. Real cron
requires GitHub Linux plus explicit opt-in, restores original crontab and
proves scheduled update-all no-op with no registered installations; it does not
claim scheduled real version replacement. Live smoke uses the explicit existing
machine-of-ideas-0.2.3-rc release, actual checksum and isolated lifecycle.
Both real integration executions remain CI04 work, not local success evidence.

Existing release workflow now resolves the tag to an exact commit, calls the
reusable required validation with that commit, and waits before packaging and
publishing. Release checkout is bound to the same commit and tag identity is
rechecked; moved tags fail rather than publishing an unvalidated tree. Existing
machine/double-agent releases are all gated; no standalone installer publication
mechanism is invented. Corrected existing escaped-shell-quote tag invocation so
the literal quote characters are not passed as part of the tag.

Successful local validation commands (repository root, macOS; exit 0):
```bash
bash -n tests/installer-ci-environment.sh tests/test-double-installer-live.sh tests/test-double-installer-cron.sh
ruby -e 'require "yaml"; ARGV.each { |f| YAML.load_file(f); puts "YAML syntax OK: #{f}" }' .github/workflows/installer-tests.yml .github/workflows/release.yml
bash tests/test-double-release.sh
python3 tests/test-git-double.py
bash tests/test-machine-of-goals-navigation.sh
bash tests/installer-ci-environment.sh
git diff --check
```
All release fixtures, eight Git-helper tests and navigation fixtures passed.
YAML parses; structural inspection verified six unique required pairs, gate
needs, same commit input/checkout and all referenced test files. Dedicated
GitHub expression/actionlint validation is not available locally; hosted
acceptance remains unverified. Environment report succeeds on local host.
The real-cron guard was separately invoked through Python subprocess and
asserted exit 2 plus refusal text: it correctly refused to modify local cron.
No live package download or actual scheduler execution performed in CI02.

Local checks do not prove runner dependency availability or Windows harness
compatibility. CI03 must resolve any actual platform failures without skipping
required rows. No commit/push/workflow dispatch or publication performed.
CI02 ready for user acceptance; CI03 and CI04 remain unstarted.


## Workflow Naming Update

User requested double-installer-tests.yml. Renamed the workflow to
.github/workflows/double-installer-tests.yml and updated current references,
including the reusable call in release.yml. Earlier command entries and
immutable snapshots retain the historical filename. No hosted execution.


## CI02 Acceptance and CI03 Effective Contract — Attempt 1

User accepted continuation after workflow rename. CI02 accepted; CI03 input:
current prepared workflow/tests/installer and active GitHub account. Actions:
prepare isolated candidate branch excluding unrelated user/staged work, validate
candidate contents, commit/push only that scope, observe automatic push-triggered
six-row matrix and record exact commit/run/job results. Output: actual hosted
matrix evidence; CI04 integration evidence is evaluated separately even when
jobs share a workflow run. No release tag or publication, no push to main,
no changes to original staging/branch. Remote push requires sandbox approval.
Stop for unsafe scope, unavailable auth/evidence, unexpected publication or
stage result ready for validation. Fix actual test/platform defects within
installer validation scope and rerun applicable checks; never skip required rows.


## CI03 Hosted Attempts and Candidate Scope

Original checkout/staging preserved. Isolated local clone:
/tmp/double-installer-ci-candidate, branch codex/double-installer-validation.
Candidate contains installer, shared tests, required navigation validator and
workflows; unrelated goals/ideas/knowledge changes excluded. Root branch main
was not changed, no release tag created or release published.

Successful actions (isolated clone cwd unless stated otherwise):
```bash
git commit -m 'Add cross-platform Double installer validation and release gate'
git push -u origin codex/double-installer-validation
```
Commit a3ab385e6ad96f8fe5706f77e46551bb212548f2, push succeeded.
[First hosted run](https://github.com/densclub-rs/double/actions/runs/38766806741):
Linux x64/ARM64 and macOS x64/ARM64 installer rows passed; both Windows rows
failed with unsafe managed inventory path after native jq CRLF output. Release
and Git-helper regressions passed; navigation regression could not find ignored
validator missing from commit. Live published-package smoke passed; real cron
timed out. Overall gate failed as intended. No required row skipped to pass.

Corrections: installer native-jq --binary handling and preservation of --arg
strings in Git Bash; native-Python fixture POSIX path conversion and UTF-8/LF
writes; include required validator in candidate despite local ignore; extend
real-cron timeout diagnostics. Local common installer checks pass after fixes.
Source: jq --binary behavior documented at https://jqlang.org/manual/ .

```bash
git commit -m 'Handle native jq output and portable Windows test fixtures'
git push -u origin codex/double-installer-validation
```
Commit 87ca23d6cd630dd390e024a3469d37b92d619730, push succeeded.
[Second hosted run](https://github.com/densclub-rs/double/actions/runs/38768403674)
is in progress; no passing result inferred. Recording successful pushes does
not authorize unrelated pushes or publication. Exact failed commands are not
presented as reusable successes; failure evidence remains summarized above.


### Subsequent CI03 Attempts

- Second run 38768403674: Windows platform smoke passed after jq LF fix;
  navigation regressions no longer failed. Full Windows fixtures accidentally
  selected WSL bash.exe from native Python. Real cron did execute per daemon
  journal, but completion probe wrongly expected the no-registry message while
  cron-add had initialized an empty registry. Both were harness defects.
- Third run 38769479270 (c2c3512a5f9ab95814af58ae665310d6afcb2640):
  explicit Git Bash selected; cron completion probe corrected by removing only
  the verified empty test-owned registry. Real cron/live release and regression
  groups passed. Windows Python fixture shebang still received POSIX script
  path unsuitable for native interpreter.
- Fourth run 38771205227 (e732b95ed53632c1b5afe5f379091851fa26d913):
  native Python fixture launch fixed. Windows comprehensive tests reached state
  paths containing an apostrophe and exposed native jq filename conversion
  failure. Earlier smoke parent state path lacked the quote. No coverage skipped.
- Fifth run 38805342615 (2940e67870db808f22408f25d8803977c7202d82):
  installer explicitly converts existing input filenames through cygpath for
  native jq and disables implicit jq argument conversion; JSON --arg strings
  remain canonical POSIX. No-cron fixture PATH includes required cygpath.
  Result pending at this entry.

Successful commit/push commands in isolated candidate clone, in observed order:
```bash
git commit -m 'Select Git Bash explicitly in native Python and fix cron completion probe'
git push -u origin codex/double-installer-validation
git commit -m 'Launch native Python fixtures with Windows script paths'
git push -u origin codex/double-installer-validation
git commit -m 'Pass explicit native jq filenames for quoted Windows state paths'
git push -u origin codex/double-installer-validation
```
All commits and pushes succeeded. Common local entry point
`bash tests/run-installer-tests.sh` passed after each final correction, exit 0
(macOS); hosted outcomes above remain separate. Failures were not recorded as
successful reusable commands. Original checkout branch remains main; unrelated
concurrent edits, including .gitignore, are preserved.


### Final Windows Fixture Adaptations

Fifth run 38805342615: Linux/macOS, regression and real integration groups
passed. Windows reached no-cron fixture; symlinked PE tools lacked MSYS DLLs
under its intentionally restricted PATH. Sixth run 38806428801 confirmed the
DLL fix allowed further execution, but Chocolatey jq shim relocation broke
registry validation. Retain strict no-crontab isolation; invoke jq's original
launcher path via a shell shim and assert native no-cron tool startup.

Successful commands, isolated candidate clone:
```bash
git commit -m 'Preserve MSYS runtime DLLs in isolated no-cron tool fixture'
git push -u origin codex/double-installer-validation
git commit -m 'Keep Chocolatey jq shim at its original path in no-cron fixture'
git push -u origin codex/double-installer-validation
```
Both pushes succeeded. Local shared installer entry point passed after both
final fixes. Sixth commit da0a4f3c32cdf89d1f76097affaf63b5e71ee29e;
seventh commit 855c8216e63991a48103bd4246a5c564fafb1d62.
[Seventh run](https://github.com/densclub-rs/double/actions/runs/38807378801)
currently has full Windows x64, both Linux/macOS rows, repository regressions
and real integration group passing. Windows ARM64 still in progress at this
entry; full gate success not assumed. No required tests were removed/skipped.


## Confirmed Complete Matrix Before Timestamp Instrumentation

[Successful run](https://github.com/densclub-rs/double/actions/runs/38807378801),
commit 855c8216e63991a48103bd4246a5c564fafb1d62, overall conclusion success.
All six installer rows, both repository regression jobs, integration job and
final required gate passed. Windows x64 duration 2m56s; Windows ARM64 duration
8m45s (job start/completion from GitHub, not an inferred test-only duration).
Windows ARM64 host runs x86-64 Git Bash under emulation with native ARM64
Python 3.13.16. This is ARM64-host coverage, not a native ARM64 Bash claim.

| Job | Conclusion | Evidence |
| --- | --- | --- |
| Repository regressions / macos-15 | success | [job](https://github.com/densclub-rs/double/actions/runs/38807378801/job/116671616160) |
| Live release and real cron / Linux | success | [job](https://github.com/densclub-rs/double/actions/runs/38807378801/job/116671616262) |
| Installer / linux / arm64 | success | [job](https://github.com/densclub-rs/double/actions/runs/38807378801/job/116671616417) |
| Installer / windows / arm64 | success | [job](https://github.com/densclub-rs/double/actions/runs/38807378801/job/116671616424) |
| Installer / linux / x64 | success | [job](https://github.com/densclub-rs/double/actions/runs/38807378801/job/116671616430) |
| Repository regressions / ubuntu-24.04 | success | [job](https://github.com/densclub-rs/double/actions/runs/38807378801/job/116671616443) |
| Installer / macos / x64 | success | [job](https://github.com/densclub-rs/double/actions/runs/38807378801/job/116671616469) |
| Installer / windows / x64 | success | [job](https://github.com/densclub-rs/double/actions/runs/38807378801/job/116671616475) |
| Installer / macos / arm64 | success | [job](https://github.com/densclub-rs/double/actions/runs/38807378801/job/116671616580) |
| Installer validation gate | success | [job](https://github.com/densclub-rs/double/actions/runs/38807378801/job/116675508584) |

Downloaded six environment/installer artifacts to
/tmp/double-ci-success-artifacts for inspection; exact runner/tool details
remain available in GitHub artifacts (14-day retention). This outcome belongs
to that exact commit and is retained while the next commit is revalidated.

## User-Requested UTC Timing Instrumentation

User observed slow Windows ARM64 job and requested timestamps in test scripts.
Added tests/test-log.sh, shell suite/phase and release-case UTC markers;
per-fixture command start/end, expected/observed exit and elapsed duration via
Python datetime/monotonic; per-unittest timing in Git helper suite. Python
fixture subprocess is bounded to 180 seconds; job timeout remains 20 minutes.
No per-line date process is spawned for long Python fixtures. All available
local installer/release/Git/navigation tests pass after this change (exit 0).

Successful validation/remote actions, repository root for checks; isolated
candidate clone for commit/push:
```bash
bash -n tests/*.sh
bash tests/run-installer-tests.sh
bash tests/test-double-release.sh
python3 tests/test-git-double.py
bash tests/test-machine-of-goals-navigation.sh
git commit -m 'Add UTC timestamps and per-command durations to test logs'
git push -u origin codex/double-installer-validation
```
Commit e0903504e355af95f5cdc9ef9909229f18e25018, push succeeded.
[Timestamped run](https://github.com/densclub-rs/double/actions/runs/38809366251)
in progress; fresh full matrix required before accepting the latest candidate.
Unrelated root .gitignore changes preserved; scoped diff checks passed.


## Timestamped Matrix and Observed Timing

[Run 38809366251](https://github.com/densclub-rs/double/actions/runs/38809366251)
completed success for e0903504e355af95f5cdc9ef9909229f18e25018. All required
rows/gate passed with UTC timestamps and per-command bounds enabled. Downloaded
Windows installer logs for comparison: both execute 58 fixture commands.
Sum of recorded subprocess durations: x64 124.12s, ARM64 390.38s; median x64
1.397s, ARM64 4.361s. Longest ARM64 command: expected partial-failure update-all
31.382s (x64 10.229s). No individual command was hung or hit the 180s bound.
Broad ~3.1x slowdown is consistent with observed x86-64 Git Bash emulation on
ARM64 Windows, but no profiling establishes it as the sole cause.

During source/candidate comparison, concurrent working-tree navigation validator
move to tests/ was discovered. Its bytes were unchanged. Preserved the move and
updated the candidate's navigation test reference; did not restore obsolete
scripts/ path or overwrite user .gitignore edits. Local navigation tests passed.

Successful commands, isolated candidate clone:
```bash
git commit -m 'Align navigation validation with the tests directory layout'
git push -u origin codex/double-installer-validation
```
Commit b30db124fe44c0d2b660ec184d53e25b439b6d08; push succeeded.
[Current layout run](https://github.com/densclub-rs/double/actions/runs/38810724139)
revalidates exact final candidate; result pending at this entry. No installer
behavior or fixture assertions changed in this final layout adaptation.


## User Decision: Stop Waiting for Final Layout Run

User explicitly requested not waiting for the latest run and accepted proceeding
on the preceding successful execution. CI03 matrix result accepted from
run 38809366251 / e0903504e355af95f5cdc9ef9909229f18e25018 (timestamped tests,
all required matrix jobs/gate passed). The final layout-only candidate
b30db124fe44c0d2b660ec184d53e25b439b6d08 retains identical validator content
at tests/ with its caller path updated; local navigation checks passed.
Latest run 38810724139 has passed available test steps, but macOS x64 artifact
upload failed with CreateArtifact request timeout after five attempts; Windows
ARM64/overall final conclusion was not refreshed after user's stop-waiting
instruction. No latest-run success inferred, no further polling/retry requested.

CI03 accepted on prior exact-commit evidence, with latest candidate/run caveat
retained. This does not approve release of an unverified new candidate or bypass
required release gate. Next stage is CI04: verify/consolidate actual live-release
and real-cron evidence already produced by the shared workflow, then CI05 final
evidence/knowledge and user acceptance. Neither stage is marked accepted here.

## Approved Plan Refactor — 2026-10-16

Parent revision 5 / child revision 2 replace future integration/consolidation
with CI04 release preparation, CI05 end-to-end release and CI06 acceptance.
This run remains pinned to baseline 1 / realization 1; CI01–CI03 accepted
results are preserved. No changed stages execute in this run. Align the
realization/decision and open a new baseline-2 run before continuation.
No release tag or publication performed.

Revision-1 run closed partial on 2026-10-16; CI01–CI03 accepted, remaining
work superseded by revision 2. No changed contract executed here.
