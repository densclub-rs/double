---
name: machine-of-knowledge
description: Extract, preserve, inspect, validate, or refresh knowledge through the Double Machine of Knowledge. Use when the user asks to capture knowledge as an artifact, distinguish static from dynamic knowledge, maintain retrieval metadata and a cached value, work with the `knowledge/` catalog, or continue an existing knowledge artifact. Do not trigger for casual factual questions, idea development, or goal planning unless the user explicitly asks to enter the Machine of Knowledge workflow.
---

# Machine of Knowledge

Use this skill as a thin activation and routing layer. The canonical process is:

- `.double/workflows/machine-of-knowledge/machine-of-knowledge-workflow.md`

## Entry

1. Read the canonical workflow.
2. Confirm the knowledge target, sources, interaction language, artifact language, knowledge type, proposed id and path, and mode.
3. Load the agent, role, selected shared mode, prompts, and template in the workflow's loading order.
4. Publish the result under `knowledge/<knowledge-id>/<knowledge-id>.md`.

## Core Routing Rules

- Route requests to create, change, move, or remove a Machine of Knowledge
  workflow, agent, role, mode, prompt, template, registry, skill, or catalog
  index under `.double/` to `.double/skills/double-agent/SKILL.md`.
- Before changing a working file, verify that `double-agent` is installed
  and available. If it is not, do not change a `.double/` file; require its
  installation first and then activate the Double Agent Skill.
- Use `knowledge-type: static` when the artifact does not normally represent a value that must be refreshed.
- Use `knowledge-type: dynamic` when the current value may change.
- For dynamic knowledge, require `retrieval-method`, `cached-value`, and `cached-value-date`; invent none of them.
- Use `retrieval-method` only for the invocation type, such as `local-command`, `local-script`, `rest-api`, or `mcp`; put the exact invocation in `Command`.
- Keep `access: free-of-charge` for all Double knowledge.
- Keep machine operating changes under `.double/` and produced knowledge under `knowledge/`.
- Reuse Machine of Ideas modes as specified by the workflow; do not create additional workflow stages.

## Questions and Completion

- Keep unresolved questions only in the artifact's `Questions` section.
- Integrate answers into the artifact and remove resolved questions.
- Use the workflow completion conditions before declaring the artifact complete.
- After completion, offer validation, refresh for dynamic knowledge, or extraction of another knowledge item.
