# Machine of Goals contract regression checks

This is a document-driven workflow. These tests inspect the real workflow's
positive output declarations, template metadata, producer ownership, fixed-plan
links, navigation, the preserved `Plan` document title, and the absence of
obsolete model/revision instructions.
They do not claim to execute an agent or prove runtime enforcement.

Run with the release suite's test dependencies (`pytest` and `PyYAML`):

```sh
python3 -m pytest tests/machine-of-goals
```

For an agent walkthrough, inspect the actual goal-directory files at each
boundary. Existing earlier realizations are history, not new files for this
execution. Use a disposable goal if running these scenarios; do not migrate
existing user artifacts as part of contract validation.

| Scenario | Expected result |
| --- | --- |
| Finish step 03 for branch `tool-readiness` | `plan-model-tool-readiness.md`, kind `plan-model`, template `plan-model-template`; no new executor files/directory |
| Approve exact model in step 04 and defer start | Same files; recoverable approval/digest/selection/boundaries in the conversation; no `plan-v1.md`, realization, decision file, registry row, run or index |
| Edit model after approval, then request start | Approval mismatch returns to review; no new executor files or planned action |
| Authorize step 05 with exact current content approved | First freeze `realizations/<start>/plan-v1.md`, then create `realization.md`, with separate source and frozen-file digests, before any planned action |
| Act and verify in steps 05–06 | Local frozen-plan stage links; progress/actions/results/evidence only in realization and stage records; plan digest stays unchanged |
| Edit source after starting | Stop further planned actions; old frozen plan stays byte-identical; observed outputs can be verified against it; renewed review and authorized successor are required for changed execution |
| Resume without new model edits | Use the existing frozen plan and realization; verify pending outputs without repeating actions or creating another start |
| Use a retained other execution mode | Same delayed-start gate; editable legacy `plan.md` is a model; immutable baseline, registration, decision and realization are created at step-05 start; run stage links use the pinned baseline |

A frozen plan must preserve approved transition content and boundaries, with
only provenance/identity metadata and relative-link rebasing. Human/agent review
must check semantic preservation; the structural suite cannot establish it for
arbitrary generated documents. Existing user-artifact repair/migration requires
separate authorization.
