---
style: double
submodule: double-agent
id: exchange-registry-template
kind: template
status: release-candidate
derived-from:
  - ../../workflows/double-agent/exchange-package-workflow.md
---

# Template: Exchange Discovery Registry

A local or remote discovery registry lists published ideas and goals; it is
independent of the installation registry. Descriptions explain what each item
offers and when an agent should consider it. Source, publication version and
links belong to the registry entry and do not imply local installation.

```yaml
schema-version: 1
entries:
  - id: install-python
    type: goal
    title: Install Python
    description: >-
      Install and verify a Python runtime. Use when a selected realization
      requires Python and the available version is missing or insufficient.
    version: "1.0.0"
    provides:
      - capability: python-runtime
    platforms: [linux, macos]
    links:
      page: https://example.org/goals/install-python
      package: https://example.org/packages/install-python.double.zip
  - id: python-environments
    type: idea
    title: Isolated Python Environments
    description: >-
      Explore approaches to isolating Python runtimes and project dependencies.
    version: "1.0.0"
    links:
      page: https://example.org/ideas/python-environments
```

Match goal `provides.capability` against the selected realization's required
capability exactly. Treat a match as a candidate: inspect version, platform and
realization applicability before recommending it. Ideas are informational and
do not satisfy a requirement. An inaccessible or invalid registry is unknown,
not an empty result. Never execute or install a discovered candidate without
the user's decision.
