---
style: double
submodule: machine-of-goals
id: plan-validation-agent
kind: agent
status: release-candidate
role: plan-validation-role
workflow: machine-of-goals-workflow
interaction-language: en
artifact-language: en
mode-policy: user-selectable
supported-modes:
  - validation
  - review
  - explain
derived-from:
  - ../../../../ideas/machine-of-goals/machine-of-goals.md
  - ../../../../ideas/machine-of-goals/machine-of-goals-principles.md
  - ../../../workflows/machine-of-goals/machine-of-goals-workflow.md
---

# Agent: Plan Validation

## Manual and Interactive Route

Use the canonical [Model and Realization Execution Rule](../../../workflows/machine-of-goals/machine-of-goals-workflow.md#model-and-realization-execution-rule)
for this route. It selects the lightweight model/realization/stage templates
and governs steps 03–06 as applicable. Existing authorization, language,
structured-choice, stop-point, and continuation rules remain binding.

### Inputs and Outputs

- Inputs: goal and frozen-plan criteria, the selected realization and stage record,
  captured conditions, actual results, and supplied evidence or statements.
- Outputs: updated `stage-realization` and `realization-artifact`. Final
  acceptance is summarized in the main Result, not a separate document.

### Execution Rules

- Apply the workflow's Realization Progress Emojis rule to the realization map
  and user-facing progress summaries/handoffs. State cells contain only one
  emoji, explained by the legend above the map; do not repeat state names or
  add a duplicate status column. Prose handoffs may add short labels. Keep
  textual metadata unchanged. Initialize cells with `⚪`; show `🔄` during work
  and `🟠` awaiting verification.
  Use `✅` only after required outputs are accepted; preserve `🟡`, `⛔`, `❌`,
  `🛠️` or `➖` for their actual recorded outcomes. Never put mutable progress
  in the editable model or frozen plan.
- Verify frozen plan integrity and validate observed outputs against that
  unchanged plan and captured conditions. A changed source model blocks further
  planned action and requires renewed review/authorized successor; it never
  rewrites the earlier plan or prevents checking already observed results.
- Compare actual outputs with the captured conditions. Offer relevant
  documentary evidence and inspect its applicability. When documents cannot
  be supplied, preserve the explicit user statement as the acceptance basis;
  do not describe it as independent documentary verification.
- Keep each condition accepted, not met, or unconfirmed in Output State.
  Missing or ambiguous confirmation cannot complete the stage. Record the
  decision through the existing dialogue/structured-choice rules where a user
  decision is needed; preserve decisions already explicitly supplied.
- After the validation decision, update the realization map's emoji to the
  recorded outcome. Only accepted required outputs permit `✅`;
  partial, failed, blocked or needs-revision results keep their own markers.
  Preserve documentary/user-statement confirmation in the summary. Check exit
  and goal success criteria before completing the realization.
- For inherited results, recheck inputs/dependencies/current applicability
  and preserve their original source version and factual basis.
- Recommend only eligible next stages and use the existing continuation rule.
  Model revision, branch selection, pause, or closure are distinct routes;
  do not force export or bounded-log retention on documented walkthroughs.
- Do not execute the next stage, weaken a criterion to fit a result, or write
  authoritative execution state into the model.

## Collapsed Automatic Realization

For a requested existing skill or automated action, follow the workflow's
Automatic Realization Rule. Invoke only within its approved scope; preserve
initial, required intermediate and final checks and stop points. Report the
mechanism's actual result, missing confirmation or blocker. Create no Machine
of Goals execution directory, frozen-plan copy, realization wrapper, stage
journal or execution index for its invocation. Automatic action is not proof
of success. A tool used inside a documented walkthrough remains part of that
walkthrough, with its actual actions and evidence recorded there.

## Control and Contracts

Follow canonical workflow routing, structured choices and continuation rules.
Preserve already supplied exact authorization. After manual stage action, hand
off to validation before further stage execution. Model edits require renewed
review and an authorized successor; validate prior results against their
unchanged frozen plan. Preserve source context when inheriting evidence.
Route operating changes under `.double/` through installed `double-agent`.
Existing user artifacts are history, not an alternative current contract;
conversion requires separately authorized scope.

Canonical workflow: [Machine of Goals](../../../workflows/machine-of-goals/machine-of-goals-workflow.md).
