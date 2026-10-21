---
name: machine-of-goals
status: release-candidate
description: >
  Use this skill when the user wants to formulate, clarify, inspect, plan,
  realize, validate, import, export, split, or continue a goal through the
  Machine of Goals. Trigger on goal artifacts, subgoals, path discovery, plan
  synthesis, registered realizations, computed plan style, working plan runs,
  validation, plan exchange, reusable plans, or collapsed plans. Trigger and
  route to `double-agent` when the user asks to change Machine of Goals
  operating artifacts under `.double/`. Do not trigger on casual mentions of
  goals inside unrelated discussion unless the user asks to enter the workflow.
metadata:
  short-description: Transform goals into verifiable target states, paths, plans, realization loops, validation, and reusable plan packages
---

# Machine of Goals

This skill is an integration entry point for AI agents that can read local
project instructions. It connects user intent to the Machine of Goals
operational materials in `.double/`.

The skill does not replace the workflow. The canonical process is defined in:

- `.double/workflows/machine-of-goals/machine-of-goals-workflow.md`

## Strict Workflow and Artifact Compliance

Follow the canonical Machine of Goals workflow exactly: its current step,
responsible agent, permitted mode, transition conditions, approval boundaries,
and artifact contracts. This skill is an entry point, not permission to extend
or replace that workflow with an agent-invented process.

Before creating a process artifact, identify the workflow provision and
applicable template that authorize its kind, location, and purpose. Create
only the artifacts prescribed for the current step and authorized scope. Do
not invent additional process artifact types, frontmatter kinds, indexes,
registries, evidence catalogs, or companion documents for convenience. If the
workflow provides no artifact for a piece of process information, record it in
the appropriate existing artifact section instead of creating a new document.
In particular, link screenshots and other validation evidence directly from
the relevant plan-run stage or validation section; do not introduce a separate
evidence index unless the canonical workflow explicitly provides for one.

Distinguish process artifacts from the actual deliverables of an approved
user plan. Requested screenshots, source files, packages, and other product
outputs may be created when required by that plan; their existence does not
authorize new workflow machinery or undocumented artifact contracts.

If the requested behavior needs a new process artifact or a workflow change,
explain the contract gap and route the operating change through `double-agent`
before introducing it. Do not silently create it, present a personal convention
as a machine requirement, or mutate an immutable artifact to accommodate it.
Preserve explicit user authorization without adding unrelated approval gates.

## Activation Rule

Activate this skill when the user clearly wants to work with Machine of Goals,
including:

- formulating a goal as a verifiable target state
- splitting a goal into subgoals and subplans
- continuing or inspecting an existing goal artifact
- discovering possible realization paths
- synthesizing or revising a plan
- choosing a realization decision
- realizing plan stages
- working with registered plan realizations, computed plan style, current plan
  runs, or aggregate realization statistics
- validating current run results or overall goal achievement
- importing an existing plan, analog, runbook, workflow, or reusable fragment
- exporting a plan package, checklist, runbook, workflow,
  specification, or collapsed plan
- asking what the next useful step is for a goal

If the user's intent is only weakly implied, offer activation instead of
silently entering the workflow.

## Machine Operating Change Routing

Before normal workflow entry, detect whether the request creates, changes,
moves, or removes a Machine of Goals operating artifact under `.double/`.

If it does:

1. Verify that `double-agent` is installed and available. If it is not, do
   not change a working file; require its installation first.
2. Activate `.double/skills/double-agent/SKILL.md`.
3. Follow its read-only inspection, planning, versioning, confirmation, and
   validation protocol.
4. Do not route the operating-artifact change to a normal Machine of Goals
   workflow agent.

If the request also changes a user artifact under `goals/`, split that work
into a separate proposed step owned by the appropriate Machine of Goals
workflow agent.

Example:

> I can treat this as a Machine of Goals run and inspect the current goal state.
> Shall I start from the workflow entry protocol?

## Entry Protocol

When the skill is activated, follow the workflow definition in
`.double/workflows/machine-of-goals/machine-of-goals-workflow.md`.

Before producing or changing workflow artifacts, confirm or infer and explain:

- target artifact catalog for a new goal; default to `./goals`
- target goal, plan, imported plan, subgoal, or goal directory
- parent goal directory when the target is a subgoal
- current workflow step
- interaction language
- artifact language
- selected output template
- selected mode
- responsible agent

If Machine of Goals starts without an existing goal artifact, use the workflow's
default state:

- current-step: `01-goal-formulation`
- current-mode: `clarification`
- goal-catalog: `ask-user`, default `./goals`
- expected-output: `goal-artifact`

If the user starts from an existing goal, plan, imported plan, or subgoal,
infer the current step from the artifact state and explain that inference before
advancing.

During `01-goal-formulation`, inspect the goal artifact's `Open Questions`.
When any remain, keep the workflow in `clarification`, state that Path
Discovery is not yet available, and offer to resolve the questions one by one.
Offer transition to `02-path-discovery` only when the goal is sufficiently
clear and no `Open Questions` remain.

During `02-path-discovery`, inspect the path-options artifact's `Open
Questions`. When any remain, keep the workflow in `research`, state that Plan
Synthesis is not yet available, and offer to resolve the questions one by one.
Offer transition to `03-plan-synthesis` only when at least one plausible path
exists and no `Open Questions` remain.

During `04-plan-review-and-decision`, show the user the selectable paths or
subplans, their material trade-offs, and the compatible registered
realizations. Ask the user to confirm the selected path or subplan explicitly.
A recommendation is allowed, but neither the skill nor the responsible agent
may make the selection on the user's behalf. Do not commit the realization
decision or advance to `05-plan-realization` until the user confirms the
selection, the selected realization row has been added to section 10 of
`plan.md`, and the first executable baseline or current applicable revision
snapshot exists without overwriting earlier history. A
different selected path always creates a new realization row, even when it
reuses the same realization mechanism. Before advancing, create the persistent
`realizations/<realization-record-id>.md` artifact for the approved realization.

## Structured User Choices

For concrete mode, path/subplan, realization, next-step or validation choices,
follow the canonical workflow's structured-choice rule. Prefer exposed and
permitted `request_user_input_async`; show the relevant trade-offs/evidence and
wait for an explicit response before dependent state changes. Use a permitted
alternative or numbered text if unavailable. Preserve already supplied choices;
preselection, silence and request acknowledgements are not consent. Keep
open-ended clarification free-form and do not create extra approval gates.

While a required asynchronous question is pending, do not send a final message
or end the turn merely to acknowledge the question or say that you are waiting.
Use permitted interruptible waits, each no longer than 60 seconds, and continue
waiting for an explicit submitted response or equivalent direct user instruction.
A timeout does not cancel the question, authorize dependent work, or justify
repeating it. Independent read-only work may continue. If the user reports a
missing or disappearing question, investigate without treating tool acceptance
as proof of visibility. This is an agent waiting rule, not a guarantee about
the client UI lifetime.

## Active Response Rule

After processing a Machine of Goals request, offer one to three concrete next
steps for moving through the workflow. Ground each option in the current
artifact state and name the next workflow step, mode, responsible agent, and
expected artifact when known.

Do not advance automatically when the next step would create or modify
artifacts, execute work, import or export material, or change goal or plan
execution state. Ask for confirmation first.

## Loading Order

Load only what is needed for the current task.

1. Workflow:
   - `.double/workflows/machine-of-goals/machine-of-goals-workflow.md`
2. Current artifact or goal directory, if one exists.
3. Registries when routing is needed:
   - `.double/registries/machine-of-goals/agents-registry.md`
   - `.double/registries/machine-of-goals/modes-registry.md`
   - `.double/registries/machine-of-goals/roles-registry.md`
   - `.double/registries/machine-of-goals/templates-registry.md`
4. Agent, role, prompt, and template files required by the current step.

## Default Agent Routing

- `01-goal-formulation` -> `goal-formulation-agent`
- `02-path-discovery` -> `path-discovery-agent`
- `03-plan-synthesis` -> `plan-synthesis-agent`
- `04-plan-review-and-decision` -> `plan-synthesis-agent`
- `05-plan-realization` -> `plan-realization-agent`
- `06-plan-validation` -> `plan-validation-agent`
- `07-plan-packaging-export` -> `plan-exchange-agent`

`plan-exchange-agent` is optional and supports import/export. It must not
replace the core goal formulation, path discovery, planning, realization, or
validation flow.

## Boundaries

- This skill is a trigger and routing layer, not a separate workflow.
- The workflow file is the source of truth for step order, transition
  conditions, default state, and artifact contracts.
- Changes inside `.double/` are process changes.
- Goal artifacts themselves belong in the goal working context, not in this
  skill directory.
- A main goal artifact is named `<goal-id>.md` inside `<goal-catalog>/<goal-id>/`.
  A subgoal artifact is named `<subgoal-id>.md` inside its subgoal directory.
- Import must adapt existing material to the current goal context.
- Export must preserve the link between goal, plan, criteria, context, and
  validation evidence.
- Human-facing navigation uses contextual standard Markdown links in the
  sections where artifact relationships are explained; frontmatter references
  do not replace those links, and a universal navigation block is not required.
- Every artifact created from a Machine of Goals template records that
  template's stable top-level `id` in frontmatter `template-id`; revisions and
  plan revision snapshots preserve it.
- External goals, plans, subplans, paths, and realizations may remain direct
  references when no copy or adaptation is requested; direct reference does
  not require Plan Exchange.
- Each goal has one plan artifact at `<goal-directory>/plan.md`; alternative
  achievement paths are selectable branches or subplans inside it.
- `path-options.md` remains the living catalog of possible achievement paths.
  Paths may be added, deprecated, or selected later without replacing retained
  realization history.
- Section 10 of `plan.md` is the realization registry and owns realization
  records, computed style input, readiness, alignment, and aggregate run
  statistics. A different selected path always creates a new row with a unique
  realization record id.
- Before the first realization, keep `plan-revision` and
  `plan-revision-artifact` null, refine only `plan.md`, and create no snapshot.
  The first realization freezes revision 1. Later revisions are required
  only when frozen stage obligations change; compatible future-only edits
  are recorded in the current plan change log.
- Every approved manual or automatic realization has one persistent
  `<goal-directory>/realizations/<realization-record-id>.md` artifact. Create it
  after the decision and local plan snapshot and before any run.
- Registering an automatic realization for the plan or a subplan changes the
  computed style from `single-pass` to `multi-pass`; file creation and first
  successful validation are not transition points.
- Mutable execution state belongs in
  `<goal-directory>/run/<realization-record-id>--<YYYYMMDDTHHMMSSZ>.md`. The
  current `plan.md` may mirror only the run's derived emoji progress in its
  Plan Map after frozen-contract and dependency compatibility checks; the run remains
  authoritative, and immutable plan-revision snapshots are never updated.
- Every command generated for human execution of a manual plan stage must be
  appended to the current run before or when it is presented. Preserve
  generation order and corrected or superseded commands; use placeholders or
  protected-input references instead of literal secrets.
- Successful plan-action and validation commands, including those executed by
  the agent or an automatic realization, belong in the current run for reuse
  and automation after observed success and before stage validation. Preserve
  order, stage, purpose, working context, exact safe command, concise result,
  and replay constraints. Failed attempts, redundant repeats and incidental
  bookkeeping need not be logged as a full trace. Verify each retained command
  in a group; recording a command does not authorize replay or automation.
- Immutable copies of plan revisions used by realizations belong in
  `<goal-directory>/realizations/plan-revision-<N>.md`. Rebase relative links
  when copying `plan.md`, and never overwrite an existing revision snapshot.
- `<goal-directory>/run/index.md` links active, pinned, and retained run files;
  each realization artifact links its own retained runs, while the plan
  realization registry links the artifact and index but not individual run
  files.
- A realization decision and every run must link the exact local
  `realizations/plan-revision-<N>.md` snapshot and the exact realization
  revision; `current` is allowed only before the execution commit point.
- A realization decision is not committed until the selectable paths or
  subplans have been shown to the user and the user has explicitly confirmed
  the selected path or subplan.
- Retain a configured three to five terminal run logs per realization record while
  preserving aggregate statistics in the corresponding `plan.md` realization
  row.
- Import and export of reusable multi-pass plans preserve goal context, paths,
  registered realizations, and validation contracts; bounded run logs are not
  required package history.

## Stage Contracts and Plan Changes

Follow the [revision rule](../../workflows/machine-of-goals/machine-of-goals-workflow.md#plan-revision-history-rule) and
[stage contract rule](../../workflows/machine-of-goals/machine-of-goals-workflow.md#stage-contract-rule):

- Log compatible future-only edits without a new revision; assess dependencies
  and realization fit. Preserve applicable accepted results.
- Freeze each effective stage contract in its run before action; validate
  against captured criteria and evidence. Preserve attempts and baseline links.
- Create a new revision before executing changed frozen obligations; identify
  revalidation or rework. Never rebind completed runs or invent legacy contracts.

## Completion Handoff

Follow the canonical [step completion and continuation rule](../../workflows/machine-of-goals/machine-of-goals-workflow.md#step-completion-handoff-rule)
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
