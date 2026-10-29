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

This document records one manual or interactive execution of a frozen approved
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
- At the authorized start of step 05, first freeze `plan-v1.md` using
  `plan-template`; then create this document. Never create either during steps
  03 or 04, including after model approval with a deferred start.
- Set this realization's `plan-id` to the source model's `id`, which the frozen
  plan preserves as its own `id` and root anchor. The realization's own `id`
  identifies the realization. `plan-id` is a reference to the plan, not another
  identity on the plan. Never generate a replacement plan ID on start.
- Link the local frozen plan, its version and computed SHA-256 digest. Keep
  source model file/revision and approved source digest separately. Recheck
  approval before freezing and compute both hashes from actual bytes.
- Check frozen plan integrity before action and output acceptance. Check for
  changed source content before further planned action; a model edit invalidates
  approval, closes this realization as `model-changed` and requires renewed
  review and an authorized successor. Validate already observed results against
  the unchanged frozen plan and captured conditions; never rewrite old facts.
- `current-stage` identifies the stage being worked on or awaiting validation.
  The map links its frozen plan anchor and stage record directly. Render every
  State cell with only its required emoji; the legend above the map explains
  the meanings. Do not append state names or add a duplicate status column.
  Progress handoffs may use emoji with short prose labels. Keep frontmatter
  status values textual and synchronize their meaning with the body. Do not
  project progress into the editable model or frozen plan.
- A stage can start only after its input conditions are accepted. It is
  completed only after its output conditions are accepted. Merely taking an
  action, attaching a file, or stating an expected outcome is not acceptance.
- The realization is completed only when its applicable exit conditions and
  the frozen plan's goal success criteria are accepted. Summarize that result and
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
its logical branch and approved revision. Update `plan-model-artifact`,
`derived-from` where present and the source-model body link together; never
fall back to `plan.md` for a named variant. Do not create or rename the source
merely to fill its branch field. Frozen execution filenames remain unchanged.

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
plan-version: 1
plan-artifact: ./plan-v1.md
plan-content-hash: sha256:<actual-frozen-plan-file-digest>
plan-model-artifact: ../../plan.md
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
Plan: [Version 1](./plan-v1.md#<plan-id>)
Source model: [<branch>](../../plan.md#<plan-id>)
Current stage: [<stage-id>: <stage-name>](./<stage-id-lowercase>-<stage-slug>.md#<stage-record-id>)

## Stage Map

Legend: ⚪ pending; 🔄 in progress; 🟠 awaiting verification; ✅ completed;
🟡 partial; ⛔ blocked; ❌ failed; 🛠️ needs revision; ➖ not selected.

| Stage | State | Record | Result |
| --- | --- | --- | --- |
| [S01: Prepare Documents](./plan-v1.md#stage-s01) | ⚪ | <record-link-when-created> | <result-and-confirmation-basis> |
| [S02: Submit Application](./plan-v1.md#stage-s02) | ⚪ | <record-link-when-created> | <result-and-confirmation-basis> |

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
