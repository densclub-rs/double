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

## Project Rules Loading Protocol

Project and group rules are ordinary project knowledge, including facts,
settings, conventions, constraints, versions, and change history. Before
selecting a catalog, planning, or writing, resolve the applicable knowledge
for the active user project. This protocol is packaged with each machine.

1. Establish the active project root from the request and context, not the
   installation directory. If it is ambiguous, clarify it before writing.
2. Examine at most three distinct directories: the project root, its immediate
   parent, and that parent's parent. These represent project, nearest group,
   and outer group. Each level is optional; stop at the filesystem root without
   inspecting a directory twice. In each directory use `.double-rules/` and
   its Markdown index `.double-rules/double-rules.md` if usable.
3. For this machine select links under `Common Rules` and its machine-id
   heading at each usable index. Resolve links relative to the index, artifact
   links relative to their containing documents, and catalog settings relative
   to the active project root unless explicitly absolute. Repeated links to
   the same resolved artifact at one level are read once. Missing headings
   contribute no rules. Use existing Machine of Knowledge artifacts and their
   metadata; do not introduce a separate rule template or configuration.
4. Silently skip absent, inaccessible, malformed, broken, draft, expired, or
   otherwise unusable indexes, links, and artifacts. An unusable entry never
   blocks ordinary work or renews a knowledge validity period. At one level,
   if distinct usable artifacts have the same `id`, silently exclude all of
   those conflicting artifacts for that id at that level. A broken entry does
   not invalidate other usable links in an otherwise usable index.
5. For each id select the nearest usable, non-conflicting whole knowledge
   artifact: project, immediate parent, then second parent. Do not merge fields
   or values. If a closer candidate is unusable or conflicting, try the next
   level. Distinct ids remain distinct knowledge. If no usable rule applies,
   use the machine defaults. Semantic overlap of distinct ids is handled by
   Machine of Knowledge, not silently assumed during rule loading.
6. Rules cannot bypass higher-priority instructions, required approvals, or
   validation. Common and machine-specific headings have no inherent priority
   within a level. Release preparation separately performs strict reproducible
   version-source checks on the candidate tree; silent ordinary loading does
   not authorize an ambiguous or external release version source.
7. Rules are user-owned knowledge outside installer-managed `.double/`; preserve
   each level during installation, updates, and removal. Package each machine's
   loading protocol, never a publishing project's or group's actual rules.
   Changes to this protocol require affected machine version updates; editing
   knowledge alone does not require machine releases.

At each level the index is navigation, not a copy of knowledge values. Machine
of Knowledge creates it when the first rule at that level is accepted. It uses
`Common Rules`, `double-agent`, `machine-of-knowledge`, `machine-of-ideas`,
and `machine-of-goals` headings with ordinary relative links; other machine-id
headings may be used and unused headings omitted. No agent-specific entry files
are required.

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

`Plan Synthesis` produces an editable `plan-model`: a sufficiently understandable
transition from the current state toward the target state. This model may gain
detail during the main work cycle; its changed content returns to review. At the authorized start of a documented manual realization, it links to the approved current plan:

```text
Plan Realization <-> Plan Validation
```

During this cycle, the model may be refined through renewed review. Facts and
progress remain in the realization and its stage documents. A collapsed skill
or automated action follows the Automatic Realization Rule without creating
a documented walkthrough for each invocation.

## Version Knowledge Rule

For ordinary work resolve the version source from usable project and group
knowledge using the Project Rules Loading Protocol. If no usable source is
established, use
`knowledge/machine-of-goals-version/machine-of-goals-version.md` as the default.
Ordinary work silently skips invalid or conflicting rule sources and uses the
next usable scope or default. Release preparation uses the strict tagged-tree
version resolution in the Double Agent workflow. Changes to
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
choose another catalog, use the base goal catalog configured by project rules,
falling back to `goals` in the active project root. Inside
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
- goal-catalog: `ask-user`, project-rule base catalog or default `./goals`
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

For the timestamped manual/interactive realization shape, inspect its linked plan, approved revision and digest, `status`, `current-stage`, map,
and corresponding three-part stage record. Resume observed actions awaiting verification at step 06 rather than
repeating them. Unaccepted inputs stay at input clarification in step 05;
Changed content routes to renewed review before further planned action.
A completed realization with accepted goal criteria can remain closed without
export. Do not infer the current shape from `template-id` alone: legacy artifacts may have different plan links, approval evidence, or stage-record structure. Explain any conversion gap and obtain its separate
authorization before writing or executing a converted artifact set.

## Active Workflow Guidance

Machine of Goals agents must behave actively after processing a user request.
Every response that produces, updates, inspects, or explains workflow material
must end by offering the next useful movement through the workflow.

The agent must propose one to three concrete next steps, grounded in the
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

During `04-plan-review-and-decision`, conduct an interactive review and show
model branches/revisions, available paths or subplans, entry points, and their
material trade-offs. Selection context belongs in a documented realization at
its authorized start; no separate registration or decision document is needed.
For a requested collapsed skill or automated action, explain its covered model,
checks and boundaries without creating walkthrough artifacts. Recommend without
selecting on the user's behalf and preserve an exact selection already supplied.

The agent may skip the proposal only when the user explicitly asks for no next
steps, asks for a narrow answer only, or the current state is blocked and no
meaningful workflow movement is available. In that case, the agent should say
what information or decision would unblock the workflow.

<a id="step-completion-handoff-rule"></a>

## Step Completion and Continuation

After completing a workflow step or a plan stage, the responsible agent must
provide a user-facing handoff in the interaction language. An artifact update,
a tool result, or a completion summary alone does not satisfy this contract.

The handoff must:

1. Name the completed workflow step (and plan stage when applicable), summarize
   its result, and link the produced or updated artifacts.
2. Read the current step's `next-step` and `transition-condition` in this
   workflow. Name the eligible next step, mode, responsible agent, expected
   artifact, and why the transition is available. If several routes are
   eligible, show their material differences and recommend one without choosing
   on the user's behalf. Do not present unavailable routes as ready.
3. State the concrete next action and ask whether to continue with it. For a
   single proposed action, use exactly Yes / No in the interaction language
   (Да / Нет in Russian), following the structured-choice rule below. When a
   route must first be selected, obtain that choice before asking for any
   continuation approval not already supplied by the selection.
4. Wait for explicit consent before dependent work. A No means stop here,
   preserving the completed result; it does not reject that result or close
   the goal. Silence, preselection and timeouts do not authorize continuation.

Explicit authorization already covering the named next action or sequence
remains valid: state the next action and that it is covered, then proceed
without asking again. General activation of the machine or permission to
complete the current step does not authorize later steps. Never bypass an
existing mandatory selection, validation decision, or stop point.

Distinguish workflow steps from plan stages. A result produced in
`05-plan-realization` goes to `06-plan-validation` before another plan stage;
execution success alone does not establish validation. After validation, offer
only the applicable routes listed in step 06 and respect dependencies and the
user's validation decision.

In the manual/interactive route, an accepted final goal at step 06 may end
here when the user closes or pauses the work. Explain that outcome without
forcing step 07, inventing an export, or requesting continuation to `<end>`.

If transition conditions are unmet, say that the step is not ready to advance,
name the blocker, and offer the concrete clarification or repair action rather
than claiming completion. At `07-plan-packaging-export` with next-step `<end>`,
state that the workflow has ended; do not invent another required step or ask
to continue to `<end>`. Export remains optional.

The narrow-answer exceptions in Active Workflow Guidance apply to inspection
or explanation requests, not to the handoff after an actually completed step
or plan stage.

<a id="structured-user-choice-rule"></a>

## Structured User Choices

Apply this rule to concrete mode/next-step choices, plan path or subplan
selection, realization choices and validation decisions. Show the relevant
trade-offs and evidence before requesting the choice; preserve every selectable
path rather than silently replacing the set with the recommendation. Keep
open-ended goal clarification free-form. This interface rule does not add
approval gates, select a path, or weaken existing explicit confirmation rules.

Use `request_user_input_async` for a concrete choice or confirmation when it
is exposed and permitted for the question. Supply concise, contextual options
in the interaction language. A recommendation may be presented, but every
material alternative must remain available; do not add an artificial choice
when the user needs to describe something freely.

For an asynchronous question, wait for an explicit submitted response or an
equivalent direct user instruction before dependent edits, execution or state
transitions. A tool acknowledgement that the question was accepted, a
preselected option, silence or a timeout is not user approval. Independent
read-only work may continue while awaiting the answer. Do not ask again for a
choice or authorization the user already supplied.

While a required asynchronous question is pending, do not send a final message
or end the turn merely to acknowledge the question or say that you are waiting.
Use permitted interruptible waits, each no longer than 60 seconds, and continue
waiting for an explicit submitted response or equivalent direct user instruction.
A timeout does not cancel the question, authorize dependent work, or justify
repeating it. Independent read-only work may continue. If the user reports a
missing or disappearing question, investigate without treating tool acceptance
as proof of visibility. This is an agent waiting rule, not a guarantee about
the client UI lifetime.

Check the actual runtime tool availability and its mode/purpose restrictions.
If `request_user_input_async` is unavailable or disallowed, use another exposed
structured-question tool only when permitted for this question; otherwise use
a concise text question with numbered options. Never assume an interface named
`AskUserQuestion` exists or call a planning-only tool for approval when its
runtime contract forbids that use. The client controls the visual presentation;
plain text does not itself create a choice card.

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

<a id="model-and-realization-execution-rule"></a>

## Model and Realization Execution Rule

This rule governs documented manual and interactive realizations. Use
`plan-model-template` for the editable plan, `plan-template` only for a preserved
historical copy, `realization-template` for the timestamped walkthrough and
`stage-realization-template` for stage facts. There is one artifact contract;
no alternative registration or execution-log layer is supported.
Collapsed skills and automated actions follow the Automatic Realization Rule.
Existing user artifacts remain historical; do not silently convert them.

### Model and Selection

- The user-facing artifact name remains `Plan`; use the document heading
  `# Plan: <Goal Title> / <Branch>`. The editable plan and any preserved historical copy
  retain this name. Technical kinds, template IDs, provenance and storage
  context express their different roles; do not rename the document `Plan Model`.
- By default, keep the editable plan at `<goal-directory>/plan.md`. Its sole
  identifier is the generated word in `id`, also used as the root anchor.
  Independent parallel variants use `plan-<id>.md`; an author's own variant
  uses `plan<owner_id>.md`. Apply the [filename rule](#logical-plan-branches)
  when synthesizing each plan, including when discovery already identifies
  the need for parallel variants. Ordinary revisions retain file, `id` and branch.
  Always generate and record one short human-readable word as `id` in frontmatter
  for any new plan. Derive it jointly from the plan's subject, core meaning and
  goal. Do not add a second plan identity field. Use `kind: plan-model`,
  `template-id: plan-model-template`, logical `branch` and an increasing
  `plan-revision` for review. A model revision is not an execution plan version.
  The actual SHA-256 digest identifies the exact reviewed file content;
  a name or revision alone cannot.
- Stages have stable IDs such as `S01`, anchors such as `stage-s01`, and short
  English names/slugs. State required inputs, intended actions, expected
  outputs, dependencies and checks. Exit conditions cover goal success.
  The model never stores execution progress, checkboxes or a realization registry.
- Give input/output conditions IDs formed from their stage ID and their own
  number: `<stage-id>-I<condition-number>` and `<stage-id>-O<condition-number>`.
  Number inputs and outputs independently within each stage, starting at `01`
  with at least two digits: `S01-I01`, `S01-I02`, `S01-O01`, then `S02-I01`,
  `S02-O01` for the next stage. Preserve these IDs in the plan, stage
  records and validation references; do not renumber captured conditions.
- Step 03 produces only the model. At step 04, show a contextual Markdown link
  to the actual current plan file, its content, relevant choices and execution
  boundaries. Ask the user to approve the current contents of that linked file,
  selection and boundaries. Keep the user decision in the conversation and the
  computed content baseline as internal verification evidence; no separate
  decision artifact is required. A checksum is not the user's approval target.
- Approval binds the exact model content, selected path/entry, and execution
  boundaries. Any model edit invalidates that approval for future execution,
  including compatible edits and edits that retain the same filename/revision.
  Return to step 04 before executing the changed content. If the earlier
  approval or approved digest cannot be recovered, review again.
- Model approval and permission to start are distinct. An approved model may
  remain deferred indefinitely without creating an execution plan or realization.
  Existing explicit sequence authorization remains valid only for its exact scope.

<a id="plan-approval-presentation"></a>

### Plan Approval Presentation

Apply this presentation rule to every execution mode. Link the actual current
plan file (`plan.md`, `plan-<id>.md` or `plan<owner_id>.md`, as selected).
Explain the selected path/entry and execution boundaries in ordinary language.
The user approves the current file contents, not a hash or technical identifier.
For example:

> Do you approve the current contents of [Plan](<current-plan-link>), the selected path and execution boundaries?

Use the interaction language and existing Yes / No choice contract. Do not put
a checksum in the question, its title, suggested answers or normal review
summaries, and do not ask the user to compare, copy or approve one. Show a
checksum only if the user explicitly requests that technical information.
Content approval remains distinct from permission to start execution.

Before presenting this request, compute the actual file's SHA-256 as internal
verification evidence. Retain it with the associated user decision in existing
recoverable tool/conversation context, not a new file or self-referential field
in the editable plan. Preserve the fingerprint and pre-start content check:
a file path alone does not detect an edit. If content changes, show the updated
plan link and request renewed content approval. If the decision or baseline
cannot be recovered, review the current linked contents again without asking
the user to supply a checksum. This rule creates no extra approval artifact.

<a id="logical-plan-branches"></a>

### Logical Branches and Plan Filenames

Choose the editable plan's filename when synthesizing it:

| Case | Filename | Identity |
| --- | --- | --- |
| Ordinary plan | `plan.md` | `id: <id>`, root anchor `<id>` |
| Independent parallel variant for the same goal | `plan-<id>.md` | `id: <id>`, root anchor `<id>` |
| An author's own variant | `plan<owner_id>.md` | `id: <id>`, root anchor `<id>`, `owner-id: <owner_id>` |

Generate one short human-readable word as `id` for every new plan, unique within
the goal directory across all plan filenames. The word must be derived from
the plan's context and must jointly express the plan's subject, core meaning
and goal. Synthesize these three concepts into a single meaningful word,
emphasizing what distinguishes this plan from other variants for the same goal.
A readable coined word is allowed. A word reflecting only one of the three
is insufficient. Use lowercase English letters only (`^[a-z]+$`), with no spaces
or hyphens; no digits, hashes or opaque codes. Do not turn the concepts into a
multiword subject-action-goal name. Do not choose a random word or an unrelated
dictionary word. Always write it as `id: <id>` in frontmatter for `plan.md`,
`plan-<id>.md` and `plan<owner_id>.md`. Only a parallel variant includes it in
the filename. Check IDs and filenames before writing and choose another ID on
collision by selecting another word derived from the plan's context that still
combines all three concepts, never adding digits. Keep it stable across revisions.
It is distinct from path IDs, revision numbers and the logical `branch`.
For an author's variant, use the actual author's filesystem-safe `owner_id`,
not the goal owner's ID by default; there is no hyphen between `plan` and
`owner_id`. Do not overwrite another variant on a filename collision; resolve
ownership/naming first. Do not invent a combined parallel/owner suffix convention.

The plan has one identity field, `id`, and its root anchor equals that value.
Do not add `plan-id` or `plan_id` as another identity field on a plan.
Preserved historical copies retain the source plan's id and root anchor.
Their path and source revision identify their provenance. If the source lacks
an id, resolve it before review and execution.

Other artifacts, such as realizations and exported packages,
keep their own `id`. Their `plan-id` is a reference to the selected plan's `id`,
not another identity field on the plan. Links to plans use the actual file
path and its `#<id>` root anchor; stage links keep their stable stage anchors.

Path discovery may identify from the outset that independent variants need
separate plans. Record that in `path-options.md`; synthesize each actual variant
directly with its own filename and `id` in step 03. No prior `plan.md` or later
major divergence is required. Paths/subplans may still live inside one plan.
Parallel stages and different realization media alone do not require separate files.

`branch` tracks each plan's lineage across revisions. Ordinary edits increment
`plan-revision` in the same file with the same `id` and branch; they do not
generate a new `id`. Record each actual plan's branch, review revision and
file/anchor in the goal table, including a sole ordinary plan. Preserve other
variants and their rows; omit the table only before any plan exists. Never add
hypothetical links or infer a new plan from a mode change or new realization.
Existing user filenames and IDs are not silently migrated.

Each variant needs exact-content review and authorized step-05 start before a
realization. Approval and provenance link the actual selected file and id
anchor; never fall back to `plan.md` for a named variant.

### Start and Resume

- At authorized step-05 start recheck the exact approved source digest, path,
  selection and boundaries. A mismatch returns to review before any action.
- Create `_realizations/<YYYY-MM-DDTHH-mm-ss>/realization.md`, recording the
  actual start, timezone, selected source path, revision, approved digest and
  decision. Link the actual main plan and its stage anchors; do not create a
  local plan copy at start. Named plan variants keep their actual paths.
- Resume the existing realization; do not create a new one merely on resumption.
  Before action check the current plan against the approval; review changed
  content again. Validate previously observed results against the conditions
  captured before action, even if the main plan has changed.
- Keep progress and stage map in the realization, and capture effective input
  conditions, intended actions, outputs, checks and dependencies in each
  three-part stage record before acting. Link the plan actually used. Render
  each stage state as one emoji with its legend above the map.

### Input, Action, and Output

1. Orient the user: show the current linked plan stage, required input conditions,
   intended action, expected output conditions, and how they will be checked.
   State relevant dependencies and existing stop points.
2. Verify the linked plan and check its content digest against approval before acting. Verify every required
   input against the captured conditions. Offer relevant documentary evidence: screenshot, photograph,
   document, or observed command output. Record what was requested and supplied.
3. Inspect what the evidence establishes. If documentary evidence cannot be
   supplied, an explicit user statement addressing the condition can support
   acceptance. Preserve its words and known attribution, clearly labeled as a
   user statement. Do not present it as independent documentary verification.
   Silence, a vague acknowledgment, an unrelated attachment, and an expected
   result are not confirmation. One request can cover related conditions;
   respect an explicit answer that documents are unavailable.
4. Act only after inputs are accepted and within approved boundaries. Record
   actual actions, outcomes, and meaningful deviations in Actions. Preserve
   generated command instructions and corrections in order with safe working
   context; record observed results honestly and do not infer all commands
   succeeded from the last exit code. Do not introduce collapsing or register
   an automatic realization as a side effect of this route.
5. Hand off from step 05 to step 06 after action, showing `🟠` in the realization map.
   Explain awaiting verification in the progress summary when useful. Compare actual outputs
   with captured output conditions. Offer documentary evidence here too; use
   the same explicit-statement fallback when unavailable. Keep a failed or
   unconfirmed condition visible; do not mark the stage completed.
6. Record each decision and its basis in Output State and reflect the recorded
   outcome with the matching emoji in the main map. Use `✅` only
   after all required outputs are accepted; partial, failed, blocked or
   needs-revision results keep their own markers. Preserve the distinction
   between documentary and explicit user-statement confirmation. Keep
   current-stage focused on unresolved work; never mirror progress into the model.
7. After accepted output, derive eligible next stages from dependencies, show
   the recommendation, and apply the existing continuation/handoff rule. At an
   exit, verify the goal's target/success criteria and carried-result
   applicability. A realization completes only after those conditions are
   accepted, with a concise result and confirmation basis in the main document.
   Goal closure need not create an export or another validation artifact.

<a id="realization-progress-emojis"></a>

### Realization Progress Emojis

In the timestamped realization's Stage Map, each State cell contains only a
single emoji. Place the explanatory legend above the table; do not append a
state name or add a duplicate text-status column. This keeps the map compact.
Progress summaries/handoffs still use emoji and may add a short label or
explanation in prose. The legend and prose use the artifact or interaction
language as appropriate. These meanings apply to documented realizations.

| Stage state | Emoji | Meaning |
| --- | --- | --- |
| pending | ⚪ | Not started |
| in progress | 🔄 | Stage work in progress; planned action still requires accepted inputs |
| awaiting verification | 🟠 | Action observed; output verification pending |
| completed | ✅ | All required output conditions verified and accepted |
| partial | 🟡 | A partial result is recorded; the stage is not complete |
| blocked | ⛔ | A blocker prevents further work or acceptance |
| failed | ❌ | A failed or rejected result is recorded |
| needs revision | 🛠️ | Recorded review/revision is required before continuation |
| not selected | ➖ | Outside the selected path for this realization |

Initialize unstarted State cells with `⚪`. Use `🔄` when work starts and `🟠`
after action. Validation records the actual result before choosing its marker.
A successful command, produced file or unconfirmed outcome cannot yield `✅`. Do not mark every non-success
as blocked: retain a recorded partial, failed or needs-revision result accurately.
Mark an unselected alternative `➖`, not pending or failed.

Include a compact legend above the map in each new realization document.
State cells contain only emoji; the legend supplies their meanings. Keep
observed facts and the evidence/confirmation basis in Result or the stage
record rather than duplicating status words in the table. The emoji does not
replace facts. These are presentation markers for
stage outcomes, not new metadata keys or permissions. Preserve existing textual
frontmatter status values and `current-stage`. Progress lives in realization
and stage records; never add it to the main plan or preserved historical copy.

### Model Change and Succession

Before changing a plan, compare stage and substage composition, identities and
numbering, including nested stages. A change to any of these is structural.
Find all previous realizations referencing that exact plan, including completed
ones, and inspect their existing links and plan copies. Do not assume a
realization needs conversion merely because it predates this contract.

Before applying a structural change, ask explicitly whether to preserve the
integrity of the affected previous realizations. While the decision is pending,
do not change the plan. If yes, preserve the actual old plan as `plan.md` in
each affected realization before editing the main plan. Preserve content,
identity, stage anchors and conditions; rebase relative links so they resolve
from the new location, verify equivalence, and update the realization and stage
links and metadata to refer to this local copy. Update affected goal-table plan
links as well; leave references to other plan copies unchanged. Never overwrite
an existing file; resolve a collision with the user. Verify every updated link before
changing the main plan. Existing historical copies remain intact when already
sufficient; do not rewrite facts or silently migrate legacy artifacts.

If the user declines preservation, offer deletion of the affected realizations,
identifying the exact directories. Deletion requires separate explicit consent;
if declined or pending, do not delete or apply the structural change. After
authorized deletion, remove only the corresponding obsolete navigation rows;
if deletion fails, do not apply the structural change. Never infer deletion
consent from the decision not to preserve. After preservation or
separately authorized deletion, edit and review the main plan. A newly started
realization links the updated main plan, not a local copy.

A nonstructural edit needs no local plan copy. It invalidates prior approval for
future actions; review the changed content again. Preserve recorded stage
conditions, actions, results and acceptance and validate observed output against
the conditions captured when that stage was performed. Do not retroactively
rewrite facts. Decide continuation or a successor under the existing workflow and
user authorization; inherited results retain origin and require applicability
checks. The approval hash detects content changes, but does not replace consent.

### Boundaries

Documented realizations and evidence are retained for verification and reuse.
Never delete earlier versions automatically. Cleanup or conversion of existing
user artifacts requires separately authorized scope. Collapsing a method into a
skill or automated action is optional and never an incidental effect of stage
execution.

<a id="plan-model-execution-boundary"></a>

## Plan Model and Execution Plan Boundary

The selected editable file may be `plan.md`, `plan-<id>.md` or
`plan<owner_id>.md`, under the filename rule. The plan is a model in every mode.
Neither main plans nor preserved historical copies contain
execution progress, current-stage, actual results, acceptance, realization
registries, execution counters or displayed-execution metadata. Executing or
validating a stage never modifies the plan to reflect progress.

| Boundary | Documented manual/interactive realization | Collapsed skill or automated action |
| --- | --- | --- |
| After step 03 | Editable plan model only | Editable plan model only |
| After step 04, start deferred | Approval and selection in conversation; model unchanged | Approval/authorization context; no execution record |
| Authorized start | Create `realization.md` linked to the approved main plan; no local copy | Invoke the authorized skill/action; create no Machine of Goals execution directory, snapshot or journal |
| Execution and validation | Facts and progress in the realization and its stage documents | Covered checks and result belong to the skill/action's execution; no Machine of Goals walkthrough is materialized |

Approval of model content and permission to start remain distinct. Steps 03
and 04 create no execution artifacts. Any model edit requires renewed review
before future planned action. Apply the structural-change preservation decision before editing stage topology; preserve earlier facts.

To inspect progress, use the goal's existing Machine of Goals Artifacts section
to open the applicable realization. Read its status, current-stage and Stage
Map, then the stage documents for facts and evidence. Do not infer the active
realization from the newest filename alone; show no active realization or
multiple candidates explicitly. Do not create a second progress dashboard in
the goal or model. Automatic invocation needs no synthetic active-realization row.

Older user artifacts retain their original meaning and are not an alternate
current operating contract. Conversion requires separate authorization.

## Agents

The first draft uses five core agents plus one optional exchange agent. Draft
contracts are defined in
[Machine of Goals Agents](../../agents/machine-of-goals/machine-of-goals.md).

Core agents:

- `goal-formulation-agent`: formulates a user intention as a verifiable goal
- `path-discovery-agent`: discovers and compares possible realization paths
- `plan-synthesis-agent`: creates the plan project and supports the review
  decision checkpoint
- `plan-realization-agent`: creates or resumes the selected realization and
  acts within verified input conditions and approved boundaries
- `plan-validation-agent`: checks stage or goal results and records the
  decision and evidence in the applicable execution shape

Optional agent:

- `plan-exchange-agent`: imports and exports plans, plan fragments, runbooks,
  workflows, specifications, and exchange packages

## Templates

Draft artifact templates are defined in
[Machine of Goals Templates](../../templates/machine-of-goals/machine-of-goals.md).

- `goal-artifact` -> `.double/templates/machine-of-goals/goal-template.md`
- `path-options` -> `.double/templates/machine-of-goals/path-options-template.md`
- `plan-model` -> `.double/templates/machine-of-goals/plan-model-template.md`
- `plan-artifact` -> `.double/templates/machine-of-goals/plan-template.md`
- `realization-artifact` -> `.double/templates/machine-of-goals/realization-template.md`
- `stage-realization` -> `.double/templates/machine-of-goals/stage-realization-template.md`
- `exported-plan-package` -> `.double/templates/machine-of-goals/exported-plan-package-template.md`

## Template Provenance Rule

Every artifact created from a Machine of Goals template records the stable
top-level `id` of that template in its frontmatter `template-id`. The value is
an identifier, not a filesystem path and not the generated artifact id.

Edits and preserved historical copies retain their source template and producer
metadata. `plan-template` supplies preservation guidance; it does not convert a
copy into a newly produced plan. Imported material receives a Machine of Goals
`template-id` only when adapted into an artifact created from that template.

## Plan and Path Rule

The editable plan models expected transitions, dependencies, checks, choices
and control boundaries. Apply the filename rule for ordinary, parallel and
author variants. Logical branches track revision lineage, not execution state.

`path-options.md` is the living catalog of possible achievement paths and their
comparison. Link actual plan stages or subplans when synthesized. Preserve a
path needed to understand retained realization evidence. Path discovery creates
no execution records, registration rows or automatic invocations.

## Automatic Realization Rule

A collapsed realization is an AI-agent skill, an automated action, or a requested
combination. The reusable mechanism embodies the method; it is not a wrapper
around another execution record. Its invocation creates no Machine of Goals
realization directory, frozen plan, stage journal, registration, execution index
or cumulative statistics. Do not add a second record under another name.

Preserve the covered model's initial, required intermediate and final state
checks, explicit selection, authorization and stop points in the mechanism.
Automatic action does not bypass validation or grant wider permissions. Its
own result, product artifacts and native operational output follow that
mechanism's contract; Machine of Goals imposes no additional storage layer.

Collapsing is optional and requires a separate user request. A skill can guide
an agent and an automated action can perform covered work; neither implies the
other. Using a tool or script inside a documented walkthrough still records
that walkthrough's actual stage actions and evidence. Repeatability does not
require automation and does not create a computed plan style.

This rule defines the artifact boundary, not a new skill-generation procedure.
Use the requested mechanism's applicable creation and execution contracts.

## Contextual Navigation and Artifact Reference Rule

Machine of Goals uses contextual Markdown navigation. A link belongs in the
section, sentence, list item, or table cell where its relationship is useful;
artifacts must not add a repeated universal navigation block merely to enumerate
neighboring files.

Frontmatter references provide machine-readable identity and provenance. They
do not replace human-facing Markdown links in the artifact body. Standard
Markdown links are required; wiki-style links and absolute local filesystem
paths are not portable artifact navigation.

The goal links its actual editable plan variants and documented realizations
with their actual linked plans in the existing Machine of Goals Artifacts section.
Realizations link their goal, applicable main or preserved plan and stage records;
stage records link that plan and evidence. Progress is read there only.
Never add a link to an execution document that does not exist.

Path options link their source goal and applicable plan stages/subplans. Plans
link goal context, stages, dependencies and subgoal integration boundaries.
Subgoals link their parent context; exported packages link their selected source
artifacts and evidence. A collapsed skill/action may be referenced in context
without creating a proxy realization record for its invocation.

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



<a id="plan-revision-history-rule"></a>

## Plan Revision History Rule

Editable revisions retain the same file, id and branch and increment the review
revision. Renew approval before future action. Follow Model Change and Succession
before any structural edit; ordinary edits do not create a local copy. At start,
a realization links the actual approved main plan. Its captured stage facts
preserve the original conditions used for observed actions and validation.

<a id="stage-contract-rule"></a>

## Stage Contract Rule

Before action in a documented realization, capture the effective input
conditions, intended action and output conditions from its linked approved plan
in the stage document. Preserve stable stage and condition IDs, dependencies,
checks, approved boundaries and stop points. Rebase copied links as needed.
A mutable plan link alone does not replace captured stage conditions.

Validate against this captured content and its evidence. Preserve facts and
original requirements when inheriting results; check applicability against the
successor's conditions and dependencies. Never relabel an inherited action as
newly performed or invent missing historical contracts. Final goal validation
also checks the applicable goal criteria; historical stage acceptance alone
does not establish current goal achievement.

<a id="successful-command-reuse-rule"></a>

### Successful Commands for Reuse and Automation

Preserve useful commands in the Actions part of the manual stage document.
Append every instruction generated for human execution before or when presented,
including corrections and superseded instructions, without overwriting history.
Record successful plan-action and validation commands after observed success
and before stage acceptance, with generation/execution order, purpose, working
context, exact safe command, result and replay constraints. Use protected-input
references instead of secrets and known times only.

Check each retained command's actual result; a group's last exit code does not
prove earlier success or fulfillment of a condition. Failed attempts and
incidental bookkeeping need not form a full tool trace, but preserve relevant
failures and blockers honestly. Recording a command does not authorize replay,
automation or collapsing. Automatic invocations have no required Machine of
Goals command journal. Their mechanism's checks and result remain authoritative.

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

A subgoal is a goal used within another goal's plan, not a separate goal type. Any goal may serve as a subgoal, and any subgoal may be pursued as an autonomous goal. The same goal may play both roles at once. These roles are determined by explicit relationships and plan integration boundaries, not by a `goal-scope` field. Workflow depth and plan detail depend on the goal's needs, not on its role.

When connecting a goal as a subgoal, the integration sequence is:

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

For manual and interactive execution:

```text
approve exact model content, branch and entry stage
-> at authorized start link main plan and create realization, or resume existing
-> show current stage and capture its conditions
-> check plan approval and input conditions
-> perform the authorized action and record facts
-> hand off to output validation
-> verify observed outputs against captured conditions
-> update the realization map and explain the result
-> continue within consent, review revisions, pause, or close
```

Both input and output verification request documentary evidence with an
explicit user-statement fallback. Output validation precedes the next plan
stage. Use the existing continuation handoff, preserving already supplied
sequence authorization. The authoritative details are in the
[Model and Realization Execution Rule](#model-and-realization-execution-rule).



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
  - extend or revise the path catalog when new possibilities appear over time
  - discover and analyze paths for the same goal contract whether the goal is
    autonomous, used as a subgoal, or both
  - include direct, minimal, exploratory, long-term, delegated, automated,
    tool-based, external, or reusable-plan paths
  - compare paths at a preliminary level by fit, risk, cost, and expected value
  - identify when paths warrant independently developed parallel plan variants;
    record this in the path catalog for step-03 synthesis under the filename rule,
    without creating plan or execution files during discovery
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

#### Manual and Interactive Execution

- purpose: synthesize understandable branch/revision models with stable stage
  IDs, English slugs, dependencies and explicit input/output checks. Use `plan.md`
  for an ordinary plan, `plan-<id>.md` for each independent parallel variant,
  or `plan<owner_id>.md` for an author's variant. Discovery may establish the
  need for separate variants before synthesis; no prior default plan is required.
  Generate one short human-readable word as `id` for every new model and
  always write it in frontmatter. Derive the word from the plan's context:
  jointly express its subject, core meaning and goal in that single word.
  Paths/subplans may also remain choices inside a plan. Record actual files in
  the goal table and retain their identities across ordinary revisions.
- produced-outputs: `plan-model` from `plan-model-template`.
- transition-condition: a model is understandable enough to present its
  branches/revisions, entry stages, and control boundaries for explicit choice.
- next-step: `04-plan-review-and-decision`.
- do not put execution progress, acceptance, registration or execution statistics
  in the model. Include required subgoal entry/exit boundaries and direct artifact
  references where they are used, without creating extra process documents.



### 04. Plan Review and Decision

- step-id: `04-plan-review-and-decision`
- default-mode: `review`
- purpose: link the actual current plan file, present its contents, relevant
  branches/paths/subplans and entry points, explain trade-offs and obtain
  explicit approval of those linked contents, selection and execution boundaries.
  Keep content fingerprints internal under the Plan Approval Presentation rule.
  For a requested collapsed mechanism, explain its checks and authority without
  creating execution records.
- produced-outputs: `approved-model-selection` in the conversation, identifying
  the linked current plan, its approved contents, selected path/entry and
  boundaries; preserve the computed digest separately as internal verification
  evidence, not in the user-facing approval request;
  no new execution file is produced.
- transition-condition: model content and selection/boundaries are approved;
  the model may remain here with start deferred. Advancing to step 05 additionally
  requires explicit start authorization, including already supplied exact consent.
- next-step: `05-plan-realization` only when start is authorized, or remain at
  this completed review with the model only when start is deferred.
- Any model edit requires renewed review. Do not create a realization, registration or separate decision file at review. Structural edits follow the preservation decision before the edit.

### 05. Plan Realization

- step-id: `05-plan-realization`
- default-mode: `execution`

#### Manual and Interactive Execution

- purpose: at authorized start recheck exact approval and
  create the timestamped realization linked to the main plan; on resume verify the linked plan, orient
  to its current plan stage, capture the stage contract, verify input conditions, act within
  authority, and record actual actions and outputs in the three-part stage file.
- produced-outputs: `realization-artifact`,
  `stage-realization`, and evidence
  linked directly where relevant. Update the existing main map on resume.
- transition-condition: action has an observed result ready for output
  verification; missing inputs block action, and model changes require renewed
  review before continuing against changed content.
- next-step: `06-plan-validation` for observed output; clarification or
  `03-plan-synthesis`/`04-plan-review-and-decision` when a model change requires it.
- preserve safe commands and corrections in Actions, and apply the evidence
  request/statement fallback to inputs. No additional execution layer is produced.

#### Collapsed Automatic Execution

- purpose: invoke an existing requested skill/action within its approved scope,
  preserving covered state checks and stop points. This route does not generate
  a new automation mechanism implicitly.
- produced-outputs: the mechanism's actual result and requested product outputs;
  no Machine of Goals execution artifact is created.
- transition-condition: the mechanism returns an observed result or explicit
  blocker under its contract; invocation alone is not proof of success.
- next-step: validate the result under that mechanism's covered criteria;
  return changed models to review before executing changed content.

### 06. Plan Validation

- step-id: `06-plan-validation`
- default-mode: `validation`

#### Manual and Interactive Execution

- purpose: validate captured output conditions using
  documentary evidence or explicit user statements, record decisions and basis
  in the stage file, and update only the realization map/current stage.
- produced-outputs: updated `stage-realization` and `realization-artifact`;
  the main Result records final goal acceptance and its confirmation basis.
- transition-condition: a recorded decision exists for the applicable
  conditions. Unconfirmed outputs remain awaiting verification or blocked;
  completion requires accepted exit conditions and goal success criteria.
- next-step:
  - `05-plan-realization` for an eligible next stage within continuation consent
  - `04-plan-review-and-decision` for another model/branch or changed boundaries
  - `03-plan-synthesis` for a changed model, applying the structural-change rule first
  - `01-goal-formulation` when the goal must be reformulated
  - `<end>` when the goal is validated and the user closes or pauses here
- a successor inherits only applicable results and keeps their original facts.
  Do not force retention cleanup or export as a condition of validation.

#### Collapsed Automatic Validation

- purpose: check the observed result against the mechanism's covered initial,
  intermediate and final state requirements and report its actual outcome.
- produced-outputs: validation outcome through the mechanism's normal interface;
  no Machine of Goals realization document or journal is created.
- transition-condition: checks establish success or expose an explicit failure,
  missing confirmation or blocker. Never infer success from invocation alone.
- next-step: finish, pause, or request model/mechanism review as appropriate;
  never synthesize an execution-history layer as a side effect.

### 07. Plan Packaging / Export

- step-id: `07-plan-packaging-export`
- default-mode: `export`
- purpose:
  - optionally export the goal and editable plan alone, or include selected/all
    documented realizations, their linked plans, stage records and evidence
  - include a requested collapsed skill/action as reusable material when it
    already exists; export does not execute it or fabricate invocation history
  - preserve source identities, context, applicable checks and provenance;
    prepare sharing copies for the intended audience
  - adapt imported source material into the local goal/model context; imported
    experience remains historical and never proves new execution
- produced-outputs:
  - `exported-plan-package`
  - `goal-closure-summary` when requested
- transition-condition: the requested package is checked and supplied, or the
  user intentionally leaves the goal without export.
- next-step: `<end>`.

Export is optional after final validation. It requires no registration,
computed style or invocation journal. Creating skills/actions from demonstrated
experience is a separate requested operation under the applicable contract.

## Deferred Contracts

The following contracts are intentionally left for detailed design:

- mode-specific prompts and templates
- marketplace or reusable-plan lookup protocol
- marketplace lookup and distribution formats beyond the local package
