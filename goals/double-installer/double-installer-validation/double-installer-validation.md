---
id: double-installer-validation
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
  - ../plan.md
  - user instruction in conversation on 2026-10-15
---

<a id="double-installer-validation"></a>

# Goal: Local and Cross-Platform CI Validation of Double Installer

## Summary

Provide development-time local validation on available hosts/VMs and enforced
full GitHub Actions testing before each new installer script version release.
Own validation and installer release execution separately from parent lifecycle implementation.

## Parent Integration

Parent [Double Installer](../double-installer.md#double-installer) delegates
[S06](../plan.md#stage-s06) to this [plan](./plan.md#double-installer-validation-plan).
Input: current scripts/double-installer.sh, tests/ scenarios, accepted parent
S01–S05 and S05R evidence. Output: accepted platform matrix, exact CI commit/run
links, live release and cron evidence, documented usage and release gate.
CI04 prepares installer release tooling; CI05 validates the exact candidate,
publishes an explicitly authorized prerelease and tests its downloaded assets
and cron in disposable environments. CI06 consolidates evidence and returns
to parent final validation. Existing machine-release smoke alone does not
prove installer publication.

## Current State

Local macOS and Linux aarch64 fixture suites have historical passing evidence;
local Windows and hosted matrix are unverified. Tests now reside in root tests/;
repository utilities remain in root scripts/. src/ software tests are separate.
No CI workflow or hosted success is claimed by this extraction.

## Target State and Success Criteria

- Local test availability is explicit by developer-host OS and available VMs;
  an unavailable local target is reported, not counted as success.
- Installer CI covers Linux/macOS/Windows Git Bash on x86_64 and ARM64.
- Shared tests/ scenarios, applicable repository regressions, Windows-specific
  behavior, published-package smoke and disposable Linux real cron checks pass.
- Every new installer version release is gated by required passing CI results
  for the exact candidate commit. No silent skip or continue-on-error coverage.
- Tool/runner versions, actual execution architecture and logs are retained.
- Reusable documentation is preserved through Machine of Knowledge; fixtures
  remain distinguished from real releases and scheduler execution.

## Boundaries

Preserve existing accepted evidence and Podman knowledge's macOS version scope.
Use disposable projects/state/runners; no live user-project/host-cron mutation,
VM deletion or machine-version changes. Installer release publication is
confined to CI05 after explicit first-version/tag authorization. Dependencies in
hosted ephemeral runners may be prepared within reviewed workflow scope.

## Open Questions

None blocking goal/plan review. Implementation must resolve concrete runner
availability, release-gate integration and smoke tag without reducing coverage.

## Machine of Goals Artifacts

Current step: 05-plan-realization; mode: execution; agent:
plan-realization-agent. [Plan](./plan.md#double-installer-validation-plan),
[path options](./path-options.md#double-installer-validation-path-options).
Interactive CI realization revision 1 and baseline 1 are registered; first run
started for CI01. See the plan registry.
