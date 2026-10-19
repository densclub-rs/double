---
id: double-installer-realization-decision
kind: realization-decision
template-id: realization-decision-template
produced-by: machine-of-goals/plan-synthesis-agent
project-id: double
interaction-language: ru
artifact-language: en
goal-id: double-installer
plan-id: double-installer-plan
plan-revision: 12
plan-revision-artifact: ./realizations/plan-revision-12.md
path-options-id: double-installer-path-options
selected-paths:
  - path-direct-release-api
realization-record-id: interactive-rest
selected-realization-id: interactive-development
realization-artifact: ./realizations/interactive-rest.md
path-selection-confirmed-by: user
path-selection-confirmed-at: 2026-10-13T15:03:39Z
derived-from:
  - ./plan.md
  - ./realizations/plan-revision-1.md
  - ./path-options.md
---

<a id="double-installer-realization-decision"></a>

# Realization Decision: Double Installer

## 1. Decision Summary

The user answered “ok” to explicit REST path selection and sequential stage validation.

- Goal: [Double Installer](./double-installer.md#double-installer).
- Baseline: [Plan revision 1](./realizations/plan-revision-1.md#double-installer-plan).
- Shown alternatives: [REST](./path-options.md#path-direct-release-api) and [gh](./path-options.md#path-github-cli-consumer).
- Selected: REST via curl/jq; lower initial setup friction, custom HTTP handling accepted.
- Record: [Interactive development](./plan.md#interactive-rest).
- Realization: [Revision 1](./realizations/interactive-rest.md#interactive-rest-revision-1), ready and aligned.
- First entry: [S01](./plan.md#stage-s01).

## 2. Reasoning

Build one Bash installer; defer the gh branch. No automatic development realization is registered.

## 3. Realization Mode

Interactive repository implementation, execution mode, with stage results submitted for validation.

## 4. Automation Boundaries

Repository changes and isolated fixture checks are allowed. Real project installs, live cron edits, dependency installation, bootstrap changes and publication require separately designated scope.

## 5. Validation Strategy

Use V01–V06 from the pinned plan. Record observed evidence and request user validation of each stage result.

## 6. Stop Points

Stop on unsafe scope, inconsistent state, unavailable required evidence, and when a stage result is ready for validation.

## 7. Revision Conditions

Semantic plan changes require a new immutable revision; procedure changes require a realization revision. No changes to machine versions or operating contracts.

## Continuation Decision

On 2026-10-13T15:31:07Z, the user instructed continuation after the knowledge correction.
Continue with [plan revision 2](./realizations/plan-revision-2.md#double-installer-plan)
and [realization revision 2](./realizations/interactive-rest.md#interactive-rest-revision-2),
starting at S03 with unchanged boundaries. Earlier revision-1 decision context above is retained.

## Revision-3 Continuation Decision

At 2026-10-14T16:18:25Z, the user approved synchronization, realization alignment and
opening a new parent run. Current binding: [plan revision 3](./realizations/plan-revision-3.md#double-installer-plan),
[realization revision 3](./realizations/interactive-rest.md#interactive-rest-revision-3).
Selected REST path and manual development mechanism unchanged. Entry: incorporate
accepted S05R handoff, prepare S06 continuation. No actual S06 test execution
or additional host changes authorized by this synchronization instruction.
Earlier decision sections are retained historical context.

2026-10-16: user explicitly approved S05A implementation on the same Direct
API path. Use realization revision 4 and new baseline-6 run, with old runs
unchanged. No release/publication/global host setup is authorized here.

2026-10-17: user authorizes project-scoped agent integration and global add;
same path, baseline 7, realization 5. Local disposable implementation/checks only.

2026-10-17: user clarifies independent agent operations; baseline 8, realization 6.

2026-10-17: user authorizes shared default; baseline 9, realization 7. Pi researched only.

2026-10-17: user authorizes doctor discovery inventory; baseline 10, realization 8.

2026-10-17: user authorizes add discovery/consent; baseline 11, realization 9.

2026-10-19: user authorizes prerelease/adoption consent and directory backups; baseline 12, realization 10.
