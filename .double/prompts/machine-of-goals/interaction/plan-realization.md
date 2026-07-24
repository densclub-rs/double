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

We are going to realize the selected plan stage.

Current step: `05-plan-realization`.
Default mode: `execution`.
Expected outputs: `stage-attempt-result`, `updated-plan-artifact`.

Before action, state:

- selected stage
- approved boundaries
- required stop points
- validation criteria
- expected evidence

Use dry run when requested or required. Stop when the next action would exceed
approved boundaries or when the stage attempt result is ready for validation.

Each stage attempt result must be stored under `<goal-directory>/results/` and
must record author, device or runtime, and attempt time with second precision.
After the attempt is reflected in the active plan artifact, ask whether to keep
the separate attempt artifact. If more than 10 attempt artifacts exist for the
same stage, ask whether old attempt artifacts should be deleted, compacted, or
kept.

After responding, offer the next useful workflow movement. Name the next step,
mode, responsible agent, and expected artifact when known.
