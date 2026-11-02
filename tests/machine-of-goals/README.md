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
| Revise a plan | Retain the same `id`, root anchor and branch; increment the review revision and review changed content before action |
| Change stage or substage composition or numbering | Before the edit, ask whether to preserve affected realizations. If yes, preserve the old plan as local `plan.md` and update links; if no, offer deletion only with separate explicit consent. New realizations link the updated main plan |
| Edit without changing stage/substage structure or numbering | No local plan copy; preserve captured conditions and facts, and renew approval before further action |
| Start or resume a documented realization | Link the approved main plan; do not create a local plan copy. Capture stage conditions before action and validate observed results against those conditions |
| Discovery identifies independent parallel variants before any plan exists | Record the finding in `path-options.md` only. Step 03 generates short IDs unique within the goal directory and creates `plan-<id>.md` per actual variant, with matching `id` and root anchor and actual goal-table row; no prior `plan.md`, major divergence or execution files required |
| Add another parallel variant beside an existing plan | Preserve every existing file/row; create a distinct `plan-<id>.md`, checking ID/filename collisions before writing. Revisions retain its sole `id`, file and logical branch |
| An author creates their own variant | Use exactly `plan<owner_id>.md`, actual author's `owner-id`, distinct ID/anchor and actual goal-table row; no inserted hyphen or defaulting to the goal owner; resolve collisions without overwriting another variant |
| One plan has parallel stages or multiple realization media | Keep the selected plan's filename; concurrency or a shell/Python/workflow choice alone does not create an independent plan |
| Review and start a named variant | Approval and realization links use the actual selected variant and anchor; start creates no local plan copy |
| Approve and defer start | No realization or separate decision file is created |
| Act and verify | Use the canonical emoji legend; `🟠` awaits verification, `✅` requires acceptance. Preserve captured conditions and evidence |
| Inspect manual progress | Follow goal → realization → Stage Map → stage facts/evidence; do not infer activity solely from the latest filename |
| Invoke an existing authorized collapsed skill/action | Covered initial/intermediate/final checks and authority remain binding; no Machine of Goals execution directory, frozen-plan copy, realization wrapper, stage journal, index or invocation statistics |
| Repeat a manual walkthrough | Start its own authorized timestamped realization; repeatability does not require automation registration or a computed plan style |
| Import/export a model with selected documented realizations | Preserve source frozen plans and evidence; imported history does not establish local execution and exchange creates no invocation record |

A preserved local plan must retain the prior plan's identity, conditions and
structure, with links rebased for its location. Human/agent review must check
semantic preservation; structural tests cannot establish it for arbitrary files.
Existing user-artifact migration requires separate authorization.
