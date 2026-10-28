---
name: machine-of-goals
status: release-candidate
description: >
  Use this skill when the user wants to formulate, clarify, inspect, plan,
  realize, validate, import, export, split, or continue a goal through the
  Machine of Goals. Trigger on goal artifacts, subgoals, path discovery, plan
  synthesis, documented realizations, stage evidence, optional skills/actions,
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
the relevant realization stage or Result section; do not introduce a separate
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
- working with documented realizations, stage evidence or existing collapsed
  skills and automated actions
- validating realization stage results or overall goal achievement
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

> I can treat this as a Machine of Goals workflow and inspect the current goal state.
> Shall I start from the workflow entry protocol?

## Entry Protocol

When the skill is activated, follow the workflow definition in
`.double/workflows/machine-of-goals/machine-of-goals-workflow.md`.

Before producing or changing workflow artifacts, confirm or infer and explain:

- target artifact catalog for a new goal; use the project-rule base catalog, falling back to `./goals`
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
- goal-catalog: `ask-user`, project-rule base catalog or default `./goals`
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

The generated artifact keeps the user-facing name `Plan` and heading
`# Plan: <Goal Title> / <Branch>` in planning and realization. `plan-model`
is a technical role, not a replacement display name. Preserve the distinct
metadata, templates and storage contracts below.

During `03-plan-synthesis`, produce only `plan-model` from
`plan-model-template`, stored as `<goal-directory>/plan.md` by default.
Generate one short human-readable word as `id`, unique within the goal directory,
for every new plan and always write it in frontmatter. The word must be derived
from the plan's context: jointly express its subject, core meaning and goal in
a single word, distinguishing it from other variants. Use lowercase English
letters only; on collision choose another word combining all three concepts.
The plan has only `id`; its root anchor equals that value. Revisions and frozen
copies retain it, with exact paths, revisions/versions and digests identifying
copies. `plan-id` in a referencing artifact points to this plan `id`; it is not
an additional identity field on the plan. Independent parallel variants use
`plan-<id>.md`; author variants use `plan<owner_id>.md` with the actual author's
`owner-id`, without a hyphen after `plan`. Discovery may identify variants before
synthesis; no earlier default plan or major divergence is required. Record each
actual plan in the goal table, preserving existing files and rows. Paths/subplans
may remain inside one plan; parallel stages or different execution media alone
do not create separate plans.
During step 04, show a contextual Markdown link to the actual current plan
file and explain choices, trade-offs, entry and boundaries. Ask for approval
of that linked file's current contents, selection and boundaries. Keep SHA-256
as internal verification evidence computed before the request and rechecked
at start; do not show it in approval questions, titles, suggested answers or
normal review summaries. Retain the internal baseline with the user decision
in existing recoverable context; create no extra checksum/approval artifact.
Every model edit invalidates approval for future execution. If start is deferred,
leave only the model. Never create an execution plan, snapshot, realization,
registration row or separate decision file during steps 03 or 04.

Only at the authorized manual start of step 05, recheck exact approval/content and
freeze `_realizations/<start>/plan-v1.md` from `plan-template`, then create
`realization.md`. Stages and the realization link this immutable local plan.
A collapsed skill/action creates no Machine of Goals execution record when
invoked; follow its applicable checks, permissions and stop points.
Do not require executor files to finish review. See the canonical
[all-mode boundary](../../workflows/machine-of-goals/machine-of-goals-workflow.md#plan-model-execution-boundary).

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
  template's stable top-level `id` in frontmatter `template-id`; a frozen
  execution plan uses `plan-template` rather than the source model template.
- External goals, plans, subplans, paths, and realizations may remain direct
  references when no copy or adaptation is requested; direct reference does
  not require Plan Exchange.
- Models use `plan-model-template`; frozen execution plans use `plan-template`.
  A newly created frozen plan records `plan-template` and producer
  `machine-of-goals/plan-realization-agent`. The source model keeps its own
  model identity, template and synthesis producer unchanged.
- Every plan contains expected transitions, with no execution progress,
  acceptance, execution registry or statistics. Its
  logical `branch` is distinct from selectable paths/subplans inside it.
  The goal table links every actual `plan.md`, `plan-<id>.md` or
  `plan<owner_id>.md`; omit a default row when no ordinary plan exists.
  `path-options.md`, approval and frozen-plan/realization provenance link actual
  selected file/anchors; never precreate files or hypothetical links.
  See the canonical filename rule.
- At authorized manual start, freeze complete approved content and rebase links
  without altering conditions/actions. Record the actual approved source hash
  and frozen-plan hash separately in the realization, with actual time/timezone.
- Render each realization Stage Map State cell as a single emoji under the
  workflow's Realization Progress Emojis rule. Keep the explanatory legend
  above the map; omit state names in cells and duplicate text-status columns.
  Prose progress summaries may add short labels. Legend: ⚪ pending, 🔄 in progress,
  🟠 awaiting verification, ✅ completed, 🟡 partial, ⛔ blocked, ❌ failed,
  🛠️ needs revision, ➖ not selected. Only verified/accepted outputs permit ✅;
  keep textual metadata unchanged and never project progress into either plan.
- Frozen plans remain immutable. Mutable current-stage, actions, progress,
  evidence and acceptance belong to the realization and three-part stage records.
  Capture stage contracts from that plan; verify input before action and output
  before completion. Offer documentary evidence with an identified explicit
  user-statement fallback. Resume awaiting outputs at validation, not by replay.
- A source edit ends the active manual/interactive realization before new action
  and requires renewed review plus an authorized successor. Verify already
  observed outputs against their original plan; preserve all earlier plans and
  facts. Inherited results retain origin and need an applicability check.
- A collapsed realization is a skill or automated action, not a wrapper around
  another execution journal. Invocation creates no Machine of Goals directory,
  frozen-plan copy, realization document, stage record or index. Keep covered
  initial/intermediate/final checks and authorization in the mechanism.
- Repeatability is independent of automation. No computed plan style,
  registration transition or cumulative invocation statistics are required.
- Preserve safe generated instructions and useful successful commands in the
  manual stage's Actions section, with context, observed results and replay
  constraints. Recorded commands do not authorize replay or automatic execution.
- Inspect manual progress by following the goal's existing links to the
  applicable realization and reading its status/current-stage and Stage Map.
  Do not guess activity solely from the newest filename or mirror its progress.
- Import/export retains context, model/plan distinction, paths, automation
  definitions and validation contracts. Imported editable material remains a
  model; import never authorizes execution or a new local execution baseline.
  Historical provider plans may remain historical package evidence. Existing
  user-artifact conversion/migration requires separately authorized scope.

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

## Project Rules Entry

Before normal entry questions or catalog selection, follow the canonical
workflow's Project Rules Loading Protocol for the active user project. Load
common rules and this machine's rules; absence of `.double-rules/` is normal.
