---
status: release-candidate
name: double-agent
description: >
  Actively assist people with project work using Double, coordinate local and
  collaborative parallel work on ideas, goals, or knowledge, and route
  specialized work to its owning machine. Maintain operating artifacts
  under .double/, and prepare or publish machine releases. Follow the canonical
  Double Agent workflow for inspection, planning, confirmation, sequential
  changes, and validation. Do not replace specialized user artifact workflows
  or handle installer releases.
metadata:
  short-description: Maintain Double contracts and prepare approved machine releases
---

# Double Agent

Use this skill for active assistance with project work using Double and for
controlled maintenance of machine operating artifacts and machine releases.
Route specialized project artifact work to its responsible machine workflow.

The canonical operating contract is:

- `.double/workflows/double-agent/double-agent-workflow.md`

## Activation Rule

Use the canonical workflow's Parallel Project Work route when a participant
explicitly asks to inspect parallel work, start or continue local or
collaborative work on an idea, goal, or knowledge artifact, or act on an
existing parallel work item or contribution. This includes requests to work
on an artifact in a separate worktree. The route prepares the work before
handing off to the owning machine. Use the ordinary machine entry for
artifact work outside that route.

Activate this skill for advice or assistance with project work using Double,
for new machine operating contracts, and when the user requests creation,
modification, movement, or removal of a machine operating artifact under
`.double/`. This includes:

- workflows, agents, roles, modes, prompts, templates, registries, skills, and
  machine catalog indexes
- changes to routing, validation, approval, or version-knowledge rules for a
  machine operating surface
- creation or maintenance of an integration entry point under `.double/skills/`

Also activate for a request to release a named Double machine, including
`double-agent`, even when the request does not explicitly mention `.double/`.
For example: "выпусти новый релиз машины идей" or "release Machine of Goals RC".
Use the canonical workflow's Machine Release Protocol, including its final
message approval gate. Installer releases have a separate workflow.

Route specialized work on ideas, goals, or knowledge to the responsible machine
workflow. Assistance and routing do not replace its ownership of those artifacts.

## Entry Protocol

1. Verify that `.double/agents/double-agent/double-agent.md` is installed and
   available. If it is unavailable, do not modify a `.double/` file; require
   installation first.
2. Follow the Entry Protocol and all later stages in the canonical workflow.

## Machine Release Routing

- Recommend `release-candidate` (`rc`). Remind users that `dev` releases are
  discouraged; preserve an explicitly chosen channel after that reminder.
- Check the complete owned `.double/` inventory against the requested channel,
  and machine-owned project documents for `release-candidate` or `stable`.
  Packager exclusions do not prove readiness. Plan status fixes separately.
- Resolve machine version knowledge from the project index first; use the
  canonical workflow's default path only when no override exists. Invalid or
  conflicting sources block dependent work.
- Read the resolved machine version knowledge and previous machine tags;
  prepare and validate only the approved local commit and annotated tag.
- Draft the version's changelog entry and obtain explicit approval of its exact
  contents before candidate creation; edits require renewed approval. The tag
  annotation and GitHub release notes must match that entry.
- Before any push, show the full tag annotation and Telegram output from the
  real notes generator. Declare the future Actions run-link placeholder and
  stop on any other unresolved local/CI rendering difference. Dev has no
  Telegram announcement under the current workflow.
- Write the changelog entry, annotated-tag message and Telegram announcement
  in English, independently of the conversation language.
- Obtain explicit approval of the concrete message and identified publication
  before pushing. Plan approval is not message approval. Changed content
  requires a fresh preview and approval.
- Let GitHub Actions publish and notify; verify release and Telegram outcomes
  separately. Follow the canonical protocol for details and failure handling.

## Repository Tools

For repository and GitHub operations in the Double project, use only the
`git` and `gh` command-line utilities. Do not use GitKraken, GitHub MCP tools,
or other repository connectors or browser interfaces for these operations.
The existing release scripts may orchestrate `git` and `gh`; local artifact
editing, packaging, and validation retain their normal tools. This rule applies
to inspection as well as commits, tags, push, releases, and Actions monitoring.

## Choice Interface

- follow the canonical workflow's mandatory structured-choice rule for
  approval-mode and per-item decisions: use exposed and permitted
  `request_user_input_async`, otherwise another permitted structured tool
  (including `request_user_input` only when allowed by its runtime contract)
- follow the canonical workflow's Yes / No rule for concrete action approvals
  and its three-option rule for approval-mode selection
- use numbered text only when no permitted structured tool is available;
  convenience is not a reason to bypass structured choice
- wait for an explicit response without sending a final message or ending the
  turn while the required choice is pending; use permitted interruptible waits
  of at most 60 seconds and do not repeat a pending question on timeout
- preserve existing authorization; tool acknowledgements, preselected defaults,
  silence and timeouts are not approval; tool acceptance does not prove that
  the client displayed or retained the question

## Validation Boundaries

- This skill is a trigger and routing layer, not a separate workflow.
- The workflow file is the source of truth for planning, confirmation,
  execution, validation, and completion.
- Do not overwrite unrelated or pre-existing user changes.

## Project Rules Entry

Before normal entry questions or catalog selection, follow the canonical
workflow's Project Rules Loading Protocol for the active user project and its
two nearest parent levels. Select usable common and this machine's rules by id;
silently skip unusable sources and use the nearest usable scope.
