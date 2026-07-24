---
style: double
submodule: machine-of-knowledge
id: machine-of-knowledge-workflow
kind: workflow
status: draft
interaction-language: en
artifact-language: en
derived-from:
  - ideas/machine-of-knowledge/machine-of-knowledge.md
  - ideas/machine-of-knowledge/machine-of-knowledge-concepts.md
  - ideas/machine-of-knowledge/machine-of-knowledge-principles.md
  - .double/workflows/machine-of-ideas/machine-of-ideas-workflow.md
---

# Workflow: Machine of Knowledge

## Purpose

This workflow extracts a piece of knowledge and preserves it as a knowledge
artifact. It is intentionally a one-step machine:

`Knowledge Extraction -> Knowledge Artifact`

## Inherited Common Contract

Machine of Knowledge reuses these common concepts from Machine of Ideas:

- confirm the target before writing an artifact
- choose interaction language and artifact language separately
- use user-selectable modes without changing the workflow step
- ground the artifact in supplied source material
- preserve unresolved questions in the active artifact
- integrate answers into the artifact instead of leaving them only in chat
- use validation before declaring an uncertain artifact complete
- keep machine operating material under `.double/`

This workflow is the canonical source for knowledge-specific behavior.

## Version Knowledge Rule

The machine version is preserved only in
`knowledge/machine-of-knowledge-version/machine-of-knowledge-version.md`.
Changes to the workflow, artifact contract, agent role, or transition
conditions require the version knowledge to be updated through the Double Agent
Skill.

## Operating Artifact Maintenance

When a request creates, changes, moves, or removes a Machine of Knowledge
operating artifact under `.double/`, activate
`.double/skills/double-agent/SKILL.md`.

Before any working-file change, verify that `double-agent` is installed and
available. If it is unavailable, do not change a `.double/` file; require
installation first, then activate the Double Agent Skill.

Machine of Knowledge remains responsible for knowledge artifacts under
`knowledge/`; they are not Machine of Knowledge operating artifacts.

## Knowledge Catalog Rule

- The project catalog is `./knowledge` in the current Double project.
- The catalog follows the [Double layout naming convention](../../../Double.md#double-layout-naming-convention).
- The catalog note is `knowledge/knowledge.md`.
- Each knowledge item uses `knowledge/<knowledge-id>/<knowledge-id>.md`.
- `<knowledge-id>` must use `kebab-case` and the artifact filename must match its directory name.
- Machine operating material remains under `.double/`; it must not be published as knowledge merely because it supports extraction.

If `knowledge/` does not yet exist, the first knowledge run may create the
catalog and its `knowledge.md` note before publishing the first item.

## Permanent Free-of-Charge Rule

Every knowledge artifact belonging to the Double project must contain:

```yaml
access: free-of-charge
```

This value must not be changed to paid, subscription-only, member-only, or
otherwise chargeable access during the lifetime of the project. Other,
non-knowledge artifacts may use different access models.

## Knowledge Temporality

Every knowledge artifact must preserve a temporal state that connects:

```yaml
observed-at: <when-the-preserved-value-was-observed>
ttl: <human-readable-period-until-which-the-preserved-value-may-be-trusted>
retrieval-method: <optional-invocation-type-for-refreshing-the-value>
```

Rules:

- `observed-at` is required for both static and dynamic knowledge.
- `ttl` is required for both static and dynamic knowledge.
- `ttl` defines the trust horizon for the last acquired value: until this time, the knowledge may be treated as valid and trusted.
- `ttl` must be a clearly bounded, human-readable period from `observed-at`.
- `retrieval-method` is optional for both types and is included only when a concrete revalidation need exists.
- `retrieval-method` identifies the invocation type, for example `local-command`, `local-script`, `rest-api`, `mcp`, or `manual`.
- When a retrieval method is present, record the exact command, request, or procedure in the `Command` section.
- Observed values, dates, TTL values, and retrieval methods must come from the user, visible sources, or an actual authorized retrieval; the agent must not invent them.
- Use `YYYY-MM-DD` or an ISO 8601 date-time for `observed-at`, with greater precision when it matters.
- TTL is a horizon for trusting knowledge as valid, not a guarantee that it remains true throughout that period.
- A stale value remains preserved knowledge, but it must not be assumed current without revalidation.
- Revalidation may be manual or automated; the base workflow does not require automatic refresh.
- If a required temporal field is unknown, keep the artifact in `draft` and record the missing information under `Questions`.

## Knowledge Types

### Static Knowledge

Static knowledge has a comparatively long validity period and is deliberately
treated as unchanged during normal use. It still carries `observed-at` and
`ttl` and may eventually become stale.

Static does not mean timeless, universally true, infallible, or impossible to
revise. A retrieval method is optional and should be included only when it
serves a concrete revalidation need.

### Dynamic Knowledge

Dynamic knowledge has a comparatively short validity period, so its preserved
value must be interpreted in relation to when it was observed and when it
becomes stale. It uses the same temporal-state fields as static knowledge.

Dynamic does not mean continuous or predictable change and does not require
automatic retrieval. Its shorter validity period only makes revalidation
operationally relevant sooner.

## Entry Protocol

Before extraction, the agent must confirm:

1. the knowledge subject or claim to extract
2. the available source material
3. interaction language
4. artifact language
5. whether the knowledge is `static` or `dynamic`
6. the proposed `<knowledge-id>` and publication path
7. the selected mode

The agent may infer a proposed target, type, or id from explicit context, but
must state the inference before using it when uncertainty could change the
artifact.

## Loading Order

1. this workflow
2. `.double/agents/machine-of-knowledge/knowledge-extraction/knowledge-extraction.md`
3. `.double/roles/machine-of-knowledge/knowledge-extractor-role.md`
4. `.double/registries/machine-of-knowledge/modes-registry.md`
5. selected mode definition
6. `.double/prompts/machine-of-knowledge/system/knowledge-extraction.md`
7. `.double/prompts/machine-of-knowledge/interaction/knowledge-extraction.md`
8. `.double/templates/machine-of-knowledge/knowledge-template.md`

## Modes

To avoid duplicating common behavior, Machine of Knowledge reuses the Machine
of Ideas mode definitions:

- `brainstorm`
- `explain`
- `strict-research`
- `validation`
- `editor`

Default mode: `strict-research`.

## Human Clarification Loop

- Record unresolved questions only in the artifact's `Questions` section.
- Ask the smallest useful set of questions.
- Integrate each answer into the appropriate main section or frontmatter.
- Remove the answered question after integration.
- Do not create a `Resolved Questions` section or store answers under questions.
- An unresolved question may remain only when it does not make the artifact misleading.

## Step 01: Knowledge Extraction

- step-id: `01-knowledge-extraction`
- agent: `knowledge-extraction-agent`
- role: `knowledge-extractor-role`
- default-mode: `strict-research`
- allowed-modes: `brainstorm`, `explain`, `strict-research`, `validation`, `editor`
- required-inputs: `knowledge-subject`, `source-material`, `interaction-language`, `artifact-language`, `knowledge-type`, `knowledge-template`
- produced-output: `knowledge-artifact`
- output-location: `knowledge/<knowledge-id>/<knowledge-id>.md`
- template: `.double/templates/machine-of-knowledge/knowledge-template.md`

### Extraction Rules

- Separate the knowledge claim from context, sources, interpretation, and unresolved uncertainty.
- Preserve source grounding and do not invent evidence, values, dates, or retrieval methods.
- Prefer one focused knowledge item over a broad knowledge system.
- Apply only the structure necessary to preserve and interpret the knowledge honestly.
- Retrieve or revalidate a value only when the user has authorized the necessary action and the required tool is available.

### Completion Conditions

The step is complete when:

- the artifact follows the knowledge template
- its directory and filename follow Double naming
- `access: free-of-charge` is present
- its knowledge type is explicit
- `observed-at` and `ttl` are present for both static and dynamic knowledge
- the static or dynamic classification is consistent with the relative length of the validity period
- `retrieval-method` is present only when a concrete revalidation need justifies it
- statements and values are grounded in visible sources or user input
- no unresolved question makes the artifact misleading

There is no automatic next step. After completion, offer
validation, revalidation of stale knowledge, or extraction of another knowledge
item.

## Artifact Contract

### knowledge-artifact

- kind: `knowledge-artifact`
- produced-by: `knowledge-extraction-agent`
- required-frontmatter: `id`, `kind`, `status`, `produced-by`, `interaction-language`, `artifact-language`, `knowledge-type`, `access`, `observed-at`, `ttl`, `derived-from`
- optional-frontmatter: `retrieval-method`
- publication-path: `knowledge/<knowledge-id>/<knowledge-id>.md`
- access-value: `free-of-charge`
