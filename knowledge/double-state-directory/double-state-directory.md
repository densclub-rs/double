---
id: double-state-directory
kind: knowledge-artifact
status: stable
produced-by: machine-of-knowledge/knowledge-extraction-agent
interaction-language: ru
artifact-language: en
type: static
value-type: text
access: free-of-charge
observed-at: 2026-10-13
ttl: two years
derived-from:
  - user decision in conversation on 2026-10-13
  - user-confirmed two-year validity period on 2026-10-13
  - user-requested contract migration and schema on 2026-10-29
  - https://github.com/densclub-rs/double/blob/double-installer-0.1.5-rc/goals/double-installer/double-installer.md
---

<a id="double-state-directory"></a>

# Double State Directory

## Description

The agreed common per-user state directory for Double components, shared
across integrated projects. The path is relative to the user's home directory.
For the installer on Windows, `~` is resolved in the selected Git Bash environment.

The [Double Installer](https://github.com/densclub-rs/double/blob/double-installer-0.1.5-rc/goals/double-installer/double-installer.md#double-installer)
uses this location for its downloaded release catalog, installation registry
and backups. Other Double components use the same location for local state.

## Value

```json
"~/.local/state/double"
```

## Schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "$id": "urn:double:knowledge:double-state-directory",
  "title": "Double State Directory",
  "description": "A local directory path relative to the user's home directory; existence is not implied.",
  "type": "string",
  "minLength": 3,
  "pattern": "^~/",
  "not": {
    "pattern": "[\\r\\n\\u0000]"
  }
}
```
