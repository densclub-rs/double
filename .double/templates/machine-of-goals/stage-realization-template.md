---
style: double
submodule: machine-of-goals
id: stage-realization-template
kind: template
status: release-candidate
workflow-stage: plan-realization
interaction-language: en
artifact-language: en
derived-from:
  - ./plan-template.md
  - ./realization-template.md
  - ../../../ideas/machine-of-goals/machine-of-goals.md
  - ../../../ideas/machine-of-goals/machine-of-goals-principles.md
---

# Template: Stage Realization

## Scope

One short Markdown document records the passage through one frozen plan stage.
Its filename is `<stage-id-lowercase>-<short-english-stage-slug>.md` inside
the timestamped realization directory. Use exactly three main parts: input
state, actions, and output state. Evidence is linked where it supports a fact;
it does not require a separate evidence or validation artifact.

## Stage Contract

- Bind the record to its realization, stable stage ID and local immutable
  `plan-v1.md`. Capture effective conditions and intended action from that plan
  before action. Retain this content and the originating plan when inherited.
- Preserve each condition ID from the frozen plan, including its stage prefix:
  `<stage-id>-I<condition-number>` for inputs and
  `<stage-id>-O<condition-number>` for outputs, such as `S02-I01`, `S02-O01`.
  Use these exact IDs in evidence and validation references; do not renumber
  captured or inherited conditions.
- Verify frozen plan integrity before action and output acceptance. A source
  model edit requires renewed review and a successor before further planned
  action, preserving the frozen plan and all earlier facts. Validate observed
  output against the original plan; never rewrite it from the edited model.
- Verify input conditions before action. Verify output conditions before
  marking the stage completed in the realization map. An unresolved or failed
  input blocks action; an unresolved output remains awaiting verification or
  blocked, rather than completed. Reflect the actual outcome with the matching
  emoji in the owning realization map: `🟠` before verification and `✅` only
  after required outputs are accepted. Preserve partial/failed/revision markers
  when those outcomes are recorded; do not copy progress into the frozen plan.
- For each input and output group, offer documentary evidence appropriate
  to the conditions, such as a screenshot, photograph, document, or relevant
  command output. Record what was requested and whether it was supplied.
  One request may cover several conditions; do not repeat a request already
  answered as unavailable without a new reason.
- Inspect what the supplied material actually establishes. A file's existence
  alone does not prove a condition, and evidence for one result does not
  automatically prove another result.
- When documents cannot be provided, an explicit user statement that addresses
  the condition can support acceptance. Preserve the statement and identify
  it as a user statement, not as an independently observed documentary fact.
  Record who stated it and when if known; do not invent missing information.
  Silence, a vague acknowledgment, and the agent's expectation are not proof.
- Documentary unavailability alone does not forbid completion when explicit
  statements establish the conditions under this contract. The fallback changes
  the basis of acceptance, not the condition the plan requires to be true.
- Keep the confirmation basis visible for each condition. A stage accepted
  on user statements is summarized as such in the realization map; do not hide
  the difference behind an unqualified completed marker.
- Record actual actions, deviations, and relevant commands in order. Preserve
  generated instructions before or when presented, including corrections;
  record observed success and failures honestly. Keep useful working context
  and results beside commands, with secrets replaced by protected references.
  Omit irrelevant bookkeeping and empty command subsections.
- Inheritance preserves original facts, statements, evidence, and their source
  version. Record the originating realization when inherited; include useful
  materials locally so the retained record is understandable on its own.
  Applicability must be rechecked against the successor's input conditions
  and dependencies before a completed result is carried forward.

## Stage Shape

````md
---
id: <stage-record-id>
kind: stage-realization
template-id: stage-realization-template
project-id: <stable-project-id>
produced-by: machine-of-goals/plan-realization-agent
interaction-language: <interaction-language>
artifact-language: <artifact-language>
realization-id: <owning-realization-id>
stage-id: <stable-stage-id>
branch: <source-branch>
plan-version: 1
plan-artifact: ./plan-v1.md
source-plan-artifact: <originating-frozen-plan-path-when-inherited>
inherited-from: <originating-realization-id-or-null>
---

<a id="<stage-record-id>"></a>

# <Stage ID>: <Short English Name>

Plan stage: [<stage-id>](./plan-v1.md#stage-<stage-id-lowercase>)

## Input State

Documentary evidence requested: <what-was-requested-and-whether-it-was-available>

| Condition | Actual state and confirmation | Decision |
| --- | --- | --- |
| <stage-id>-I01: <captured-required-condition> | <actual-state; documentary-link-or-explicit-user-statement> | <accepted|not-met|unconfirmed> |

## Actions

Intended action: <captured-action-from-the-frozen-plan>

<actual-actions-in-order-with-relevant-commands-results-and-deviations>

## Output State

Documentary evidence requested: <what-was-requested-and-whether-it-was-available>

| Condition | Actual state and confirmation | Decision |
| --- | --- | --- |
| <stage-id>-O01: <captured-required-condition> | <actual-state; documentary-link-or-explicit-user-statement> | <accepted|not-met|unconfirmed> |
````

Use a short documentary reference such as `Document: [receipt](./attachments/receipt.png)`
or an explicitly attributed statement such as `User statement: "The application
was accepted."` inside the confirmation cell. Attribute statements verbatim
where possible, even if the quotation language differs from the artifact language.
If unavailable, say so rather than inventing evidence, a timestamp, or a result.

Add rows only for actual conditions. Before outputs are observed, keep their
decisions unconfirmed and their actual-state cells factual. Omit
`inherited-from` and `source-plan-artifact` when the stage is newly performed. The realization map owns
progress status; this record provides the facts that justify that status.
