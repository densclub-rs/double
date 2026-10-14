---
id: double-agent-version
kind: knowledge-artifact
produced-by: machine-of-knowledge/knowledge-extraction-agent
interaction-language: ru
artifact-language: en
knowledge-type: static
type: static
access: free-of-charge
value-type: text
observed-at: 2026-10-14
ttl: one month
derived-from:
  - knowledge/double-main-modules/double-main-modules.md
  - user-provided project versioning decision
  - user-approved structured-choice interface update on 2026-10-14
---

<a id="double-agent-version"></a>

# Double Agent Version

## Description

The version assigned to the `double-agent` main module of the Double project.

## Value

`0.0.7`

## Change Note

Version `0.0.7` updates the structured-choice interface for approval-mode and per-item choices:

- prefer `request_user_input_async` only when exposed and permitted for the question
- wait for explicit user submission or equivalent direct instruction before
  dependent changes; preselection, silence, timeouts and tool acknowledgements
  do not grant approval
- respect runtime tool/mode restrictions and use a permitted structured
  alternative or concise text fallback when needed
- preserve free-form clarification, existing authorization and workflow gates
