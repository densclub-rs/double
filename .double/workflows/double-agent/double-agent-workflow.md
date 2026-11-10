---
style: double
submodule: double
id: double-agent-workflow
kind: workflow
status: release-candidate
interaction-language: en
artifact-language: en
derived-from:
  - ideas/double-agent/double-agent.md#double-agent
  - ideas/double-agent/double-agent-principles.md#principle-explicit-collaborative-entry
  - ideas/double-agent/double-agent-principles.md#principle-integrate-checked-contributions
---

# Workflow: Double Agent

## Project Rules Loading Protocol

Project and group rules are ordinary project knowledge, including facts,
settings, conventions, constraints, versions, and change history. Before
selecting a catalog, planning, or writing, resolve the applicable knowledge
for the active user project. This protocol is packaged with each machine.

1. Establish the active project root from the request and context, not the
   installation directory. If it is ambiguous, clarify it before writing.
2. Examine at most three distinct directories: the project root, its immediate
   parent, and that parent's parent. These represent project, nearest group,
   and outer group. Each level is optional; stop at the filesystem root without
   inspecting a directory twice. In each directory use `.double-rules/` and
   its Markdown index `.double-rules/double-rules.md` if usable.
3. For this machine select links under `Common Rules` and its machine-id
   heading at each usable index. Resolve links relative to the index, artifact
   links relative to their containing documents, and catalog settings relative
   to the active project root unless explicitly absolute. Repeated links to
   the same resolved artifact at one level are read once. Missing headings
   contribute no rules. Use existing Machine of Knowledge artifacts and their
   metadata; do not introduce a separate rule template or configuration.
4. Silently skip absent, inaccessible, malformed, broken, draft, expired, or
   otherwise unusable indexes, links, and artifacts. An unusable entry never
   blocks ordinary work or renews a knowledge validity period. At one level,
   if distinct usable artifacts have the same `id`, silently exclude all of
   those conflicting artifacts for that id at that level. A broken entry does
   not invalidate other usable links in an otherwise usable index.
5. For each id select the nearest usable, non-conflicting whole knowledge
   artifact: project, immediate parent, then second parent. Do not merge fields
   or values. If a closer candidate is unusable or conflicting, try the next
   level. Distinct ids remain distinct knowledge. If no usable rule applies,
   use the machine defaults. Semantic overlap of distinct ids is handled by
   Machine of Knowledge, not silently assumed during rule loading.
6. Rules cannot bypass higher-priority instructions, required approvals, or
   validation. Common and machine-specific headings have no inherent priority
   within a level. Release preparation separately performs strict reproducible
   version-source checks on the candidate tree; silent ordinary loading does
   not authorize an ambiguous or external release version source.
7. Rules are user-owned knowledge outside installer-managed `.double/`; preserve
   each level during installation, updates, and removal. Package each machine's
   loading protocol, never a publishing project's or group's actual rules.
   Changes to this protocol require affected machine version updates; editing
   knowledge alone does not require machine releases.

At each level the index is navigation, not a copy of knowledge values. Machine
of Knowledge creates it when the first rule at that level is accepted. It uses
`Common Rules`, `double-agent`, `machine-of-knowledge`, `machine-of-ideas`,
and `machine-of-goals` headings with ordinary relative links; other machine-id
headings may be used and unused headings omitted. No agent-specific entry files
are required.

## Purpose

Double Agent actively assists people with project work using Double: answer
questions, offer advice and alternatives, and help identify the machine suited
to the work. Route specialized artifact work through its owning machine rather
than replacing it. This workflow is also the canonical algorithm for controlled
machine operating changes under `.double/` and machine release preparation,
approval, publication, and verification.

For a new machine, its idea, concepts, and principles are developed through
Machine of Ideas. Double Agent helps form and review its operating contracts
against those artifacts, Double's foundational ideas, and existing machines.

`Clarify -> Inspect -> Plan -> Confirm -> Apply -> Validate -> Complete`

For a machine release, also follow the Machine Release Protocol below:

`Inspect -> Check readiness -> Prepare locally -> Preview -> Approve message -> Push -> Verify`

## Version Knowledge Rule

For ordinary work resolve the version source from usable project and group
knowledge using the Project Rules Loading Protocol. If no usable source is
established, use
`knowledge/double-agent-version/double-agent-version.md` as the default.
Ordinary work silently skips invalid or conflicting rule sources and uses the
next usable scope or default. Release preparation uses the strict tagged-tree
version resolution in the Double Agent workflow. A change to this
workflow, the Double Agent skill, agent, or role requires a separately planned
version-knowledge update through the Machine of Knowledge workflow.

## Version Knowledge Resolution

For ordinary work apply the Project Rules Loading Protocol, including silent
fallback to the nearest usable source. The strict procedure below applies only
to machine release preparation, comparison, and tagged packaging:

1. Load `.double-rules/double-rules.md`, its `Common Rules` and `double-agent`
   knowledge. For the selected machine's version lookup, also inspect links
   under that machine's heading; this does not make all its other rules global.
2. Prefer an indexed artifact with id `<machine>-version`. A project knowledge
   artifact may instead link to the version artifact in its `Value` section.
   Resolve document links relative to the containing document. This uses ordinary
   Markdown links and existing artifact ids, with no new configuration schema.
3. A single explicit project version source is authoritative. Record its resolved
   path and use it consistently for reads, updates, readiness, tag comparison
   and packaging. Do not compare competing authoritative copies by timestamp.
4. Only if no project version source exists, read the default
   `knowledge/<machine>-version/<machine>-version.md`. The default paths for
   the four main modules remain supported without a rules directory.
5. A missing index in an existing `.double-rules/`, broken required link,
   multiple version sources, incorrect id, invalid value, draft or expired
   source blocks dependent work. Report the problem; never hide it by fallback.
6. Local preparation and CI must resolve the same source. For a tagged release,
   resolve both index and knowledge from that exact tagged tree. External files
   cannot serve as a reproducible tagged version source; preserve the source in
   the candidate project tree before release.

## Scope and Routing

`double-agent` maintains working files under `.double/`: workflows, agents,
roles, modes, prompts, templates, registries, skills, and machine catalog
indexes, including existing machines and new machines being developed.

User artifacts in the configured idea, goal, knowledge catalogs and `.double-rules/` are outside this
workflow's default editing scope. Release readiness includes read-only checks
of project artifacts belonging to the selected machine. Split a mixed change
request into separate proposed steps and route every project artifact edit to
its responsible machine workflow.

Do not store or infer machine versions from `.double/` frontmatter. Dedicated
version knowledge artifacts are the only source of machine versions.

<a id="collaborative-project-work"></a>

## Parallel Project Work

Route explicit requests to inspect parallel work, start or continue local or
collaborative work, or act on an existing work item or contribution to the
[Parallel Project Work workflow](./parallel-work-workflow.md). It prepares
the working copy before handing off to the machine responsible for the
artifact. Use the ordinary machine entry for artifact work outside that route.
Follow the applicable release process when the parallel-work workflow hands
off a release request.

## Repository Tools

Use only the `git` and `gh` command-line utilities for repository and GitHub
operations in the Double project, including read-only inspection, history,
branches, commits, tags, remote state, publication, and Actions monitoring.
Do not use GitKraken, GitHub MCP tools, other repository connectors, or browser
interfaces for these operations. Existing release scripts may orchestrate
`git` and `gh`; this rule does not replace the normal tools for local artifact
editing, packaging, or validation.

## Entry Protocol

1. Verify that `.double/agents/double-agent/double-agent.md` is installed and
   available. If it is unavailable, do not modify a `.double/` file; require
   installation first.
2. Identify the affected machine or cross-machine scope, intended operating
   artifacts, requested behavior, and any ambiguity that could materially
   change the result.
3. Read the requested artifacts and directly related workflow, agent, role,
   template, registry, and version-knowledge contracts read-only.
4. Preserve unrelated and pre-existing user changes. Inspection and
   explanation do not authorize edits.
5. Determine whether a dedicated version knowledge artifact needs a separate
   Machine of Knowledge update.
6. If the request is to release a machine, use the Machine Release Protocol.
   Approval of local preparation never replaces its final message approval.

## Planning Protocol

Remain in planning mode until the user approves a plan. Present ordered plan
items; for every item state its target artifact, intended edit, and validation.
State the current version knowledge and every proposed version-knowledge
follow-up.

Before seeking agreement on a machine change plan, inspect the relevant sources
and compare the proposed changes in three areas: Double's foundational ideas;
the affected machine's own idea, concepts, and principles; and other relevant
machines. Present one table with an area, result, and supporting evidence for
each area. Use only 🟢 for no discrepancy found in the checked material, 🔴 for
an identified discrepancy, and 🟡 for insufficient evidence. Explain the
legend. Below the table describe each finding, uncertainty, possible solutions,
and consequences, and ask the person how to proceed. Distinguish an inferred
concern from an established contradiction; do not represent an unchecked area
as passing. Incorporate the person's answer into the plan before agreement.

For a local machine the person may decide to proceed despite a contradiction
with Double's foundational ideas. Explain that such a contradiction prevents
adding the machine to the public Double repository until resolved. Project
members determine the nature and consequences of inter-machine inconsistencies;
do not impose a fixed public outcome for every such finding.

For a base-template change, offer a read-only impact list of derived
artifacts. Do not apply a template change to derived artifacts unless they are
separate items in the confirmed plan.

## Confirmation and Execution Algorithm

After presenting the plan, ask the user to choose one mode:

1. approve the entire plan;
2. approve each plan item separately;
3. reject the plan.

Present these three approval modes as the options of the permitted structured
question tool; use their matching numbers or named modes when processing the
user's response. In per-item mode, present the concrete item's approve/reject
choice after describing its scope.

For approval or rejection of one concrete plan item or an already described
whole-plan action, present exactly two suggested answers in the interaction
language: Yes / No (Да / Нет in Russian). Put the proposed action in the
question title so each answer is unambiguous. Keep the three approval-mode
options above for choosing the execution mode; do not replace that mode
selection with a binary confirmation. A Yes approves the described action;
a No does not authorize it. Preserve an explicit choice already supplied and
do not add another confirmation solely to display the interface.

Structured choice is mandatory for approval-mode and per-item decisions when
a permitted structured-question tool is available. You must use
`request_user_input_async` when it is exposed and permitted for the question.
Supply concise, contextual options
in the interaction language. A recommendation may be presented, but every
material alternative must remain available; do not add an artificial choice
when the user needs to describe something freely.

For an asynchronous question, wait for an explicit submitted response or an
equivalent direct user instruction before dependent edits, execution or state
transitions. A tool acknowledgement that the question was accepted, a
preselected option, silence or a timeout is not user approval. Independent
read-only work may continue while awaiting the answer. Do not ask again for a
choice or authorization the user already supplied.

While a required asynchronous choice is pending, do not send a final message
or end the turn merely to say that the question was sent or that you are
waiting. Use permitted interruptible waits, each no longer than 60 seconds,
and continue waiting for an explicit response. A timeout does not cancel the
question, authorize dependent work, or justify repeating it. Independent
read-only work may continue. If the user reports a missing or disappearing
question, investigate without claiming that tool acceptance proves visibility.
This is an agent waiting rule, not a guarantee about the client UI lifetime.

Check the actual runtime tool availability and its mode/purpose restrictions.
If `request_user_input_async` is unavailable or disallowed, use another exposed
structured-question tool, including `request_user_input`, only when permitted
for this question and current mode. Use a concise text question with numbered
options only when no permitted structured-question tool is available. Never
choose text merely for convenience. Never assume an interface named
`AskUserQuestion` exists or call a planning-only tool for approval when its
runtime contract forbids that use. The client controls the visual presentation;
plain text does not itself create a choice card.


### Reject or Clarify

If the plan is rejected, do not change an artifact. Treat a response that does
not select a mode as clarification: revise the plan if needed, then ask for a
mode again.

### Approve the Entire Plan

Before applying the first item, verify that each required choice used the
mandatory structured interface or a permitted fallback and that explicit user
approval was received. Preserve approval already supplied by the user.

Apply every plan item without further per-item confirmation. Validate every
completed item immediately. Stop and report a blocker if an item cannot be
safely completed; never silently skip it.

### Approve Each Plan Item

Before every unexecuted plan item, check compliance with the mandatory choice
interface and explicit-response requirement. Show its artifact and intended edit, then
ask the user to approve or reject it. Apply and validate only an approved
item. If it is rejected or changed by clarification, do not edit it; reformulate
the item when applicable and ask again.

## Machine Release Protocol

### Release Target and Sources

Activate this protocol for requests such as "release Machine of Ideas",
"выпусти новый релиз машины целей", or "release double-agent". Preparing a
release does not itself authorize sending a message or pushing to GitHub.

1. Identify the machine, requested channel, repository, remote, branch, and
   dedicated version knowledge source resolved by the protocol above. Supported
   machine identifiers are `machine-of-ideas`, `machine-of-goals`,
   `machine-of-knowledge`, and `double-agent`. Installer releases use a
   separate workflow and are outside this protocol.
2. Read the current release contracts: `scripts/double-release/release_common.py`,
   `double-release.py`, and `double-release-notes.py` in that directory,
   `.github/workflows/release.yml`, and `tests/double-release/README.md`.
   Inspect the tooling revision that Actions will execute as well as the
   candidate tree; do not assume they are identical.
3. Read local Git state and refresh remote branch/tag information without
   overwriting local refs or tags. Inspect the entire range that a push would
   introduce, including existing unpushed commits. Identify unrelated staged,
   unstaged, untracked, and ignored machine files; preserve their contents and
   staging. Do not use a broad add, implicit commit-all, or push-all operation.
4. Present a release plan using the normal planning and confirmation algorithm.
   Include any required status corrections or version-knowledge update as
   separate proposed changes. Preparation approval permits only the described
   local changes, commit, tag, and validation; remote publication stays gated
   on the final Telegram preview approval.

### Channels and Readiness

| Channel | Tag | Required working-file status | Publication |
| --- | --- | --- | --- |
| Release candidate (`rc`, `release-candidate`) | `<machine>-X.Y.Z-rc` | `release-candidate` | Prerelease; recommended channel |
| Stable (`stable`) | `<machine>-X.Y.Z` | `stable` | Stable release |
| Development (`dev`) | `<machine>-X.Y.Z-dev` | `draft` | Prerelease; discouraged; no Telegram announcement |

Recommend release candidate when the user has not specified a channel. Before
a dev release, remind the user that this kind of release is discouraged and
recommend RC. Do not silently change an explicitly requested channel. Dev may
proceed only when explicitly selected after that reminder; its project-document
readiness checks still apply.

- Build and show the complete inventory of the selected machine's working
  contracts and catalog files under `.double/`, using `owned()` from the
  release tooling as the package boundary. Include files not yet tracked or
  currently ignored. Identify shared dependencies separately without treating
  another machine's files as owned by the target.
- Check the opening YAML frontmatter of every owned working file, including
  nested files and indexes. Embedded template examples are not file statuses.
  Every owned file must match the channel exactly. Missing, unknown, or mixed
  statuses block preparation; a stable file is also excluded by the current
  RC packager. Never treat the packager's successful exclusion of files as
  evidence that the complete machine is ready.
- Identify project documents belonging to the machine under `ideas/`, `goals/`,
  and `knowledge/`: its defining idea/concepts/principles, related owned
  sub-artifacts, release-related goals, and dedicated version knowledge.
  Establish ownership from directories and explicit artifact relationships;
  report ambiguous ownership before using it as a blocker. Do not scan every
  unrelated user artifact or follow every external link as release scope.
- Require every in-scope project document to have `release-candidate` or
  `stable` status, including for a dev release. A `draft`, missing, or unknown
  status blocks release. Do not confuse goal/run execution state with document
  readiness, or impose the working-file channel's exact status on project
  documents.
- Report failures by path, actual status, required status, and owning workflow.
  Do not promote statuses, remove files from scope, or fix project artifacts
  implicitly. Route approved corrections through the normal maintenance or
  responsible machine workflow, then repeat readiness checks.

### Version, History, and Local Candidate

1. Read `X.Y.Z` from the dedicated version knowledge artifact and compare it
   with existing local and remote tags of the same machine. Report the most
   recent released versions and intended tag. Never overwrite or move an
   existing release tag; RC-to-stable promotion may retain `X.Y.Z`, while a
   second RC must use a new available version under the current tag syntax.
   Treat older-version requests or conflicting remote/local tags as unresolved
   release decisions, rather than silently choosing a new version.
2. Determine the comparison baseline using the existing baseline rules
   and confirm it using `baseline()` once the local candidate tag exists:
   the highest eligible earlier reachable stable/RC tag of the same machine;
   dev tags and tags at the candidate commit are excluded. Stable can use an
   RC of the same numeric version. Show the chosen baseline and comparison
   range. If no baseline qualifies, explain the initial-history behavior and
   any existing tags excluded by ancestry or version rules.
3. Inspect all candidate machine files and changes since that baseline:
   frontmatter, identifiers, links, registry/template/workflow agreement, and
   version knowledge. Summarize actual changes for the commit and annotation.
   Avoid generic release prose that hides what changed. Prepare a `### X.Y.Z[-rc|-dev] — YYYY-MM-DD` entry with concise change
   bullets inside `Value` in the machine's resolved changelog knowledge. Resolve
   `<machine>-changelog` from the project index as for version knowledge, using
   `knowledge/<machine>-changelog/<machine>-changelog.md` only when no project
   source is established. The approved entry includes the version/date heading.
   Show its full text, allow user edits or requested corrections, and obtain
   explicit Yes / No approval of the exact current entry before candidate
   commit or tag creation. Plan approval is not entry approval. A later edit
   invalidates entry approval and requires review and approval again. Stable
   and RC may have different approved entries in their respective tagged trees.
4. After local preparation and the exact entry are approved, stage only the explicit approved file
   list and verify the staged diff. If unrelated changes are already staged,
   use an isolated candidate/index or another method preserving their staging.
   Include the changelog in the candidate commit and create an annotated tag
   whose full message equals the approved entry. Use `--cleanup=verbatim` when
   creating the tag so Git preserves Markdown version headings beginning with
   `#`. Verify the stored annotation against the complete approved entry.
   Record the candidate commit
   and tag object IDs. If a suitable
   commit already exists, use it rather than creating an empty commit.
5. Recheck readiness in the exact tagged tree. Run the release suite and its
   candidate check, following the current test README, including
   `--release-tag <tag>`. Inspect the archive/checksum outputs and compare the
   archive inventory to the complete expected machine inventory. Warnings,
   skipped files, no package, or a missing candidate check are not successful
   release validation. Keep generated `dist/` outputs out of the release
   commit unless separately required by an approved plan.

### Telegram Preview and Final Approval

#### Release Language

Write the full annotated-tag message and complete Telegram announcement in
English, regardless of the conversation language. This includes change
descriptions, headings, and link labels; preserve machine identifiers, version
strings, URLs, and proper names as required.

The approved changelog entry and matching annotation must be English. Do not
silently translate only the preview. An unresolved language mismatch blocks
push and requires an updated approved entry and preview.

1. Generate release notes and `telegram-message.html` locally from the exact
   annotated tag using `python3 scripts/double-release/double-release-notes.py --tag
   <tag> --repository <owner/repository> --directory <preview-directory>`.
   Use the same tagged changelog entry, annotation, renderer revision and
   repository identity as Actions. A missing, empty or ambiguous entry or an
   annotation mismatch blocks publication. GitHub notes contain the full
   entry; Telegram may shorten it and links to the full release.
2. Show the complete resulting Telegram text and links in readable form and
   provide the generated HTML for inspection. Use the rendered output rather
   than composing a separate sample. Show actual truncation and release links
   produced by the renderer. The only
   permitted declared dynamic part is the future Actions run URL: show its
   position as an explicit placeholder and explain its substitution before
   approval. Render with that placeholder already present via the generator's
   Actions run environment inputs, so the footer participates in the Telegram
   length budget. Check that substituting the real URL cannot change entry
   omission or truncation; otherwise the preview is unresolved. If any other
   content cannot be reproduced, stop before push and
   report the mismatch; a promise of an exact preview is not validation.
3. Present one review packet: machine, channel, version, baseline, included
   files, validation results, remote/branch, complete outgoing commit range,
   candidate commit ID, tag name/object ID, full annotation, release notes,
   and Telegram preview. For dev, explicitly show that Actions will send no
   Telegram announcement; preview generation does not establish eligibility.
4. Ask a concrete Yes / No question in the interaction language approving
   this message (or explicit dev non-announcement) and publication of the
   identified commit/tag to the specified GitHub remote. Use the mandatory
   structured choice interface. Approval of the maintenance plan or local
   preparation is not this approval. Wait for an explicit response; rejection
   leaves the candidate local and authorizes no publication.
5. Approval is bound to that review packet. If the candidate tree, outgoing
   history, version, channel, tag annotation/object, baseline, tooling, or
   rendered content changes, invalidate it, rerun affected checks, show the
   updated preview, and obtain approval again. Do not recreate even an
   unpushed local tag without approval of that replacement. Recheck Git/remote
   state and metadata immediately before pushing.

### Publish and Verify

After final approval, push only the identified branch update and annotated
tag, using explicit refspecs and an atomic push when supported. If atomic push
is unavailable, report it and use a deliberate sequence that pushes the
candidate commit before its triggering tag. Never force-push or replace a
remote release tag. Do not push additional tags or unreviewed branch commits.

Let `.github/workflows/release.yml` build and publish the release and send the
notification. Do not call local `publish`, create a second GitHub Release, or
send Telegram directly as a substitute for Actions.

Track the run for the exact tag/commit. Verify candidate validation, package
and checksum assets, GitHub Release URL and prerelease/stable classification,
and the Telegram job's configuration and delivery steps. Telegram failure is
non-fatal in the current workflow, so overall workflow success alone does not
prove delivery. Report delivery as sent, skipped, failed, or unverified based
on available evidence. Dev should be skipped by eligibility.

Report publication and notification results separately, with release/run
links. If publication or notification fails, inspect the failure and preserve
the published state. Do not automatically rerun publication or Telegram:
reruns may duplicate announcements or replace assets and require an explicit
decision based on the actual remote state. If run monitoring is unavailable,
report the pending or unverified result without claiming release completion.

## Validation and Completion

For each changed operating artifact, validate frontmatter, required
identifiers, links, agreement with this workflow, relevant version knowledge,
and repository-specific structural rules. Validate immediately after changing
the artifact.

When the confirmed plan is complete, provide a Markdown table of every
executed item, result, and validation outcome. Identify blocked, rejected, or
pending items and any required version-knowledge follow-up.

## Boundaries

- Do not edit while clarifying, inspecting, validating, or planning.
- Do not edit before the change plan has been confirmed.
- Do not silently expand the confirmed scope or overwrite unrelated user work.
- Do not claim completion without the relevant validation.
