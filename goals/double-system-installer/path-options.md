---
id: double-system-installer-path-options
kind: path-options
template-id: path-options-template
project-id: double
produced-by: machine-of-goals/path-discovery-agent
interaction-language: ru
artifact-language: en
goal-id: double-system-installer
goal-artifact: ./double-system-installer.md
parent-goal-id: null
derived-from:
  - ./double-system-installer.md
  - ../../knowledge/double-installer/double-installer.md
  - ../../scripts/double-installer-release.sh
---

<a id="double-system-installer-path-options"></a>

# Path Options: Double System Installer

## 1. Source Goal

- Goal: [Double System Installer](./double-system-installer.md#double-system-installer)
- Parent goal: none.
- Current state: the installer script and its release packaging exist; a system bootstrap is not established by the goal.
- Target state: a shell bootstrap installs a supported distribution entry point for a user or system, displays instructions, and does not launch it.
- Success criteria: usable separate invocation across Linux, macOS, and Git Bash on Windows, with both installation scopes and a boundary adaptable to future distributions.
- Constraints: keep downstream machine management in the installed distribution; future TypeScript support is not an implementation commitment.

## 2. Discovery Scope

- Mode: `research`.
- Sources inspected: the goal, [Double Installer knowledge](../../knowledge/double-installer/double-installer.md#double-installer), the local [release script](../../scripts/double-installer-release.sh), and its [workflow](../../.github/workflows/double-installer.yml).
- Existing analogs checked: the repository's installer release packaging publishes the installer script and a SHA-256 checksum; the knowledge artifact records a historical published release.
- Known limitations: current remote release availability and platform-specific installation locations were not verified. A checksum from the same source detects corruption but is not independent authentication.

## 3. Path Options

<a id="release-asset-bootstrap"></a>

### 3.1. Path: Bootstrap from a published release asset

- Path id: `release-asset-bootstrap`
- Path type: direct
- Description: a small shell bootstrap selects an appropriate installer release, retrieves its script and checksum, checks the download, installs it for the selected scope, and prints its invocation instructions.
- Why it is plausible: existing release packaging already produces the script and checksum; a distribution-specific boundary can accommodate future variants.
- Required resources: a published bootstrap entry point and installer release assets, supported shell and download/checksum tools, and platform test environments.
- Main risks: release/channel selection, replacement and permission behavior, PATH differences, and ensuring failures do not leave a misleading installation.
- Expected cost: medium; expected value: high.
- Unknowns: release policy, locations, dependency handling and update/reinstall behavior are planning decisions.
- Reuse / import opportunity: reuse the existing release assets and test infrastructure; no plan import identified.
- Lifecycle: `included-in-plan`; plan element: [distribution contract](./plan.md#stage-s01); recommendation: `include-in-plan`.

<a id="versioned-bundle-bootstrap"></a>

### 3.2. Path: Bootstrap from a versioned distribution bundle

- Path id: `versioned-bundle-bootstrap`
- Path type: hybrid
- Description: publish a versioned bundle and distribution description, then have the bootstrap retrieve and install the selected bundle's entry point.
- Why it is plausible: a bundle can carry additional files if a later distribution requires them.
- Required resources: bundle format, publication and validation support, bootstrap and platform test environments.
- Main risks: additional packaging and extraction complexity, especially for the initial single-script variant.
- Expected cost: high; expected value: medium.
- Unknowns: future distributions and their dependencies are not defined.
- Reuse / import opportunity: existing release automation is a starting point; no reusable plan identified.
- Lifecycle: `discovered`; plan element: none; recommendation: `keep-as-alternative`.

<a id="repository-source-bootstrap"></a>

### 3.3. Path: Bootstrap from a pinned repository source

- Path id: `repository-source-bootstrap`
- Path type: minimal
- Description: retrieve the installer script from a specified repository revision and install it in the chosen scope.
- Why it is plausible: the script is present in the repository and a fixed revision can identify the source.
- Required resources: a published bootstrap, accessible repository source, a revision selection policy and platform tests.
- Main risks: source retrieval bypasses the existing release-asset packaging and requires an explicit integrity and release selection policy.
- Expected cost: low to medium; expected value: medium.
- Unknowns: whether source revisions are an acceptable distribution contract and how to verify them.
- Reuse / import opportunity: reuse the existing script and repository; no reusable plan identified.
- Lifecycle: `discovered`; plan element: none; recommendation: `keep-as-alternative`.

## 4. Comparison

| Path | Fit | Cost | Risk | Uncertainty | Expected Value | Recommendation |
| --- | --- | --- | --- | --- | --- | --- |
| [Release asset](#release-asset-bootstrap) | high | medium | medium | medium | high | include in plan |
| [Versioned bundle](#versioned-bundle-bootstrap) | medium | high | medium | high | medium | keep as alternative |
| [Pinned source](#repository-source-bootstrap) | medium | low | medium | medium | medium | keep as alternative |

These are distribution alternatives for one goal. Discovery does not establish a need for independent parallel plans; synthesis can represent a selected approach and relevant alternatives within one model.

## 5. Rejected or Deferred Paths

- A TypeScript agent distribution is deferred until its distribution contract exists; the goal does not commit to implementing it.
- Launching the installed installer automatically is outside the goal.

## 6. Open Questions

None blocking plan synthesis. Release and channel selection, bootstrap hosting, installation locations, permissions, dependencies, integrity, replacement behavior and platform validation remain decisions and checks for planning and review.
