---
style: double
submodule: machine-of-goals
id: plan-template
kind: template
status: draft
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
status: draft
produced-by: plan-synthesis-agent
workflow-version: <workflow-version>
interaction-language: <language-code-or-name-used-for-dialogue>
artifact-language: <language-code-or-name-used-for-this-artifact>
current-step: 03-plan-synthesis
current-mode: <planning|review|explain|dry-run>
next-expected-step: 04-plan-review-and-decision
transition-condition: plan project is understandable enough to review and choose realization strategy
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
imported-from: <source-plan-artifact-or-package-or-null>
goal-scope: <main-goal|subgoal>
parent-goal-id: <parent-goal-id-or-null>
parent-plan-artifact: <parent-plan-artifact-or-null>
selected-paths:
  - <path-id>
related-plan-variants:
  - <plan-artifact-id-or-path>
existing-plan-implementations:
  - <plan-state-id-or-path>
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
- Active stage:
- Next expected stage:

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

Use this section for fast review and mindmap visualization. Each stage is a
TODO item linked to its detailed section. Inputs, outputs, and subgoals are
listed as nested links.

- [ ] [S01: <Stage 1 Name>](#stage-s01)
  - outputs: [S02](#stage-s02), [S03](#stage-s03)
  - subgoals: [<Subgoal Title>](<path-to-subgoal-artifact>)
- [ ] [S02: <Stage 2 Name>](#stage-s02)
  - inputs: [S01](#stage-s01)
  - outputs: [S04](#stage-s04)
- [ ] [S03: <Stage 3 Name>](#stage-s03)
  - inputs: [S01](#stage-s01)
  - outputs: [S04](#stage-s04)

## 4. Stage Details

<a id="stage-<stage-id>"></a>

### Stage: <Stage Name>

- Stage id: `<stage-id>`
- Status: <not-started|in-progress|done|blocked|rejected>
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
- Risks:
- Stop points:

## 5. Shared Dependencies

- Internal dependencies:
- External dependencies:
- Decision dependencies:

## 6. Shared Risks and Controls

- Risk:
- Impact:
- Mitigation:
- Stop condition:

## 7. Automation Boundaries

- Allowed automatic actions:
- Actions requiring confirmation:
- Actions not allowed:
- Dry-run required before:

## 8. Revision Conditions

- Revise stage when:
- Rebuild plan when:
- Reformulate goal when:

## 9. Open Questions

- [ ] <question that affects realization or validation>

## 10. Related Plan Variants

Use this section when multiple plan variants exist for the same goal.

| Variant | Artifact | Role | Author | Device | Time | Selection Status | Use |
| --- | --- | --- | --- | --- | --- | --- | --- |
| <variant-id> | <plan-artifact-id-or-path> | <canonical-community|personal-variant|imported-variant|experimental-variant|hybrid-variant> | <author> | <device> | <YYYY-MM-DDTHH:MM:SS+HH:MM> | <candidate|selected|superseded|rejected|promoted-to-canonical> | <compare|active|reference|promote|archive> |

- Comparison notes:
- Selected active plan:
- Why this plan is active now:

## 11. Existing Plan Implementations

Use this section when importing existing implementations of this plan for
reference, comparison, or verification.

| Implementation | Plan State Artifact | Author | Device | Time | Use |
| --- | --- | --- | --- | --- | --- |
| <implementation-id> | <plan-state-id-or-path> | <author> | <device> | <YYYY-MM-DDTHH:MM:SS+HH:MM> | <reference|comparison|verification> |

- Comparison notes:
- Verification notes:
```
