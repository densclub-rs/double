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
