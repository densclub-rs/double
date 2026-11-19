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

One short Markdown document records the passage through one linked plan stage.
Its filename is `<stage-id-lowercase>-<short-english-stage-slug>.md` inside
the timestamped realization directory. At creation, derive the short English
kebab-case slug from the stage name. Keep the created filename and its links
unchanged if the stage name later changes. Use exactly three main parts: input
state, actions, and output state. Evidence is linked where it supports a fact;
it does not require a separate evidence or validation artifact.

For an authorized repeat of either stage type, keep each passage as a separate stage record in the
same realization: retain the first filename and append `-02`, `-03`, etc. to
the slug for later passages. Never overwrite an earlier record. Link all actual
passages from the map and identify the current one. Capture and verify conditions
again for each passage; retain prior decisions and evidence unchanged. Derive a
unique record id and anchor for each later passage by appending its ordinal.
Continue a partial passage in its existing record with accepted new substages
or a clearly attributed user statement; keep 🟡 until all outputs are accepted.

## Substage Records

Use this same template for a substage, under the workflow's
[Stage Subdivision During Execution](../../workflows/machine-of-goals/machine-of-goals-workflow.md#stage-subdivision-rule).
Keep the dotted `<substage-id>` as `stage-id` and in condition IDs; replace dots
with hyphens in lowercase filenames and plan anchors. Keep the same
`realization-id` and directory. In the body add a contextual Parent stage link
to the actual parent passage record. Repeat-passage suffixes stay governed by
the existing repeatability rule and must not overwrite any prior child record.

Keep the parent's existing three-part record and captured contract. Append the
subdivision note to its Actions with old/new revisions, prior approval digest,
child IDs/links and applicable earlier evidence. Preserve the approval history
before updating realization metadata. Child records link earlier evidence in
place, identify its source and check it against each child condition; evidence
reuse does not claim the child's actions were performed again. Parent Output
State records acceptance of required selected child outputs and its own
integration conditions. No extra main section, journal or new realization is
introduced by subdivision.

## Stage Contract

- Bind the record to its realization, stable stage ID and actual linked plan.
  Capture effective conditions and intended actions before action. Preserve
  the captured content and origin when inherited.
- Preserve each condition ID, including stage prefix, in evidence and validation
  references; do not renumber captured or inherited conditions.
- Review changed plan content before future action. Validate observed outputs
  against conditions captured before action and preserve all earlier facts.
  Follow the workflow's preservation decision before incompatible plan changes.
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
- Record actual actions and deviations in order. For each substantive command
  used for the stage or its validation, follow the workflow's command and output
  rule: a separate block with working directory, safe command, observed output
  and exit code, including failures and corrections. Put long output in a
  distinct linked file directly in the current realization directory. Preserve
  earlier output files; identify unavailable, truncated, empty or redacted
  output honestly. Preserve generated instructions before or when presented,
  marking those not observed running. Omit incidental bookkeeping.
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
plan-artifact: ../../plan.md
source-plan-artifact: <originating-plan-path-when-inherited>
inherited-from: <originating-realization-id-or-null>
---

<a id="<stage-record-id>"></a>

# <Stage ID>: <Short English Name>

Plan stage: [<stage-id>](../../plan.md#stage-<stage-id-lowercase>)

## Input State

Documentary evidence requested: <what-was-requested-and-whether-it-was-available>

| Condition | Actual state and confirmation | Decision |
| --- | --- | --- |
| <stage-id>-I01: <captured-required-condition> | <actual-state; documentary-link-or-explicit-user-statement> | <accepted|not-met|unconfirmed> |

## Actions

Intended action: <captured-action-from-the-linked-plan>

<actual-actions-in-order-with-relevant-commands-results-and-deviations>

### <Command ordinal and purpose>

Working directory: `<working-directory>`

```sh
<exact-safe-command>
```

Output:

```text
<observed-short-output-or-explicitly-no-output>
```

For long output, replace the text block with a link to a distinct output file
directly in this realization directory, e.g. `[full output](./s02-command-01.log)`.
Mark unavailable or truncated output and any redactions explicitly.

Exit code: `<observed-code-or-unavailable>`

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
