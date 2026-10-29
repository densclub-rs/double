---
status: stable
name: machine-of-knowledge
description: Extract, preserve, inspect, validate, or refresh knowledge through the Double Machine of Knowledge. Use when the user asks to capture knowledge as an artifact, distinguish static from dynamic knowledge, maintain retrieval metadata and a cached value, work with the knowledge catalog, preserve or convert project rules under `.double-rules/`, or continue an existing knowledge artifact. Do not trigger for casual factual questions, idea development, or goal planning unless the user explicitly asks to enter the Machine of Knowledge workflow.
---

# Machine of Knowledge

Use this skill as a thin activation and routing layer. The canonical process is:

- `.double/workflows/machine-of-knowledge/machine-of-knowledge-workflow.md`

## Entry

1. Read the canonical workflow.
2. Confirm the knowledge target, sources, interaction language, artifact language, knowledge type, proposed id and path, and mode.
3. Load the agent, role, selected shared mode, prompts, and template in the workflow's loading order.
4. Resolve the applicable storage schema and publish at its derived path inside
   the selected catalog; use the default layout only when no schema applies.

## Core Routing Rules

- Route requests to create, change, move, or remove a Machine of Knowledge
  workflow, agent, role, mode, prompt, template, registry, skill, or catalog
  index under `.double/` to `.double/skills/double-agent/SKILL.md`.
- Before changing a working file, verify that `double-agent` is installed
  and available. If it is not, do not change a `.double/` file; require its
  installation first and then activate the Double Agent Skill.
- Use `type: static` or `type: dynamic` according to the workflow's temporality contract.
- For both types, preserve the value, `observed-at`, and `ttl`; invent none of them. Include `retrieval-method` only when justified.
- Use `retrieval-method` only for the invocation type, such as `local-command`, `local-script`, `rest-api`, or `mcp`; put the exact invocation in `Command`.
- Keep `access: free-of-charge` for all Double knowledge.
- Keep machine operating changes under `.double/` and produced knowledge in the configured catalog or `.double-rules/`.
- `Schema` is optional and may remain undefined. Omit it when unnecessary;
  schema-free or unstructured knowledge can be complete without formalization.
  Do not invent a placeholder or require migration of existing artifacts.
- When `Schema` is defined, use only JSON Schema Draft 2020-12; require the explicit
  `$schema` URI and knowledge-bound `$id`, validate the schema and value, and
  resolve missing or unsupported dialect declarations before use.
- A storage schema may group several knowledge artifacts in a subject directory.
  Validate its structured value and actual paths; preserve ids, anchors and links.
  An invalid selected schema blocks writing instead of authorizing fallback.
- Reuse Machine of Ideas modes as specified by the workflow; do not create additional workflow stages.

## Completeness and Completion

- Ask questions in conversation and describe material gaps in `Notes` only when needed.
- Integrate answers into the artifact and update `Notes`.
- Validate fields and sections against the template; keep version history in separate knowledge.
- Use the workflow completion conditions before declaring the artifact complete.
- After completion, offer validation, refresh for dynamic knowledge, or extraction of another knowledge item.

## Project Rules Entry

Before normal entry questions or catalog selection, follow the canonical
workflow's Project Rules Loading Protocol for the active user project. Load
common rules and this machine's rules; absence of `.double-rules/` is normal.

## Project Rule Routing

Follow the canonical workflow's Project Rule Recognition and Publication
contract within the existing extraction step. Infer intent and common or
named-machine scope from context and confirm a successful inference. If
project-context intent is present, route facts, settings, versions and history
to `.double-rules/` as well as prescriptive rules. Wording such as "project
knowledge" or "at project level" is sufficient; clarify missing scope rather
than silently routing it to the ordinary catalog. Use the existing knowledge
template for both destinations.
