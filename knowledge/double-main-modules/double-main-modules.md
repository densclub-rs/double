---
id: double-main-modules
kind: knowledge-artifact
produced-by: machine-of-knowledge/knowledge-extraction-agent
interaction-language: ru
artifact-language: en
type: dynamic
access: free-of-charge
value-type: text
observed-at: 2026-07-19
ttl: one month
retrieval-method: local-command
derived-from:
  - .double/agents/
---

<a id="double-main-modules"></a>

# Main Double Modules

## Description

The main modules that make up the Double project. The value is obtained from
the first-level directories in `.double/agents/`.

## Value

- `double-agent`
- `machine-of-goals`
- `machine-of-ideas`
- `machine-of-knowledge`

## Command

```sh
find .double/agents -mindepth 1 -maxdepth 1 -type d -exec basename {} \; | sort
```
