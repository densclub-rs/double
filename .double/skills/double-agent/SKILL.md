---
status: stable
name: double-agent
description: >
  Use this skill when the user asks to create, change, move, or remove a Double
  operating artifact under .double/, including a workflow, agent, role, mode,
  prompt, template, registry, skill, or machine catalog index for Machine of
  Ideas, Machine of Goals, or Machine of Knowledge. Route the request through
  Double Agent's read-only inspection, user-selected confirmation mode,
  sequential application, and validation protocol. Do not use it for ordinary
  user artifacts under ideas/, goals/, or knowledge/.
metadata:
  short-description: Safely maintain Double operating artifacts under .double/
---

# Double Agent

Use this skill as the dedicated entry point for controlled maintenance of
Double operating artifacts. It routes process changes to the Double Agent; it
does not replace a machine workflow or create user artifacts itself.

The canonical operating contract is:

- `.double/workflows/double-agent/double-agent-workflow.md`

## Activation Rule

Activate this skill when the user requests creation, modification, movement,
or removal of an operating artifact under `.double/` for Machine of Ideas,
Machine of Goals, or Machine of Knowledge. This includes:

- workflows, agents, roles, modes, prompts, templates, registries, skills, and
  machine catalog indexes
- changes to routing, validation, approval, or version-knowledge rules for a
  machine operating surface
- creation or maintenance of an integration entry point under `.double/skills/`

Do not activate solely because the user discusses an idea, goal, or knowledge
item. Such project artifacts belong under `ideas/`, `goals/`, or `knowledge/`
and must use the responsible machine workflow.

## Entry Protocol

1. Verify that `.double/agents/double-agent/double-agent.md` is installed and
   available. If it is unavailable, do not modify a `.double/` file; require
   installation first.
2. Follow the Entry Protocol and all later stages in the canonical workflow.

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
