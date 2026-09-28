---
style: double
submodule: machine-of-goals
id: plan-run-template
kind: template
status: release-candidate
workflow-stage: plan-realization
interaction-language: en
artifact-language: en
derived-from:
  - ../../workflows/machine-of-goals/machine-of-goals-workflow.md
  - ../../../ideas/machine-of-goals/machine-of-goals-principles.md
---

# Template: Plan Run

```md
---
id: <goal-id>-run-<realization-record-id>-<YYYYMMDDTHHMMSSZ>
kind: plan-run
template-id: plan-run-template
project-id: <stable-project-id>
produced-by: machine-of-goals/plan-realization-agent
artifact-path: ./run/<realization-record-id>--<YYYYMMDDTHHMMSSZ>.md
interaction-language: <language-code-or-name-used-for-dialogue>
artifact-language: <language-code-or-name-used-for-this-artifact>
goal-id: <goal-id>
plan-id: <plan-id>
plan-revision: <positive-integer>
plan-revision-artifact: <goal-directory>/realizations/plan-revision-<N>.md
realization-id: <registered-realization-id>
realization-record-id: <unique-realization-record-id>
realization-artifact: <goal-directory>/realizations/<realization-record-id>.md
realization-revision: <positive-integer>
selected-paths:
  - <path-or-subplan-id>
started-at: <YYYY-MM-DDTHH:MM:SSZ>
finished-at: <YYYY-MM-DDTHH:MM:SSZ-or-null>
result: <running|succeeded|partial|failed|blocked|cancelled|precondition-failed>
pinned: <yes|no>
derived-from:
  - <plan-artifact-id-or-path>
  - <plan-revision-artifact-path>
  - <path-options-id-or-path>
  - <realization-decision-id-or-path>
  - <realization-artifact-id-or-path>
---

<a id="<goal-id>-run-<realization-id>-<YYYYMMDDTHHMMSSZ>"></a>

# Plan Run: <Goal Title> / <Realization Record Id>

## 1. Run Context

- Source goal: [<goal-title>](../<goal-id>.md#<goal-id>)
- Realization decision: [<decision-label>](../realization-decision.md#<goal-id>-realization-decision)
- Plan revision: [Revision <N>](../realizations/plan-revision-<N>.md#<goal-id>-plan)
- Additional plan VCS evidence: [<exact-plan-revision>](<immutable-vcs-permalink>) or none
- Realization record: [<realization-label>](../plan.md#<realization-record-id>)
- Realization artifact: [<realization-label>](../realizations/<realization-record-id>.md#<realization-record-id>)
- Realization revision: [Revision <R>](../realizations/<realization-record-id>.md#<realization-record-id>-revision-<R>)
- Selected paths or subplans: [<path-or-subplan-label>](../path-options.md#<path-or-subplan-id>)
- Actor:
- Runtime or environment:
- Approved boundaries:
- Required stop points:

## 2. Initial State Validation

- [ ] Initial state checked
- Expected state:
- Observed state:
- Evidence:
- Decision: <accepted|rejected|partial|blocked|needs-revision>

## 3. Plan Map

Instantiate only the stages and path branches selected for this run.

This map visualizes execution of the exact plan revision linked in Run Context.
It is the source of the emoji projection optionally mirrored into the current
`plan.md`; the immutable plan-revision snapshot is never changed.

Legend: `⚪` not started; `🔄` in progress; `🟠` awaiting validation; `✅`
accepted; `🟡` partial; `⛔` blocked; `❌` failed or rejected; `🛠️` needs
revision; `➖` not selected.

| Progress | Stage | Status | Validation | Started | Finished | Result |
| --- | --- | --- | --- | --- | --- | --- |
| ⚪ | [<stage-id>](../realizations/plan-revision-<N>.md#stage-<stage-id>) | <not-started|in-progress|done|partial|blocked|failed|needs-revision|not-selected> | <not-validated|accepted|partial|blocked|rejected|needs-revision|not-applicable> | <time-or-null> | <time-or-null> | <summary> |

## 4. Working Log

Keep concise notes that explain the current realization effort, not a complete
command-by-command trace of automatic execution. As a required exception,
record every command generated for a human to execute while manually performing
a stage. Append the command before or when it is presented, preserve generation
order, and add corrected or replacement commands as new entries instead of
overwriting earlier instructions. Record the exact safe-to-share command shown
to the human; never interpolate literal secrets, and use placeholders or
protected-input references instead.

### Generated Commands for Manual Stage Execution

#### <YYYY-MM-DDTHH:MM:SSZ> — <Stage Id> — Command <Sequence Number>

- Purpose:
- Working directory or execution context:
- Preconditions or protected inputs:

```<command-language>
<exact-safe-to-share-command-presented-for-manual-execution>
```

- Disposition: <generated|presented|executed|failed|superseded|skipped>
- Result or evidence:

### Concise Execution Notes

### <YYYY-MM-DDTHH:MM:SSZ> — <Stage Id>

- Attempted:
- Changed or produced: [<artifact-label>](<artifact-link>)
- Observed:
- Decision or next action:

## 5. Intermediate State Validation

- Stage:
- Expected state:
- Observed state:
- Evidence: [<evidence-label>](<evidence-link>)
- Decision:

## 6. Blockers and Deviations

- Blocker:
- Planned:
- Actual:
- Reason:
- Impact:
- Required decision:

## 7. Final State Validation

- [ ] Final state checked
- Expected state:
- Observed state:
- Evidence: [<evidence-label>](<evidence-link>)
- Decision: <accepted|rejected|partial|blocked|needs-revision>

## 8. Run Result

- Result: <succeeded|partial|failed|blocked|cancelled|precondition-failed>
- Summary:
- Plan revision needed: <yes|no>
- Realization revision needed: <yes|no>
- Path review needed: <yes|no>
- Recommended next step:
- Statistics updated in [Plan realization registry](../plan.md#realization-registry): <yes|no>
- Next decision, revision, or run: [<artifact-label>](<artifact-link>) or none
```
