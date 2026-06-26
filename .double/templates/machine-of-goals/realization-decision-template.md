---
style: double
submodule: machine-of-goals
id: realization-decision-template
kind: template
status: draft
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
status: draft
produced-by: plan-synthesis-agent
workflow-version: <workflow-version>
interaction-language: <language-code-or-name-used-for-dialogue>
artifact-language: <language-code-or-name-used-for-this-artifact>
goal-id: <goal-id>
plan-id: <plan-id>
derived-from:
  - <plan-artifact-id-or-path>
---

# Realization Decision: <Goal Title>

## 1. Decision Summary

- Selected plan:
- Selected branch or hybrid:
- First entry point:
- Decision owner:
- Decision date:

## 2. Reasoning

- Why this plan or branch:
- Trade-offs accepted:
- Alternatives rejected or deferred:

## 3. Realization Mode

- Realization mode: <manual|interactive|partial-automation|automatic|external-handoff>
- Current default mode: `<execution>`
- Dry-run required: <yes|no|conditional>
- Explanation required before execution: <yes|no|conditional>

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

## 8. Workflow State

- Current step: `04-plan-review-and-decision`
- Current mode: `<review|explain|dry-run>`
- Next expected step: `05-plan-realization`
- Transition condition: realization start and control boundaries are selected
```
