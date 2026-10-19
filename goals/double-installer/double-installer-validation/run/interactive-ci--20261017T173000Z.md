---
id: double-installer-validation-run-interactive-ci--20261017T173000Z
kind: plan-run
template-id: plan-run-template
produced-by: machine-of-goals/plan-realization-agent
project-id: double
goal-id: double-installer-validation
plan-revision: 4
plan-revision-artifact: ../realizations/plan-revision-4.md
realization-record-id: interactive-ci
realization-id: interactive-ci-procedure
realization-artifact: ../realizations/interactive-ci.md
realization-revision: 4
started-at: 2026-10-17T17:30:00Z
finished-at: null
result: running
---
# Run: Tests Then Publication

User explicitly authorizes removing all post-publication checks. CI02R removes
the published-installer job, recheck dispatch inputs/resolver mode and dedicated
published test harness. Retain six-platform prepublication matrix, regressions,
live/cron checks and strict gate. CI05 ends with publishing the exact tested
commit. Current plans and docs follow this contract; historical logs stay intact.
No tag, push, hosted run or publication is authorized here.

## Local Evidence

Working directory: repository root. Successful validation commands:

```bash
bash tests/test-double-installer-release.sh
ruby -e 'require "yaml"; YAML.load_file(".github/workflows/double-installer.yml"); puts "PASS YAML"'
bash -n scripts/double-installer-release.sh
```

All passed; release fixture output: /tmp/double-no-post-release.log.
Full platform tests are unchanged; no installer product code changed here.
Ready for review; hosted execution remains pending.

## S06-CI05 — Authorized Release 0.1.2-rc (2026-10-19)

User authorizes publishing the revised installer after hosted validation.
Use unified double-installer.yml: exact tagged candidate → six platform rows,
repository regressions, live package and real cron → required gate → script and
SHA256SUMS publication. No post-publication test phase. Separate local checkout
protects unrelated root working changes. Prepublication live smoke explicitly
acknowledges prerelease installation using --yes. Local packaging, machine
release fixtures, navigation fixtures and git-double tests pass; candidate
lifecycle suite is running. Target tag: double-installer-0.1.2-rc.

Hosted release run: [39275470554](https://github.com/densclub-rs/double/actions/runs/39275470554), tag double-installer-0.1.2-rc,
commit b16a6a1eff10ff250fd5ccc5ce44b4e36f20349b. GitHub reports in_progress.
A same-commit branch-only test run 39275470521 also started; cancellation was
requested to avoid duplicate runner consumption. The tagged run remains required.
Publication is pending the tagged run's complete required validation gate.

Run 39275470554 failed closed: Linux lacked gzip in the restricted fixture
PATH; native Windows jq --slurpfile could not open the Unicode registry path.
Both macOS rows, regression rows and live/cron passed. Publishing was skipped.
Fix status JSON registry input to stdin and add gzip to fixture tools. Corrected
local suite passed (175 fixtures). Proceed as 0.1.3-rc with tag-only push,
retaining failed 0.1.2-rc immutable tag and eliminating duplicate branch run.

Corrected tagged run: [39278007855](https://github.com/densclub-rs/double/actions/runs/39278007855),
commit 6b9a4f796657d1b1c1b4f4f5bfa5a0949c1c59f3, tag double-installer-0.1.3-rc.
GitHub initially reports queued. No branch push accompanied this tag.

0.1.3-rc Windows ARM64 was cancelled at the 20-minute shared-suite limit;
fixtures progressed through 114 into 115. All five other platform steps passed.
Set this row's bounded job budget to 60 minutes (Git Bash x64 emulation on
ARM64 Windows), preserve the full suite and strict gate, and continue as
0.1.4-rc. No product/test-fixture code change and no tag overwrite.
