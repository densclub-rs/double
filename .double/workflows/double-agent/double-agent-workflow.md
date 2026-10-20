---
style: double
submodule: double
id: double-agent-workflow
kind: workflow
status: stable
interaction-language: en
artifact-language: en
---

# Workflow: Double Agent

## Purpose

This workflow defines how `double-agent` maintains Double operating artifacts
under `.double/`. It is the canonical algorithm for controlled cross-machine
process changes.

`Clarify -> Inspect -> Plan -> Confirm -> Apply -> Validate -> Complete`

## Version Knowledge Rule

The Double Agent version is preserved only in
`knowledge/double-agent-version/double-agent-version.md`. A change to this
workflow, the Double Agent skill, agent, or role requires a separately planned
version-knowledge update through the Machine of Knowledge workflow.

## Scope and Routing

`double-agent` maintains working files under `.double/`: workflows, agents,
roles, modes, prompts, templates, registries, skills, and machine catalog
indexes for Machine of Ideas, Machine of Goals, and Machine of Knowledge.

User artifacts under `ideas/`, `goals/`, and `knowledge/` are outside this
workflow's default scope. Split a mixed request into separate proposed steps
and route every project artifact to its responsible machine workflow.

Do not store or infer machine versions from `.double/` frontmatter. Dedicated±`
version knowledge artifacts are the only source of machine versions.

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

## Planning Protocol

Remain in planning mode until the user approves a plan. Present ordered plan
items; for every item state its target artifact, intended edit, and validation.
State the current version knowledge and every proposed version-knowledge
follow-up.

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
