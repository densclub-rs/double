---
style: double
submodule: double
id: parallel-work-workflow
kind: workflow
status: release-candidate
interaction-language: en
artifact-language: en
derived-from:
  - ideas/double-agent/double-agent.md#double-agent
  - ideas/double-agent/double-agent-concepts.md#concept-parallel-project-work
  - ideas/double-agent/double-agent-principles.md#principle-guide-parallel-work-from-state
  - ideas/double-agent/double-agent-principles.md#principle-explicit-collaborative-entry
  - ideas/double-agent/double-agent-principles.md#principle-integrate-checked-contributions
  - ideas/double-agent/double-agent-principles.md#principle-separate-integration-and-publication
---

# Workflow: Parallel Project Work

## Scope and Entry

Use this [Double Agent workflow](./double-agent-workflow.md) on an explicit
request to inspect parallel work, start or continue local or collaborative
work on an idea, goal, or knowledge artifact, or act on an existing parallel
work item or contribution. Apply the parent workflow's Project Rules
Loading Protocol and repository tool rules to the participant's project.

Identify the project and the requested action. For work on a specific
artifact, identify its type and existing ID or the intended new artifact.
Resolve ambiguous work items, branches, or destinations with the participant
before changing them. The owning machine governs artifact creation and editing
after the working copy is ready.

## Configure Git Work

Before preparing or resuming a working copy, load the project's default Git
settings and any settings for the selected work item. Store both as project
knowledge and route changes through the Machine of Knowledge. Apply explicit
work-item settings first and project defaults for settings the work item
leaves unspecified. Show the effective settings before handing off.

- For local work, select the work branch and working copy.
- For collaborative work, select a synchronization branch and choose between
  participant branches (the default) and one shared branch. Resolve the
  remote from Git configuration in the current clone, using the relevant
  branch configuration or the sole remote when unambiguous. Resolve any
  remaining ambiguity before remote operations.
- Configure commit, push, and pull independently as manual (the default),
  reminder, or automatic. Set an interval or time without edits for each
  scheduled action. Enable automatic commits explicitly and select the
  paths they may include.

Keep machine-specific state, such as worktree paths, activity observations,
and execution history, in the local session record. Remote configuration
belongs to the Git clone.

## Inspect Work and Offer Actions

Inspection is read-only. Use the repository and the project's configured
work or session records to identify what is known. Show, where available:

- The artifact or intended work, its branch and working copy, and any
  uncommitted changes or unfinished Git operation.
- The selected base and integration destination, and known divergence.
- Whether a contribution has been submitted or marked ready, and whether
  it has been integrated into the selected destination.
- In collaborative mode, visible sessions, potential overlap, and decisions
  awaiting review.

Treat unavailable information as unknown. A branch alone does not establish
which artifact it represents or whether its contribution is ready. A cached
remote-tracking reference only describes the last observed remote state.

Use the observed state and project policy to offer available actions:

| Observed state | Available action |
| --- | --- |
| Local work is new, or an existing working copy is ready | Prepare or resume the selected work item and enter its machine. |
| Shared work is known and the participant wants to continue | Resume their session or join the shared work with a new working copy. |
| The work branch can receive changes from a selected source | Preview the incoming changes or request an update. |
| The working copy has uncommitted changes or an unfinished Git operation | Preserve the changes and identify what must be resolved before an update or integration. |
| One or more contributions are ready for integration | Select contributions and a destination, then prepare a candidate. |
| A candidate has conflicts or a required decision | Review the affected contributions and resolve or defer the decision. |
| The contribution has been integrated | Preview outgoing changes or hand off a release request for a selected revision. |

## Prepare Local Work

1. For a new work item, identify the source branch or revision. Create a
   dedicated branch and isolated working copy, typically a Git worktree.
   For existing work, use the selected branch and working copy when they
   match the requested work. If the branch is already checked out, inspect
   that working copy before offering to reuse it.
2. Associate the work item with the project, artifact, branch, working copy,
   and starting revision. Use the project's configured records where
   available. Otherwise report the association to the participant and
   verify it from Git and participant context when resuming.
3. Preserve uncommitted work in existing copies. Report the prepared
   working copy and hand off to the owning machine.

## Start or Continue Collaborative Work

Use Git by default. Use another mechanism when the project's rules
explicitly select one.

1. Look up shared work for the project and artifact using the configured
   mechanism. Distinguish no match from an unavailable lookup. On start,
   establish shared work if none exists. If related work exists, offer to
   join it or start separate work. On continue, select existing work or
   offer to start it separately if there is no match.
2. Identify the shared integration destination and base revision. Resume
   the participant's selected session or prepare a new isolated working
   copy. Record the work ID, session ID, participant, area of work, and
   base revision.
3. Show visible activity and potential overlap before artifact editing.
   Treat overlap as a warning unless project policy restricts proceeding.
   Announce the session through the configured mechanism and report the
   result. If required lookup, preparation, or announcement is unavailable,
   identify the missing capability before treating the session as ready.

### Git Coordination

- Use the current repository for participants who share it. For separate
  clones, use the remote resolved in Configure Git Work.
  Check the shared refs before concluding that no work exists.
  If the remote cannot be queried, report its state as unknown.
- Store coordination records on dedicated Git branches under
  `refs/heads/double/work/<work-id>` and
  `refs/heads/double/session/<work-id>/<session-id>`. Use a
  `record.json` file at the root of each record branch. The work record
  identifies the artifact type and ID, integration branch, and base
  commit. The session record identifies the participant, area of work,
  base commit, and its work branch, which may be shared. Read records from Git
  without checking out their branches.
- Create or update the relevant record refs to announce work and sessions.
  In separate clones, publish only the selected coordination refs under
  project policy and verify their visibility on the shared remote. If a
  concurrent update rejects the push, refresh the record and reconcile
  before retrying. Keep record branches out of contribution candidates
  and keep working-copy paths and unpublished artifact content local.
- Compare visible session records to detect possible overlap. A record
  shows the last published session state. When work pauses or ends, update
  its session record so other participants can distinguish open and closed
  sessions. Publish contribution branches separately under project policy.

## Hand Off to the Owning Machine

Provide the project, artifact, work item, working copy, branch and base
revision, plus the integration destination if selected. Include work and
session IDs when applicable. The Machine of Ideas, Goals, or Knowledge
enters its own workflow in that working copy. When changes are submitted
for integration, Double Agent resumes coordination using the submitted
revision and its work context.

## Update a Work Branch

Confirm which source revision supplies the incoming changes and which work
branch receives them. Inspect divergence, uncommitted work, and unfinished
Git operations first. If an update could disturb existing changes, pause
for a preservation or recovery decision. Apply the project's update
policy when authorized. Report the resulting revision or the conflict
requiring resolution before further work.

## Synchronize Collaborative Branches

- With participant branches, bring changes from the selected synchronization
  branch into the participant's branch. Push committed changes to the
  participant's remote branch. Submit ready contributions through a pull
  request targeting the synchronization branch and apply the project's
  integration checks before accepting them.
- With a shared branch, each participant works from their local copy of
  that branch. Refresh the remote revision before pushing. Automatic pushes
  must be ordinary fast-forward updates that pass project checks. If a push
  is rejected because the branch advanced, refresh the state and report any
  divergence for review. Preserve both histories.

## Run Scheduled Actions

Use an available, authorized background executor to evaluate the configured
schedule for each working copy. Reload effective settings and inspect the
working copy and branch before acting. Serialize scheduled actions for the
same working copy. For a due reminder, report the action without running it.
Execute due actions only in automatic mode. Calculate inactivity from observed edits. When inactivity
cannot be established, report it as unknown and offer a manual action.

- **Commit.** Commit only the selected paths. Preserve unrelated staged and
  unstaged changes. Pause when the staged state or an unfinished Git
  operation makes the selected commit ambiguous.
- **Push.** Send committed changes only to the destination for the selected
  branch mode. Apply the synchronization rules above and the project's
  permissions. A scheduled push leaves contribution acceptance and release
  decisions to their respective workflows.
- **Pull.** Check the configured synchronization branch or selected local
  source. Apply incoming changes automatically only by fast-forward in a
  clean working copy. If the worktree has uncommitted changes, an unfinished
  operation, or divergent history, report what blocks the update.

Record the last check, last successful action, and any block or failure in
the local session record. Recheck state before a retry. Show whether the
schedule is active when resuming work. Without an executor, check for due
actions on entry and show reminders.

## Review and Integrate Selected Contributions

1. Identify the selected contributions by revision and the destination by
   branch and current revision. Show the selected range or diff and its
   dependencies. If a selection includes another work item through its
   history, disclose that dependency and resolve the selection before
   proceeding. Leave unselected work available in its own working copy.
2. Preserve each submitted revision and its base. Prepare the combined
   candidate away from the destination branch. Ask owning machines to
   check the affected artifacts and dependencies. Check semantic conflicts
   even when Git merges cleanly. For example, evidence tied to an older
   goal criterion can require validation against the candidate.
3. Show check results and any alternatives to the person authorized by the
   project. Apply local integration only when the required checks and
   authorization are in place and the destination remains at the reviewed
   revision. If it advances, prepare and check a new candidate. If the
   destination working copy has changes that the operation would disturb,
   pause and preserve them before updating it.

## Remote Publication and Release

Local integration leaves remote branches untouched. On request, preview
outgoing changes for the selected local branch and remote destination,
including the remote revision used for comparison. Refresh remote state
as authorized by the participant or the configured schedule. Treat a push
as authorized by an explicit request or the configured automatic policy.
For a release, pass the selected revision and
release target to the applicable release process. Use Double Agent's
Machine Release Protocol for releases of Double machines.
