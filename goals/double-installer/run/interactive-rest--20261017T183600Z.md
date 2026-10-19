---
id: double-installer-run-interactive-rest-20261017T183600Z
kind: plan-run
template-id: plan-run-template
produced-by: machine-of-goals/plan-realization-agent
project-id: double
goal-id: double-installer
plan-revision: 8
plan-revision-artifact: ../realizations/plan-revision-8.md
realization-record-id: interactive-rest
realization-id: interactive-development
realization-artifact: ../realizations/interactive-rest.md
realization-revision: 6
started-at: 2026-10-17T18:36:00Z
finished-at: 2026-10-17T18:44:56Z
result: partial
---
<a id="double-installer-run-interactive-rest-20261017T183600Z"></a>
# Run: Independent Project and Global Agent Installation

## S05A Effective Contract — Attempt 1

User authorizes project-local add --agent/default discovery, global add for
installation, registered-only updates, and independent agent operations.
Payload and successful agents remain committed when another agent fails;
rollback only failed agent writes, continue the rest, return nonzero for partial
failure. Retry via add without reinstalling/upgrading existing payload. Removal
likewise retains successful detaches, registered failures and payload for retry.
Validate discovery, explicit targeting, isolation, collisions, partial failure,
retry, updates and cleanup with disposable projects/state only. No release.

## S05A Local Validation

Implemented scoped roots, default discovery and explicit selection for project
add; global add creates payloads/skills while global update selects registered
machines only. Repeated add retries/repairs skills without payload upgrades.
Each agent write/detach has a separate transaction, lock and registry commit.
Partial failure returns nonzero and keeps successful registrations/removals;
failed writes roll back only their own skill. Payload remains on failed detach.
Help/explain, knowledge, plan/registry/decision/run navigation synchronized.

Successful commands from repository root:

```bash
bash -n scripts/double-installer.sh
bash tests/run-installer-tests.sh
bash tests/test-double-installer-release.sh
```

All passed locally on macOS ARM64 / Bash 3.2. Evidence:
/tmp/double-scoped-independent-final.log and /tmp/double-scoped-release.log.
Fixtures cover two project scopes, explicit Codex, discovered Codex/Claude,
foreign collisions, failures of both first and second agents with other-agent
success retained, retry via add, registered-only global update, backup/rollback,
independent detach failure and full cleanup. No real agent was executed or
configured. Current navigation links and changed-file whitespace also passed.
Fresh hosted six-platform checks remain pending; no release/tag/push performed.

User changes default integration to shared roots; continue under baseline 9.
