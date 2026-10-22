---
id: machine-of-goals-version
kind: knowledge-artifact
status: release-candidate
produced-by: machine-of-knowledge/knowledge-extraction-agent
interaction-language: ru
artifact-language: en
knowledge-type: static
access: free-of-charge
value-type: text
observed-at: 2026-10-28
ttl: one month
derived-from:
  - user clarification preserving the Plan artifact display name on 2026-10-22
  - user-approved plan-model and frozen execution plan separation on 2026-10-22
  - .double/templates/machine-of-goals/plan-model-template.md
  - .double/skills/machine-of-goals/SKILL.md
  - tests/machine-of-goals/test_plan_contract.py
  - user-requested synchronization of model and realization workflow on 2026-10-22
  - .double/registries/machine-of-goals/agents-registry.md
  - user-approved lightweight model and realization artifact contracts on 2026-10-22
  - .double/templates/machine-of-goals/plan-template.md
  - .double/templates/machine-of-goals/realization-template.md
  - .double/templates/machine-of-goals/stage-realization-template.md
  - .double/registries/machine-of-goals/templates-registry.md
  - user-approved goal and subgoal interchangeability release on 2026-10-21
  - knowledge/double-main-modules/double-main-modules.md
  - ideas/machine-of-goals/machine-of-goals.md
  - .double/workflows/machine-of-goals/machine-of-goals-workflow.md
  - user-approved step completion and continuation contract on 2026-10-21
  - user-provided project versioning decision
  - user-approved structured-choice interface update on 2026-10-14
  - user approval of successful-command contract and version 0.0.9 on 2026-10-14
---

<a id="machine-of-goals-version"></a>

# Machine of Goals Version

## Description

The version assigned to the `machine-of-goals` main module of the Double
project.

## Value

`0.0.15`

## Change Note

Generated planning and frozen execution documents retain the user-facing name
`Plan` and heading `# Plan: <Goal Title> / <Branch>`. `plan-model` remains a
technical role in metadata and template contracts, not a replacement display
name. This naming clarification is part of the unreleased `0.0.15` change.

Version `0.0.15` separates the editable `plan-model` from the immutable execution
`plan-artifact`. Step 03 creates only a model from `plan-model-template`;
manual/interactive files are `plan-model-<branch>.md` with a review revision,
not an execution plan version. Step 04 approves exact content, selected
path/entry and execution boundaries. Approval and permission to start are
separate: a deferred start leaves only the model. Approval/digest/selection
remain in the recoverable conversation until start, with renewed review
required if they cannot be recovered.

Only at the authorized start of step 05, after checking current content against
the approved source digest, the executor freezes `plan-v1.md` from
`plan-template` in the timestamped realization directory, then creates
`realization.md`, before the first planned action. The frozen plan preserves
complete approved transition content and scope, with provenance and rebased
links. Its file digest is distinct from the approved source digest. The
realization and stage records link this local immutable plan and own progress,
actual actions, evidence and acceptance. The source model and plan do not own
manual/interactive execution progress.

Every model edit invalidates its approval for future execution. Changed
manual/interactive execution requires renewed review and an authorized linked
successor with its own frozen plan. Old plans remain unchanged; already
observed outputs can be validated against their original plan and captured
conditions. Inherited facts retain their original plan/execution context and
require an applicability check. Resume uses the existing frozen plan and
realization rather than replaying actions or creating another start.

Workflow, templates, catalogs, registries, synthesis/realization/validation
agents, roles, prompts, exchange guidance and the canonical entry-point skill
are aligned with this boundary. Other-mode registration/run mechanisms and
legacy filenames remain supported: editable `plan.md` uses the model template,
and immutable `realizations/plan-revision-<N>.md` baselines use the execution
plan template. Their snapshot, decision and realization materialization also
waits for authorized step-05 start. Transition edits, including unstarted work,
require renewed review and a new frozen baseline before changed execution;
bookkeeping alone does not change the approved transition. Runs capture stage
contracts from their pinned plan rather than the current editable model.

Structural regression checks cover workflow output boundaries, distinct
artifact/template kinds and producers, exact approval/integrity rules, local
frozen-plan stage links, navigation and obsolete instruction detection. A
walkthrough matrix specifies actual file inventories after synthesis, deferred
review, execution start, source edits and resume; these checks do not claim an
implemented execution engine. Existing user goals and plans are not migrated,
and no machine release or publication is performed by this contract update.

Version `0.0.14` connects the lightweight model, realization, and stage
contracts to the manual and interactive route in the Machine of Goals
workflow. Steps 03–06 now prepare branch/version models, obtain explicit
selection, start or resume timestamped realizations, verify inputs before
action, and verify outputs before completion. Documentary evidence is offered
with an explicitly identified user-statement fallback. The realization owns
current-stage and progress; the model remains free of execution state.

Model identity/content checks stop old-model action after an edit and route
work to review and an authorized successor. Inherited results retain their
original facts and require an applicability check. Resume distinguishes
pending input from outputs awaiting verification so an action is not blindly
repeated. Accepted final goals may close without mandatory packaging/export.

The synthesis, realization, and validation agent cards, roles, prompts, and
registry now select this route, and template-scope notes point to the active
workflow rule. Earlier run/registry/snapshot instructions are explicitly
scoped to other execution modes; they do not require extra manual artifacts.
Other-mode instruction bodies and packaging behavior are retained, with no
redesign of collapsing, skills, automatic actions, cleanup, or existing goal
artifact migration. Machine entry-point skill files are unchanged; the
canonical workflow explicitly governs the manual route when older helper
instructions describe the legacy artifact shape.

Version `0.0.13` defines lightweight artifact shapes for manual and interactive
plan execution. Named plan branches evolve independently through model
versions; the model contains expected transitions rather than execution
progress. Its stages have stable anchors and short English names.

A timestamped realization document records its model file, branch, version,
content digest, current stage, and progress map. A stage document contains
only three main parts: input state, actions, and output state. It captures
the effective conditions and intended action before acting, verifies input
before action and output before completion, and links evidence directly.
Documentary confirmation is requested first. An explicit user statement is
an accepted fallback when documents cannot be provided, with its basis kept
visible rather than presented as independently verified documentary evidence.
Model changes close the realization and require a linked successor, carrying
forward only results that remain applicable.

These shapes do not require a separate decision artifact, registration
wrapper, run, run index, evidence manifest, or validation document. Their
generated filenames do not include an execution-mode prefix. The registry,
catalog, and goal/path navigation expose the new shapes. Existing shapes for
other execution modes remain available unchanged where retained. This is a
contract-only revision: workflow order and routing have not been migrated;
collapsing, skills, automatic-action behavior, and existing goal artifacts
are outside this change.

Version `0.0.12` aligns the Machine of Goals project documents with the
existing workflow contract for interchangeable goals and subgoals. A subgoal
is a goal used within another goal's plan, not a separate goal type. Any goal
may serve as a subgoal, and any subgoal may be pursued autonomously; the same
goal may play both roles at once. Explicit relationships and plan integration
boundaries determine the role, without a `goal-scope` field. Workflow depth
and plan detail depend on the goal's needs rather than its role.
The operating files already contain this contract in version `0.0.11`;
this release brings the idea, concepts, principles and version record into
agreement without changing the operating contract.

Version `0.0.11` requires an interactive handoff after every completed workflow
step or plan stage: summarize the result and link artifacts, derive eligible
next steps from the workflow and transition conditions, recommend a concrete
action, and request explicit continuation consent in the interaction language.
A No stops continuation while preserving the result. Existing explicit
sequence authorization remains valid without repeated approval; mandatory
selection, validation and stop points remain binding. Plan-stage execution
hands off to validation before further execution. Blocked and terminal states
must be explained without inventing available transitions.

Version `0.0.10` updates the structured-choice interface for mode, path/subplan, realization and validation choices:

- prefer `request_user_input_async` only when exposed and permitted for the question
- wait for explicit user submission or equivalent direct instruction before
  dependent changes; preselection, silence, timeouts and tool acknowledgements
  do not grant approval
- respect runtime tool/mode restrictions and use a permitted structured
  alternative or concise text fallback when needed
- preserve free-form clarification, existing authorization and workflow gates

The successful-command contract introduced in version `0.0.9` remains supported:

- runs preserve successful commands implementing plan actions or validating
  conditions/results, regardless of whether a human, agent or automatic
  realization executed them
- entries keep execution order, stage, purpose, working context, exact safe
  command, observed result and replay/automation constraints
- this is a useful selection, not a full trace: failed attempts, redundant
  repeats and incidental bookkeeping need not be recorded as commands
- validation checks applicable command entries or an explicit statement that
  no applicable commands executed; group success is checked per command
- generated human instructions and their history remain a separate section;
  successful commands provide evidence for future automation, not permission
  to replay them or an automatic realization registration

The existing plan revision and execution contracts remain supported by the
retained shapes for other execution modes and the unchanged workflow; they
do not add mandatory layers to the new manual/interactive artifact shapes:

- compatible edits to unstarted stages are recorded in the current plan change
  log without creating a new plan revision
- each stage attempt captures its effective contract in the run before action;
  validation uses the captured criteria and evidence
- changes to frozen obligations require a new immutable plan revision and an
  explicit revalidation or rework decision
- historical baselines and completed runs remain unchanged; progress and
  continuation require contract and dependency compatibility checks
- existing release-candidate skill packaging remains supported

## Project Rules Change

This version adds project-owned Markdown rules discovery, unconditional common
rule loading and machine-specific scope, configured catalog selection, and
independent package delivery of the loading protocol. Machine of Knowledge
also recognizes and confirms project rules using the existing knowledge
artifact template. Assigned by the approved project-rules implementation on
2026-10-28; this records a development version, not a published release.
