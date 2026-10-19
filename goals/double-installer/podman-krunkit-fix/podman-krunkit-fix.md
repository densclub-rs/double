---
id: podman-krunkit-fix
kind: goal-artifact
template-id: goal-template
project-id: double
produced-by: machine-of-goals/goal-formulation-agent
owner-id: double-project
interaction-language: ru
artifact-language: en
goal-scope: subgoal
parent-goal-id: double-installer
derived-from:
  - user instruction in conversation on 2026-10-13
  - user reusable input/output contract in conversation on 2026-10-14
  - ../run/interactive-rest--20261013T153107Z.md
  - https://thomasuebel.de/blog/podman-desktop-on-macos/
---

<a id="podman-krunkit-fix"></a>

# Goal: Restore the Podman Linux Validation Environment

## 1. Summary

Provide a reusable transition from an installed Podman to a startable Podman
virtual machine. The first application resolves the missing-`krunkit` startup
failure on the current macOS host so Double Installer validation can continue.

The problem is, while starting virtual machine 

```shell
podman machine start --log-level debug
```

amongst the output, it showed: `Error: exec: "krunkit": executable file not found in $PATH`.

The goal can be realized independently or referenced as a subplan by other
plans. Its reusable input/output contract does not depend on Double Installer,
the current host, or the name `podman-machine-default`.

Parent goal: [Double Installer](../double-installer.md#double-installer).
Complete this subgoal through [parent stage S05R](../plan.md#stage-s05r)
before entering or resuming parent stage S06.

## 2. Subject of the Goal

### Subject

- An installed Podman and the virtual machine selected for a particular run.
- First consumer: the Linux runtime needed to validate Double Installer.

## 3. Motivation

- Remove the concrete environment blocker encountered during S06.
- Obtain Linux execution evidence rather than infer portability from macOS.
- Keep host-environment repair separate from installer product code.

## 4. Current State

### Known facts

- Docker is not running.
- Podman lists `podman-machine-default` as stopped, using the `libkrun`
  provider on the current macOS host.
- Authorized startup failed with `Error: exec: "krunkit": executable file
  not found in $PATH`.
- Existing VM contents and configuration have not been inventoried for repair.
- The user supplied [Thomas Uebel's article](https://thomasuebel.de/blog/podman-desktop-on-macos/)
  as a solution reference. It describes the same error and proposes switching
  to `applehv`, recreating the machine, and persisting the provider setting.
  The article includes machine deletion; it is a candidate procedure, not an
  approved command sequence or proof of suitability for this host.

### Relevant environment

macOS 26.6.2 on Apple Silicon, installed Podman, and the existing stopped VM.

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

- Time: for the first application, complete before parent S06 resumes;
  subsequent callers define their own schedule.
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
- Parent [validation evidence](../run/interactive-rest--20261013T153107Z.md#double-installer-run-interactive-rest-20261013T153107Z).
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

- Current step: `05-plan-realization`; mode: `execution`.
- Responsible agent: `plan-realization-agent`.
- Paths: [Path options](./path-options.md#podman-krunkit-fix-path-options).
- Plan: [Current plan](./plan.md#podman-krunkit-fix-plan).
- Realization registry: [Registry](./plan.md#realization-registry), interactive libkrun registered.
- Decision: [libkrun](./realization-decision.md#podman-krunkit-fix-realization-decision).
- Baseline: [Revision 1](./realizations/plan-revision-1.md#podman-krunkit-fix-plan).
- Realization: [Interactive procedure](./realizations/interactive-libkrun.md#interactive-libkrun).
- Runs: [Run index](./run/index.md#podman-krunkit-fix-run-index).
- Computed plan style: single-pass; reusable invocation contract retained.


## Current Execution Update — 2026-10-14

The libkrun runtime was installed, but the invocation failed startup validation.
The user selected the existing applehv alternative; no working applehv VM has
yet been demonstrated. See [decision](./realization-decision.md#podman-krunkit-fix-realization-decision)
and [plan](./plan.md#plan-change-log). Existing VMs/disks remain preserved;
shutdown of pending libkrun operations is not confirmed. Parent S06 remains gated.


### Verified Platform Scope — Current applehv Result

Successful initialization/startup was observed and user-accepted specifically
on macOS 26.6.2 (build 25G83), Podman 6.1.0, vfkit v0.6.4, machine-os:6.1,
on the current host. Other macOS versions/builds and hosts remain unverified;
reuse requires fresh invocation checks and startup validation. This scope
restricts the observed result, not the reusable plan input contract.


## Accepted Invocation Result

S04 completed and accepted on 2026-10-14. The applehv run succeeded within the
verified platform scope above; the reusable plan is available for fresh
invocations with current checks. [Knowledge](../../../knowledge/podman-applehv-macos-26-6-2/podman-applehv-macos-26-6-2.md#podman-applehv-macos-26-6-2)
has user-selected TTL one year. Parent S05R receives the accepted startup
result; Linux installer tests remain separate S06 work. No old disk recovery or
migration was established by this result.
