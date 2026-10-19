---
id: double-installer-run-interactive-rest-20261017T183500Z
kind: plan-run
template-id: plan-run-template
produced-by: machine-of-goals/plan-realization-agent
project-id: double
goal-id: double-installer
plan-revision: 7
plan-revision-artifact: ../realizations/plan-revision-7.md
realization-record-id: interactive-rest
realization-id: interactive-rest-procedure
realization-artifact: ../realizations/interactive-rest.md
realization-revision: 5
started-at: 2026-10-17T18:35:00Z
finished-at: 2026-10-17T18:36:00Z
result: partial
---
<a id="double-installer-run-interactive-rest-20261017T183500Z"></a>
# Run: Project and Global Agent Installation

## S05A Effective Contract — Attempt 1

User explicitly authorizes add --agent for project installations, default all
supported detected agents in that project, and add --global for global initial
installation. Preserve installed-only update semantics, registry scope/ownership,
backups, cleanup and portable Bash3.2/Git Bash support. Test default/explicit agents,
project/global isolation, foreign collisions, partial second-agent rollback,
registered-only global updates, existing project updates and full cleanup.
Refresh help/explain/knowledge and plans. No live agent configuration or release.

Superseded by explicit user clarification: agent operations must be independent.
