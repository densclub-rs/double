---
style: double
submodule: machine-of-goals
mindmap-plugin: basic
status: draft
derived-from:
  - ../../workflows/machine-of-goals/machine-of-goals-workflow.md
---

# [Machine of Goals](../../workflows/machine-of-goals/machine-of-goals.md)

## [Modes](../modes.md)

- [Clarification](./clarification/clarification.md)
- [Research](./research/research.md)
- [Planning](./planning/planning.md)
- [Review](./review/review.md)
- [Execution](./execution/execution.md)
- [Validation](./validation/validation.md)
- [Explain](./explain/explain.md)
- [Dry Run](./dry-run/dry-run.md)
- [Import](./import/import.md)
- [Export](./export/export.md)

## Draft Interpretation

These modes are cross-step behavior contracts for Machine of Goals.

A mode does not replace the current workflow step. It changes how the agent
works inside that step: what it emphasizes, what it may produce, what evidence
it needs, and where it must stop before changing the goal, plan, execution
state, or exported package.

The same workflow step may use more than one mode over time. For example,
`Plan Realization` may move between `execution`, `explain`, `dry-run`, and
`validation` as a stage becomes more concrete.
