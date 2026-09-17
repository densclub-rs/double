---
style: double
submodule: machine-of-goals
id: realization-decision-template
kind: template
status: release-candidate
workflow-stage: plan-review-and-decision
interaction-language: en
artifact-language: en
derived-from:
  - ../../workflows/machine-of-goals/machine-of-goals-workflow.md
---

# Template: Realization Decision

```md
---
id: <goal-id>-realization-decision
kind: realization-decision
template-id: realization-decision-template
project-id: <stable-project-id>
produced-by: plan-synthesis-agent
interaction-language: <language-code-or-name-used-for-dialogue>
artifact-language: <language-code-or-name-used-for-this-artifact>
goal-id: <goal-id>
plan-id: <plan-id>
plan-revision: <positive-integer>
plan-revision-artifact: <goal-directory>/realizations/plan-revision-<N>.md
path-options-id: <path-options-id>
selected-paths:
  - <path-or-subplan-id>
realization-record-id: <unique-realization-record-id>
selected-realization-id: <registered-realization-id>
realization-artifact: <goal-directory>/realizations/<realization-record-id>.md
path-selection-confirmed-by: <user-id-or-user-label>
path-selection-confirmed-at: <YYYY-MM-DDTHH:MM:SSZ>
derived-from:
  - <plan-artifact-id-or-path>
  - <plan-revision-artifact-path>
  - <path-options-id-or-path>
---

<a id="<goal-id>-realization-decision"></a>

# Realization Decision: <Goal Title>

## 1. Decision Summary

- Source goal: [<goal-title>](./<goal-id>.md#<goal-id>)
- Selected plan revision: [Revision <N>](./realizations/plan-revision-<N>.md#<goal-id>-plan)
- Additional VCS evidence: [<exact-plan-revision>](<immutable-vcs-permalink>) or none
- Paths or subplans shown to the user:
  - [<path-or-subplan-label>](./path-options.md#<path-or-subplan-id>): <material-trade-off-summary>
- Selected paths or subplans: [<path-or-subplan-label>](./path-options.md#<path-or-subplan-id>)
- User confirmation: <concise-explicit-confirmation>
- Confirmed by:
- Confirmed at:
- Selected realization record: [<realization-label>](./plan.md#<realization-record-id>)
- Realization artifact: [<realization-label>](./realizations/<realization-record-id>.md#<realization-record-id>)
- Selected realization revision: [Revision <R>](./realizations/<realization-record-id>.md#<realization-record-id>-revision-<R>)
- Realization readiness:
- Realization alignment:
- First entry point: [<stage-label>](./plan.md#stage-<stage-id>)
- Decision owner:
- Decision date:

## 2. Reasoning

- Why this path and realization:
- Trade-offs accepted:
- Alternatives rejected or deferred:

## 3. Realization Mode

- Realization mode: <manual|interactive|partial-automation|automatic|external-handoff>
- Current default mode: `<execution>`
- Dry-run required: <yes|no|conditional>
- Explanation required before execution: <yes|no|conditional>
- Realization artifact to create before execution: `./realizations/<realization-record-id>.md`
- First run pattern: `./run/<realization-record-id>--<YYYYMMDDTHHMMSSZ>.md`

## 4. Automation Boundaries

- Allowed without confirmation:
- Requires confirmation:
- Not allowed:
- External effects:

## 5. Validation Strategy

- First stage validation criteria:
- Evidence expected:
- Who or what validates:
- Validation method:

## 6. Stop Points

- Before:
- During:
- After:

## 7. Revision Conditions

- Continue when:
- Branch when:
- Revise plan when:
- Reformulate goal when:
- Stop or pause when:
```
