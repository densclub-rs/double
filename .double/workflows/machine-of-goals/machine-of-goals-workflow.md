---
style: double
submodule: machine-of-goals
id: machine-of-goals-workflow
kind: workflow
status: release-candidate
interaction-language: en
artifact-language: en
derived-from:
  - ideas/machine-of-goals/machine-of-goals.md
  - ideas/machine-of-goals/machine-of-goals-concepts.md
  - ideas/machine-of-goals/machine-of-goals-principles.md
---

# Workflow: Machine of Goals

## Purpose

This workflow defines the first working draft of Machine of Goals.

Machine of Goals helps transform a user's goal description into a verifiable
goal, discover possible paths, synthesize a plan, choose a realization strategy,
realize the plan through iterative work, validate results, and optionally
package or export the resulting plan.

The current working flow:

```text
Goal Formulation
-> Path Discovery
-> Plan Synthesis
-> Plan Review and Decision
-> Plan Realization
-> Plan Validation
-> Plan Packaging / Export
```

## Working Thesis

Machine of Goals does not require a final complete plan before realization.

`Plan Synthesis` produces a project of a plan: a sufficiently understandable
transition model from the current state toward the target state. The plan is
expected to gain detail during the main work cycle:

```text
Plan Realization <-> Plan Validation
```

During this cycle, plan stages may be refined, validation specifications may be
created, external implementation may happen, automation may be introduced, and
the plan may be revised as the goal becomes clearer through execution.

## Version Knowledge Rule

The machine version is preserved only in
`knowledge/machine-of-goals-version/machine-of-goals-version.md`. Changes to
the structure of steps, artifact contracts, modes, execution policy, validation
policy, or transition conditions require the version knowledge to be updated
through the Double Agent protocol.

## Catalog Interpretation Rule

The `.double/` directory is the working catalog of Double.

Machine of Goals working files should be placed in subdirectories named
`machine-of-goals` when the file belongs to a specific workflow, agent, role,
mode, prompt, template, registry, or skill of this submodule.

Goal artifacts themselves are not process files. They belong in the goal working
context defined by Machine of Goals, not in this workflow directory.

When Machine of Goals starts work on a new goal, the agent must ask the user
which target catalog should contain that goal's artifacts. If the user does not
choose another catalog, use `goals` in the current working directory. Inside
that catalog, create one directory per goal and place the goal artifact and
related artifacts there, following the Double layout naming convention:
kebab-case directory names, and a Markdown file inside each directory with the
same name as that directory.

The goal artifact filename must be `<goal-id>.md`, where `<goal-id>` is the
name of the goal directory.

## Machine Operating Change Routing Rule

When the user requests the creation, modification, movement, or removal of a
Machine of Goals operating artifact under `.double/`, activate
`.double/skills/double-agent/SKILL.md` and suspend normal workflow-agent
editing for that request.

Before any working-file change, verify that `double-agent` is installed and
available. If it is unavailable, do not change a `.double/` file; require
installation first, then activate the Double Agent Skill.

A request that mixes Machine of Goals operating changes with user artifact
changes under `goals/` must be split into separately planned steps. The normal
Machine of Goals workflow agent remains responsible for the user artifact
portion.

## Default State

If Machine of Goals starts without an existing goal artifact, the initial state
is considered to be:

- current-step: `01-goal-formulation`
- current-mode: `clarification`
- goal-catalog: `ask-user`, default `./goals`
- interaction-language: `ask-user`
- artifact-language: `ask-user`
- expected-output: `goal-artifact`
- available-actions:
  - `describe-goal`
  - `clarify-goal`
  - `inspect-existing-goal`
  - `look-for-existing-analog`
  - `choose-mode`
  - `inspect-workflow`

If the user starts from an existing goal, plan, imported plan, or subgoal, the
agent should infer the current step from the artifact state and explain that
inference before advancing.

## Active Workflow Guidance

Machine of Goals agents must behave actively after processing a user request.
Every response that produces, updates, inspects, or explains workflow material
should end by offering the next useful movement through the workflow.

The agent should propose one to three concrete next steps, grounded in the
current artifact state and transition conditions. Each proposal should name the
workflow step, mode, responsible agent, and expected artifact when those are
known.

This guidance is not permission to advance silently. When a next step would
create or modify artifacts, execute work, call external systems, import or
export material, or change goal or plan execution state, the agent must ask for
user confirmation before performing that step.

During `01-goal-formulation`, unresolved `Open Questions` keep the goal in
`clarification`. The agent must state that path discovery is not yet available,
offer to resolve the questions one by one, and wait for each user response
before proceeding to the next question. The agent may offer transition to
`02-path-discovery` only when no open questions remain and the goal is
sufficiently clear to search for paths.

During `02-path-discovery`, unresolved `Open Questions` keep the goal in
`research`. The agent must state that Plan Synthesis is not yet available,
offer to resolve the questions one by one, and wait for each user response
before proceeding to the next question. The agent may offer transition to
`03-plan-synthesis` only when at least one plausible path exists and no open
questions remain, unless the goal is marked blocked, infeasible, or requiring
reformulation.

The agent may skip the proposal only when the user explicitly asks for no next
steps, asks for a narrow answer only, or the current state is blocked and no
meaningful workflow movement is available. In that case, the agent should say
what information or decision would unblock the workflow.

## Modes

The first draft assumes these cross-step modes. Draft contracts are defined in
[Machine of Goals Modes](../../modes/machine-of-goals/machine-of-goals.md).

- `clarification`: formulate, refine, and disambiguate user intent
- `research`: inspect available context and possible ways to reach the goal
- `planning`: create or revise the plan as a transition model
- `review`: compare plan options and prepare a realization decision
- `execution`: move through selected plan stages
- `validation`: verify stage attempt results or overall goal achievement
- `explain`: explain the current goal, path, plan, stage, decision, or check
- `dry-run`: simulate an execution stage without real-world effects
- `import`: adapt an existing goal, plan, or reusable analog into this context
- `export`: package a goal, plan, runbook, specification, workflow, or checklist

## Agents

The first draft uses five core agents plus one optional exchange agent. Draft
contracts are defined in
[Machine of Goals Agents](../../agents/machine-of-goals/machine-of-goals.md).

Core agents:

- `goal-formulation-agent`: formulates a user intention as a verifiable goal
- `path-discovery-agent`: discovers and compares possible realization paths
- `plan-synthesis-agent`: creates the plan project and supports the review
  decision checkpoint
- `plan-realization-agent`: creates or resumes a run and realizes selected plan
  paths within approved boundaries
- `plan-validation-agent`: validates run or goal results and updates the run
  and aggregate realization statistics

Optional agent:

- `plan-exchange-agent`: imports and exports plans, plan fragments, runbooks,
  workflows, specifications, and exchange packages

## Templates

Draft artifact templates are defined in
[Machine of Goals Templates](../../templates/machine-of-goals/machine-of-goals.md).

- `goal-artifact` -> `.double/templates/machine-of-goals/goal-template.md`
- `path-options` -> `.double/templates/machine-of-goals/path-options-template.md`
- `plan-artifact` -> `.double/templates/machine-of-goals/plan-template.md`
- `realization-decision` -> `.double/templates/machine-of-goals/realization-decision-template.md`
- `plan-run` -> `.double/templates/machine-of-goals/plan-run-template.md`
- `run-index` -> `.double/templates/machine-of-goals/run-index-template.md`
- `exported-plan-package` -> `.double/templates/machine-of-goals/exported-plan-package-template.md`

## Plan and Path Rule

Each goal has one plan artifact at `<goal-directory>/plan.md`. The plan is the
stable model of transition from the initial state through required intermediate
states to the final state. Different achievement alternatives are selectable
paths, branches, or subplans inside this model, not separate plan variants.

`path-options.md` begins as the Path Discovery output and remains a living
registry after plan synthesis. It records path lifecycle, the corresponding
plan branch or subplan, registered realizations, and aggregate execution
statistics. Unrealized paths may be removed over time when they have no retained
plan, realization, or statistics dependency.

## Plan Realization Registration Rule

A realization is a manual or automatic projection of the complete plan or of
specific paths or subplans. A shell script, Python program, workflow, agentic
process, or manual procedure may be registered as a realization.

Every run must select a registered realization. If a single-pass plan has no
realization yet, Plan Review registers the selected manual or interactive
realization before the first run. Manual or interactive registration does not
change the computed style.

Every registered realization has:

- a stable realization id and kind
- supported paths or subplans
- registration and readiness status
- alignment status against the current plan
- cumulative run count
- latest run time
- latest run result

Automatic realizations must implement validation of the initial state, required
intermediate results, and final state defined by the plan. Creating an
implementation file does not register it. Registration occurs only when the
realization is added to the realization registry in `path-options.md`.

## Computed Plan Style Rule

Plan working style is computed from active realization registrations:

- no registered automatic realization -> `single-pass`
- an automatic realization registered for the plan or a subplan ->
  `multi-pass`

Registration is the style transition point. The machine does not wait for the
first successful validation. Readiness and alignment remain separate
realization statuses and must not be inferred from the computed style.

The single-pass workflow closes after the concrete realization and validation
of the goal. The multi-pass workflow supports repeated runs, import into another
project, and revision of the plan or realization from later execution
experience.

## Contextual Navigation and Artifact Reference Rule

Machine of Goals uses contextual Markdown navigation. A link belongs in the
section, sentence, list item, or table cell where its relationship is useful;
artifacts must not add a repeated universal navigation block merely to enumerate
neighboring files.

Frontmatter references provide machine-readable identity and provenance. They
do not replace human-facing Markdown links in the artifact body. Standard
Markdown links are required; wiki-style links and absolute local filesystem
paths are not portable artifact navigation.

The required contextual relationships are:

- a goal's related-goal and Machine of Goals artifact sections link to the
  related goal, plan, path registry, decision, and run index artifacts that
  actually exist
- a path registry's `Source Goal` links to the goal, each planned path links to
  its plan stage or subplan anchor, and each registered realization links to its
  definition or implementation artifact when one exists
- a plan summary links to its source goal; plan-map and stage-detail links
  connect stages, paths, subplans, input and output artifacts, realizations, and
  evidence in the contexts where they are used
- a subgoal links to its parent goal in its goal context, and the parent plan's
  integration boundary links to the subgoal, subgoal plan, exchanged artifacts,
  and continuation stage
- a realization decision links to the selected plan revision, paths or
  subplans, realization revision, and first stage
- a run context links to its source goal, realization decision, exact plan
  revision, exact realization revision, and selected paths or subplans; run
  stages, produced artifacts, and evidence link to their sources in the
  corresponding run sections
- an exported package links to source artifacts, reusable material, and
  validation evidence in their existing contextual sections

Artifacts and addressable plan elements use stable explicit HTML anchors. An
artifact anchor matches its frontmatter `id`; path, realization, and stage
anchors use their stable ids. Cross-artifact fragment links target these
explicit anchors rather than renderer-generated heading slugs.

A goal, subgoal, plan, subplan, path, or realization from another project may
be used without Plan Exchange by declaring a direct reference at the point of
use. The reference records:

- `relation: direct-reference`
- stable source `project-id` and `artifact-id`
- `revision: current` or an exact revision or VCS reference
- `link-scope: workspace` or `remote`
- a contextual Markdown link to the referenced artifact or explicit anchor

Every Machine of Goals semantic artifact records the stable `project-id` of
its owning project. Agents must use the declared id and must not silently infer
cross-project identity from a checkout directory name.

Direct reference does not copy, adapt, or import the source. The referenced
artifact keeps its own source-goal context, so navigating into it provides a
route to its origin without requiring the provider project to maintain a
consumer backlink. Use Plan Exchange only when material is copied, adapted, or
packaged.

Planning may explicitly follow `revision: current`. A realization decision and
every concrete run must pin resolvable exact plan and realization revisions.
An integer revision without a link to an immutable snapshot or VCS permalink
is not sufficient. Plan revisions remain versions of the single `plan.md`, not
alternative plan variants.

## Plan Run Rule

Mutable execution state is stored outside `plan.md`. Every concrete execution
creates one `plan-run` working artifact:

```text
<goal-directory>/run/<realization-id>--<YYYYMMDDTHHMMSSZ>.md
```

The run records the plan and realization revisions, selected paths or subplans,
initial-state validation, stage checkboxes, concise execution notes,
intermediate validation, blockers, final-state validation, and terminal result.
The run, not `plan.md`, is the source of execution status.

Run logs are bounded working context. The default retention depth is the latest
five terminal runs per realization and may be configured from three to five.
Active runs do not count toward the terminal-run limit. When the limit is
exceeded, remove the oldest unpinned terminal run only after the new run has
updated aggregate statistics. Product artifacts and external evidence are not
removed with a working run log.

`path-options.md` stores cumulative run statistics without links to individual
run files. The cumulative count must not be recomputed only from the bounded
contents of `run/`.

`run/index.md` is the contextual navigation index for active, pinned, and
retained run files. It links each retained run to its exact plan and realization
revisions. `path-options.md` may link to this index from `Run Retention`, but its
realization statistics table must not link individual run files. When retention
removes a run, remove its live link from the index only after aggregate
statistics have been updated; do not leave a broken link.

When a run file is created, increment the realization's cumulative run count,
set latest run time to the run start time, and set latest result to `running`.
Terminal validation replaces only latest result; it does not increment the run
count again.

Canonical semantic artifacts remain at the goal-directory root:

- `<goal-id>.md`
- `path-options.md`
- `realization-decision.md`
- `plan.md`

The run navigation artifact remains at `<goal-directory>/run/index.md`.

Source code, product files, automatic realization artifacts, and external
evidence remain in their normal project locations and are identified by the
realization registration or current run.

## Import and Existing Analog Rule

Machine of Goals starts from goal formulation, not from import.

During `Goal Formulation`, the machine may look for an existing analog of the
goal or plan in a local catalog, future marketplace, or user-provided material.
If a useful analog exists, it may be imported or adapted instead of inventing a
plan from scratch.

When the source remains authoritative in its original project and no adaptation
is required, record a contextual direct reference instead of invoking import or
export. Import remains the path for copied or adapted material.

Until a marketplace exists, the normal working behavior is to formulate and
clarify the goal directly from the user's description.

## Subgoal Rule

A goal may be split into subgoals when an intermediate target needs its own
clear context, path analysis, or plan.

A subgoal uses a simpler Machine of Goals flow:

```text
formulate subgoal
-> discover and analyze paths to the subgoal
-> synthesize subgoal plan
-> connect the main plan to the subgoal plan
```

The subgoal directory must be created inside the main goal directory. For a
main goal directory `<goal-catalog>/<goal-id>`, the subgoal directory is:

```text
<goal-catalog>/<goal-id>/<subgoal-id>
```

The subgoal directory and its main Markdown artifact must follow the Double
layout naming convention: kebab-case directory names, and a Markdown file
inside the directory with the same name as that directory.

The subgoal artifact filename must be `<subgoal-id>.md`, where `<subgoal-id>`
is the name of the subgoal directory.

The subgoal artifact records:

- `goal-scope: subgoal`
- `parent-goal-id`
- `parent-goal-directory`
- `subgoal-directory`

The subgoal plan records its own path options and stages, but the main plan
must record the integration boundary:

- entry point into the subgoal plan
- input state or artifact passed from the main plan
- expected output state or artifact returned to the main plan
- exit point from the subgoal plan
- continuation point in the main plan

After this boundary is explicit, the subgoal may be reused as an autonomous
goal or subplan in another plan, as long as import or reuse preserves the link
between its purpose, inputs, outputs, success criteria, and validation evidence.

## Main Realization Loop

`Plan Realization` and `Plan Validation` form the primary working loop of the
machine:

```text
choose next plan stage
-> select registered realization and plan path
-> create or resume plan run
-> explain current stage
-> refine stage if needed
-> prepare validation specification if needed
-> execute, delegate, automate, or hand off externally
-> validate result in dialogue until an explicit decision is reached
-> update run and aggregate realization statistics
-> revise plan or realization if needed
-> review realization alignment if either changed
-> continue, branch, stop, or close goal
```

This loop is where the plan becomes more concrete. The machine may discover
that a stage needs more detail, a validation specification, a subgoal, an
external implementation artifact, or a different realization route.

## Steps

### 01. Goal Formulation

- step-id: `01-goal-formulation`
- default-mode: `clarification`
- purpose:
  - formulate the user's goal as a verifiable target state
  - clarify the subject of the goal, current state, target state, motivation,
    constraints, resources, and success criteria
  - identify obvious subgoals when they are already visible and formulate each
    accepted subgoal as its own goal artifact in a subdirectory of the main goal
  - optionally look for an existing analog of the goal or plan
  - identify unresolved `Open Questions`, state that they block transition,
    and offer to resolve them one by one
- produced-outputs:
  - `goal-artifact`
- transition-condition:
  - the goal is sufficiently clear to search for possible realization paths and
    has no unresolved `Open Questions`
- next-step:
  - `02-path-discovery`

### 02. Path Discovery

- step-id: `02-path-discovery`
- default-mode: `research`
- purpose:
  - discover possible ways to reach the formulated goal
  - discover and analyze possible ways to reach a formulated subgoal when the
    current artifact has `goal-scope: subgoal`
  - include direct, minimal, exploratory, long-term, delegated, automated,
    tool-based, external, or reusable-plan paths
  - compare paths at a preliminary level by fit, risk, cost, and expected value
  - identify unresolved `Open Questions`, state that they block transition,
    and offer to resolve them one by one
- produced-outputs:
  - `path-options`
- transition-condition:
  - at least one plausible path exists and no unresolved `Open Questions`
    remain, or the goal is marked as blocked, infeasible, or requiring
    reformulation
- next-step:
  - `03-plan-synthesis`

### 03. Plan Synthesis

- step-id: `03-plan-synthesis`
- default-mode: `planning`
- purpose:
  - turn one or more paths into selectable branches or subplans of one plan
  - model the plan as a transition from current state to target state
  - synthesize a simpler subgoal plan when the current goal artifact is a
    subgoal
  - include stages, dependencies, resources, risks, checks, stop points,
    subgoals, and known uncertainties
  - when a main plan delegates a stage to a subgoal plan, record the entry and
    exit points between the main plan and the subgoal plan
  - link paths, subplans, referenced artifacts, and integration-boundary
    artifacts where those relationships appear in the plan
  - allow a local or cross-project artifact to remain a direct reference when
    no copy or adaptation is required
- produced-outputs:
  - `plan-artifact`
- transition-condition:
  - at least one plan project is understandable enough to review and choose a
    realization strategy
- next-step:
  - `04-plan-review-and-decision`

### 04. Plan Review and Decision

- step-id: `04-plan-review-and-decision`
- default-mode: `review`
- purpose:
  - act as the commit point before movement through the plan
  - choose the path or subplan for the first run
  - choose a compatible registered realization, or register the selected manual
    or interactive realization before the first run
  - define the first entry point
  - choose the realization mode
  - set automation boundaries, confirmation points, dry-run needs, validation
    strategy, and plan revision conditions
- produced-outputs:
  - `realization-decision`
  - `updated-path-options` when a manual or interactive realization is first
    registered
- transition-condition:
  - the user or responsible agent has selected how the plan will start and under
    which control boundaries it may proceed
- next-step:
  - `05-plan-realization`

### 05. Plan Realization

- step-id: `05-plan-realization`
- default-mode: `execution`
- purpose:
  - create or resume a working `plan-run` for the selected realization and path
  - create or update `run/index.md` so retained runs remain discoverable
  - execute, delegate, automate, or externally realize the selected plan stage
  - refine the stage when necessary before or during work
  - create additional specifications, scripts, workflows, checklists, or
    handoff artifacts when the current stage requires them
  - register a new automatic realization in `path-options.md` when the user
    chooses to make it available for selection
  - recompute plan style immediately when registration changes
  - when creating a run, increment run count and set latest run time and
    `running` result in `path-options.md`
- produced-outputs:
  - `plan-run`
  - `run-index`
  - `updated-path-options` when a realization is registered or a run starts
- transition-condition:
  - the run has produced a stage or final result that can be validated, or is
    blocked and needs plan or realization revision
- next-step:
  - `06-plan-validation`

### 06. Plan Validation

- step-id: `06-plan-validation`
- default-mode: `validation`
- purpose:
  - validate the result of the current run stage or final run result
  - compare evidence with the stage completion criteria
  - conduct validation as a dialogue until the user confirms the stage result,
    rejects it, marks it partial, or asks for revision
  - record the validation decision and terminal result in the current run
  - replace the current realization's latest `running` result with the terminal
    result in `path-options.md` without incrementing run count again
  - preserve plan topology in `plan.md`; revise it only when execution feedback
    changes the intended transition model
  - enforce bounded run retention after terminal statistics have been updated
  - remove retired run links from `run/index.md` without leaving broken links
  - decide whether to continue, branch, revise, stop, or close the goal
- produced-outputs:
  - `updated-plan-run`
  - `updated-run-index` when retention removes a run
  - `updated-path-options`
  - `updated-plan-artifact` only when plan revision is explicitly required
- transition-condition:
  - the current run result has an explicit validation decision and aggregate
    statistics have been updated
- next-step:
  - `05-plan-realization`
  - `07-plan-packaging-export`
  - `01-goal-formulation` when the goal itself must be reformulated
  - `03-plan-synthesis` when the plan project must be rebuilt

### 07. Plan Packaging / Export

- step-id: `07-plan-packaging-export`
- default-mode: `export`
- purpose:
  - optionally package the goal, plan, selected paths or subplans, realization
    registry, registered automatic realizations, validation contracts, and
    supporting evidence for future use
  - import or export a multi-pass plan as a reusable mechanism in another
    project
  - exclude bounded `run/` working logs by default
  - export into a suitable form such as Markdown plan, runbook, checklist,
    workflow, SDD/spec, script scaffold, handoff package, or exchange package
- produced-outputs:
  - `exported-plan-package`
  - `goal-closure-summary`
- transition-condition:
  - the goal is closed, paused, transferred, exported, or intentionally left
    without export
- next-step:
  - `<end>`

## Deferred Contracts

The following contracts are intentionally left for detailed design:

- mode-specific prompts and templates
- marketplace or reusable-plan lookup protocol
- marketplace lookup and distribution formats beyond the local package
