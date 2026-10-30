---
id: double-installer-validation
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
[S06](../plan.md#stage-s06) to this [plan](./plan.md#installproof).
Input: the current installer candidate, applicable scenarios and selected
validation environments. Output: test results, platform coverage, candidate
identity, release-gate status and explicit gaps. If publication is authorized,
include published-asset verification. Otherwise return available validation
results while retaining publication as an outstanding goal criterion.

## Current State

The installer and test infrastructure exist. Inspect their current behavior,
runner availability and release gate before selecting the checks to perform.

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

Use disposable projects/state/runners; no live user-project/host-cron mutation,
VM deletion or machine-version changes. Installer release publication is
requires explicit version/tag authorization. Dependencies in
hosted ephemeral runners may be prepared within reviewed workflow scope.

## Open Questions

None blocking goal/plan review. Implementation must resolve concrete runner
availability, release-gate integration and smoke tag without reducing coverage.

## Machine of Goals Artifacts

Possible paths: [Path options](./path-options.md#double-installer-validation-path-options).

| Branch | Review revision | Plan |
| --- | --- | --- |
| main | 7 | [Plan](./plan.md#installproof) |
