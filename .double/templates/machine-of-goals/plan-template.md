---
style: double
submodule: machine-of-goals
id: plan-template
kind: template
status: release-candidate
workflow-stage: plan-realization
interaction-language: en
artifact-language: en
derived-from:
  - ../../workflows/machine-of-goals/machine-of-goals-workflow.md
  - ./plan-model-template.md
---

# Template: Plan (Realization)

## Frozen Plan Contract

- Keep the user-facing document name `Plan`, with heading
  `# Plan: <Goal Title> / <Branch>`. Provenance, metadata and realization
  context distinguish this frozen plan from its editable source.
- Use this template only at the authorized start of step 05, before the first
  planned action. Step 03 and step 04 use `plan-model-template`; approving or
  deferring a model never creates a plan, realization directory or realization.
- Recheck the approved model content digest, selected path, entry and boundaries
  before creating `realizations/<YYYY-MM-DDTHH-mm-ss>/plan-v1.md`.
- Freeze the approved goal context, transition, complete stage contracts,
  dependencies, checks and control boundaries. Copy the model's substantive
  sections and stable stage anchors; add plan identity/provenance and rebase
  relative links for the destination. Verify semantic equality with the approved
  model, allowing only that metadata/link adaptation and explicit selection.
- `plan-version: 1` names the first frozen plan in this realization directory;
  it does not inherit `model-revision`. Each successor has its own directory
  and first frozen plan. Never increment a version to overwrite an existing plan.
- Compute the frozen file digest after writing it; record it in the realization.
  Keep the approved source digest separately because rebasing/provenance changes
  the bytes. Never invent either hash or a timestamp.
- Once created, the plan is immutable. Progress, actual actions, observations,
  evidence and acceptance belong to `realization.md` and stage records. Any model
  edit needs renewed review before future action and an authorized successor;
  earlier plans and their factual records remain intact.
- Omit unused optional fields. A plan is the approved content for one concrete
  realization, not an editable planning document or progress report.

## Frozen Plan Shape

````md
---
id: <realization-id>-plan-v1
kind: plan-artifact
template-id: plan-template
project-id: <stable-project-id>
produced-by: machine-of-goals/plan-realization-agent
interaction-language: <interaction-language>
artifact-language: <artifact-language>
goal-id: <goal-id>
realization-id: <realization-id>
branch: <branch-name>
plan-version: 1
plan-model-artifact: ../../plan-model-<branch>.md
model-revision: <approved-model-revision>
approved-model-content-hash: sha256:<actual-approved-source-file-digest>
created-at: <actual-ISO8601-time-with-offset>
derived-from:
  - ../../plan-model-<branch>.md
---

<a id="<realization-id>-plan-v1"></a>

# Plan: <Goal Title> / <Branch>

Goal: [<goal-title>](../../<goal-id>.md#<goal-id>)
Source model: [<branch>](../../plan-model-<branch>.md#<model-id>)

## Approved Selection

- Content approval: <explicit-user-approval-and-recoverable-reference>
- Start authorization: <explicit-consent-covering-this-start>
- Selected path/subplan: <approved-selection-or-single-path>
- Entry stage: <approved-stage-id>
- Execution boundaries and stop points: <exact-approved-scope>

<copy-the-approved-model-context-and-stage-sections-here-with-rebased-links>
````

The final placeholder requires the complete approved content, including goal
success criteria, every applicable stage and alternative, stable anchors,
conditions, actions, checks and dependencies. A link to a mutable model alone
is insufficient; this plan must be readable without recovering old model bytes.

## Other Execution Modes

Their existing snapshot filename is `realizations/plan-revision-<N>.md`.
Create it only at the authorized start of step 05 from the approved other-mode
model in `plan-model-template`. Assign a new plan ID, `kind: plan-artifact`,
`template-id: plan-template` and
`produced-by: machine-of-goals/plan-realization-agent`; include
source model, exact approval digest, selection and boundaries. Preserve stable
stage anchors and rebase links. Remove mutable registry rows, run statistics,
displayed-run metadata, progress projection and change-log bookkeeping from the
frozen plan. Its transition content remains the exact approved model content.
Never revise it for progress or adopt later model edits without renewed review
and a new frozen baseline. Existing user snapshots are not silently converted.
