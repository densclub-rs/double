---
id: machine-of-ideas-version
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

<a id="machine-of-ideas-version"></a>

# Machine of Ideas Version

## Description

The version assigned to the `machine-of-ideas` main module of the Double
project.

## Value

`0.2.5`

## Change Note

Version `0.2.5` updates the structured-choice interface for mode, target, review-scope and transition choices:

- prefer `request_user_input_async` only when exposed and permitted for the question
- wait for explicit user submission or equivalent direct instruction before
  dependent changes; preselection, silence, timeouts and tool acknowledgements
  do not grant approval
- respect runtime tool/mode restrictions and use a permitted structured
  alternative or concise text fallback when needed
- preserve free-form clarification, existing authorization and workflow gates
