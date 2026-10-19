---
id: podman-krunkit-fix-realization-decision
kind: realization-decision
template-id: realization-decision-template
produced-by: machine-of-goals/plan-synthesis-agent
project-id: double
interaction-language: ru
artifact-language: en
goal-id: podman-krunkit-fix
plan-id: podman-krunkit-fix-plan
plan-revision: 1
plan-revision-artifact: ./plan-revision-1.md
path-options-id: podman-krunkit-fix-path-options
selected-paths:
  - path-restore-libkrun
realization-record-id: interactive-libkrun
selected-realization-id: interactive-libkrun-procedure
realization-artifact: ./interactive-libkrun.md
path-selection-confirmed-by: user
path-selection-confirmed-at: 2026-10-14T14:20:33Z
derived-from:
  - ./plan.md
  - ./path-options.md
---

<a id="podman-krunkit-fix-realization-decision"></a>

# Realization Decision: Restore libkrun

## 1. Decision Summary

The user confirmed the libkrun candidate after review of the two paths and proposed interactive procedure.

- [Goal](../podman-krunkit-fix.md#podman-krunkit-fix).
- [Baseline](./plan-revision-1.md#podman-krunkit-fix-plan), current plan has no applicable post-baseline changes.
- Selected [libkrun](../path-options.md#path-restore-libkrun); [applehv](../path-options.md#path-applehv) deferred.
- [Registry](../plan.md#interactive-libkrun), [realization revision 1](./interactive-libkrun.md#interactive-libkrun-revision-1).
- First stage: [S01](../plan.md#stage-s01). Readiness ready; alignment aligned.

## 2. Reasoning

Preserve existing VM; inspect runtime/helper resolution before proposing package changes. No destructive fallback.

## 3. Realization Mode

Reusable interactive procedure. Each invocation gets a separate run and frozen stage contracts.

## 4. Automation Boundaries

S01 read-only diagnosis and repository evidence authorized. No installation, configuration changes, VM deletion or recreation in S01. Later host operations must fit explicit reviewed scope and sandbox permissions.

## 5. Validation Strategy

V01–V04 from the baseline. Capture each stage contract before action, observed evidence and user acceptance.

## 6. Stop Points

Stop when stage evidence is ready for validation or host-change scope is not approved; no automatic path change.

## 7. Revision Conditions

Preserve baseline and previous run evidence. Future-only edits use the change log; changed frozen obligations require a new baseline before action.
