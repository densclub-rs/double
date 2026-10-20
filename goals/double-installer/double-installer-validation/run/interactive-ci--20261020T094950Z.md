---
id: double-installer-validation-run-interactive-ci-20261020T094950Z
kind: plan-run
template-id: plan-run-template
produced-by: machine-of-goals/plan-realization-agent
project-id: double
goal-id: double-installer-validation
plan-revision: 5
plan-revision-artifact: ../realizations/plan-revision-5.md
realization-record-id: interactive-ci
realization-id: interactive-ci-procedure
realization-artifact: ../realizations/interactive-ci.md
realization-revision: 5
started-at: 2026-10-20T09:49:50Z
finished-at: null
result: running
---
<a id="double-installer-validation-run-interactive-ci-20261020T094950Z"></a>
# Run: Quick Release Validation

[Plan](../plan.md#double-installer-validation-plan),
[decision](../realization-decision.md#double-installer-validation-realization-decision),
[paths](../path-options.md), [baseline](../realizations/plan-revision-5.md#double-installer-validation-plan),
[realization](../realizations/interactive-ci.md#interactive-ci-revision-5).

## Effective Contract Before Action

## Temporary Quick Release Validation — 2026-10-20

User explicitly authorizes temporarily excluding long tests and publishing the
installer with quick checks. Required: syntax and platform lifecycle smoke on
all six OS/architecture rows, fast repository regressions, live package and real
cron checks, then the strict gate and two-asset publication. CI invokes
run-installer-tests.sh --quick and bounds installer jobs at ten minutes.
The 175-case comprehensive fixture suite is preserved for explicit/manual runs;
it is not required for this temporary release policy. This reduced coverage must
not be reported as full regression coverage. User plans to refactor slow tests.
No branch duplicate, tag overwrite, manual gate bypass or post-publication tests.
Baseline 5 / realization 5 capture the changed acceptance contract before action.

## Local Evidence and Candidate

Quick shared suite passed locally in three seconds; installer release/workflow
fixtures passed. Added one JSON status smoke assertion, preserving the Windows
Unicode-path regression check in quick coverage. Candidate tag 0.1.5-rc avoids
changing any earlier local or remote candidate tag. Prior 0.1.4-rc never reached
GitHub (verified absence); old 0.1.3-rc run is completed/cancelled.

Successful commands at repository root:

```bash
PATH="/opt/homebrew/bin:$PATH" bash tests/run-installer-tests.sh --quick
PATH="/opt/homebrew/bin:$PATH" bash tests/test-double-installer-release.sh
```

Logs: /tmp/double-quick-local.log, /tmp/double-quick-packaging.log.
Reduced validation is explicitly user-approved; full fixtures remain manual.
