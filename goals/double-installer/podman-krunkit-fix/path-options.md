---
id: podman-krunkit-fix-path-options
kind: path-options
status: release-candidate
template-id: path-options-template
project-id: double
produced-by: machine-of-goals/path-discovery-agent
interaction-language: ru
artifact-language: en
goal-id: podman-krunkit-fix
goal-artifact: ./podman-krunkit-fix.md
parent-goal-id: double-installer
derived-from:
  - ./podman-krunkit-fix.md
---

<a id="podman-krunkit-fix-path-options"></a>

# Path Options: Startable Podman VM

## 1. Source Goal

- Goal: [Podman krunkit Fix](./podman-krunkit-fix.md#podman-krunkit-fix).
- Parent: [Double Installer](../double-installer.md#double-installer),
  [S05R](../plan.md#stage-s05r), before S06.
- Input: installed Podman; output: a VM with successful startup/running-state evidence.
- Reuse: standalone or referenced by other plans; inspect each host/machine anew.
- Constraints: preserve existing data; no unreviewed VM deletion/recreation.

## 2. Discovery Scope

- Mode: research, 2026-10-14.
- Inspect the current host, provider helpers, machine inventory and data before
  choosing or applying a path.
- Primary sources: [Podman machine providers](https://docs.podman.io/en/stable/markdown/podman-machine.1.html),
  [machine initialization](https://docs.podman.io/en/stable/markdown/podman-machine-init.1.html),
  and [krunkit installation](https://github.com/libkrun/krunkit#installation).
- User-supplied analog: [Thomas Uebel's applehv solution](https://thomasuebel.de/blog/podman-desktop-on-macos/).
- Limitations: applicability depends on the actual host, provider helpers, VM
  data and available dependencies; verify them for each invocation.

## 3. Path Options

<a id="path-restore-libkrun"></a>

### 3.1. Restore the Existing libkrun Runtime

- Path id: `path-restore-libkrun`; type: minimal.
- Description: inspect installed runtime/helper paths; correct resolution if
  krunkit exists, otherwise install the supported krunkit runtime dependencies,
  then start the existing selected VM. No VM deletion is part of this path.
- Plausibility: upstream krunkit documents a Homebrew installation with its
  libkrun dependencies; this path addresses a missing helper when applicable.
- Resources: installed Podman, package manager/network if runtime is absent,
  installation authority, and preserved current VM configuration.
- Risks: runtime/package compatibility or later startup errors; installing a
  helper solves the observed error but is not itself success evidence.
- Cost: low to medium; value: preserve existing VM and its data.
- Unknowns: actual helper availability and post-repair startup behavior;
  resolve by read-only inspection and validation in the reviewed realization.
- Reuse: diagnose first on every invocation; no-op success for a suitable
  already-running VM; install only when needed and authorized.
- Lifecycle: included-in-plan; plan element: [Restore libkrun](./plan.md#stage-s02a).
- Recommendation: include-in-plan as a candidate when preserving the existing VM is feasible.

<a id="path-applehv"></a>

### 3.2. Use an applehv Machine

- Path id: `path-applehv`; type: alternative.
- Description: inspect applehv helper availability and create/start a separately
  named VM with the explicitly selected provider, preserving the old VM. The
  article's default-machine replacement remains an optional, separately reviewed
  variant requiring a data-preservation decision.
- Plausibility: official Podman docs list applehv and provider selection, and
  the supplied article uses applehv for this error.
- Resources: supported macOS/provider helper, image download, disk/memory,
  and authority for a new VM/configuration changes.
- Risks: additional VM/storage, missing provider helper, new rather than migrated
  workload state; do not claim the existing VM's data migrated automatically.
- Cost: medium; value: running VM without the missing libkrun helper.
- Unknowns: current helper/configuration availability and workload compatibility;
  these need validation before reporting success.
- Reuse: machine name/provider are invocation context; preserve caller-owned
  defaults and data unless a separate change is explicitly selected.
- Lifecycle: included-in-plan; plan element: [Prepare applehv](./plan.md#stage-s02b).
- Recommendation: keep-as-alternative when applehv is supported.

## 4. Comparison

| Path | Fit | Cost | Risk | Uncertainty | Value | Recommendation |
| --- | --- | --- | --- | --- | --- | --- |
| [Restore libkrun](#path-restore-libkrun) | High | Low–medium | Medium | Medium | Existing VM preserved | First candidate |
| [applehv](#path-applehv) | High | Medium | Medium | Medium | Alternative startable VM | Alternative |

Both paths require host-specific diagnosis and explicit selection before action.

## 5. Rejected or Deferred Paths

- Blind deletion of the existing default VM: excluded without a data decision.
- Replacing Podman with Docker: outside the installed-Podman input contract.
- Building a container/test environment: caller work after VM startup, not
  part of the reusable goal's required output.

## 6. Open Questions

None blocking plan synthesis. User path selection is required at plan review;
host/package inspection and actual startup are future stage work.
