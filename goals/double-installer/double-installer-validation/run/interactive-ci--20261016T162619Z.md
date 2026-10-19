---
id: double-installer-validation-run-interactive-ci--20261016T162619Z
kind: plan-run
template-id: plan-run-template
produced-by: machine-of-goals/plan-realization-agent
project-id: double
goal-id: double-installer-validation
plan-revision: 3
plan-revision-artifact: ../realizations/plan-revision-3.md
realization-record-id: interactive-ci
realization-id: interactive-ci-procedure
realization-artifact: ../realizations/interactive-ci.md
realization-revision: 3
started-at: 2026-10-16T16:26:19Z
finished-at: 2026-10-17T17:30:00Z
result: partial
---
<a id="double-installer-validation-run-interactive-ci--20261016T162619Z"></a>
# Run: Unified Installer Workflow

[Baseline 3](../realizations/plan-revision-3.md#double-installer-validation-plan),
[realization 3](../realizations/interactive-ci.md#interactive-ci-revision-3).

## CI02R Effective Contract — Attempt 1

User explicitly requests one double-installer.yml to own installer tests,
publication and downloaded verification. Preserve machine release.yml, route
its validation-only call to the unified file, and remove split workflows.
Candidate modes distinguish test, publish and existing-release recheck; bind
commit/tag identity, require all prepublication groups, use read-only by default
and write only in publication. Test local resolver modes/guards, dependency
contracts and YAML parsing. No remote mutation or new release in this run.
The user also requests a clear explanation of event → tests → publish →
download verification. S05A renames list to status; current release tests must
use status while existing-release rechecks retain legacy inspection support.

## Implementation Clarification — Independent Release Pipelines

Keep release.yml independent: machine/Double Agent tags run their own package
validation and publication, with no call into double-installer.yml. This replaces
the provisional reusable-call wording in baseline 3: a reusable workflow containing
a write-permission publication job would complicate read-only caller permissions.
The installer workflow owns candidate resolution, six-platform tests, repository
regressions, Linux live/cron checks, a strict gate, publication and six-platform
verification of downloaded assets. Only publication has contents:write.
PR/branch events test only; installer tags/manual tag publish after validation;
manual release_tag checks an existing release without republishing.
Frozen historical baselines and previous release evidence remain unchanged.

## Local Validation — 2026-10-16

Successful commands executed from the repository root:

```bash
bash tests/run-installer-tests.sh
bash tests/test-double-installer-release.sh
bash tests/test-double-release.sh
ruby -e 'require "yaml"; ARGV.each { |p| YAML.load_file(p); puts "PASS YAML: #{p}" }' .github/workflows/double-installer.yml .github/workflows/release.yml
bash -n scripts/double-installer.sh scripts/double-installer-release.sh tests/test-double-installer-release.sh tests/test-double-installer-live.sh
```

All passed locally on macOS ARM64. Fixtures cover status/list rejection,
install alias, channel-priority bulk selection, global discovery, registry,
backups, rollback and cleanup; release fixtures cover resolver modes/conflicts,
exact-tag checks, publication gate and independent machine pipeline contracts.
Evidence: /tmp/double-unified-installer.log, /tmp/double-unified-release.log,
/tmp/double-unified-machines.log. YAML parsing and shell syntax also passed.
Full repository diff checking found an unrelated pre-existing .gitignore blank
line at EOF; it was preserved. No hosted run, tag, push or publication performed.
Implementation is locally validated and awaiting stage acceptance; fresh hosted
validation and downloaded-release evidence remain required for changed source.

Superseded by user decision removing post-publication obligations; baseline 4
and a new run preserve the earlier effective contract as history.
