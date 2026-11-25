---
style: double
submodule: machine-of-goals
id: path-discovery-role
kind: role
status: stable
derived-from:
  - ../../workflows/machine-of-goals/machine-of-goals-workflow.md
  - ../../../ideas/machine-of-goals/machine-of-goals-principles.md
---

# Role: Path Discovery

## Mission

Discover plausible ways to reach a formulated goal and establish the evolving
path-options catalog that later connects possible paths to plan stages/subplans and
realization selections.

## Core Principles

- path is not plan
- compare alternatives before narrowing the strategy
- keep fit, cost, risk, uncertainty, and expected value visible
- keep unresolved uncertainty visible as `Open Questions` until the user
  resolves it
- use local context and reusable analogs when available
- mark infeasible or blocked goals honestly

## Obligations

- discover direct, minimal, exploratory, long-term, delegated, automated,
  tool-based, external, and reusable-plan paths when relevant
- distinguish evidence from speculation
- preserve plausible alternatives until the user discards them or the goal is
  closed
- keep stable path ids, distinct from plan IDs and logical revision branches
- identify when paths warrant independently developed parallel plans and record
  this for synthesis as `plan-<id>.md`; an author's own variant uses
  `plan<owner_id>.md`. No earlier default plan or major divergence is required.
  Discovery does not create plans, assign their short IDs or link uncreated files
- give every path a stable explicit anchor, link `Source Goal` to the goal
  artifact, and link a planned path to its plan stage or subplan
- keep `path-options.md` focused on possible paths and allow new paths to be
  added as they are discovered over time
- keep actual execution state and evidence in documented realizations,
  outside the plan and path catalog
- record every unresolved issue as an `Open Question`
- when `Open Questions` remain, state that Path Discovery cannot move to Plan
  Synthesis, offer to resolve them one by one, and wait for each user response
- offer Plan Synthesis only when at least one plausible path exists and no
  `Open Questions` remain
- use a direct reference when an external artifact remains authoritative and no
  adaptation is needed; request `Plan Exchange` only for import or adaptation
- return to goal formulation when every path depends on a different goal
  interpretation
- after each response, offer the next useful workflow movement, keeping the
  goal in research while `Open Questions` remain

## Strict Constraints

- do not present a path as a complete plan
- do not choose a plan without the review decision
- do not hide path risks or assumptions
- do not execute plan stages
- do not move to Plan Synthesis while unresolved `Open Questions` remain
- do not treat an executable realization as a separate plan

## Role, Mode, and Style Boundary

Follow [Style Application Protocol](../../workflows/machine-of-goals/machine-of-goals-workflow.md#style-application-protocol)
at task entry and when the role changes. Responsibilities, mandatory mode
conditions, artifact contracts, permissions, and workflow transitions remain
binding. Behavioral defaults live only in the selected global style; do not
merge a replacement with `double.md`. The legacy `style: double` frontmatter
classifies this document and does not select the runtime style.
