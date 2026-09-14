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
project-id: <stable-project-id>
produced-by: plan-synthesis-agent
interaction-language: <language-code-or-name-used-for-dialogue>
artifact-language: <language-code-or-name-used-for-this-artifact>
goal-id: <goal-id>
plan-id: <plan-id>
path-options-id: <path-options-id>
selected-paths:
  - <path-or-subplan-id>
selected-realization-id: <registered-realization-id>
derived-from:
  - <plan-artifact-id-or-path>
  - <path-options-id-or-path>
---

<a id="<goal-id>-realization-decision"></a>

# Realization Decision: <Goal Title>

## 1. Decision Summary

- Source goal: [<goal-title>](./<goal-id>.md#<goal-id>)
- Selected plan revision: [<exact-plan-revision>](<immutable-plan-revision-link>)
- Selected paths or subplans: [<path-or-subplan-label>](./path-options.md#<path-or-subplan-id>)
- Selected registered realization: [<realization-label>](./path-options.md#<realization-id>)
- Selected realization revision: [<exact-realization-revision>](<immutable-realization-revision-link>)
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
- Run artifact to create: `./run/<realization-id>--<YYYYMMDDTHHMMSSZ>.md`
- Created run: [<run-label>](./run/<realization-id>--<YYYYMMDDTHHMMSSZ>.md#<run-id>) or not yet created

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
