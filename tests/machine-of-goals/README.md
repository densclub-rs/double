# Machine of Goals contract regression checks

This is a document-driven workflow. These tests inspect the real workflow's
positive output declarations, template metadata, producer ownership, fixed-plan
links, navigation, ordinary/parallel/author filenames, stable plan ID/anchor,
`Plan` document title, mandatory progress emoji/legend, and the absence of
obsolete execution artifacts, mode exceptions and model/revision instructions.
The scan includes active mode definitions and the shared template catalog.
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
| Create any new plan: ordinary, parallel or author variant | Synthesize one short meaningful word jointly expressing the actual plan's subject, core meaning and goal, distinguishing it from other variants. A readable coined word is allowed. Use lowercase English letters only, without spaces, hyphens or digits. Write only `id` in plan frontmatter and use it as the root anchor; use it in the filename only for parallel variants. Do not add a duplicate plan identity field |
| An ID names only the subject, action or goal, or uses several hyphen-separated words | It does not satisfy the contract. Synthesize one word combining all three concepts from this plan's context |
| The generated word is already used by another plan | Choose another single word derived from the same plan's context that still combines its subject, core meaning and goal. Do not choose a random/unrelated word, generate numeric/opaque codes or append a numeric suffix. Preserve existing plans and their IDs |
| Revise or freeze a plan, start a successor realization | Retain the same `id` and root anchor in the source and frozen plans. Exact file paths, revisions/versions and digests identify copies. The realization keeps its own `id` and references the plan through `plan-id` |
| Finish step 03 for an ordinary plan with branch `tool-readiness` | `plan.md`, generated word as `id` and root anchor, heading `Plan`, kind `plan-model`, template `plan-model-template`; branch metadata alone creates no additional plan; no executor files/directory |
| Revise the default plan within its existing lineage | Same logical `branch`, updated review revision and goal-table row; still `plan.md`, no new branch file |
| Discovery identifies independent parallel variants before any plan exists | Record the finding in `path-options.md` only. Step 03 generates short IDs unique within the goal directory and creates `plan-<id>.md` per actual variant, with matching `id` and root anchor and actual goal-table row; no prior `plan.md`, major divergence or execution files required |
| Add another parallel variant beside an existing plan | Preserve every existing file/row; create a distinct `plan-<id>.md`, checking ID/filename collisions before writing. Revisions retain its sole `id`, file and logical branch |
| An author creates their own variant | Use exactly `plan<owner_id>.md`, actual author's `owner-id`, distinct ID/anchor and actual goal-table row; no inserted hyphen or defaulting to the goal owner; resolve collisions without overwriting another variant |
| One plan has parallel stages or multiple realization media | Keep the selected plan's filename; concurrency or a shell/Python/workflow choice alone does not create an independent plan |
| Review and start a named variant | Approval links the actual `plan-<id>.md` or `plan<owner_id>.md`. At authorized start, frozen-plan/realization source paths, anchors and digests refer to that file; frozen filenames remain `plan-v1.md` and `realization.md` |
| Approve the linked plan contents in step 04 and defer start | User sees the current plan file link, contents and scope; no checksum in the question/choices/summary. Internal content fingerprint remains recoverable for the start check. Same files; no new frozen plan, realization, registration, separate decision or execution index |
| Edit model after approval, then request start | Approval mismatch returns to review; no new executor files or planned action |
| Authorize step 05 with exact current content approved | First freeze `_realizations/<start>/plan-v1.md`, then create `realization.md`, with separate source and frozen-file digests, before any planned action |
| Act and verify in steps 05–06 | State cells contain only one emoji, with the explanatory legend above the map; no repeated state words or duplicate status column. Prose handoffs may add labels. Use 🟠 after action and ✅ only after output acceptance; preserve other outcome markers, textual metadata and evidence; frozen plan digest stays unchanged |
| Edit source after starting | Stop further planned actions; old frozen plan stays byte-identical; observed outputs can be verified against it; renewed review and authorized successor are required for changed execution |
| Resume without new model edits | Use the existing frozen plan and realization; verify pending outputs without repeating actions or creating another start |
| Inspect manual progress | Follow goal → actual timestamped realization → Stage Map/current stage → stage facts/evidence; neither editable nor frozen plan has progress. Activity is not inferred solely from the latest filename |
| Invoke an existing authorized collapsed skill/action | Covered initial/intermediate/final checks and authority remain binding; no Machine of Goals execution directory, frozen-plan copy, realization wrapper, stage journal, index or invocation statistics |
| Repeat a manual walkthrough | Start its own authorized timestamped realization; repeatability does not require automation registration or a computed plan style |
| Import/export a model with selected documented realizations | Preserve source frozen plans and evidence; imported history does not establish local execution and exchange creates no invocation record |

A frozen plan must preserve approved transition content and boundaries, with
only provenance/identity metadata and relative-link rebasing. Human/agent review
must check semantic preservation; the structural suite cannot establish it for
arbitrary generated documents. Existing user-artifact repair/migration requires
separate authorization.
