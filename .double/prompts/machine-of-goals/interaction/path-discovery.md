---
style: double
submodule: machine-of-goals
id: path-discovery-interaction-prompt
kind: prompt
status: draft
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

For each useful path, describe:

- what makes the path plausible
- expected cost and risk
- uncertainty and missing evidence
- whether it can use delegation, tools, automation, or reusable analogs
- whether it should become a plan candidate

If no plausible path exists, mark the goal as blocked, infeasible, or requiring
reformulation.
