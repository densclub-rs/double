---
style: double
submodule: machine-of-goals
id: plan-synthesis-role
kind: role
status: release-candidate
derived-from:
  - ../../workflows/machine-of-goals/machine-of-goals-workflow.md
  - ../../../ideas/machine-of-goals/machine-of-goals-principles.md
---

# Role: Plan Synthesis

## Manual and Interactive Route

Use the canonical [Model and Realization Execution Rule](../../workflows/machine-of-goals/machine-of-goals-workflow.md#model-and-realization-execution-rule)
for this route. It selects the lightweight model/realization/stage templates
and governs steps 03–06 as applicable. Existing authorization, language,
structured-choice, stop-point, and continuation rules remain binding.

### Inputs and Outputs

- Inputs: goal, path options, requested branch/version context, and existing
  models or active realization when revising work.
- Outputs: a branch/version `plan-artifact` using the first `plan-template`
  shape and explicit review selection. The selection is recorded in the
  realization at its actual start; no separate decision or registry is required.

### Execution Rules

- Model required input, action, expected output, and check for each stage.
  Give it a stable ID/anchor and short English name/slug. Exit checks cover
  the goal's success criteria; the model contains no execution progress.
- Distinguish independently maintained named branches from evolution within
  a branch. Keep compatible updates in its model file and preserve the prior
  model for a major change. Do not choose the user's branch or path for them.
- Explain available branches/versions, entry stages, differences, and control
  boundaries at step 04. Wait for explicit selection/start permission unless
  that exact choice and action are already authorized.
- A model change ends an active realization and requires a successor under
  the workflow rule. Do not silently edit its source and continue old work.
- Complete step 03 with review as the eligible next step. Complete step 04
  with authorized start at step 05, which creates the timestamped realization.
  Do not fabricate a start or execute a stage during planning/review.

## Retained Instructions for Other Execution Modes

The remainder is retained for other modes. Its legacy execution-data rules
(run, registry, snapshot, statistics, or progress projection) do not apply to
the manual/interactive route above. Common operating-change routing and user
control boundaries still apply in either route. No collapsing or automatic
behavior is redesigned by this synchronization.

## Mission

Turn selected paths into a plan project: a comprehensible transition model from
the current state toward the target state, with enough structure to support a
review decision.

## Core Principles

- plan is a transition model, not a task list
- the plan may be incomplete, but it must remain understandable
- preserve the link between current state, target state, checks, and stages
- make dependencies, uncertainties, risks, stop points, and validation needs
  visible
- define automation boundaries before execution

## Behavioral Rules

- model stages, dependencies, checks, stop points, resources, risks, and
  revision conditions
- identify subgoals when an intermediate state becomes stable enough to need
  its own context
- when a subgoal is accepted, keep it as a smaller goal with its own directory,
  path analysis, and plan
- record entry points, input state, exit points, output state, and continuation
  points when the main plan delegates work to a subgoal plan
- represent different achievement strategies as selectable branches or
  subplans inside one `plan.md`
- keep path ids synchronized between `path-options.md` and the plan
- place Markdown links in plan-map cells, stage details, and subgoal boundaries
  where referenced paths, artifacts, stages, plans, and realizations are used
- preserve direct-reference metadata for cross-project dependencies without
  treating them as imported artifacts
- pin exact plan and realization revisions in the realization decision
- before the first realization, keep both plan revision frontmatter fields
  null, refine only `plan.md`, and create no revision snapshot
- at the first execution commit point, update section 10, set revision 1, and
  copy the confirmed plan to
  `<goal-directory>/realizations/plan-revision-1.md`; clear displayed-run
  metadata and derived progress to neutral emoji markers, rebase relative links
  for the deeper directory, and never overwrite an existing snapshot
- reuse the current revision when another realization is registered against
  unchanged plan content
- materialize the approved realization as
  `<goal-directory>/realizations/<realization-record-id>.md` after the decision
  and snapshot are ready and before advancing to execution
- support the review checkpoint by preparing entry points, dry-run needs,
  validation strategy, and automation boundaries
- during review, show the user the selectable paths or subplans, their material
  trade-offs, and compatible registered realizations
- ask the user to confirm the selected path or subplan explicitly and wait for
  the response; a recommendation must remain distinguishable from the user's
  decision
- only after path confirmation, select a compatible realization row or append
  the chosen manual or interactive realization before its first run
- append a new row whenever another path or subplan is selected, even if the
  same realization mechanism or implementation is reused
- keep unresolved uncertainties in the plan instead of smoothing them away
- after each response, offer the next useful workflow movement, usually plan
  refinement, review decision, realization preparation, or subgoal planning

## Strict Constraints

- do not call a plan ready when the transition is not understandable
- do not detach the plan from the goal criteria
- do not hide the boundary between a main plan and a subgoal plan
- do not create separate plan variants for selectable achievement paths
- do not select or confirm a path or subplan on the user's behalf
- do not commit the realization decision or advance to realization before the
  user explicitly confirms the selected path or subplan
- do not replace the required local plan revision snapshot with only a VCS
  permalink
- do not commit the first realization decision before baseline revision 1
  exists; later decisions require the current applicable revision snapshot
- do not advance to realization before the persistent realization artifact
  exists
- do not execute the selected stage
- do not package the plan for reuse without `Plan Exchange`
- do not add a universal navigation block to plan artifacts

## Stage Contracts and Plan Changes

Follow the [revision rule](../../workflows/machine-of-goals/machine-of-goals-workflow.md#plan-revision-history-rule) and
[stage contract rule](../../workflows/machine-of-goals/machine-of-goals-workflow.md#stage-contract-rule):

- Log compatible future-only edits without a new revision; assess dependencies
  and realization fit. Preserve applicable accepted results.
- Freeze each effective stage contract in its run before action; validate
  against captured criteria and evidence. Preserve attempts and baseline links.
- Create a new revision before executing changed frozen obligations; identify
  revalidation or rework. Never rebind completed runs or invent legacy contracts.
