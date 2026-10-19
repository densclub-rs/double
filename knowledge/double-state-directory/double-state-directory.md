---
id: double-state-directory
kind: knowledge-artifact
status: stable
produced-by: machine-of-knowledge/knowledge-extraction-agent
interaction-language: ru
artifact-language: en
knowledge-type: static
type: static
value-type: text
access: free-of-charge
observed-at: 2026-10-13
ttl: two years
derived-from:
  - user decision in conversation on 2026-10-13
  - ../../goals/double-installer/double-installer.md
---

<a id="double-state-directory"></a>

# Double State Directory

## Description

The agreed common per-user state directory for Double components, preserved
for reuse beyond the first installer.

## Value

Double uses `~/.local/state/double` as its common per-user state directory,
shared across integrated projects.

The [Double Installer](../../goals/double-installer/double-installer.md#double-installer)
uses this directory for its downloaded release catalog, installation registry,
and backups. Other Double components should use this shared location for
their local state. Component-specific subdirectory names are not prescribed
by this decision.

The path is relative to the user's home directory. For the installer on
Windows, `~` is resolved in the selected Git Bash environment.

This records a project convention, not evidence that a directory or an
installer implementation already exists.

## Sources

The user selected `~/.local/state/double` as the shared directory during
installer goal clarification on 2026-10-13, then explicitly requested that
the decision be preserved as project knowledge for other Double components.
The user confirmed a validity period of two years on the same date.
