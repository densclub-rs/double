---
id: double-installer-run-interactive-rest-20261019T102423Z
kind: plan-run
template-id: plan-run-template
produced-by: machine-of-goals/plan-realization-agent
project-id: double
goal-id: double-installer
plan-revision: 12
plan-revision-artifact: ../realizations/plan-revision-12.md
realization-record-id: interactive-rest
realization-id: interactive-development
realization-artifact: ../realizations/interactive-rest.md
realization-revision: 10
started-at: 2026-10-19T10:24:23Z
finished-at: null
result: running
---
<a id="double-installer-run-interactive-rest-20261019T102423Z"></a>
# Run: Release Consent and Directory Backups

[Plan](../plan.md#double-installer-plan),
[decision](../realization-decision.md#double-installer-realization-decision),
[path registry](../path-options.md#double-installer-path-options),
[immutable revision](../realizations/plan-revision-12.md#double-installer-plan),
[realization](../realizations/interactive-rest.md#interactive-rest-revision-10).

## Effective Contract Before Implementation

## S05A Release Consent and Directory Backups — 2026-10-19

Default add selects stable, otherwise rc, otherwise dev; newest numeric version
within the chosen channel. Installing a prerelease requires affirmative terminal
consent or add --yes, including explicit prerelease selection. Download remains
cache-only. Existing registered updates keep their approved channel. Unregistered
machine directories require separate adoption consent before replacement and
registration. Non-terminal input never implicitly authorizes either operation.
add --yes acknowledges prerelease/adoption only, never all-agent integration.

Snapshot complete machine directories .double/<category>/<machine>, and complete
agent skill directories, including extra nested files. Apply directory snapshots
to persistent backups and transaction rollback. Registry JSON remains metadata.
Adoption replaces only selected machine roots after backup; rollback restores
whole original directories. Preserve other machines and independent agent commits.
Validate consent accept/reject, fallback priority, full directory preservation,
adoption rollback and existing lifecycle/release fixtures in isolated projects.
Baseline 12 / realization 10 supersede affected S05A obligations. S06 requires
fresh validation; hosted runs and publication remain outside this action.

## Successful Validation Commands — S05A

Working directory: repository root. Isolated fixture state only. Commands are
reusable; this record does not authorize applying them to a real installation.

```bash
bash -n scripts/double-installer.sh tests/test-double-installer.sh
bash tests/test-double-installer-release.sh
```

Shell syntax passed. Release tooling fixtures passed with the unified required
six-platform publication gate; this is local workflow-contract validation, not
a hosted six-platform run or publication. Log: /tmp/double-directory-release.log.

```bash
python3 tests/validate-machine-of-goals-navigation.py goals/double-installer/plan.md goals/double-installer/realizations/plan-revision-12.md goals/double-installer/realizations/interactive-rest.md goals/double-installer/realization-decision.md goals/double-installer/run/interactive-rest--20261019T102423Z.md
```

All five current
artifacts passed. The broader historical goal-tree navigation audit also reports
pre-existing incomplete links in retained runs/subgoals; those unrelated artifacts
were not rewritten. This scope does not certify the whole historical tree.

```bash
bash tests/run-installer-tests.sh
```

Passed: platform smoke and 175 lifecycle fixtures, macOS ARM64, Bash 3.2.57;
66 seconds total. Log: /tmp/double-directory-tests.log. Coverage includes
stable without consent, rc before newer dev, dev fallback, prerelease rejection,
separate manual-adoption rejection/acceptance, complete nested machine and skill
backups, obsolete manual categories, failed adoption rollback, registry accuracy,
cache verification and independent per-agent failures/removals. Existing cleanup
checks pass with full-directory rollback snapshots. Foreign uninventoried files
remain after ordinary removal, as before; adoption replaces selected machine
roots only after explicit consent and a successful complete backup.

Scoped navigation and whitespace checks passed, including untracked deliverables.
Current plan map/run baseline and goal requirements are synchronized. S05A local
implementation is ready for user acceptance. Fresh S06 — delegated validation
remains required before release. No real external project, installed agent,
crontab, hosted workflow, tag or release was changed by this action.

## Authorized Release — 2026-10-19

User authorizes a new installer release. Target double-installer-0.1.2-rc
(existing releases checked: 0.1.0-rc and 0.1.1-rc). Prepare an isolated checkout
from current tracked HEAD plus scoped installer sources, tests, workflow, release
router and owner documentation. Preserve the main checkout/index and unrelated
changes. Run local checks, push the candidate/tag, require all hosted validation
groups before automatic publication of script + SHA256SUMS. Live prerelease
smoke now explicitly supplies --yes, matching the new confirmation contract.
Do not bypass failed CI or publish assets directly.

### Release Candidate Local Evidence

Isolated checkout: /tmp/double-installer-release-012, branch
codex/double-installer-0.1.2-rc. Successful commands (run there unless noted):

```bash
PATH="/opt/homebrew/bin:$PATH" bash tests/run-installer-tests.sh
bash tests/test-double-release.sh
bash tests/test-machine-of-goals-navigation.sh
python3 tests/test-git-double.py
```

175 installer fixtures and platform smoke passed (63 seconds); machine packaging,
navigation fixtures and eight git-double tests passed. Python 3.10+ is required
for this test harness; local rerun selected Homebrew Python 3.14, while CI pins
Python 3.13. Logs: /tmp/double-012-local.log, /tmp/double-012-machine-release.log,
/tmp/double-012-nav.log, /tmp/double-012-git.log. Installer release tooling also
passed from the root checkout: bash tests/test-double-installer-release.sh
(/tmp/double-012-release-local.log). No real host cron/agent changes.

### Candidate Identity

Commit: b16a6a1eff10ff250fd5ccc5ce44b4e36f20349b.
Tag: double-installer-0.1.2-rc. Clean isolated checkout after commit.
Script SHA-256: 5bc45a72de4653a59440b122d79fb3f4fae62ea7116d44dade76c097787bc3bd.
Local exact-tag package contains script + SHA256SUMS; byte comparison passed.

Successful commands in isolated checkout:

```bash
git commit -m "Release Double installer 0.1.2-rc with consent and directory backups"
git tag double-installer-0.1.2-rc
bash scripts/double-release.sh package --tag double-installer-0.1.2-rc
cmp scripts/double-installer.sh dist/double-installer-0.1.2-rc/double-installer.sh
shasum -a 256 scripts/double-installer.sh
```

Do not replay commit/tag creation: the immutable candidate already exists.
Branch and tag were pushed successfully; hosted publication is pending.

Successful command in isolated checkout:

```bash
git push --atomic origin HEAD:refs/heads/codex/double-installer-0.1.2-rc refs/tags/double-installer-0.1.2-rc
```

Both new refs were accepted. Do not replay as permission to replace refs.
User release authorization accepts the S05A local implementation for the S06
release validation handoff; goal completion is not inferred from that decision.

Hosted release run: [39275470554](https://github.com/densclub-rs/double/actions/runs/39275470554), tag double-installer-0.1.2-rc,
commit b16a6a1eff10ff250fd5ccc5ce44b4e36f20349b. GitHub reports in_progress.
A same-commit branch-only test run 39275470521 also started; cancellation was
requested to avoid duplicate runner consumption. The tagged run remains required.
Publication is pending the tagged run's complete required validation gate.

### S06-CI05 Required Rework

Tagged run 39275470554 failed closed: macOS x64/ARM64, both repository
regressions and live/cron passed; Linux fixture PATH lacked gzip, Windows
status --json failed native jq --slurpfile on the Unicode fixture registry path.
Publish was skipped. Duplicate branch run had already completed when cancellation
was attempted; no further branch push is needed. Fix only the test gzip inventory
and status JSON registry input (Bash stdin redirection avoids native jq Unicode
filename handling). Retain failed 0.1.2-rc tag unchanged; next candidate 0.1.3-rc
will push only its tag, eliminating the duplicated branch-triggered validation.

Corrected local shared suite passed again: 175 fixtures and platform smoke,
67 seconds, /tmp/double-013-local.log. Successful command at repository root:

```bash
PATH="/opt/homebrew/bin:$PATH" bash tests/run-installer-tests.sh
```

Use a fresh immutable 0.1.3-rc candidate and push only its tag. No additional
branch-triggered duplicate run. New hosted validation is necessary because
status input code and test dependencies changed after the failed candidate.

### Corrected Candidate 0.1.3-rc

Commit: 6b9a4f796657d1b1c1b4f4f5bfa5a0949c1c59f3.
Script SHA-256: 5b5193289546d5ca86b2c943598bc9a94bf1edeef32a38d95eaa9c379913e402.
Installer packaging fixtures passed again (/tmp/double-013-packaging.log).
Successful commands in isolated checkout:

```bash
git commit -m "Fix Linux fixture compression and Windows JSON status for installer 0.1.3-rc"
git tag double-installer-0.1.3-rc
bash scripts/double-release.sh package --tag double-installer-0.1.3-rc
shasum -a 256 scripts/double-installer.sh
git push origin refs/tags/double-installer-0.1.3-rc
```

Only the new tag was pushed. Existing branch/tag refs were not moved.
The isolated checkout is clean; the root index and unrelated changes are preserved.
Do not replay commit/tag creation or infer permission to overwrite a tag.

Corrected tagged run: [39278007855](https://github.com/densclub-rs/double/actions/runs/39278007855),
commit 6b9a4f796657d1b1c1b4f4f5bfa5a0949c1c59f3, tag double-installer-0.1.3-rc.
GitHub initially reports queued. No branch push accompanied this tag.

### Existing Run Monitoring

REST Actions run lookups repeatedly returned HTTP 502; release API initially
returned 404 (not published). The [official GitHub status page](https://www.githubstatus.com/) reported no active
incident, so no global outage is asserted. These were status reads, not CI reruns.
GraphQL commit checks remain readable: observed success for Linux x64, macOS
ARM64, both regression jobs and live/cron; four platform rows still in progress.
Switch monitoring to statusCheckRollup for the same exact 6b9a4f7 commit/run.
No tag, commit, workflow or test rerun is created by monitoring.

Successful read command (repository-independent; read permission required):

```bash
gh api graphql -f query='query { repository(owner:"densclub-rs", name:"double") { object(oid:"6b9a4f796657d1b1c1b4f4f5bfa5a0949c1c59f3") { ... on Commit { oid statusCheckRollup { state contexts(first:100) { nodes { ... on CheckRun { name status conclusion detailsUrl } } } } } } } }'
```

### S06-CI05 Windows ARM64 Runtime Rework

Direct job steps show five platform suites passed. Windows ARM64 shared checks
were cancelled by the 20-minute job deadline, after ongoing progress through
fixture 114 and into fixture 115. Log: /tmp/double-013-winarm.log. Host reports
ARM64 Windows with x86_64 Git Bash (emulation), unlike native Python ARM64.
Raise only Windows ARM64 job budget to 60 minutes, keeping the complete required
fixture suite, evidence upload and publication gate. The script bytes stay
5b5193289546d5ca86b2c943598bc9a94bf1edeef32a38d95eaa9c379913e402.
Retain 0.1.3-rc tag unchanged; prepare 0.1.4-rc with the corrected CI budget.
Push only the new tag. This is a new candidate validation, not a branch duplicate
or a post-publication test stage. REST/GraphQL top-level statuses lagged actual
step results; direct step timestamps established the real timeout.
