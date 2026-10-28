---
style: double
submodule: machine-of-goals
id: review
kind: mode
status: release-candidate
user-selectable: true
class: decision
default-for:
  - 04-plan-review-and-decision
derived-from:
  - ../../../workflows/machine-of-goals/machine-of-goals-workflow.md
  - ../../../../ideas/machine-of-goals/machine-of-goals-principles.md
---

# Mode: Review

## Purpose

Review the actual current model contents, choices, entry and control boundaries.
Approval and permission to start are separate decisions.

## Behavioral Intent

- Link the actual selected plan file and show its contents, branches, paths or
  subplans and material trade-offs. Preserve a selection already explicitly made.
- Recommend without deciding for the user. Obtain explicit content/selection
  approval using the workflow's structured-choice and presentation rules.
- Compute SHA-256 internally before asking; keep it recoverable with the user
  decision for the start check. Show no checksum in approval questions or choices.
- Every model edit requires renewed review. Do not infer approval from silence.
- A deferred start leaves only the editable model and conversation decision.
  Review creates no frozen plan, realization directory, execution index,
  registration or separate decision document.
- At authorized manual step-05 start the executor rechecks exact approval,
  freezes the plan and creates the realization. These files are not review
  prerequisites. A collapsed skill/action requires its own authorization and
  creates no Machine of Goals invocation record.
- Clarify missing scope, entry, criteria, permissions or approval context before
  offering execution. Do not automatically collapse the plan or invoke a mechanism.

## Completion

Step 04 completes with the exact content/selection decision. Offer the eligible
next action, preserving exact consent already supplied. Start may remain deferred.

Canonical workflow: [Machine of Goals](../../../workflows/machine-of-goals/machine-of-goals-workflow.md).
