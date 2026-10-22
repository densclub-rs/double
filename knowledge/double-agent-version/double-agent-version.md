---
id: double-agent-version
kind: knowledge-artifact
status: stable
produced-by: machine-of-knowledge/knowledge-extraction-agent
interaction-language: ru
artifact-language: en
knowledge-type: static
type: static
access: free-of-charge
value-type: text
observed-at: 2026-10-22
ttl: one month
derived-from:
  - knowledge/double-main-modules/double-main-modules.md
  - user-provided project versioning decision
  - .double/workflows/double-agent/double-agent-workflow.md
  - .double/skills/double-agent/SKILL.md
  - .double/agents/double-agent/double-agent.md
  - .double/roles/double-agent/machine-artifact-maintainer-role.md
  - user-approved machine release preparation and Telegram approval plan on 2026-10-22
  - user-required git and gh repository-tool boundary on 2026-10-22
  - user-required English tag annotations and Telegram announcements on 2026-10-22
---

<a id="double-agent-version"></a>

# Double Agent Version

## Description

The version assigned to the `double-agent` main module of the Double project.

## Value

`0.0.9`

## Change Note

Version `0.0.9` adds the machine release protocol to Double Agent:

- activate for release requests for Machine of Ideas, Machine of Goals,
  Machine of Knowledge, and Double Agent itself
- use only the git and gh command-line utilities for Double repository and
  GitHub operations, including inspection and Actions monitoring; do not use
  GitKraken, GitHub MCP tools, other repository connectors, or browser interfaces
- recommend release candidate, discourage dev releases, and check the entire
  owned working-file inventory against the requested channel before packaging
- require machine-owned project documents to be release-candidate or stable;
  report readiness failures and plan corrections through the responsible workflow
- compare dedicated version knowledge with machine tags and determine the
  changelog baseline using the existing release tooling
- prepare an approved local commit and annotated tag; validate the exact tagged
  tree and complete package inventory
- show the full annotation and actual generated Telegram output before push;
  declare the future Actions run URL and block other unresolved rendering
  differences between local preview and CI
- require the full tag annotation and complete Telegram announcement in
  English regardless of the conversation language; check commit/PR title
  inputs because the current generator preserves their original language
- require explicit approval of the concrete message and publication packet,
  separately from preparation approval; changed inputs require another preview
- show dev non-announcement explicitly, since Actions excludes dev from Telegram
- push only the approved branch/commit and tag, then let GitHub Actions publish
  and notify; verify release and Telegram outcomes separately
- preserve the mandatory structured-choice, explicit-response, waiting, and
  sequential maintenance rules; avoid automatic retries of publication or
  notification that could duplicate announcements

This version changes the operating instructions. It does not change the release
scripts or GitHub Actions workflow and does not itself publish a release.
