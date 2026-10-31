---
id: container-runtime-fallback
kind: knowledge-artifact
status: stable
produced-by: machine-of-knowledge/knowledge-extraction-agent
interaction-language: ru
artifact-language: en
type: static
access: free-of-charge
value-type: text
observed-at: 2026-10-31
ttl: one year
derived-from:
  - user instruction on 2026-10-31 to use Podman when Docker is unavailable
  - user decision on 2026-10-31 to review this rule after one year
---

<a id="container-runtime-fallback"></a>

# Container Runtime Fallback

## Description

Project-wide preference for container-based work when Docker is unavailable.

## Value

When Docker is unavailable, use Podman for compatible container-based project
work. Check Podman's availability and the requirements of the specific task;
report any remaining blocker rather than assuming that Docker and Podman are
interchangeable in every case.
