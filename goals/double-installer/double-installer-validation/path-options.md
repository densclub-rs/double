---
id: double-installer-validation-path-options
kind: path-options
status: release-candidate
template-id: path-options-template
project-id: double
produced-by: machine-of-goals/path-discovery-agent
interaction-language: ru
artifact-language: en
goal-id: double-installer-validation
goal-artifact: ./double-installer-validation.md
parent-goal-id: double-installer
derived-from:
  - ./double-installer-validation.md
---

<a id="double-installer-validation-path-options"></a>

# Path Options: Installer Validation

## 1. Source Goal

- Goal: [Installer Validation](./double-installer-validation.md#double-installer-validation).
- Parent: [Double Installer](../double-installer.md#double-installer), integrated at [S06](../plan.md#stage-s06).
- Target: repeatable local checks, required cross-platform release validation,
  and evidence for the exact installer candidate.
- Constraints: disposable test state; explicit publication authorization; local
  environment availability does not reduce the required release matrix.

## 2. Discovery Scope

- Mode: `research`.
- Context: the goal's platform, lifecycle, release and evidence requirements.
- Limitation: available runners and published assets must be checked for the
  selected candidate; a proposed matrix is not evidence of successful tests.

## 3. Path Options

<a id="path-shared-tests-ci"></a>

### 3.1. Path: Shared Local Scenarios and Hosted CI

- Path id: `path-shared-tests-ci`.
- Path type: hybrid.
- Description: run shared portable scenarios locally on available hosts and
  in GitHub Actions across the required operating-system and architecture
  matrix. Gate release on passing required checks for the exact candidate.
- Why it is plausible: shared entry points let local and hosted checks exercise
  the same scenarios while hosted runners supply broader platform coverage.
- Required resources: test scenarios, disposable projects and state, suitable
  hosted runners, and an authorized release workflow.
- Main risks: unavailable runners, platform-specific behavior, fixture gaps,
  and accidental publication before all required checks pass.
- Expected cost: medium to high; value: repeatable evidence tied to a candidate.
- Unknowns: actual runner availability, candidate coverage and live asset access.
- Reuse / import opportunity: reuse applicable installer test scenarios.
- Lifecycle: included-in-plan.
- Plan element: [local scenarios](./plan.md#stage-s01), [CI matrix](./plan.md#stage-s02)
  and [release gate](./plan.md#stage-s03).
- Recommendation: include-in-plan.

## 4. Comparison

| Path | Fit | Cost | Risk | Uncertainty | Expected value | Recommendation |
| --- | --- | --- | --- | --- | --- | --- |
| [Shared scenarios and hosted CI](#path-shared-tests-ci) | High | Medium–high | Medium | Runner availability | Cross-platform candidate evidence | Include in plan |

## 5. Rejected or Deferred Paths

- Local-only validation cannot establish the required release matrix.
- Duplicating scenario logic in workflow configuration increases divergence;
  shared scenarios remain the preferred interface.
- Linux containers do not establish Windows/Git Bash or macOS behavior.

## 6. Open Questions

None blocking plan review. Runner availability and candidate-specific evidence
must be established during validation.
