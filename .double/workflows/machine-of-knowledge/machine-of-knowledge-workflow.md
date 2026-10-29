---
style: double
submodule: machine-of-knowledge
id: machine-of-knowledge-workflow
kind: workflow
status: stable
interaction-language: en
artifact-language: en
derived-from:
  - ideas/machine-of-knowledge/machine-of-knowledge.md
  - ideas/machine-of-knowledge/machine-of-knowledge-concepts.md
  - ideas/machine-of-knowledge/machine-of-knowledge-principles.md
  - .double/workflows/machine-of-ideas/machine-of-ideas-workflow.md
---

# Workflow: Machine of Knowledge

## Project Rules Loading Protocol

Here, project rules means project knowledge broadly: facts, settings,
conventions, constraints, version knowledge and change history. A request about
something at project level normally belongs in `.double-rules/`; it need not
use the word "rule" or prescribe behavior. Preserve the directory and existing
index headings as the discovery interface.

Before selecting a catalog, planning, or writing, load the current project's
rules. This protocol belongs to this machine and is included in its package.

1. Establish the active user project root from the request and available project
   context. Do not substitute the installation directory of a globally installed
   machine. If the root is ambiguous, clarify it before writing.
2. Look for `.double-rules/` at that root. Its absence is normal: use this
   workflow's defaults without creating a rules directory or asking the user
   to configure one.
3. When present, read `.double-rules/double-rules.md`. It is a Markdown index
   with `Common Rules` and machine-id headings. Common rules apply to every
   machine, including Double Agent, on every invocation regardless of task.
   Read every linked common rule, then every rule under this machine's heading
   (`machine-of-knowledge`). A rule may be linked under several machine headings; read it once.
4. The links identify ordinary Machine of Knowledge artifacts, not a separate
   rule template. Resolve index links relative to the index and artifact links
   relative to their documents. Catalog settings in rule values are relative
   to the active project root unless explicitly absolute. Use the existing
   knowledge template and metadata; introduce no YAML configuration, additional
   rule metadata, or mandatory rule-specific artifact sections.
5. Missing machine headings mean no additional machine rules. An existing
   directory with a missing index, a broken required link, an expired or draft
   rule, or conflicting rules must be reported and resolved before dependent
   work. Never silently ignore a rule or fall back past an unresolved conflict.
   A rule's presence does not renew its knowledge validity period.
6. Rules configure documented project settings and add project constraints;
   they cannot bypass required approvals, validation, or higher-priority
   instructions. Do not infer that machine-specific rules override common rules.
   State material conflicts and ask for resolution before dependent actions.
7. Keep `.double-rules/` in the project's version control. It is project-owned
   knowledge, outside the installer-managed `.double/` tree. Package the loading
   protocol with each machine, never the publishing project's actual rules.
   Installation, update, and removal must preserve the user's rules. A repository
   release tag records its project's rules in Git without shipping them to other
   projects in a machine archive. Changes to this protocol require affected
   machine version updates; project-rule edits alone do not require machine releases.

The index is navigation, not a second copy of each knowledge value. Machine of
Knowledge creates it only when the first project rule is accepted. It uses
Markdown headings `Common Rules`, `double-agent`, `machine-of-knowledge`,
`machine-of-ideas`, and `machine-of-goals`, with ordinary relative links under
applicable headings; unused headings may be omitted. No agent-specific entry
files are required by this protocol.

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

The version source is resolved from applicable project knowledge first, using
the Version Knowledge Resolution protocol in the Double Agent workflow. If no
project source is established, use
`knowledge/machine-of-knowledge-version/machine-of-knowledge-version.md` as the default.
An invalid or conflicting project source blocks dependent work; it does not
authorize fallback to the default.
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

Machine of Knowledge remains responsible for knowledge artifacts in the selected knowledge catalog and `.double-rules/`; they are not Machine of Knowledge operating artifacts.

## Knowledge Catalog Rule

- The ordinary knowledge catalog defaults to `./knowledge` in the active user
  project; use the base catalog configured by applicable project rules.
- The catalog follows the [Double layout naming convention](../../../Double.md#double-layout-naming-convention).
- The catalog note is `<knowledge-catalog>/<catalog-name>.md`.
- Resolve an applicable storage schema before choosing the artifact path.
- Without a storage schema, ordinary items default to
  `<knowledge-catalog>/<knowledge-id>/<knowledge-id>.md`, and project items to
  `.double-rules/<knowledge-id>/<knowledge-id>.md`.
- Accepted project knowledge is linked from `.double-rules/double-rules.md`
  regardless of the selected internal layout.
- Ids and filenames use `kebab-case`. The default layout uses matching directory
  and filename stems; a storage schema may group distinct artifact files in one
  subject directory while preserving each artifact's id and root anchor.
- Machine operating material remains under `.double/`; it must not be published as knowledge merely because it supports extraction.

If the selected ordinary knowledge catalog does not yet exist, the first knowledge run may create the
catalog and its `knowledge.md` note before publishing the first item.

## Knowledge Schema Standard

When a knowledge artifact includes `Schema`, use **JSON Schema Draft 2020-12**
exclusively. `Schema` is optional and may remain undefined, including for
unstructured knowledge that does not currently need formalization.

- An absent or undefined schema is a valid state, not an artifact defect. Omit
  the entire `Schema` section when no schema is defined; do not add an empty
  block, `null`, an "undefined" marker or a permissive placeholder schema.
- Do not invent a schema, request one as a mandatory prerequisite, restructure
  existing knowledge or mark it draft merely because no schema is defined.
  The artifact may be complete with a free-form textual `Value`.
- Record a missing schema in `Notes` only when it creates a material limitation
  for the knowledge's intended use; schema absence alone needs no note.
- Apply the following standard and schema-validation requirements only when a
  schema is actually defined or explicitly selected. Content grounding, temporal
  metadata and other ordinary artifact requirements still apply.

- Write the schema as a JSON object in a fenced `json` block under `Schema`.
- Require the root declaration
  `"$schema": "https://json-schema.org/draft/2020-12/schema"`.
- Bind the schema to its knowledge artifact with a stable `$id`, for example
  `urn:double:knowledge:<knowledge-id>`, and describe the value it validates.
- Use a validator explicitly configured for Draft 2020-12. First validate the
  schema against that dialect's meta-schema, then validate the structured value
  or descriptor against the schema. Check semantic relationships and actual
  files separately where JSON Schema cannot express them.
- Do not substitute another dialect, a custom validation language, YAML or a
  free-form structure description for `Schema`. JSON descriptors in `Value`
  are data, not an alternative schema standard.
- If an input schema omits `$schema`, declares another dialect or fails
  validation, report it and resolve or explicitly convert it before dependent
  work. Do not guess the dialect, silently reinterpret it or bypass validation.

References:

- [Dialect declaration and `$schema`](https://json-schema.org/understanding-json-schema/reference/schema)
- [Draft 2020-12 meta-schema](https://json-schema.org/draft/2020-12/schema)

## Storage Schema Resolution

Resolve placement within the existing extraction step, before creating or moving files:

1. Establish the catalog root and ordinary or project-context destination from
   the request and applicable project knowledge. A storage schema describes
   placement within that root; it does not silently change the chosen catalog.
2. Identify any applicable storage-layout knowledge supplied by the user or
   referenced by the loaded project context. A public layout knowledge artifact
   can be used without moving it into `.double-rules/`. State the selected
   source and its applicability; do not invent a schema from incidental examples.
3. A layout knowledge artifact may express a directory and its artifact files
   as structured JSON in `Value`, with JSON Schema Draft 2020-12 under `Schema` validating
   that JSON. `Schema` describes its own artifact's value, not automatically
   the path of every knowledge artifact. Apply the layout only when its subject
   and scope match the current extraction.
4. Instantiate documented placeholders from confirmed context, then derive the
   output directory, filenames and artifact ids. A subject directory may contain
   several independent knowledge artifacts. Confirm the concrete paths under
   existing authorization; do not add a mandatory folder index or wrapper artifact.
5. Check the descriptor against its JSON Schema where present, then check the
   resolved paths, ids, anchors, unique filenames and catalog boundaries. JSON
   Schema checks the descriptor; actual file existence and content require
   separate filesystem checks. Do not allow placeholders, traversal or filename
   collisions to escape the selected catalog or overwrite existing artifacts.
6. If no applicable schema exists, use the default layout above. If an explicitly
   selected schema is invalid, unsupported, ambiguous or conflicts with another
   applicable schema, resolve the problem before writing; do not silently fall
   back. Schemas do not bypass artifact content contracts, approval or validation.
7. Register the actual artifact links in the appropriate catalog or project index.
   For an authorized migration, preserve ids and values, update incoming and
   outgoing links and remove the former active copies. Do not migrate other
   artifacts merely because a schema has become available.

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
- If a required temporal field is unknown, keep the artifact in `draft` and describe the gap in `Notes`.

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

## Project Rule Recognition and Publication

Within the existing extraction step, infer from the preservation request and
conversation whether the knowledge most likely establishes a rule for running
the current project through Double. Separately infer its scope: common to all
machines, or one or more named machine ids (including `double-agent`). Project-level knowledge includes facts, versions and change history as well
as instructions; do not require imperative wording or an explicit "rule" label.

- When both project-rule intent and scope can be identified, state the inferred
  classification and scope and ask the user to confirm before publication. Reuse
  explicit confirmation already given; never infer approval from silence.
- Treat "project knowledge", "project rules" and "at project level" as signals
  for `.double-rules/`. Infer common or named-machine scope from context and
  reuse existing authorization. If project intent is clear but scope is not,
  clarify scope instead of silently publishing in the ordinary catalog. Use
  ordinary knowledge only when project-context intent is absent.
- When the user explicitly requests a project rule, including conversion of an
  existing item, scope is required. Ask whether it is common or which machines
  it applies to if that scope has not been supplied or confirmed. Do not silently
  save it as ordinary knowledge or assume every machine is an addressee.
- After acceptance, use the existing knowledge artifact template, with its
  existing grounding, access and temporal requirements. Do not create a new
  rule artifact type, metadata schema, or mandatory content sections. A rule
  awaiting confirmation must not be registered as active.
- Publish under `.double-rules/` at the path resolved by Storage Schema
  Resolution; the per-artifact directory is the default when no schema applies.
  Create the Markdown index if necessary and add its relative link under
  `Common Rules` or each confirmed machine-id heading. Common rules are loaded
  by all machines regardless of task; machine rules supplement them.
- For conversion, move the existing artifact, preserve its id, update catalog
  navigation and inbound relative links, and rebase its outgoing links. Remove
  the old active copy; do not keep competing authoritative values. Preserve
  source grounding and revalidate observation/TTL without inventing values.
- Validate the destination, confirmation, scope, index links, preserved identity,
  knowledge contract, and link integrity before declaring publication complete.

## Entry Protocol

Before extraction, the agent must confirm:

1. the knowledge subject or claim to extract
2. the available source material
3. interaction language
4. artifact language
5. whether the knowledge is `static` or `dynamic`
6. the proposed `<knowledge-id>`, applicable storage schema and resolved publication path
7. the selected mode
8. ordinary knowledge or confirmed project rule, with common or named-machine scope

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

- Ask the smallest useful set of questions in conversation.
- Assess completeness; when material gaps or uncertainty remain, describe them and whether clarification is needed in `Notes`.
- Integrate answers into the appropriate section or frontmatter and revise or omit `Notes` accordingly.
- An unresolved gap may remain only when the artifact clearly describes it and is not misleading.

## Step 01: Knowledge Extraction

- step-id: `01-knowledge-extraction`
- agent: `knowledge-extraction-agent`
- role: `knowledge-extractor-role`
- default-mode: `strict-research`
- allowed-modes: `brainstorm`, `explain`, `strict-research`, `validation`, `editor`
- required-inputs: `knowledge-subject`, `source-material`, `interaction-language`, `artifact-language`, `knowledge-type`, `knowledge-template`
- produced-output: `knowledge-artifact`
- output-location: the ordinary catalog or project-rule path selected below
- template: `.double/templates/machine-of-knowledge/knowledge-template.md`

### Extraction Rules

- Separate the knowledge claim from context, sources, interpretation, and unresolved uncertainty.
- Preserve source grounding and do not invent evidence, values, dates, or retrieval methods.
- Prefer one focused knowledge item over a broad knowledge system.
- Apply only the structure necessary to preserve and interpret the knowledge honestly.
- Follow the template's allowed fields, sections and conditional elements exactly; do not add extra fields or sections. Keep version history in a separate knowledge artifact, not the version knowledge.
- Retrieve or revalidate a value only when the user has authorized the necessary action and the required tool is available.

### Completion Conditions

The step is complete when:

- the artifact follows the knowledge template
- all frontmatter fields and top-level sections are allowed by the template, required elements are present, and optional elements are justified
- `Notes`, when needed, describes material gaps or uncertainty; omit it when there are none. Version knowledge contains no embedded changelog
- its directory and filename follow the selected storage schema, or default Double naming when no schema applies
- every included or selected schema declares JSON Schema Draft 2020-12 explicitly, has a knowledge-bound `$id`, and passes meta-schema validation
- structured values and layout JSON satisfy any defined applicable schemas; schema absence or an undefined schema does not block completion
- actual artifact paths, ids, anchors and index links agree
- `access: free-of-charge` is present
- its knowledge type is explicit
- `observed-at` and `ttl` are present for both static and dynamic knowledge
- the static or dynamic classification is consistent with the relative length of the validity period
- `retrieval-method` is present only when a concrete revalidation need justifies it
- statements and values are grounded in visible sources or user input
- no unresolved gap makes the artifact misleading

There is no automatic next step. After completion, offer
validation, revalidation of stale knowledge, or extraction of another knowledge
item.

## Artifact Contract

### knowledge-artifact

- kind: `knowledge-artifact`
- produced-by: `knowledge-extraction-agent`
- required-frontmatter: `id`, `kind`, `status`, `produced-by`, `interaction-language`, `artifact-language`, `type`, `access`, `value-type`, `observed-at`, `ttl`
- optional-frontmatter: `retrieval-method`, `derived-from`
- publication-path: resolved by Storage Schema Resolution inside the selected catalog; per-artifact directory layout is the default
- access-value: `free-of-charge`
