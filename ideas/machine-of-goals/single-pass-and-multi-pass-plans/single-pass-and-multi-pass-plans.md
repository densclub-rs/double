---
id: single-pass-and-multi-pass-plans
kind: mini-idea-artifact
status: draft
produced-by: idea-capture-agent
interaction-language: Russian
artifact-language: English
parent-idea:
  id: machine-of-goals
  artifact: ../machine-of-goals.md
integration-targets:
  concepts: ../machine-of-goals-concepts.md
  principles: ../machine-of-goals-principles.md
derived-from:
  - user observation on 2026-08-26
  - ideas/styles/styles.md
---

<a id="single-pass-and-multi-pass-plans"></a>

# Mini-Idea: Single-Pass and Multi-Pass Plans

## 1. Summary

Within Machine of Goals, it may be useful to distinguish between single-pass and multi-pass styles for working with plans. The style is computed from the registered realizations of the plan or its subplans. A plan without a registered automatic realization remains single-pass. When an automatic realization is registered, the plan becomes multi-pass and selects a workflow for repeated execution, bounded working run logs, import into another project, and revision of the plan from later execution experience.

## 2. Main Idea Context

- Main idea: [`machine-of-goals`](../machine-of-goals.md#machine-of-goals)
- Related independent idea: [`styles`](../../styles/styles.md)
- This mini-idea clarifies the lifecycle of a plan and the relationship between the plan, its concrete realizations, and its collapsed executable form.
- It remains part of Machine of Goals because it concerns repeatable goal achievement, preserving execution experience, and evolving a plan based on that experience.

## 3. Motivation

Two different flows have emerged while working on plan realization. In one case, a plan is used to guide a specific project and is not expected to be executed again after completion. In the other case, the value comes precisely from repeated execution: the results of a previous pass become source material for changing the plan, the next realization, and the executable mechanism. These flows can be represented as styles that select different workflows without requiring a detailed plan-usage specification in the plan itself.

Distinguishing these flows may help avoid conflating the history of a one-time realization with a repeatable process that evolves from one run to the next.

## 4. Raw Description

### Single-Pass Style

The plan has no automatic realization, so Machine of Goals computes the single-pass style and selects a workflow for one realization of a specific project. The plan may be refined as work progresses, but after the project is complete, the same plan is not executed again as a new pass under that workflow.

### Multi-Pass Style

An automatic realization of the plan or one of its subplans is registered, so Machine of Goals computes the multi-pass style and selects a workflow that supports repeated execution. Registration is the style transition point: creating an implementation file alone does not change the style, and the machine does not wait for the first successful validation. A registered realization may still have a readiness or alignment status that shows that it has not yet been validated. Later executions may reveal changes needed in the plan, a subplan, or the automatic realization.

A particularly important case is when plan execution is gradually collapsed into a script. The user runs the script, discovers and corrects errors, refines the executable form, and, when necessary, modifies the plan itself based on the experience of an actual run. The next pass is then executed with these changes incorporated.

### Plan, Paths, Realizations, and Runs

The plan defines a verifiable transition from the initial state to the final state. Alternative achievement paths such as deployment to Kubernetes or to a virtual machine are represented as selectable subplans or options inside that plan rather than as separate plans.

Shell scripts, Python programs, manual procedures, workflows, and similar forms are realizations of the plan or of particular subplans. An automatic realization must validate the initial state, required intermediate results, and the final state defined by the plan.

Available realizations and their aggregate execution statistics are recorded in the realization registry in `plan.md`. The statistics show which realizations exist, how many times each realization has been run, when it was last run, and the result of the latest run. The registry does not link to individual run files.

After the user approves a path and chooses a manual or automatic realization, the machine creates `realizations/<realization-record-id>.md` before the first run. This persistent realization artifact records the approved execution context and links every active, pinned, or retained run for that realization record.

Creating a run increments the realization run count, records the start time as
the latest run time, and sets the latest result to `running`. Terminal
validation replaces that result without incrementing the count again.

Each concrete execution creates a working run artifact under `run/`. Its filename identifies the realization and the UTC start time:

```text
run/<realization-record-id>--<YYYYMMDDTHHMMSSZ>.md
```

Run artifacts are short-lived working logs that record the selected paths, checked stages, concise execution notes, and result. When the machine generates commands for a human to execute while manually performing a stage, the run records every such command in generation order, including corrected or superseded commands. The retained depth is bounded, normally to the latest three to five runs per realization. Their links are maintained in the persistent realization artifact and the shared run index. Aggregate statistics in `plan.md` survive removal of old run files.

## 5. Key Points

- Single-pass and multi-pass are computed styles for working with plans rather than immutable plan types.
- Registration of an automatic realization for the plan or a subplan changes the computed style from single-pass to multi-pass; file creation and first successful validation are not style transition points.
- The computed style determines which workflow Machine of Goals uses for the plan.
- A general computed style designation is sufficient at the plan level; the detailed behavior belongs to the selected workflow.
- The plan defines the transition and its state validation contract; selectable achievement alternatives are subplans or path options within it.
- Shell scripts, Python programs, manual procedures, and workflows are realizations of the plan or its subplans.
- Every approved manual or automatic realization has a persistent artifact before its first run, and that artifact links its retained runs.
- Each execution creates a bounded working run log rather than a permanent realization-history artifact.
- Every command generated for manual execution of a stage is recorded in that
  run before or when it is presented to the human.
- `plan.md` retains aggregate realization statistics without links to individual run files.
- Both the plan and its realization may evolve between runs.
- A script may be a collapsed executable form of the plan that is refined through actual runs.
- Errors and observations discovered while running the script may lead to changes not only in the script but also in the source plan.
- Multi-pass operation enables importing the plan into another project and changing the plan from experience gathered during later executions.

## 6. Main Idea Impact

- Possible concept impact: computed plan style; style-based workflow selection; plan and subplan realization; working run; aggregate realization statistics; bounded run retention; collapsed executable form.
- Possible principle impact: deriving style from automatic realizations; validating states in automatic realizations; retaining bounded working history; feedback from execution to the plan.
- Possible parent idea impact: sections about plan realizations, execution state, path options, import, repeated execution, and collapsing a plan into a script or another executable mechanism.
- Semantic mismatch with the main idea: none.
- Mismatch signals: high semantic closeness; the questions clarify the model within Machine of Goals.

## 7. Open Questions

- [x] Is being single-pass or multi-pass a property of the plan itself, a selected way of using it, or a computed style?
- [ ] How should changes to the plan between passes be distinguished from changes only to its concrete executable realization?
- [x] Should each run record the exact revisions of the plan and realization under which it was executed? Yes; the run must retain resolvable references to both revisions.
- [x] What execution details need to be preserved so that the next pass can use the experience of the previous one?
- [ ] At what point should a modified script lead to a corresponding change in the source plan?
- [ ] Which additional capabilities or workflow changes should follow from the computed multi-pass style?

## 8. Boundaries / Non-Goals

- The mini-idea requires exact plan and realization revision references in each
  run, while the storage or VCS mechanism for immutable revisions remains an
  operating-contract choice.
- The mini-idea does not require every plan to become multi-pass or to be collapsed into a script.
- The mini-idea does not define a detailed configuration schema for plan usage; the computed style points to the applicable workflow.
- It does not design a mechanism for execution, run comparison, automatic plan modification, or run-retention cleanup.
- Concrete operating behavior under `.double/` is handled in a separate Double Agent change after parent concept and principle integration.

## 9. Parent Integration

- Parent concept integration: `[completed]`
- Parent principle integration: `[completed]`
- Parent sections changed:
  - `machine-of-goals.md`: `Raw Description`, `Key Elements`, `Assumptions`, `Notes`, and development-artifact indexes
  - `machine-of-goals-concepts.md`: realization paths, realization registry, computed style, working runs, execution, exchange, and artifact context
  - `machine-of-goals-principles.md`: automatic-realization registration, bounded working logs, persistent statistics, tensions, and future operating inputs
- User notification required before parent rewrite: `[completed-by-request]`
