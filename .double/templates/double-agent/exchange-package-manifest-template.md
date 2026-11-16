---
style: double
submodule: double-agent
id: exchange-package-manifest-template
kind: template
status: release-candidate
derived-from:
  - ../../workflows/double-agent/exchange-package-workflow.md
---

# Template: Exchange Package Manifest

Create `manifest.yaml` at the package root. Choose the example matching the
content type, replace placeholders with actual values and omit optional fields
when absent. The [version 1 schema](./exchange-package-manifest.schema.json)
defines the structural fields; package validation also checks file references
and relationships that JSON Schema cannot establish.
Paths are relative to the package root. A realization's `path` may be a file or
a directory; `entrypoint`, when present, names an existing file inside the package.
There is no `files` inventory: `SHA256SUMS` records package file integrity.

## Goal Package

```yaml
schema-version: 1
package:
  id: <package-id>
  version: <package-version>
  type: goal
  title: <title>
  summary: <summary>
  language: <language>
  public-url: <optional-public-goal-or-catalog-url>
content:
  goal:
    id: <goal-id>
    path: <goal-file>
  plans:
    - id: <plan-id>
      path: <main-plan-file>
      revision: <plan-revision>
  sharing-realizations:
    - id: <manual-realization-id>
      type: manual
      plan-id: <plan-id>
      path: <manual-realization-file-or-directory>
      documentation: <documentation-file>
    - id: <automatic-realization-id>
      type: automatic
      plan-id: <plan-id>
      path: <realization-file-or-directory>
      entrypoint: <entrypoint-file>
      documentation: <documentation-file>
      execution:
        kind: <shell-or-python-or-other-kind>
      requires:
        - capability: python-runtime
          version: ">=3.11"
          check:
            command: [python3, --version]
            version-pattern: 'Python ([0-9]+(?:\.[0-9]+)*)'
  provides:
    - capability: <capability-id>
```

Include only selected plans and realizations; omit `sharing-realizations` when
none are selected, and `documentation` or `execution` details when absent.
Omit `public-url`, `requires` and `provides` when not applicable. A `requires`
entry applies to its realization; `provides` describes a capability achieved by
the goal, not proof it exists on the current machine. Checks use an argument
array without shell interpolation; `version-pattern` captures the version in its
first group. For schema version 1, version constraints use `>=` followed by
dot-separated nonnegative integers, and comparisons pad missing components with
zeros. Report an unparseable version or an unsupported constraint as unknown.
Only run checks after an explicit check request; show the exact argument array.
Package version is independent of plan revision. Do not create separate frozen
plans merely for sharing realizations; preserve captured conditions and provenance.

## Idea Package

```yaml
schema-version: 1
package:
  id: <package-id>
  version: <package-version>
  type: idea
  title: <title>
  summary: <summary>
  language: <language>
content:
  idea:
    id: <idea-id>
    path: <idea-file>
  related-artifacts:
    - id: <artifact-id>
      path: <artifact-file>
```

Omit `related-artifacts` if none are selected. The manifest describes portable
content, not installation paths, installation state or execution history.
Execution variants beyond their kind and installation procedures remain to be designed.
