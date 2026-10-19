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

`.github/workflows/double-installer.yml` runs the shared installer entry point
on six required OS/architecture rows. Repository release/Git/navigation
regressions run separately on Linux x86_64 and macOS ARM64; no additional
platform coverage is claimed for those utilities. The release workflow resolves
the candidate tag to a commit, waits for its validation gate and rechecks tag
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

## Installer release preparation

`bash tests/test-double-installer-release.sh` runs disposable Git/fake-GitHub
checks for stable/rc/dev installer packaging, exact tagged bytes and checksums,
invalid/missing tags, commit mismatch, publication scope, API/create errors and
existing-release refusal. It also invokes stdlib-only
`test-installer-release-workflow.py` for local gate/identity contract checks.
These are local checks, not proof of hosted publication; CI05 must execute
the actual test → gate → publication chain.

Prepare assets with `bash scripts/double-release.sh package --tag
double-installer-<version>[-rc|-dev]` from an existing local tag. Output lives
in `dist/<tag>/`: double-installer.sh and SHA256SUMS.txt.
Publication routes to scripts/double-installer-release.sh, requires the
validated commit in GitHub Actions, and refuses existing releases rather than
overwriting assets. No production tag is created by the local test suite.

Publication is the final automated step. There is no post-publication matrix
or manual existing-release verification mode.

Installer releases contain only the script and checksum; release notes link
to the installation guide in knowledge/double-installer/double-installer.md.

CI live smoke may source github-api-auth.sh with the built-in read-only
Actions token. The adapter authenticates only api.github.com requests;
release assets and ordinary local/user invocations remain unauthenticated.
No credentials are required from users of the installer.

## Bulk downloads and global agent fixtures

The comprehensive installer harness also isolates HOME, CODEX_HOME,
CLAUDE_CONFIG_DIR and PATH. It verifies install aliases, stable/rc/dev priority,
cache corruption handling, config/CLI discovery, explicit-agent selection,
shared payload registry, wrapper backups, promotion through update-all,
one-agent/full removal, foreign collision and symlink refusal, rollback of
failed wrapper writes/deletes, tampered inventory refusal and full cleanup.
Fake agents are never executed; actual agent skill discovery/model behavior
and fresh six-platform evidence remain S06 work for the changed installer.

## Project and Global Agent Registration

Fixtures cover add --project with auto-detected or explicit agents, project-local
skill roots and separation from global HOME roots. Global first installation uses
add --global; update --global requires registered machines. Per-agent operations
are independent: partial write rollback, successful registrations on either side
of a failed agent, retry via add, and retained successful detaches on later-agent
removal failure. Payload remains available on partial integration failure.
No real agent is executed or configured.

Shared defaults are validated without installed CLIs/config: only .agents/skills
is created, registry records shared, and Claude directories require explicit
--agent. Tests also cover a Codex/shared file referenced by multiple logical
connections, owned-file reuse without unnecessary backups and last-reference
cleanup. Existing explicit adapter lifecycle/failure cases remain covered.

Doctor fixtures cover all eight detection rows, missing CLI evidence, fake
executables that must never run, configuration-only detection with overrides and
spaces in paths, VS Code Copilot extension evidence, credential-content omission
and no installer-state creation. Agent absence does not change doctor success.

POSIX PTY fixtures exercise add's detected-agent question: decline produces only
the common root; accept produces common plus detected Claude roots; global add
asks once; --agent skips the question. A dedicated-agent write failure preserves
the common integration. Windows continues to run portable non-terminal and
explicit adapter cases; Python PTY fixtures run only on POSIX hosts.

Platform smoke covers `[doctor] -> releases -> add` with no explicit download:
assert no cache before add and a cached archive after installation. A second
project add reuses that cache while the fake transport rejects archive/checksum
requests, proving that only catalog discovery is repeated. Both paths verify
installed bytes and existing registry/removal/full-cleanup behavior.

Status fixtures assert project paths, nested machine/version/channel entries,
absence of raw registry fields in human output, and unchanged full installation
records in --json. Terminal presentation continues to honor shared color rules.

Installer fixtures also cover default stable → rc → dev installation selection,
non-terminal prerelease refusal, explicit add --yes, separate terminal adoption
consent, obsolete manual categories, full nested-directory backups and complete
manual directory rollback after a replacement failure. Existing wrapper backups
are asserted at old/skills/<machine>/SKILL.md, within the full skill directory.
