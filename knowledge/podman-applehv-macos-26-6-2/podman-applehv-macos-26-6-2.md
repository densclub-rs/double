---
id: podman-applehv-macos-26-6-2
kind: knowledge-artifact
template-id: knowledge-template
status: stable
produced-by: machine-of-knowledge/knowledge-extraction-agent
interaction-language: ru
artifact-language: en
knowledge-type: static
type: static
value-type: text
access: free-of-charge
observed-at: 2026-10-14
ttl: one year
derived-from:
  - https://github.com/densclub-rs/double/blob/double-installer-0.1.5-rc/goals/double-installer/podman-krunkit-fix/run/interactive-applehv--20261014T160319Z.md
  - user command outputs and acceptance in conversation on 2026-10-14
---

<a id="podman-applehv-macos-26-6-2"></a>

# Podman applehv Startup on macOS 26.6.2

## Description

A version-scoped, observed startup solution, preserved as a static record of
this test. It is not a claim of current VM state or general compatibility.

## Value

On the tested macOS 26.6.2 (build 25G83) host, Podman 6.1.0 with bundled vfkit
v0.6.4 successfully initialized and started a separate applehv VM using
quay.io/podman/machine-os:6.1. The user accepted the startup result. The previous
libkrun path did not satisfy startup validation on this invocation; its root
cause remains unresolved and universal libkrun incompatibility is not established.

The VM double-applehv has 2 CPUs, 2048 MiB memory, 20 GiB virtual disk and
rootless mode. Start returned its success message; subsequent inspect reported
running and the expected resources. The initially empty connection registry
acquired double-applehv as its default; the root connection is not default.
Docker socket helper installation and rootful mode were not needed for this
minimal Podman VM startup result. Container execution and Linux installer tests
were not part of this validation.

## Reusable Procedure

Input: installed Podman, a supported host, usable vfkit and reviewed resource
and data boundaries. Inspect current machines, processes and connections first.
Existing VM data must not be discarded; use a separate unused name. The tested
commands below create persistent storage and may download an image; they are
not authorization to replay. Resolve resources/name/default policy per caller.

```bash
podman machine init --provider applehv --cpus 2 --memory 2048 --disk-size 20 double-applehv
podman machine start double-applehv
podman machine inspect double-applehv
podman system connection list
```

Success requires completed startup and running-state evidence. A running
hypervisor with a hanging start is insufficient. Do not repeat init against an
existing name or restart a suitable already-running VM unnecessarily.

## Applicability and Limits

Verified only on this host with macOS 26.6.2 (25G83), Podman 6.1.0 and vfkit
v0.6.4. Other macOS versions/builds, architectures and hosts require fresh
validation; TTL cannot extend this compatibility scope. No old VM migration,
old disk preservation or package cleanup was verified. Before the applehv test,
registered machine and connection lists were empty; why old registrations
were absent was not established.

## Sources

[Accepted invocation evidence](https://github.com/densclub-rs/double/blob/double-installer-0.1.5-rc/goals/double-installer/podman-krunkit-fix/run/interactive-applehv--20261014T160319Z.md#podman-krunkit-fix-run-interactive-applehv--20261014T160319Z).
The OS version/build was verified with sw_vers; host command outputs were
supplied by the user. No source recommendation substitutes for observed evidence.

## Trust Horizon

The user selected one year from observed-at (2026-10-14), ending 2027-10-14.
This does not broaden the tested platform scope or guarantee future runtime
state. Revalidate after relevant OS/provider/Podman changes.
