---
id: double-installer-run-interactive-rest-20261017T184456Z
kind: plan-run
template-id: plan-run-template
produced-by: machine-of-goals/plan-realization-agent
project-id: double
goal-id: double-installer
plan-revision: 9
plan-revision-artifact: ../realizations/plan-revision-9.md
realization-record-id: interactive-rest
realization-id: interactive-development
realization-artifact: ../realizations/interactive-rest.md
realization-revision: 7
started-at: 2026-10-17T18:44:56Z
finished-at: 2026-10-17T19:00:57Z
result: partial
---
<a id="double-installer-run-interactive-rest-20261017T184456Z"></a>
# Run: Shared Skills by Default

## S05A Effective Contract

Explicit user direction: common .agents/skills roots by default, independent
agent directories only by --agent. One shared registry record; no default Claude
registration claim. Preserve existing explicit records, shared-file references,
independent failures, updates and owned cleanup. Research Pi official support;
do not claim live Pi acceptance or a dedicated pi adapter. Local changes only.

## S05A Local Validation and Pi Findings

Implemented default shared integration, explicit-only agent directories and
owned-file reuse across shared/Codex logical records. Per-agent failures remain
independent. Existing explicit registrations are preserved; last-reference
removal prevents one connection deleting another's shared file. Default does
not create .claude directories or claim Claude loaded common-root skills.
Help/explain, knowledge, plan/baseline/realization/run navigation synchronized.

Successful commands, repository root:

```bash
bash -n scripts/double-installer.sh tests/test-double-installer.sh
bash tests/run-installer-tests.sh
bash tests/test-double-installer-release.sh
```

All passed locally (macOS ARM64, Bash 3.2). Evidence:
/tmp/double-shared-acceptance.log and /tmp/double-shared-release.log.
Tests cover no-agent-config shared default, explicit Claude/Codex selection,
shared physical-file reuse, one-connection detach retaining another connection's
file, last-reference cleanup, independent errors/retry, updates and uninstall.
Current navigation links and changed-source whitespace also passed.

Official Pi skills/configuration docs confirm common-root discovery, SKILL.md
format, .pi/skills and ~/.pi/agent/skills native roots, PI_CODING_AGENT_DIR,
/skill:name and /reload. No Pi runtime/host configuration was executed and no
--agent pi adapter is claimed. Primary source URLs are in installer knowledge.
No hosted execution, tag, push or publication performed. Ready for review.

Continue the newly requested doctor contract under baseline 10; prior results retained.
