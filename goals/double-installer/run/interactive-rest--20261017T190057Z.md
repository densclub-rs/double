---
id: double-installer-run-interactive-rest-20261017T190057Z
kind: plan-run
template-id: plan-run-template
produced-by: machine-of-goals/plan-realization-agent
project-id: double
goal-id: double-installer
plan-revision: 10
plan-revision-artifact: ../realizations/plan-revision-10.md
realization-record-id: interactive-rest
realization-id: interactive-development
realization-artifact: ../realizations/interactive-rest.md
realization-revision: 8
started-at: 2026-10-17T19:00:57Z
finished-at: 2026-10-17T19:08:39Z
result: partial
---
<a id="double-installer-run-interactive-rest-20261017T190057Z"></a>
# Run: Doctor Agent Inventory

## S05A Effective Contract

User requests doctor agent detection for Codex, Claude Code, Cursor, Copilot,
Gemini CLI, OpenCode, Cascade/Windsurf/Devin and Pi. Show all eight plus evidence;
read only known paths and executable locations. Never execute agents/read token
contents/create state. Honor config overrides and preserve optional-agent vs
required-tool exit behavior. Discovery does not enable new installation adapters.
Validate disposable CLI/config/extension fixtures and existing shared suite.

## S05A Local Validation

Doctor now lists all eight selected agents with evidence. CLI detection uses
executable lookup only; config/app/VS Code extension probes check path presence,
not credential contents. Known overrides and native Windows paths are handled.
Agent absence is informational; dependency exit semantics and shared add remain
unchanged. Explicit installation adapters remain codex/claude only.

Successful commands executed from repository root:

```bash
bash -n scripts/double-installer.sh tests/test-double-installer.sh
bash tests/run-installer-tests.sh
bash tests/test-double-installer-release.sh
bash scripts/double-installer.sh doctor
```

All passed locally (macOS ARM64 / Bash 3.2). Fixture evidence:
/tmp/double-doctor-agents.log; release evidence: /tmp/double-doctor-release.log.
Fake binaries write a marker if executed; marker stayed absent. Configuration-only
fixtures exercise overrides, spaces, all eight rows, credential-output omission,
Copilot extension detection and absence of installer-state creation. Existing
installer lifecycle fixtures also passed. Current links/whitespace validated.
Actual local evidence: Codex/Claude/Gemini/OpenCode CLI/config and Copilot config;
Cursor/Cascade/Pi had no known evidence. These findings are time-specific and
are not proof of authentication or skill loading. No live agent invocation,
configuration mutation, tag, push, hosted run or release publication performed.
Plan, realization, decision, knowledge and run navigation synchronized.

## S05A Doctor Colors — 2026-10-17

User authorizes terminal colors. Cyan headings, green dependency successes/
DETECTED statuses, yellow optional/agent absence, red missing required tools.
Keep column padding independent of ANSI. Honor NO_COLOR (even empty), TERM=dumb,
stdout redirection and stderr's own terminal state; preserve messages/exit codes.
Compatible presentation-only update; no new discovery/adapter behavior.

Successful commands from repository root:

```bash
bash -n scripts/double-installer.sh
python3 /tmp/check-double-doctor-colors.py
bash scripts/double-installer.sh doctor > /tmp/double-doctor-plain.log
```

Passed: disposable POSIX PTY checks compare colored/plain text, verify green/
yellow/cyan and red missing-jq errors, status 1 vs 0, empty NO_COLOR, TERM=dumb,
plain redirected streams and absence of state creation. Fake utilities are not
executed. No hosted run, release or agent configuration change.

Continue the newly requested add discovery/consent contract under baseline 11.
