---
id: double-installer-validation-path-options
kind: path-options
template-id: path-options-template
project-id: double
produced-by: machine-of-goals/path-discovery-agent
interaction-language: ru
artifact-language: en
goal-id: double-installer-validation
goal-scope: subgoal
parent-goal-id: double-installer
---

<a id="double-installer-validation-path-options"></a>

# Path Options: Installer Validation

[Goal](./double-installer-validation.md#double-installer-validation),
[plan](./plan.md#double-installer-validation-plan), [parent](../plan.md#stage-s06).

<a id="path-shared-tests-ci"></a>

## Shared Local Scenarios and Hosted CI Matrix

User-selected direction: keep portable tests/ entry points runnable locally
and invoke them through GitHub Actions for the required OS/architecture matrix.
Local host/VM coverage is conditional; full release coverage is mandatory.
Interactive repository implementation is proposed for execution; no realization
registered. Runner/source details and release gate belong in the subgoal plan.

## Deferred or Excluded Approaches

Local-only validation cannot satisfy the required release matrix. Duplicating
test logic in workflow YAML is excluded in favor of shared tests/ scenarios.
A Linux container is not Windows/Git Bash or macOS evidence.

## Open Questions

None blocking review. No additional selectable alternative is invented for
an implementation direction already explicitly chosen by the user.

## Approved End-to-End Extension — 2026-10-16

The same selected path now includes CI04 release preparation, CI05 mandatory
tests followed by authorized installer publication and downloaded-asset smoke,
and CI06 final acceptance. No new alternative or automatic realization is
registered. Existing realization requires alignment with plan revision 2.
