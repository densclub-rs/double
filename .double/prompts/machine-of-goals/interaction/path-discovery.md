---
style: double
submodule: machine-of-goals
id: path-discovery-interaction-prompt
kind: prompt
status: release-candidate
produced-by: path-discovery-agent
mode: shared
derived-from:
  - ../../../roles/machine-of-goals/path-discovery-role.md
---

# Interaction Prompt: Path Discovery

We are going to discover possible ways to reach the formulated goal.

Current step: `02-path-discovery`.
Default mode: `research`.
Expected output: `path-options`.

Start from the goal artifact and look for possible paths before planning.
If the artifact is a subgoal, keep the path analysis scoped to the subgoal and
its expected input/output boundary with the parent plan.

For each useful path, describe:

- what makes the path plausible
- expected cost and risk
- uncertainty and missing evidence
- whether it can use delegation, tools, automation, or reusable analogs
- whether it should become a selectable path/subplan inside one plan or an
  independently developed parallel plan variant, distinct from revision lineage

Record independent variants for step-03 synthesis as `plan-<id>.md`, with
short stable plan IDs assigned when the plans are formed. An author's own variant
uses `plan<owner_id>.md`. No earlier default plan or major divergence is required.
Discovery produces only the path catalog; do not create plans or link uncreated files.

If no plausible path exists, mark the goal as blocked, infeasible, or requiring
reformulation.

Record unresolved issues only as `Open Questions`. If any `Open Questions`
remain, state that Path Discovery is not complete and that Plan Synthesis is
not yet available. Offer to resolve the questions one by one, wait for the
user's response to the current question, then continue with the next one.

Offer transition to `03-plan-synthesis` only when at least one plausible path
exists and no `Open Questions` remain.

Keep stable path ids: `path-options.md` remains the evolving catalog of possible
paths after planning, and new paths may be added later. Actual progress and
evidence belong in documented realizations, outside the plan.

Link `Source Goal`, give paths explicit anchors, and link a planned path to its
plan element. Keep external authoritative artifacts as direct references unless
adaptation is requested.

After responding, offer the next useful workflow movement. Name the next step,
mode, responsible agent, and expected artifact when known.

## Completion Handoff

Follow the canonical [step completion and continuation rule](../../../workflows/machine-of-goals/machine-of-goals-workflow.md#step-completion-handoff-rule)
after every completed workflow step or plan stage. State the completed step,
result and artifact links; name the eligible next workflow step, mode, agent,
expected artifact and transition readiness; then ask whether to perform the
concrete next action (Yes / No in the interaction language) and wait for an
explicit response using the permitted structured-choice interface. A summary
or a list of possible next steps alone is insufficient.

Preserve explicit authorization already covering the next action; do not ask
again or bypass mandatory selections, validation decisions or stop points.
A No stops continuation without rejecting the completed result. If blocked,
name the blocker and offer clarification or repair. At the workflow end, state
completion instead of inventing a next step. After plan-stage execution, offer
`06-plan-validation` before any further plan-stage execution.
