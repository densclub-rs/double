---
style: double
submodule: machine-of-goals
id: plan-realization-interaction-prompt
kind: prompt
status: release-candidate
produced-by: plan-realization-agent
mode: shared
derived-from:
  - ../../../roles/machine-of-goals/plan-realization-role.md
---

# Interaction Prompt: Plan Realization

## Manual and Interactive Route

Use the canonical [Model and Realization Execution Rule](../../../workflows/machine-of-goals/machine-of-goals-workflow.md#model-and-realization-execution-rule)
for this route. It selects the lightweight model/realization/stage templates
and governs steps 03–06 as applicable. Existing authorization, language,
structured-choice, stop-point, and continuation rules remain binding.

### Inputs and Outputs

- Inputs: approved model file/branch/revision/digest, authorized start or existing
  realization/current stage, and the relevant conditions and stop points.
- Outputs: immutable `plan-artifact`, `realization-artifact`, `stage-realization`, and directly linked
  evidence or actual deliverables required by the approved stage.

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
- Only at authorized step-05 start, recheck exact model approval/digest, selected
  path/entry and boundaries. Freeze `plan-v1.md` using `plan-template` in the
  timestamped directory before creating `realization.md`. Record actual start,
  timezone, source digest and frozen-plan digest separately. Approval with a
  deferred start creates neither file. Resume the existing realization otherwise.
- Show current stage and its local frozen plan anchor, required inputs, planned action,
  expected outputs, and checks. Keep progress/current-stage only in the main
  realization map and use `stage-realization-template` for stage detail.
- Capture conditions/actions from the frozen plan before acting and verify its
  integrity. A source model edit invalidates approval for future actions, ends
  this realization as `model-changed` and requires renewed review/authorized
  successor. Never edit the earlier frozen plan or its factual history.
- Offer appropriate documentary confirmation of inputs. Inspect what it
  establishes; when unavailable, an explicit condition-specific user statement
  can support acceptance, labeled as such. Silence and unrelated files
  do not confirm conditions. Do not act on unaccepted inputs.
- Record actual actions and relevant safe commands/corrections in order inside
  Actions. Do not invent evidence, timestamps, or command success, and remain
  within existing approval boundaries and stop points.
- After action, leave outputs awaiting verification and hand off to step 06.
  An existing stage awaiting validation must be checked, not blindly executed
  again on resume. Do not mark it completed from action success alone.
- Do not create a registration, execution index, evidence manifest or validation file;
  do not mirror progress into the model or introduce collapsing as a side effect.

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
