---
style: double
submodule: machine-of-goals
id: realization-template
kind: template
status: release-candidate
workflow-stage: plan-review-and-decision
interaction-language: en
artifact-language: en
derived-from:
  - ../../workflows/machine-of-goals/machine-of-goals-workflow.md
  - ../../../ideas/machine-of-goals/machine-of-goals-principles.md
---

# Template: Realization

## Scope

This shape records one manual or interactive execution of a plan model.
It is the walkthrough itself, not a registration wrapper around another run.
No separate decision, run, run index, evidence manifest, or validation document
is required for this shape. Other execution modes keep their existing shape
below. The [Model and Realization Execution Rule](../../workflows/machine-of-goals/machine-of-goals-workflow.md#model-and-realization-execution-rule)
selects this shape for manual and interactive execution; other-mode automation
is outside this synchronization.

## Realization Contract

- Create `realizations/<YYYY-MM-DDTHH-mm-ss>/realization.md` when execution
  starts. Record the actual start with its offset and timezone; retain the
  creation name throughout the realization and never overwrite an existing
  realization directory.
- Identify the source model by file, branch, version, and a SHA-256 digest of
  that file at the start. A mutable file path or version alone is insufficient
  to detect an unrecorded edit. Obtain the digest from the file; never invent it.
- Check model identity/content before acting on a stage and before accepting
  its output. A changed model closes this realization as `model-changed` and
  requires a successor before further planned action. Preserve actions already
  taken and validate their recorded facts against the captured conditions.
- `current-stage` identifies the stage being worked on or awaiting validation.
  The map links its model anchor and stage record directly. Keep the body and
  frontmatter synchronized; do not project this progress into the model.
- A stage can start only after its input conditions are accepted. It is
  completed only after its output conditions are accepted. Merely taking an
  action, attaching a file, or stating an expected outcome is not acceptance.
- The realization is completed only when its applicable exit conditions and
  the model's goal success criteria are accepted. Summarize that result and
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
plan-version: <MAJOR.MINOR.PATCH>
plan-artifact: ../../plan-<branch>-v<major>.md
plan-content-hash: sha256:<actual-model-file-digest>
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
Model: [<branch> / <version>](../../plan-<branch>-v<major>.md#<plan-id>)
Current stage: [<stage-id>: <stage-name>](./<stage-id-lowercase>-<stage-slug>.md#<stage-record-id>)

## Stage Map

| Stage | State | Record | Result |
| --- | --- | --- | --- |
| [S01: Prepare Documents](../../plan-<branch>-v<major>.md#stage-s01) | <state> | [Walkthrough](./s01-prepare-documents.md#<s01-record-id>) | <result-and-confirmation-basis> |
| [S02: Submit Application](../../plan-<branch>-v<major>.md#stage-s02) | <state> | <record-link-when-created> | <result-and-confirmation-basis> |

## Result

<current-blocker-or-terminal-result; omit-this-section-until-needed>
````

Map states are `pending`, `in progress`, `awaiting verification`, `completed`,
`blocked`, and `not selected` when an alternative is outside this walkthrough.
A missing record for a pending stage is plain text, not a dangling link.
When no stage remains current, use `current-stage: null` and a short body
statement rather than an invented current-stage link.

Record branch/path selection and its reason briefly in the context if needed;
this does not require another decision artifact. A model change keeps the
predecessor's result and acceptance intact. Inherited confirmations remain
identified as inherited rather than being presented as new observations.

## Existing Shape for Other Execution Modes

The following pre-existing shape is retained unchanged for other modes.
Its run, registration, implementation, and automation contracts are outside
this manual/interactive revision. It is not an additional wrapper required
by the realization shape above.

```md
---
id: <realization-record-id>
kind: realization-artifact
template-id: realization-template
project-id: <stable-project-id>
produced-by: machine-of-goals/plan-synthesis-agent
artifact-path: ./realizations/<realization-record-id>.md
interaction-language: <language-code-or-name-used-for-dialogue>
artifact-language: <language-code-or-name-used-for-this-artifact>
goal-id: <goal-id>
plan-id: <plan-id>
plan-revision: <positive-integer>
plan-revision-artifact: <goal-directory>/realizations/plan-revision-<N>.md
realization-decision-id: <realization-decision-id>
realization-record-id: <unique-realization-record-id>
realization-id: <registered-realization-id>
realization-kind: <manual|shell|python|workflow|agentic|external>
realization-revision: <positive-integer>
implementation-revision: <exact-revision-or-null>
realization-mode: <manual|interactive|partial-automation|automatic|external-handoff>
selected-paths:
  - <path-or-subplan-id>
status: <draft|ready|unvalidated|failed|retired>
alignment: <aligned|review-required|incompatible>
derived-from:
  - <goal-artifact-id-or-path>
  - <plan-artifact-id-or-path>
  - <plan-revision-artifact-path>
  - <path-options-id-or-path>
  - <realization-decision-id-or-path>
---

<a id="<realization-record-id>"></a>

# Realization: <Goal Title> / <Realization Label>

## 1. Realization Context

- Source goal: [<goal-title>](../<goal-id>.md#<goal-id>)
- Realization registry record: [<realization-label>](../plan.md#<realization-record-id>)
- Realization decision: [<decision-label>](../realization-decision.md#<goal-id>-realization-decision)
- Historical plan baseline: [Revision <N>](./plan-revision-<N>.md#<goal-id>-plan)
- Current plan and applicable changes: [Plan](../plan.md#<goal-id>-plan), [<change-entry>](../plan.md#plan-change-<change-id>) or none
- Compatibility assessment: <affected-stage-ids-dependency-impact-and-procedure-fit>
- Selected paths or subplans: [<path-or-subplan-label>](../path-options.md#<path-or-subplan-id>)
- Realization definition or implementation: [<realization-label>](<definition-or-implementation-link>)
- Current realization revision: [Revision <R>](#<realization-record-id>-revision-<R>)
- Exact implementation revision: [<exact-implementation-revision>](<immutable-implementation-revision-link>) or not applicable for a self-contained manual procedure
- Mode: <manual|interactive|partial-automation|automatic|external-handoff>
- Readiness:
- Alignment:

<a id="<realization-record-id>-revision-<R>"></a>

## 2. Realization Revision <R>

Preserve every earlier revision section. Increment `realization-revision` only
when the procedure, implementation reference, boundaries, or validation
contract changes. Run-link and status updates do not create a new revision.

### Procedure or Entry Point

- First plan stage: [<stage-label>](../plan.md#stage-<stage-id>)
- Invocation or first manual action:
- Required inputs:
- Expected outputs:
- Runtime or environment:

### Automation and Control Boundaries

- Allowed without confirmation:
- Requires confirmation:
- Not allowed:
- External effects:
- Required stop points:

### Validation Contract

- Before action, freeze each effective stage contract in its run; validate
  against captured criteria and evidence. Preserve historical acceptance.
- Future-only edits require a logged applicability check, not automatic
  invalidation. Revise the plan when frozen obligations change; revise this
  realization only when its procedure, implementation, boundaries, or checks change.
- Initial-state checks:
- Intermediate checks:
- Final-state checks:
- Evidence expected:
- Validator:

## 5. Runs

This table links every active, pinned, or retained run created from this
realization artifact. Remove a row only when retention removes its unpinned run
file, after aggregate statistics have been updated in the plan registry.

| Run | Started | Finished | Result | Pinned |
| --- | --- | --- | --- | --- |
| [<run-label>](../run/<realization-record-id>--<YYYYMMDDTHHMMSSZ>.md#<run-id>) | <YYYY-MM-DDTHH:MM:SSZ> | <YYYY-MM-DDTHH:MM:SSZ-or-null> | <result> | <yes|no> |

The goal-wide retained-run view is the [run index](../run/index.md#<goal-id>-run-index).

## 6. Revision and Retirement

- Revise the realization when:
- Reconfirm the decision when:
- Retire when:
- Replacement realization artifact: [<realization-label>](./<replacement-realization-record-id>.md#<replacement-realization-record-id>) or none
```
