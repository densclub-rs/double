---
id: double-agent-changelog
kind: knowledge-artifact
status: stable
produced-by: machine-of-knowledge/knowledge-extraction-agent
interaction-language: ru
artifact-language: en
type: static
access: free-of-charge
value-type: text
observed-at: 2026-10-28
ttl: one month
derived-from:
  - .double-rules/double-agent/double-agent-version.md
  - knowledge/machine-version-and-changelog-locations/machine-version-and-changelog-locations.md
  - git history and local annotated machine tags inspected on 2026-10-28
---

<a id="double-agent-changelog"></a>

# double-agent Changelog

## Description

Changes recorded for the `double-agent` module.

## Value

### 0.0.11 — 2026-10-29

- Load project-owned common and machine-specific rules before planning or applying changes.
- Distribute the rules-loading protocol with Double Agent without including project rules in machine archives.
- Treat project rules as project facts, settings, conventions, versions and history.
- Resolve machine versions and changelogs from the project index, using default paths only when no project source exists.
- Stop on broken or conflicting sources and resolve release knowledge from the exact tagged tree.
- Require approval of the exact changelog entry before creating a release candidate.
- Use the approved entry for the annotated tag and complete GitHub release notes.
- Shorten Telegram announcements when needed and link to the complete release.
- Block publication when the changelog entry is missing, empty, ambiguous or inconsistent with the tag annotation.
- Require separate approval of the final publication and Telegram preview.

### 0.0.10 — 2026-10-28

- Load project-owned common and machine-specific rules from `.double-rules/` before planning or applying changes.
- Distribute the rules-loading protocol with the machine while preserving the project's own rules.

### 0.0.9 — 2026-10-22

- Add machine release preparation, readiness checks and validation of the exact tagged package.
- Use `git` and `gh` for repository and GitHub operations.
- Recommend release candidates and report readiness blockers through the responsible machine workflows.
- Require approval of the English tag annotation and generated Telegram preview before publication.
- Publish through GitHub Actions and verify release and Telegram delivery separately; development releases have no Telegram announcement.
