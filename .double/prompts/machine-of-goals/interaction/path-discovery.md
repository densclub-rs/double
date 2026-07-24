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
- whether it should become a plan candidate

If no plausible path exists, mark the goal as blocked, infeasible, or requiring
reformulation.

Record unresolved issues only as `Open Questions`. If any `Open Questions`
remain, state that Path Discovery is not complete and that Plan Synthesis is
not yet available. Offer to resolve the questions one by one, wait for the
user's response to the current question, then continue with the next one.

Offer transition to `03-plan-synthesis` only when at least one plausible path
exists and no `Open Questions` remain.

After responding, offer the next useful workflow movement. Name the next step,
mode, responsible agent, and expected artifact when known.
