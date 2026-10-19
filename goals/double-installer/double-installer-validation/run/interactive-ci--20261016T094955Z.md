---
id: double-installer-validation-run-interactive-ci--20261016T094955Z
kind: plan-run
template-id: plan-run-template
produced-by: machine-of-goals/plan-realization-agent
project-id: double
goal-id: double-installer-validation
interaction-language: ru
artifact-language: en
plan-revision: 2
plan-revision-artifact: ../realizations/plan-revision-2.md
realization-record-id: interactive-ci
realization-id: interactive-ci-procedure
realization-artifact: ../realizations/interactive-ci.md
realization-revision: 2
started-at: 2026-10-16T09:49:55Z
finished-at: 2026-10-16T16:21:30Z
result: partial
---
<a id="double-installer-validation-run-interactive-ci--20261016T094955Z"></a>
# Run: Release Preparation

[Baseline 2](../realizations/plan-revision-2.md#double-installer-validation-plan),
[realization 2](../realizations/interactive-ci.md#interactive-ci-revision-2).
User authorized the next stage. Accepted CI01–CI03 are carried from the
[earlier run](./interactive-ci--20261015T104854Z.md#double-installer-validation-run-interactive-ci--20261015T104854Z);
new candidate must still pass full CI before publication.

## CI04 Effective Contract — Attempt 1

Input: approved independent installer tags/channels, scripts/double-installer.sh,
existing release tooling, shared workflow and accepted earlier evidence.
Actions: implement exact-tag packaging, SHA-256, release instructions and
installer tag routing; preserve machine release contracts/versions. Enforce
required-test gate and exact commit identity; reject existing conflicting assets.
Output: reviewable local assets and tooling, no remote publication/tag/push.
Validation: isolated package byte/checksum tests, publication failure/conflict
checks with fake gh, workflow dependency/identity checks and machine regressions.
Stop: invalid tag, missing source, mismatched commit/checksum, failed checks.
Next: user stage acceptance, then CI05 concrete version/publication decision.

## CI04 Result — Awaiting User Acceptance

Added scripts/double-installer-release.sh, routed installer tags through
scripts/double-release.sh, and extended release.yml tag routing. Publication
depends on the complete reusable validation workflow and checks tag/HEAD/
VALIDATED_COMMIT identity. Assets are the exact tagged script, checksum and
INSTALL.md; stable/rc/dev are independent of machine versions. Existing
installer releases are refused; API/create failures propagate nonzero.
All installer releases set --latest=false to avoid disturbing repository-wide
latest semantics; instructions use installer prefix/channel selection.

Successful commands, repository working directory:

```bash
bash -n scripts/double-installer-release.sh scripts/double-release.sh tests/test-double-installer-release.sh
bash tests/test-double-installer-release.sh > /tmp/double-ci04-installer-release.log
bash tests/test-double-release.sh > /tmp/double-ci04-machine-release.log
```

Syntax passed. Installer release fixtures and stdlib workflow contract checks
passed; unchanged machine release suite passed. Tags/commits and fake gh
invocations occur only inside disposable fixture repositories. A first test
version required unavailable PyYAML; replaced with stdlib contract checks,
so no new dependency installation is needed. These source checks do not prove
hosted GitHub Actions execution. CI05 will validate the full release chain
on an actual candidate. No production tag, remote push or publication.

CI04 is ready for stage acceptance, not yet accepted. Proposed first version
remains double-installer-0.1.0-rc pending the concrete CI05 decision.

## CI04 Acceptance — 2026-10-16

User explicitly accepted CI04 ("Верю, принимаю :-)"). Local packaging,
checksum, publication guard/gate contract checks and machine release
regressions constitute the accepted preparation result. Hosted publication
remains untested and belongs to CI05. This run stays open for continuation;
no production tag, push or release created by acceptance.

Next: CI05 — end-to-end GitHub Actions release; proposed initial version
double-installer-0.1.0-rc requires a concrete publication decision.

## CI05 Effective Contract — Attempt 1

User explicitly approved double-installer-0.1.0-rc and tag/publication after
mandatory tests. Input: accepted CI04, exact isolated candidate containing
installer/release/tests/workflows only. Actions: implement downloaded-asset
smoke in six-row matrix and disposable Linux cron; commit/push candidate and
release tag, run full exact-commit gate, publish assets, then verify actual
release bytes/checksum/project lifecycle on every platform and cron on Linux.
Preserve unrelated working-tree/staged changes. No main push or machine
version change. Missing/failed tests prevent publication. Post-publication
failure is recorded honestly without silently overwriting/deleting assets.
Evidence: exact commit/tag/run/jobs/assets, checksums, architecture and cleanup.
Stop for conflicts, unsafe source mismatch or unavailable required evidence.
Next: user CI05 acceptance, then CI06 knowledge/evidence consolidation.

### CI05 Prepared Candidate

Isolated checkout /tmp/double-installer-ci-candidate, branch
codex/double-installer-validation. Commit
40bbd5f675c0a866568637dbc830005e9f0939a5 contains only installer release
implementation, workflows and tests. Root main/staging remain untouched.
Added six-target post-publication smoke and optional disposable Linux x64
cron using DOUBLE_TEST_INSTALLER to exercise the downloaded script. Public
assets are checksum/byte/source-identity verified before project mutation.

Successful local commands (root repository unless noted):

```bash
bash -n tests/test-double-installer-published.sh tests/test-double-installer-live.sh tests/test-double-installer-cron.sh
bash tests/test-double-installer-release.sh > /tmp/double-ci05-release-local.log
bash tests/test-double-release.sh > /tmp/double-ci05-machine-local.log
python3 tests/test-installer-release-workflow.py .
```

All passed. Remote tag absence verified with git ls-remote (no matching ref).
In the isolated candidate checkout, successful commit/tag preparation:

```bash
git add .github/workflows/release.yml .github/workflows/double-installer-tests.yml scripts/double-release.sh scripts/double-installer-release.sh tests/test-double-installer-cron.sh tests/test-double-installer-live.sh tests/test-double-installer-published.sh tests/test-double-installer-release.sh tests/test-installer-release-workflow.py tests/tests.md
git commit -m 'Publish independent installer releases after full validation'
git tag double-installer-0.1.0-rc
```

Replay constraints: tag/commit creation is not idempotent; these commands
record this observed run only. Production remote publication remains pending
until the approved tag push and hosted gate succeed.

### CI05 Tag Push and Hosted Run

Approved production tag push succeeded from the isolated checkout:

```bash
git push origin refs/tags/double-installer-0.1.0-rc
```

Tag targets 40bbd5f675c0a866568637dbc830005e9f0939a5. No main/branch
push and no other tag changes. Successful read-only inspection:

```bash
gh run list --repo densclub-rs/double --workflow release.yml --limit 8 --json databaseId,headSha,status,conclusion,url,headBranch,createdAt
```

[Release run 38898572399](https://github.com/densclub-rs/double/actions/runs/38898572399)
was in progress on the exact tagged commit when inspected. Publication and
post-publication result remain pending; no successful release inferred.

### CI05 First Release Run — Publication Succeeded, Windows Smoke Failed

Run 38898572399 completed failure: all six pre-publication installer rows,
regressions, live/cron integration and validation gate passed; publication
job succeeded. Linux/macOS x64/ARM64 downloaded-asset checks passed, including
Linux x64 real cron. Both Windows downloaded checks failed after checksum
passed, before lifecycle checks. Windows x64 log shows cmp differing at
char 20/line 1: Git checkout CRLF conversion versus exact LF release bytes.
The test compared checkout bytes instead of immutable Git blob bytes.

Original release/tag/assets are preserved, not overwritten or deleted.
Corrected test reads source bytes using git show of the expected tag commit;
added a local CRLF checkout reproduction, which passes. Extracted reusable
published-tests workflow, callable via existing validation workflow manual
dispatch for read-only rechecking an existing tag/commit using a separately
versioned harness. This preserves product identity and full six-target
post-publication checks without republishing or creating a new version.

Repair candidate 0795161c050bc4774d330d90ae13f6fc426b818c changes only
tests/workflows; git diff double-installer-0.1.0-rc -- scripts/double-installer.sh
is empty. Local installer release/gate/CRLF checks passed again.
CI05 remains running until actual recheck outcomes are observed.

### CI05 Corrected Harness Recheck Started

Successful command from isolated candidate checkout:

```bash
git push -u origin codex/double-installer-validation
```

Pushed harness 0795161c050bc4774d330d90ae13f6fc426b818c. No product
change or retag. Successful dispatch and release metadata read:

```bash
gh workflow run double-installer-tests.yml --repo densclub-rs/double --ref codex/double-installer-validation -f release_tag=double-installer-0.1.0-rc -f release_commit=40bbd5f675c0a866568637dbc830005e9f0939a5
gh release view double-installer-0.1.0-rc --repo densclub-rs/double --json tagName,isPrerelease,isDraft,url,assets
```

[Corrected-harness run 38914939360](https://github.com/densclub-rs/double/actions/runs/38914939360)
checks the existing release on all six targets; pre-publication tests are
not repeated in this read-only recheck, having passed in the original run.
The product commit is 40bbd5f, harness commit 0795161; keep both identities.

[Published prerelease](https://github.com/densclub-rs/double/releases/tag/double-installer-0.1.0-rc)
is not draft; contains double-installer.sh (37437 bytes), SHA256SUMS.txt
and INSTALL.md. GitHub reports script SHA-256
3f3fdeb5b96f6755b33fd704bf5bc60b5de83bc25c58026527f95b23ac5781e0.
Release assets were created at 2026-10-16T12:18:42Z and remain unchanged.
Ruby Psych syntax parsing passed all three workflow YAML files locally.

### CI05 Final Observed Result — Awaiting User Acceptance

Corrected-harness run 38914939360 attempt 1 passed five targets including
Windows ARM64, but Windows x64 received HTTP 403 from the GitHub releases
API during the live machine-release phase. Checksum/blob verification had
already passed. HTTP response cause (rate limiting/access policy) was not
proven by headers, so no unsupported cause is asserted. Requested retry of
only the failed job; the product/harness commits and published assets did
not change. Successful commands:

```bash
gh run rerun 38914939360 --repo densclub-rs/double --job 117019885823
gh run watch 38914939360 --repo densclub-rs/double --exit-status --interval 30 > /tmp/double-installer-published-recheck-retry.log 2>&1
```

Watch exited 0. Latest observed post-publication targets:

| Target | Result | Job id | Duration |
| --- | --- | --- | --- |
| Windows x64 | success | 117026773414 | 59s |
| Linux x64 + disposable cron | success | 117026774098 | 43s |
| macOS x64 | success | 117026774930 | 33s |
| macOS ARM64 | success | 117026775430 | 21s |
| Windows ARM64 host / Git Bash | success | 117026776433 | 2m40s |
| Linux ARM64 | success | 117026853033 | 12s |

Intentional skipped fixture/regression/prepublication-gate groups belong only
to this read-only existing-release recheck. They are not skipped in the actual
release path: all required groups passed on tagged product commit 40bbd5f
in original release run 38898572399 before publication. Its overall failure
remains recorded because its original Windows smoke was wrong; it is not
retroactively declared green. Corrected recheck uses harness commit 0795161.

Published script SHA-256 was also independently calculated from the immutable
local tagged blob with this successful command:

```bash
git -C /tmp/double-installer-ci-candidate show double-installer-0.1.0-rc:scripts/double-installer.sh | shasum -a 256
```

Result matches the actual release checksum and GitHub asset digest:
3f3fdeb5b96f6755b33fd704bf5bc60b5de83bc25c58026527f95b23ac5781e0.
Six-target smoke verifies downloaded files/checksum/source commit and actual
machine-of-ideas-0.2.3-rc installation, registry/list/removal and state cleanup
with unrelated project sentinel retained. Linux x64 additionally proves real
scheduled unattended no-op execution, idempotent task and baseline crontab
restoration; no real scheduled version replacement is claimed.

CI05 result is ready for user acceptance. Original tag/assets are unchanged.
Next: CI06 — consolidate durable release/platform evidence and knowledge,
then final parent validation. No CI06 acceptance or full goal completion yet.

## User-Approved Asset Simplification

User requested the current published release without INSTALL.md. Update
future packaging/tests to two assets, preserve instruction in existing project
knowledge and link it from release notes. Removing only INSTALL.md from the
published release is explicitly authorized; script/checksum/tag stay intact.
Earlier three-asset observations remain historical, not rewritten.

### Two-Asset Release Update Completed

Local release fixture tests and shell syntax checks passed after removing
INSTALL.md from packaging/download assertions. Documentation is preserved in
knowledge/double-installer/double-installer.md; commit
066bd419c649ca0fa20bc77d11fb21a54f35af97 pushed to the isolated branch.
Successful external commands (isolated checkout):

```bash
git push -u origin codex/double-installer-validation
gh release edit double-installer-0.1.0-rc --repo densclub-rs/double --notes-file /tmp/double-installer-release-notes.md
gh release delete-asset double-installer-0.1.0-rc INSTALL.md --repo densclub-rs/double --yes
gh release view double-installer-0.1.0-rc --repo densclub-rs/double --json tagName,assets,body,url
```

Metadata confirms exactly two assets. Script asset id 647243747 and checksum
asset id 647243755, original timestamps and digests are unchanged. Release
notes link the compatible guide at documentation commit 066bd41; product tag
still targets 40bbd5f. No product byte change, retag or asset replacement.
Prior successful six-platform evidence remains applicable to the identical
script/checksum; it originally fetched a third documentation asset. Updated
two-asset harness passed locally; no new hosted success is asserted here.

### Help Documentation Link Requested

User requested the installer --help output to show the instruction URL.
Added a link to the existing compatible guide pinned at documentation commit
066bd419c649ca0fa20bc77d11fb21a54f35af97. This changes product source bytes;
existing release 0.1.0-rc is preserved. New source needs fresh required CI
and a new version before publication; prior release evidence is not rebound.

## CI05 Effective Contract — 0.1.1-rc Release

User explicitly authorized publishing double-installer-0.1.1-rc with the
help instruction link. Isolated candidate adds changed script plus help-output
assertions; complete required exact-commit CI must pass again. Publish only
script/SHA256SUMS.txt; guide remains project documentation linked in notes.
After publication verify downloaded bytes/checksum and live lifecycle on
all six targets plus real cron on disposable Linux. Preserve 0.1.0-rc and
unrelated main/staged content; no tag overwrite. Record new run/commit/assets
and failures honestly; stop for stage acceptance after observed result.

### 0.1.1-rc Candidate and Tag Push

Product/test commit cf7f726f1cdec6413912080ca24513ad2e982f43 created
in isolated checkout. Local syntax and release fixtures (including packaged
help-link assertions) passed:

```bash
bash tests/test-double-installer-release.sh > /tmp/double-installer-0.1.1-release-tests.log
bash -n scripts/double-installer.sh
```

Successful isolated checkout commit/tag/push commands:

```bash
git add scripts/double-installer.sh tests/test-double-installer-release.sh
git commit -m 'Show installation guide in installer help'
git tag double-installer-0.1.1-rc
git push origin refs/tags/double-installer-0.1.1-rc
```

Tag pushed successfully; production script checksum differs from 0.1.0-rc
by design. Fresh mandatory CI/publication and downloaded-asset outcome are
pending. No old evidence is reused as proof of this changed product version.

### 0.1.1-rc First Hosted Attempt

[Release run 38922734064](https://github.com/densclub-rs/double/actions/runs/38922734064)
ran on cf7f726f1cdec6413912080ca24513ad2e982f43. All mandatory
prepublication matrix/regression/integration checks and gate passed; release
publication succeeded. Five postpublication targets passed, including both
Windows architectures and Linux x64 cron. macOS ARM64 verified downloaded
script/checksum/help but then received GitHub API HTTP 403 in live package
smoke. Original attempt is recorded failure, not silently accepted.
Requested retry of only failed job 117051141823 on unchanged candidate/tag;
no script, checksum, tag or release assets are replaced. Source blob SHA-256
for this version is 0b7d5147acd9e3e012574600c981714baf58ffca637a86a86f073b86e78fbf82.

### 0.1.1-rc CI API Access Repair

The same macOS ARM64 live-smoke API request returned HTTP 403 on retry.
Actual cause is not proven by headers. Added CI-only optional authentication
adapter in tests/github-api-auth.sh; when GH_TOKEN is provided, only exact
https://api.github.com/ requests receive the read-only Actions token. Asset
download hosts and local no-token invocations remain unauthenticated. Fake
curl/fake-token tests prove the host boundary and no-token fallback; syntax
and YAML checks pass. No real token is logged or stored in repository files.

Harness commit 53725ce612a8aa399acd46545a6c8a286594c70c changes tests/
workflows only. git diff --exit-code double-installer-0.1.1-rc --
scripts/double-installer.sh succeeds with empty diff. Recheck targets the
unchanged product commit cf7f726. Release metadata confirms exactly script
and checksum assets; script digest matches the tagged source SHA-256.
Original publication and HTTP-failed attempts are retained; new authenticated
recheck result is pending until observed.

### 0.1.1-rc Final Observed Result — Awaiting Acceptance

[Authenticated post-release run 38925798842](https://github.com/densclub-rs/double/actions/runs/38925798842)
completed success on harness commit 53725ce612a8aa399acd46545a6c8a286594c70c,
verifying product tag/commit cf7f726f1cdec6413912080ca24513ad2e982f43.
All six downloaded-asset targets passed: Linux x64 (including real cron),
Linux ARM64, macOS x64/ARM64, Windows x64/ARM64 host with Git Bash.
The optional recheck intentionally skips prepublication groups; all mandatory
prepublication groups passed on cf7f726 in original release run 38922734064.
Original run/retry remain failures due to unauthenticated API HTTP 403; no
failed execution is retroactively marked green.

Successful remote commands (isolated candidate checkout):

```bash
git push -u origin codex/double-installer-validation
gh workflow run double-installer-tests.yml --repo densclub-rs/double --ref codex/double-installer-validation -f release_tag=double-installer-0.1.1-rc -f release_commit=cf7f726f1cdec6413912080ca24513ad2e982f43
gh run watch 38925798842 --repo densclub-rs/double --exit-status --interval 30
gh run view 38925798842 --repo densclub-rs/double --json status,conclusion,jobs,url,headSha
gh release view double-installer-0.1.1-rc --repo densclub-rs/double --json tagName,isPrerelease,isDraft,url,assets,body
```

Watch exited 0; metadata and JSON conclusions checked locally.
[Published 0.1.1-rc](https://github.com/densclub-rs/double/releases/tag/double-installer-0.1.1-rc)
is prerelease, not draft; exactly double-installer.sh and SHA256SUMS.txt.
Actual script asset digest matches tagged source:
0b7d5147acd9e3e012574600c981714baf58ffca637a86a86f073b86e78fbf82.
The --help instruction URL is included in the published script; instructions
remain linked project documentation. No existing tag/assets were overwritten.
CI05 is ready for user acceptance; CI06 consolidation remains unstarted.

## Superseded Scope — CLI/Global Extension

User did not accept final CI05 and instead requested alias/bulk/global agent
integration. Parent revision 6 resumes implementation at S05A. This baseline-2
run closes partial with existing releases and observed results retained, not
retroactively rebound. S06 must align its future contracts/realization before
revalidating expanded source; no CI06 acceptance or overall goal completion.
