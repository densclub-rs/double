---
id: podstart
kind: plan-model
status: release-candidate
template-id: plan-model-template
project-id: double
produced-by: machine-of-goals/plan-synthesis-agent
interaction-language: ru
artifact-language: en
goal-id: podman-krunkit-fix
branch: main
plan-revision: 3
derived-from:
  - ./podman-krunkit-fix.md
  - ./path-options.md
---

<a id="podstart"></a>

# Plan: Reusable Podman VM Startup / main

Goal: [Reusable Podman VM Startup](./podman-krunkit-fix.md#podman-krunkit-fix).
Paths: [Path options](./path-options.md#podman-krunkit-fix-path-options).

## Model

- Initial state: inspect the selected host, installed Podman, machine state and data before action.
- Target state and success criteria: see the linked goal; verify all applicable conditions before acceptance.
- Evidence: prefer documentary evidence; an explicit user statement may be recorded as a fallback.

## Selection and Control Boundaries

- Review this model and select any applicable path and entry before execution.
- Stop for missing inputs, unsafe operations, unavailable evidence or actions outside the authorized scope.
- Publication, host changes and real installations require explicit authorization.

- Choose [libkrun](./path-options.md#path-restore-libkrun) or [applehv](./path-options.md#path-applehv), or proceed to S03 if a suitable machine is already usable.
- Parent entry: optional [S05R](../plan.md#stage-s05r), only when Podman is selected and preparation is needed. Return VM readiness and evidence to the parent for its [S06](../plan.md#stage-s06) validation; other environments do not depend on this subgoal.

## Stages

| Stage | Input | Output | Next |
| --- | --- | --- | --- |
| [S01: Inspect the host and machine](#stage-s01) | Podman and caller context are available. | The selected machine, data boundaries and applicable paths are established. | S02A, S02B or S03 |
| [S02A: Restore the libkrun runtime](#stage-s02a) | S01 diagnosis and explicit approval of the libkrun path are available. | The selected runtime and helper are compatible and available. | S03 |
| [S02B: Prepare an applehv machine](#stage-s02b) | S01 diagnosis and explicit approval of the applehv path are available. | The selected machine and provider prerequisites are established and existing data is preserved. | S03 |
| [S03: Start and validate the machine](#stage-s03) | A suitable machine and provider are available from S01 or a selected S02 path. | Startup or an already-running state is verified with machine and provider identification. | S04 |
| [S04: Return the result](#stage-s04) | The startup result and evidence from S03 are available. | The caller can assess the VM readiness without inferring installer validation. | End |

<a id="stage-s01"></a>

## S01: Inspect the host and machine

Stage slug: `inspect-context`

### Input Conditions

- S01-I01: Podman and caller context are available. Check the applicable goal, prior outputs and authorization.

### Actions

Inspect host, provider, machines and existing data; identify feasible paths without mutation.

### Output Conditions

- S01-O01: The selected machine, data boundaries and applicable paths are established. Verify against documented results or an explicit user statement.

<a id="stage-s02a"></a>

## S02A: Restore the libkrun runtime

Stage slug: `restore-libkrun`

### Input Conditions

- S02A-I01: S01 diagnosis and explicit approval of the libkrun path are available. Check the applicable goal, prior outputs and authorization.

### Actions

Resolve or install the approved helper and configure only the authorized scope while preserving VM data.

### Output Conditions

- S02A-O01: The selected runtime and helper are compatible and available. Verify against documented results or an explicit user statement.

<a id="stage-s02b"></a>

## S02B: Prepare an applehv machine

Stage slug: `prepare-applehv`

### Input Conditions

- S02B-I01: S01 diagnosis and explicit approval of the applehv path are available. Check the applicable goal, prior outputs and authorization.

### Actions

Reuse a suitable machine or prepare an approved separately named machine and resources without changing global defaults.

### Output Conditions

- S02B-O01: The selected machine and provider prerequisites are established and existing data is preserved. Verify against documented results or an explicit user statement.

<a id="stage-s03"></a>

## S03: Start and validate the machine

Stage slug: `verify-startup`

### Input Conditions

- S03-I01: A suitable machine and provider are available from S01 or a selected S02 path. Check the applicable goal, prior outputs and authorization.

### Actions

Start the selected VM if needed and inspect its running state; stop on errors.

### Output Conditions

- S03-O01: Startup or an already-running state is verified with machine and provider identification. Verify against documented results or an explicit user statement.

<a id="stage-s04"></a>

## S04: Return the result

Stage slug: `handoff`

### Input Conditions

- S04-I01: The startup result and evidence from S03 are available. Check the applicable goal, prior outputs and authorization.

### Actions

Document the usable entry point, applicable host context and evidence for the caller.

### Output Conditions

- S04-O01: The caller can assess the VM readiness without inferring installer validation. Verify against documented results or an explicit user statement.
