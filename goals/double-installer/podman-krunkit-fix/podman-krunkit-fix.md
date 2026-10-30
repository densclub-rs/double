---
id: podman-krunkit-fix
kind: goal-artifact
status: release-candidate
template-id: goal-template
project-id: double
produced-by: machine-of-goals/goal-formulation-agent
owner-id: double-project
interaction-language: ru
artifact-language: en
parent-goal-id: double-installer
derived-from:
  - user instruction in conversation on 2026-10-13
  - user reusable input/output contract in conversation on 2026-10-14
  - https://thomasuebel.de/blog/podman-desktop-on-macos/
---

<a id="podman-krunkit-fix"></a>

# Goal: Restore the Podman Linux Validation Environment

## 1. Summary

Provide a reusable transition from installed Podman to a startable virtual
machine, preserving existing machine data and configuration.

Parent goal: [Double Installer](../double-installer.md#double-installer).
Use [parent S05R](../plan.md#stage-s05r) only when Podman is selected as a
validation environment and its VM requires preparation. Other Linux validation
environments do not depend on this subgoal.

## 2. Subject of the Goal

### Subject

- An installed Podman and the virtual machine selected for a particular run.
- First consumer: the Linux runtime needed to validate Double Installer.

## 3. Motivation

- Resolve Podman startup blockers when they affect a selected environment.
- Obtain Linux execution evidence rather than infer portability from macOS.
- Keep host-environment repair separate from installer product code.

## 4. Current State

### Known facts

- Podman startup depends on the selected host, machine, provider and helper.
- Inspect the actual host and existing VM data before selecting a repair.
- The [supplied article](https://thomasuebel.de/blog/podman-desktop-on-macos/)
  is a research reference, not authorization to delete or recreate a VM.

### Relevant environment

A host with installed Podman and a selected virtual machine.

### Existing related goals or subgoals

- [Double Installer](../double-installer.md#double-installer) — accepted parent;
  Linux validation is the consumer of this subgoal's result.

## 5. Target State

### Input Conditions

- Podman is installed and its CLI can be invoked on the target host.
- The selected host supports a Podman machine provider. Host, Podman version,
  machine name, provider preference, and data-preservation boundaries are
  resolved as invocation context, not hardcoded to the first consumer.
- An existing VM is not mandatory: a run may repair an existing machine or
  initialize one where appropriate, according to its reviewed plan.

### Output Conditions

- The selected Podman VM is startable. Actual startup succeeds and Podman
  reports the selected machine as running; merely changing configuration or
  installing an executable does not establish success.
- The result identifies the machine, provider, host, invocation, and observed
  startup evidence so a caller can continue its own work.

- Required result: a startable Podman VM, demonstrated by successful startup.
- Optional quality improvement: retain the working provider configuration
  across subsequent invocations if a configuration change is required.
- Evidence: recorded diagnosis, selected repair, startup result, Linux runtime
  identity when checked, and the machine/provider/startup entry point.

### Reuse Contract

- A standalone caller supplies installed Podman and invocation context and
  receives the verified VM startup result without needing Double Installer.
- A parent plan may use this goal/plan as a direct reference, with explicit
  entry and exit conditions. Copying or adapting a reusable package goes
  through Plan Exchange when requested.
- Each application creates its own run and checks input and output anew.
  Previous success on another host or machine does not establish current
  readiness. An already-running usable machine is a valid no-repair outcome.
- The future plan and realization must support repeated applications and
  preserve per-run evidence. Reusability does not itself register an automatic
  realization or determine `single-pass` versus `multi-pass` style.

## 6. Success Criteria

- Minimal success: installed Podman is verified, VM startup succeeds, running
  state is observed, and the caller receives the startup entry point.
- High-quality success: the procedure is repeatable, a Linux command succeeds,
  and existing user VM data is preserved.
- Partial success: the provider or executable issue is diagnosed, but the VM
  or Linux test entry point remains unusable.
- Failure / not achieved: startup still fails, no VM running-state evidence is
  available, or existing VM data is destroyed without an approved disposition.

## 7. Constraints

- Time: each caller defines its schedule; parent validation needs this result
  only when it depends on the selected Podman environment.
- Attention/cost: prefer a minimal local repair; no new subscription required.
- Technical: inspect the actual installation, PATH, provider configuration,
  and existing VM state before selecting the remedy.
- Data preservation: preserve existing VM contents and configuration. Machine
  deletion/recreation requires an explicit data-preservation decision before
  execution; the supplied article is not authorization to delete user data.
- Scope: do not change Double machine versions or operating artifacts.

## 8. Resources

- Installed Podman CLI and existing machine configuration.
- [Supplied solution article](https://thomasuebel.de/blog/podman-desktop-on-macos/).
- Missing resources to establish during research: provider/runtime availability,
  VM data inventory, safe repair alternatives and required installation scope.

## 9. Open Questions

None blocking path discovery. Repair selection and any data-destructive
operation remain subject to research, plan review and explicit authorization.

## 10. Boundaries / Non-Goals

- No installer feature development or Windows setup in this subgoal.
- No automatic application of the article's deletion/recreation commands.
- No host Docker migration or unrelated container workload changes.
- The caller owns workload-specific tests and dependencies. Parent S06 owns
  installer test-tool setup, platform validation and final acceptance; this
  subgoal supplies a startable VM and its evidence.

## 11. Machine of Goals Artifacts

Possible paths: [Path options](./path-options.md#podman-krunkit-fix-path-options).

| Branch | Review revision | Plan |
| --- | --- | --- |
| main | 3 | [Plan](./plan.md#podstart) |
