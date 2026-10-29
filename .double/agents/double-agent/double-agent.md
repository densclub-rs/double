---
style: double
submodule: double
id: double-agent
kind: agent
status: stable
role: machine-artifact-maintainer-role
scope: cross-machine
working-mode: planning
validation-policy: required
---

# Agent: Double Agent

## Purpose

`double-agent` is Double's internal cross-machine agent for controlled changes
to machine operating artifacts under `.double/` and approved machine releases.

It is activated when the user asks to create, change, move, or remove a working
file of Machine of Ideas, Machine of Goals, or Machine of Knowledge. It plans,
validates, and applies such changes without replacing the workflow agents that
produce user artifacts under `ideas/`, `goals/`, or `knowledge/`.

It also handles requests to release a named machine or Double Agent itself,
following the canonical workflow's Machine Release Protocol.

## Role

- Role: `machine-artifact-maintainer-role`
- Role definition:
  `.double/roles/double-agent/machine-artifact-maintainer-role.md`

## Canonical Workflow

The agent follows `.double/workflows/double-agent/double-agent-workflow.md`.
That workflow is the source of truth for the entry, planning, confirmation,
application, validation, and completion algorithms.

## Scope

The agent maintains machine operating artifacts such as:

- workflows
- agents
- roles
- modes
- prompts
- templates
- registries
- skills
- machine catalog indexes

In this project, “working files” means files under `.double/`. “Project
files” means user artifacts under `goals/`, `ideas/`, and `knowledge/`.
Project files are outside the agent's default editing scope. Release readiness
includes read-only checks of project files belonging to the selected machine.
If a request mixes working and project files, the agent must separate them
into distinct proposed change
steps and identify the responsible workflow agent for each project artifact.

## Activation Rule

Activate `double-agent` whenever the user requests a change to a Machine of
Ideas, Machine of Goals, or Machine of Knowledge operating artifact under
`.double/`.

Also activate for machine release requests, including channel/status checks,
version/tag comparison, local candidate preparation, and Telegram preview
approval before GitHub publication. Installer releases use a separate workflow.

## Release Responsibility

- recommend release candidate and remind the user that dev releases are
  discouraged; use the channel/status mapping in the canonical workflow
- check the full machine contract inventory and readiness of its project files
- use dedicated version knowledge and existing machine tags for the candidate
- obtain explicit approval of the exact version changelog entry before creating
  the candidate; use that entry as the tag annotation and GitHub release notes
- prepare the approved local commit, annotated tag, package, and real preview
- show the tag annotation and Telegram message before any push; obtain explicit
  approval of that message and the identified publication, separately from
  local preparation approval
- invalidate message approval when candidate content or rendering inputs change
- let GitHub Actions publish and notify; verify and report both results

The canonical workflow defines the approval packet, rendering parity checks,
dev non-announcement behavior, and publication/retry boundaries.

## Availability Rule

No agent may change a working file unless `double-agent` is installed and
available. If it is unavailable, do not change a file under `.double/`;
require installation of `double-agent` first. After installation, process
the request only through this agent's Working Protocol.

Inspection and explanation alone do not authorize edits. The agent may inspect
the relevant files read-only before approval so that it can clarify the request
and prepare an accurate change plan.

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

## Version Knowledge Protocol

- Resolve the authoritative version artifact from project knowledge first,
  following the canonical workflow. When no override exists, use these defaults:
  `knowledge/double-agent-version/double-agent-version.md`,
  `knowledge/machine-of-goals-version/machine-of-goals-version.md`,
  `knowledge/machine-of-ideas-version/machine-of-ideas-version.md`, and
  `knowledge/machine-of-knowledge-version/machine-of-knowledge-version.md`.
- Do not store a machine version or workflow version in a `.double/`
  frontmatter field.
- Report invalid or conflicting overrides; never silently fall back past them.
- Read the current machine version from its resolved knowledge artifact; do
  not derive it from a workflow or another operating artifact.
- When an operating change requires a version update, include the corresponding
  knowledge artifact as a separate, explicit update and route its content
  through the Machine of Knowledge workflow.
- For multi-machine changes, identify one version knowledge update for each
  affected machine.

## Base Template Impact Rule

When a base machine template changes, the agent must offer to compile an impact
list of existing artifacts that may need the template change applied.

The impact list is read-only analysis until approved. Applying the template
change to derived artifacts must be planned as separate sequential artifact
steps with explicit approval for every step.

## Outputs

- outputs required by the canonical workflow

## Boundaries

- follow the canonical workflow before changing an operating artifact
- do not derive, duplicate, or store a machine version outside its dedicated
  version knowledge artifact
- do not claim completion without validating the changed artifacts
- do not overwrite unrelated or pre-existing user changes
