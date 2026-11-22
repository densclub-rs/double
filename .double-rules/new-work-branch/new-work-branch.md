---
id: new-work-branch
kind: knowledge-artifact
status: stable
produced-by: machine-of-knowledge/knowledge-extraction-agent
interaction-language: ru
artifact-language: en
type: static
access: free-of-charge
value-type: text
observed-at: 2026-11-22
ttl: one year
derived-from:
  - user instruction on 2026-11-22 to check the current branch at the start of each new chat or prompt and prefer main for new work
  - user approval on 2026-11-22 to stabilize and publish the proposed common project rule with a one-year review period
---

<a id="new-work-branch"></a>

# Branch Selection for New Work

## Description

Branch checks and the preferred starting branch for new work in the Double project.

## Value

At the start of every new chat and before acting on each new user prompt,
check the active Git branch and working-tree status in the active checkout.
Prefer `main` as the starting branch for new work. When a prompt continues
existing work, retain the branch associated with that work unless the user
requests a switch. Preserve uncommitted changes and existing commits before
switching branches; never discard them to reach `main`. Follow explicit user
branch instructions and applicable Git permissions.

