---
style: double
submodule: machine-of-goals
id: plan-template
kind: template
status: release-candidate
workflow-stage: plan-synthesis
interaction-language: en
artifact-language: en
derived-from:
  - ../../workflows/machine-of-goals/machine-of-goals-workflow.md
  - ../../../ideas/machine-of-goals/machine-of-goals-principles.md
---

# Template: Plan

```md
---
id: <goal-id>-plan
kind: plan-artifact
produced-by: plan-synthesis-agent
interaction-language: <language-code-or-name-used-for-dialogue>
artifact-language: <language-code-or-name-used-for-this-artifact>
goal-id: <goal-id>
goal-artifact: <path-to-goal-artifact>
plan-role: <canonical-community|personal-variant|imported-variant|experimental-variant|hybrid-variant>
plan-filename: <plan.md-or-plan--author-<author>--device-<device>--time-<YYYYMMDDTHHMMSS>.md>
variant-id: <canonical-or-author-device-time-specific-id>
variant-of: <canonical-plan-id-or-null>
canonical-plan-artifact: <goal-directory>/plan.md
author: <author-or-agent-id-or-null>
device: <device-or-runtime-id-or-null>
created-at: <YYYY-MM-DDTHH:MM:SS+HH:MM-or-null>
updated-at: <YYYY-MM-DDTHH:MM:SS+HH:MM-or-null>
imported-from: <source-plan-artifact-or-package-or-null>
goal-scope: <main-goal|subgoal>
parent-goal-id: <parent-goal-id-or-null>
parent-plan-artifact: <parent-plan-artifact-or-null>
selected-paths:
  - <path-id>
related-plan-variants:
  - <plan-artifact-id-or-path>
existing-plan-implementations:
  - <plan-artifact-id-or-package-path>
derived-from:
  - <goal-artifact-id-or-path>
  - <path-options-id-or-path>
---

# Plan: <Goal Title>

## 1. Plan Summary

Briefly describe the plan as a transition from current state to target state.

- Goal artifact: `<path-to-goal-artifact>`
- Selected path or hybrid:
- Current state:
- Target state:
- Success criteria:

## 2. Plan Variant Identity

- Plan role: <canonical-community|personal-variant|imported-variant|experimental-variant|hybrid-variant>
- Plan filename: `<plan.md-or-plan--author-<author>--device-<device>--time-<YYYYMMDDTHHMMSS>.md>`
- Canonical plan artifact: `<goal-directory>/plan.md`
- Variant of:
- Author:
- Device / runtime:
- Created at:
- Imported from:
- Active selection status: <candidate|selected|superseded|rejected|promoted-to-canonical>
- Promotion rule: only replace `plan.md` when the user or responsible community process explicitly chooses this variant as the canonical community plan.

## 3. Plan Map

Use this section for fast review, stage topology, and execution status. This is
the single source of stage status and validation status in the plan. `Last
Attempt` values should be Markdown links to files under `./results/` when those
artifacts exist. `Last Attempt Time` records when the most recent realization
attempt for the stage was made.

Status of stage:

- ⚪ not-started
- 🔵 in-progress
- ✅ done
- 🟡 partial
- ⛔ blocked
- ❌ rejected
- 🔁 needs-revision

Validation status:

- ⚪ not-validated
- ✅ accepted
- 🟡 partial
- ⛔ blocked
- ❌ rejected
- 🔁 needs-revision

| Stage | Status | Validation | Inputs | Outputs | Last Attempt | Last Attempt Time |
| --- | --- | --- | --- | --- | --- | --- |
| [S01: <Stage 1 Name>](#stage-s01) | ⚪ not-started | ⚪ not-validated | <goal|path-options|other> | [S02](#stage-s02) | [<attempt-file>.md](./results/<attempt-file>.md) | <YYYY-MM-DDTHH:MM:SS+HH:MM-or-none> |
| [S02: <Stage 2 Name>](#stage-s02) | ⚪ not-started | ⚪ not-validated | [S01](#stage-s01) | [S03](#stage-s03) | <none-or-link> | <none> |

## 4. Blocker

- Blocker: <none|description>
- Owner:
- Needed decision:
- Unblock condition:

## 5. Stage Attempts

- Save attempt artifacts after plan update: <ask-user|yes|no>
- Current attempt count: <number>
- Retention threshold: 10
- Cleanup decision when attempts exceed threshold: ask-user
- Attempt artifact directory: `./results/`

| Stage | Attempt | Artifact | Author | Device | Time | Keep |
| --- | --- | --- | --- | --- | --- | --- |
| <stage-id> | `<attempt-id>` | [<attempt-file>.md](./results/<attempt-file>.md) | <author> | <device> | <YYYY-MM-DDTHH:MM:SS+HH:MM> | <yes|no|ask> |

## 6. Stage Details

<a id="stage-<stage-id>"></a>

### Stage: <Stage Name>

- Stage id: `<stage-id>`
- Status: ⚪ not-started
- Automation level: <manual|interactive|partial|automatic|external>
- Purpose:
- Input state:
- Output state:
- Preconditions:
- Actions:
- Required resources:
- Possible input stages:
  - [<Input Stage Name>](#stage-<input-stage-id>)
- Possible output stages:
  - [<Output Stage Name>](#stage-<output-stage-id>)
- Related subgoal artifacts:
  - [<Subgoal Title>](<path-to-subgoal-artifact>)
- Validation criteria:
- Evidence expected:
- Validation:
  - Status: ⚪ not-validated
  - Confirmed by: <user|agent|external-system|not-needed|none>
  - Confirmed at: <YYYY-MM-DDTHH:MM:SS+HH:MM-or-null>
  - Evidence:
  - Decision:
  - Notes:
- Risks:
- Stop points:

## 7. Shared Dependencies

- Internal dependencies:
- External dependencies:
- Decision dependencies:

## 8. Shared Risks and Controls

- Risk:
- Impact:
- Mitigation:
- Stop condition:

## 9. Automation Boundaries

- Allowed automatic actions:
- Actions requiring confirmation:
- Actions not allowed:
- Dry-run required before:

## 10. Revision Conditions

- Revise stage when:
- Rebuild plan when:
- Reformulate goal when:

## 11. Open Questions

- [ ] <question that affects realization or validation>

```
