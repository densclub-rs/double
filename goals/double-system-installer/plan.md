---
id: doublebootstrap
kind: plan-model
template-id: plan-model-template
project-id: double
produced-by: machine-of-goals/plan-synthesis-agent
interaction-language: ru
artifact-language: en
goal-id: double-system-installer
branch: main
plan-revision: 2
derived-from:
  - ./double-system-installer.md
  - ./path-options.md
---

<a id="doublebootstrap"></a>

# Plan: Double System Installer / main

Goal: [Double System Installer](./double-system-installer.md#double-system-installer)

## Model

- Initial state: a Double Installer script and release packaging exist; a published system bootstrap and its installation contract are not established.
- Target state: a shell bootstrap installs the supported distribution entry point for a user or system and prints instructions for separate invocation.
- Success criteria: the first iteration demonstrates the goal's scope, usability, failure handling and adaptability criteria on Linux and macOS. Evidence must show no automatic launch and a subsequent user-initiated invocation. Windows Git Bash remains required for the overall goal and is deferred to a separately reviewed second iteration; first-iteration completion is partial goal achievement.
- Evidence: prefer source, release records, logs and platform observations; an explicit user statement may be used as an identified fallback where documentary evidence is unavailable.

## Selection and Control Boundaries

- Recommended path: [published release asset](./path-options.md#release-asset-bootstrap), using existing installer packaging. [Versioned bundle](./path-options.md#versioned-bundle-bootstrap) and [pinned repository source](./path-options.md#repository-source-bootstrap) remain alternatives requiring model revision before their execution.
- Entry stage: [S01](#stage-s01). Each subsequent stage requires accepted output of its predecessor.
- First iteration covers Linux and macOS, both user and system scopes. Windows Git Bash support, its system-wide path, PATH handling and platform evidence belong to a second iteration; do not claim the overall goal fully achieved until those requirements are verified and accepted.
- The previous realization's S01 decisions and evidence remain historical; check their applicability against this revision before reusing them. Unconfirmed outputs do not become accepted merely through succession.
- Resolve release selection, hosting, installation locations, permissions, dependencies, integrity and replacement semantics in S01; present material choices for user decision. If these decisions materially change this model, revise and review it before further action.
- Work covers bootstrap, its documentation, tests and necessary release integration. The installed installer retains machine management. Do not automatically launch it, implement future distributions, publish a release, or perform system-wide installation without the applicable separate authorization. Missing tools, unavailable platforms or unsafe/conflicting existing files stop the affected action and are reported.
- Validate each observed stage output before continuing. User consent for the exact model and a separate authorized start are required before execution.

## Stages

| Stage | Input | Output | Next |
| --- | --- | --- | --- |
| [S01: Define Distribution Contract](#stage-s01) | Goal and release evidence | Reviewed distribution and installation decisions | [S02](#stage-s02) |
| [S02: Implement Bootstrap](#stage-s02) | Accepted contract | Bootstrap and documentation | [S03](#stage-s03) |
| [S03: Validate Installation](#stage-s03) | Bootstrap and test environments | Platform and failure evidence | [S04](#stage-s04) |
| [S04: Prepare Distribution](#stage-s04) | Accepted validation evidence | Reviewable publication package and goal assessment | End |

<a id="stage-s01"></a>

## S01: Define Distribution Contract

Stage slug: `define-distribution-contract`

### Input Conditions

- S01-I01: The goal, path catalog and approved model are available; inspect their linked contents.
- S01-I02: The existing installer and release packaging can be inspected; identify actual sources and verify available release assets before relying on them.

### Actions

Inspect release and hosting options and define the initial artifact selection, integrity check, shell/tool requirements, installation paths and invocation for Linux and macOS in each scope. Specify permissions, existing-file and failure behavior, and the boundary for future variants and deferred Windows support. Review applicable decisions and evidence from the predecessor without presenting historical actions as new. Present material choices and obtain decisions before dependent work; document them in the appropriate existing stage record. Do not treat a same-source checksum as independent authenticity proof.

### Output Conditions

- S01-O01: A coherent, user-decided first-iteration contract covers release selection, hosting, tools, integrity, both scopes on Linux and macOS, replacement, failure reporting and separate invocation, and records Windows as deferred; check decisions and sources in the stage record.
- S01-O02: The contract fits the goal and approved model, or a material change is returned to model revision and review; compare it with the linked goal and model.

<a id="stage-s02"></a>

## S02: Implement Bootstrap

Stage slug: `implement-bootstrap`

### Input Conditions

- S02-I01: S01 outputs are verified and accepted; inspect their evidence and decisions.
- S02-I02: Required repository files and development tools are available; inspect the checkout and tool availability.

### Actions

Implement the bootstrap and appropriate release integration against the accepted contract. Document the entry point, dependencies, scope, invocation, failure and integrity limitations. Add meaningful tests for selection, installation, errors, existing files and the no-launch boundary. Preserve unrelated files and downstream installer responsibilities.

### Output Conditions

- S02-O01: Source and documentation implement the accepted contract, including separate invocation; inspect changes against S01 and the goal.
- S02-O02: Relevant automated tests pass or outstanding failures are recorded; inspect test commands and results.

<a id="stage-s03"></a>

## S03: Validate Installation

Stage slug: `validate-installation`

### Input Conditions

- S03-I01: S02 outputs are verified and accepted; inspect source, documentation and test evidence.
- S03-I02: Test environments and safe installation locations are available or their absence is recorded; verify access before action.

### Actions

Exercise documented bootstrap and separate invocation for user and system scopes across Linux and macOS. Check download/setup failure reporting, existing-file handling and no automatic launch. Use isolated test locations or explicit authorization for system changes. Record exact environments, commands and results; distinguish fixture, CI and actual platform evidence. Windows Git Bash is deferred to the second iteration; stop short of claiming it or any other untested environment was verified.

### Output Conditions

- S03-O01: Evidence demonstrates the documented flow, separate invocation and both scopes on Linux and macOS, or explicitly identifies missing evidence; record Windows as deferred and review results against the goal criteria.
- S03-O02: Error and safety behaviors are checked and any failures or limitations are recorded; inspect test and observation results.

<a id="stage-s04"></a>

## S04: Prepare Distribution

Stage slug: `prepare-distribution`

### Input Conditions

- S04-I01: S03 results are verified and accepted, including explicit limitations; inspect stage evidence.
- S04-I02: The release and hosting contract from S01 is available; verify the intended publication inputs.

### Actions

Prepare and check the distribution material and instructions for review. Assess first-iteration results and the goal's success criteria using the evidence, including adaptability of the distribution boundary. Record Windows as an outstanding second-iteration obligation. If publication is needed to satisfy the selected hosting contract, present the exact release and obtain separate authorization before publishing; verify the actual published entry point afterward. Record unmet criteria rather than inferring completion from preparation.

### Output Conditions

- S04-O01: The distribution material and instructions are reviewable and consistent with the accepted contract; inspect artifacts and checks.
- S04-O02: The goal assessment identifies evidence and acceptance for each applicable criterion, including availability of the entry point, or records the precise remaining blocker; compare with the goal and actual release evidence.
