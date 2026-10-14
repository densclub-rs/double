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
- Historical plan baseline: [Revision <N>](../realizations/plan-revision-<N>.md#<goal-id>-plan)
- Current stage source: [Current plan](../plan.md#<goal-id>-plan)
- Applicable plan changes: [<change-entry>](../plan.md#plan-change-<change-id>) or none
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

This map follows captured stage attempts. Unstarted entries may adopt current
plan changes after a recorded dependency and realization compatibility check.
Started entries link their frozen contract below; unstarted entries link the
current plan. Keep the exact baseline in Run Context as provenance, not as the
sole source of requirements. Project compatible statuses into `plan.md` by
stable stage id; never modify an immutable plan snapshot.

Legend: `⚪` not started; `🔄` in progress; `🟠` awaiting validation; `✅`
accepted; `🟡` partial; `⛔` blocked; `❌` failed or rejected; `🛠️` needs
revision; `➖` not selected.

| Progress | Stage | Status | Validation | Started | Finished | Result |
| --- | --- | --- | --- | --- | --- | --- |
| ⚪ | [<stage-id>](../plan.md#stage-<stage-id>) | <not-started|in-progress|done|partial|blocked|failed|needs-revision|not-selected> | <not-validated|accepted|partial|blocked|rejected|needs-revision|not-applicable> | <time-or-null> | <time-or-null> | <summary> |

### Frozen Stage Contracts

Create one block per attempt before action; change the started map entry to
link to this block. Preserve captured content after action starts. A source
link alone is insufficient. Rebase copied links for this directory.

<a id="stage-<stage-id>-attempt-<attempt-id>"></a>

#### <Stage Id> / Attempt <Attempt Id>

- Captured at: <YYYY-MM-DDTHH:MM:SSZ>
- Source stage: [<stage-label>](../plan.md#stage-<stage-id>)
- Historical baseline: [Revision <N>](../realizations/plan-revision-<N>.md#<goal-id>-plan)
- Applicable change entry: [<change-entry>](../plan.md#plan-change-<change-id>) or none
- Inputs and preconditions: <captured-content>
- Actions: <captured-content>
- Expected outputs: <captured-content>
- Acceptance criteria: <captured-content>
- Dependencies: <captured-content>
- Approved boundaries and required stop points: <captured-content>
- Dependency and realization compatibility decision: <decision-and-evidence>
- Carried results: <original-contract-and-evidence-links-with-applicability> or none
- Supersedes: <earlier-attempt-link-and-reason> or none

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

### Successful Commands for Reuse and Automation

Record successful commands that implement the plan or validate its conditions
and results, regardless of executor. Append after observed success, in execution
order and before stage validation. Keep useful commands rather than a full
trace: failed attempts, repeated commands without a new result and incidental
bookkeeping may be omitted. Relevant failures/blockers remain in execution notes.
For command groups verify each recorded command; a group's final exit code alone
is insufficient. Keep the manual instruction history above separate.

#### <Stage Id> — Successful Command <Sequence Number>

- Purpose:
- Working directory or execution context:
- Preconditions and environment-specific values:

```<command-language>
<exact-successfully-executed-command-with-secrets-replaced-by-protected-references>
```

- Observed result or evidence:
- Replay / automation constraints: <permissions, interactive input, state, host-specific paths, or none>
- Execution time: <known-time-or-not-recorded>; identify retrospective reconstruction when applicable

If no applicable commands executed, record that explicitly. Do not invent
commands or timestamps. Success does not establish safe replay or authorize it.

### Concise Execution Notes

### <YYYY-MM-DDTHH:MM:SSZ> — <Stage Id>

- Attempted:
- Changed or produced: [<artifact-label>](<artifact-link>)
- Observed:
- Decision or next action:

## 5. Intermediate State Validation

- Stage:
- Frozen contract: [<stage-attempt>](#stage-<stage-id>-attempt-<attempt-id>)
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
- Frozen obligations affected and revalidation or rework needed:
- Realization revision needed: <yes|no>
- Path review needed: <yes|no>
- Recommended next step:
- Statistics updated in [Plan realization registry](../plan.md#realization-registry): <yes|no>
- Next decision, revision, or run: [<artifact-label>](<artifact-link>) or none
```
