---
style: double
submodule: machine-of-goals
id: realization-template
kind: template
status: release-candidate
workflow-stage: plan-realization
interaction-language: en
artifact-language: en
derived-from:
  - ../../workflows/machine-of-goals/machine-of-goals-workflow.md
  - ../../../ideas/machine-of-goals/machine-of-goals-principles.md
---

# Template: Realization

## Scope

This document records one manual or interactive execution of an approved linked
plan. The timestamped realization and its stage documents are the walkthrough;
no registration wrapper, additional execution journal, index, evidence manifest
or validation document is required. A collapsed skill or automated action
creates none of these Machine of Goals execution records when invoked. See the
[execution boundary](../../workflows/machine-of-goals/machine-of-goals-workflow.md#plan-model-execution-boundary).

## Realization Contract

- Create `_realizations/<YYYY-MM-DDTHH-mm-ss>/realization.md` when execution
  starts. Record the actual start with its offset and timezone; retain the
  creation name throughout the realization and never overwrite an existing
  realization directory.
- At authorized step 05 start, recheck the approved source digest and create
  this realization linked to the actual main plan. Do not create a local copy.
  Retain the approved revision and digest as evidence of the decision.
- Set `plan-id` to the selected main plan's `id`. The realization has its own
  separate identity. Named plan variants use their actual paths.
- Before a structural edit to the main plan, apply the workflow's explicit
  preservation decision. When preservation is chosen, copy the old plan to
  `./plan.md` and update this realization and stage references before the edit.
  Do not overwrite an existing file. A new realization links the new main plan.
- Any changed plan content needs renewed approval before future action. Validate
  observed results against the conditions captured in stage records and preserve
  earlier facts, even after nonstructural edits.
- `current-stage` identifies the stage being worked on or awaiting validation.
  The map links its linked plan anchor and stage record directly. Render every
  State cell with only its required emoji; the legend above the map explains
  the meanings. Do not append state names or add a duplicate status column.
  Progress handoffs may use emoji with short prose labels. Keep frontmatter
  status values textual and synchronize their meaning with the body. Do not
  project progress into the editable model or frozen plan.
- A stage can start only after its input conditions are accepted. It is
  completed only after its output conditions are accepted. Merely taking an
  action, attaching a file, or stating an expected outcome is not acceptance.
- The realization is completed only when its applicable exit conditions and
  the applicable plan's goal success criteria are accepted. Summarize that result and
  its confirmation basis here; no separate final-validation artifact is needed.
- For both input and output checks, offer suitable documentary evidence first.
  If it cannot be provided, accept an explicit user statement when it addresses
  the condition, recording the exact basis without claiming independent proof.
  Missing or ambiguous confirmation leaves the condition unconfirmed.
- Use `stage-realization-template` for the stage documents. A factual
  documentary check and an accepted user statement are distinguishable even
  when both permit completion. Preserve the basis in the map's short result.
- A successor includes applicable inherited records and evidence, identifies
  their origin, and rechecks applicability against changed dependencies and
  current conditions. It does not claim to have repeated inherited actions.
- Include predecessor/successor metadata and a continuation note only when
  they exist. Omit unused fields and empty sections from generated documents.

The example below uses the default source `plan.md`. For a parallel variant
`plan-<id>.md` or author variant `plan<owner_id>.md`, use its actual relative
source path and distinct plan anchor in provenance and navigation, preserving
its logical branch and approved revision. Update `plan-artifact`,
`derived-from` where present and the plan body links together; never
fall back to `plan.md` for a named variant. Do not create or rename the source
merely to fill its branch field. A preserved historical copy uses `./plan.md` only when needed.

## Realization Shape

````md
---
id: <realization-id>
kind: realization-artifact
template-id: realization-template
project-id: <stable-project-id>
produced-by: machine-of-goals/plan-realization-agent
interaction-language: <interaction-language>
artifact-language: <artifact-language>
goal-id: <goal-id>
branch: <branch-name>
plan-id: <plan-id>
plan-artifact: ../../plan.md
plan-revision: <approved-plan-revision>
approved-model-content-hash: sha256:<actual-approved-source-file-digest>
started-at: <actual-ISO8601-time-with-offset>
timezone: <IANA-timezone>
status: <in-progress|completed|blocked|cancelled|model-changed>
current-stage: <stage-id-or-null>
predecessor: <previous-realization-path-or-null>
successor: <next-realization-path-or-null>
---

<a id="<realization-id>"></a>

# Realization: <Goal Title> / <Branch>

Goal: [<goal-title>](../../<goal-id>.md#<goal-id>)
Plan: [<branch>](../../plan.md#<plan-id>)
Current stage: [<stage-id>: <stage-name>](./<stage-id-lowercase>-<stage-slug>.md#<stage-record-id>)

## Stage Map

Legend: ⚪ pending; 🔄 in progress; 🟠 awaiting verification; ✅ completed;
🟡 partial; ⛔ blocked; ❌ failed; 🛠️ needs revision; ➖ not selected.

| Stage | State | Record | Result |
| --- | --- | --- | --- |
| [S01: Prepare Documents](../../plan.md#stage-s01) | ⚪ | <record-link-when-created> | <result-and-confirmation-basis> |
| [S02: Submit Application](../../plan.md#stage-s02) | ⚪ | <record-link-when-created> | <result-and-confirmation-basis> |

## Result

<current-blocker-or-terminal-result; omit-this-section-until-needed>
````

Use only emoji in State cells, with their meanings in the legend above, under
the workflow's [progress rendering rule](../../workflows/machine-of-goals/machine-of-goals-workflow.md#realization-progress-emojis).
New stages start `⚪`; update the marker to the actual recorded state. After
action use `🟠`, and only after required outputs are accepted use `✅`. Partial,
blocked, failed and needs-revision outcomes retain their own markers. Outside
the selected path use `➖`. Do not append state names to the cells or add a
second textual status column. Progress summaries may add short labels in prose.
Markers never replace condition checks, evidence or textual metadata states.
A missing record for a pending stage is plain text, not a dangling link.
When no stage remains current, use `current-stage: null` and a short body
statement rather than an invented current-stage link.

Record branch/path selection and its reason briefly in the context if needed;
this does not require another decision artifact. A model change keeps the
predecessor's result and acceptance intact. Inherited confirmations remain
identified as inherited rather than being presented as new observations.
