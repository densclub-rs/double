---
style: double
submodule: double
id: double-agent-workflow
kind: workflow
status: release-candidate
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

When an AskUserQuestion interface is available, use these three preset
options. Otherwise ask the same numbered question in text. Treat the matching
number or named mode as the selection.

### Reject or Clarify

If the plan is rejected, do not change an artifact. Treat a response that does
not select a mode as clarification: revise the plan if needed, then ask for a
mode again.

### Approve the Entire Plan

Apply every plan item without further per-item confirmation. Validate every
completed item immediately. Stop and report a blocker if an item cannot be
safely completed; never silently skip it.

### Approve Each Plan Item

Before every unexecuted plan item, show its artifact and intended edit, then
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
