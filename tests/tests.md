# Double tests

Test scenarios and test-only fixtures/helpers belong in the root `tests/`
directory. Deliverable and maintenance scripts belong in `scripts/`.
Tests exercise the actual scripts in `scripts/`; they do not duplicate them.
Run these commands from the repository root:

```bash
bash tests/test-double-installer.sh
bash tests/test-double-release.sh
python3 tests/test-git-double.py
bash tests/test-machine-of-goals-navigation.sh
```

The installer fixture suite requires Python 3 and the installer runtime tools;
it uses temporary projects/state and fake HTTP/crontab. Release tests use
isolated fixture repositories. Git tests use temporary Git repositories.
Navigation tests exercise the validator with disposable documents.

Prior run logs and immutable plan snapshots retain historical `scripts/test-*`
paths and commands. Since 2026-10-15, those scenarios reside under `tests/`;
resolve old references through the matching filename here. New invocations and
CI workflows must use `tests/`. This move does not itself prove new platform
coverage or create a multi-platform CI workflow.


## Shared installer entry point

```bash
bash tests/run-installer-tests.sh
```

Run from the repository root or invoke by absolute path. It reports runtime
versions, checks syntax, exercises the real jq/platform lifecycle smoke and
runs the comprehensive fixture suite. The same entry point is intended for
local validation and each installer CI matrix row.

The platform scenario uses shell-based HTTP/cron fixtures with actual jq,
tar and filesystem tools. Git Bash runs report raw native jq output bytes
(including CRLF when emitted); the test does not normalize away that behavior.
Canonical paths with spaces, Unicode, apostrophes and percent signs must remain
consistent in installed files and persistent registry. Test state/projects are
temporary; no network request or host crontab mutation is performed.

Actual Windows execution is pending CI. A passing macOS/Linux invocation does
not establish Git Bash portability, and any fixture-harness incompatibilities
found on Windows must be fixed before accepting the required Windows rows.


## Hosted validation and real integrations

`.github/workflows/double-installer-tests.yml` runs the shared installer entry point
on six required OS/architecture rows. Repository release/Git/navigation
regressions run separately on Linux x86_64 and macOS ARM64; no additional
platform coverage is claimed for those utilities. The release workflow resolves
the candidate tag to a commit, waits for reusable validation and rechecks tag
identity before packaging/publication. Any required failure blocks publication.

- `installer-ci-environment.sh` reports commit, runner/image and tool/binary
  architecture evidence, and rejects a mismatched runner or Windows WSL shell.
- `test-double-installer-live.sh` downloads the explicit published
  machine-of-ideas-0.2.3-rc package into temporary state, verifies/records its
  checksum and tests installation/removal. It performs real public network I/O.
- `test-double-installer-cron.sh` requires explicit disposable GitHub Linux
  scope. It proves real scheduled unattended no-op invocation with an empty
  registry, then removes the owned task and restores the original crontab.
  It does not prove a real scheduled version replacement; update scenarios
  remain independently covered by lifecycle fixtures.

CI integration jobs may install dependencies on their ephemeral runner.
Logs are uploaded on failure as well as success and retained for 14 days.
All six installer jobs and integration/regression groups must pass for the
exact candidate; preparing YAML is not evidence that hosted jobs have passed.


## Test timing

Shell entry points report UTC ISO 8601 start/end and phase timestamps through
`test-log.sh`. Release cases and Python Git tests report per-case durations.
The comprehensive installer harness logs every synthetic command's start/end,
observed exit and elapsed time using Python clocks, without spawning date for
each command. Each harness invocation is bounded to 180 seconds; the GitHub
job timeout remains the final bound. Fixture commands use synthetic data only.
