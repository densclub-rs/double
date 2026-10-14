---
id: machine-of-goals-version
kind: knowledge-artifact
status: release-candidate
produced-by: knowledge-extraction-agent
interaction-language: ru
artifact-language: en
knowledge-type: static
access: free-of-charge
value-type: text
observed-at: 2026-10-14
ttl: one month
derived-from:
  - knowledge/double-main-modules/double-main-modules.md
  - ideas/machine-of-goals/machine-of-goals.md
  - .double/workflows/machine-of-goals/machine-of-goals-workflow.md
  - user-provided project versioning decision
---

<a id="machine-of-goals-version"></a>

# Machine of Goals Version

## Description

The version assigned to the `machine-of-goals` main module of the Double
project.

## Value

`0.0.7`

## Change Note

Version `0.0.7` fixes the Machine of Goals release package:

- the integration skill declares `status: release-candidate` in its frontmatter
- release-candidate packages include `.double/skills/machine-of-goals/SKILL.md`
  instead of excluding it because its status is missing
