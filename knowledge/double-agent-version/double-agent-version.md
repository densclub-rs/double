---
id: double-agent-version
kind: knowledge-artifact
status: stable
produced-by: machine-of-knowledge/knowledge-extraction-agent
interaction-language: ru
artifact-language: en
knowledge-type: static
type: static
access: free-of-charge
value-type: text
observed-at: 2026-10-20
ttl: one month
derived-from:
  - knowledge/double-main-modules/double-main-modules.md
  - user-provided project versioning decision
  - .double/workflows/double-agent/double-agent-workflow.md
  - .double/skills/double-agent/SKILL.md
  - .double/agents/double-agent/double-agent.md
  - .double/roles/double-agent/machine-artifact-maintainer-role.md
  - user-approved mandatory-choice and waiting contract on 2026-10-20
---

<a id="double-agent-version"></a>

# Double Agent Version

## Description

The version assigned to the `double-agent` main module of the Double project.

## Value

`0.0.8`

## Change Note

Version `0.0.8` makes structured choices mandatory for Double Agent approval:

- use exposed and permitted `request_user_input_async`; otherwise use another
  permitted structured-question tool, including `request_user_input` only
  when its runtime and mode allow the question
- use numbered text only when no permitted structured-question tool is
  available; convenience does not justify bypassing the structured interface
- retain three choices for approval mode: approve the entire plan, approve
  each item separately, or reject the plan
- use Yes / No in the interaction language for a concrete action or individual
  item approval, with the proposed action stated in the question
- wait for an explicit submitted response or equivalent direct instruction;
  acknowledgements, preselection, silence and timeouts are not approval
- keep the turn active while a required asynchronous choice is pending;
  do not send a final waiting message, repeat the question on timeout, or
  perform dependent changes; use permitted interruptible waits of at most
  60 seconds while independent read-only work may continue
- check interface compliance and explicit approval before applying the plan
  or an individual item; preserve existing authorization without extra gates

The waiting rule governs agent behavior. It does not establish the cause of
an app question disappearing or guarantee that the client retains the UI.
