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
only as a separate authorized action. Treat a push as a separate decision
under project policy. For a release, pass the selected revision and
release target to the applicable release process. Use Double Agent's
Machine Release Protocol for releases of Double machines.
