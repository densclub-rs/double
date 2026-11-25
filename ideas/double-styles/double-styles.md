---
id: double-styles
kind: idea-artifact
status: stable
double-repository: https://github.com/densclub-rs/double
project-repository: https://github.com/densclub-rs/double
produced-by: idea-capture-agent
interaction-language: Russian
artifact-language: English
derived-from:
  - user conversations on 2026-08-27
  - user clarification and refinement of styles on 2026-11-22
  - user decision on project precedence over global style settings on 2026-11-23
  - user clarification of project-wide and role-specific style selection on 2026-11-23
  - user confirmation that project rules determine style application on 2026-11-23
  - user decision that a selected style fully replaces the previous style without mixing on 2026-11-23
  - user clarification that styles are AI-agent recommendations without mandatory machine compatibility declarations on 2026-11-23
  - user decision to create every new style directly in the global catalog and select it through project rules on 2026-11-23
  - user decision to reserve updates of Double styles to Double and give user overrides new names on 2026-11-23
  - user decision to use installed style updates immediately and require agent rereading on 2026-11-23
  - user decision to share the existing global Double service-artifact root across projects and AI clients on 2026-11-23
  - user decision to store official style files directly in styles/ and personal styles in styles/custom/ on 2026-11-23
  - user decision to start with free-form Markdown style files and refine the format through use on 2026-11-23
  - user decision to treat empty or unreadable style files as unavailable on 2026-11-23
  - user approval of a separate default double.md style and formal role-mode-style separation on 2026-11-23
  - user approval of independent stable releases of the whole style library on 2026-11-23
---

<a id="double-styles"></a>

# Idea: Double Styles

## 1. Summary

A style is a named, reusable resource containing recommendations for an AI agent to act in a particular way, shaping machine behavior through preferences such as communication formality, search depth, and the breadth of alternative analysis. Roles define responsibility, modes define the purpose and mandatory conditions of current work, and styles define behavioral recommendations. The default Double style is centralized in `styles/double.md`; project rules can select a different style that replaces it completely.

Double Agent helps users define styles directly in the global catalog and connect them through project rules. Styles can remain personal indefinitely; contributing them to Double is optional.

## 2. Context / Origin

The earlier idea explored styles as reusable ways of working that might select or replace a complete workflow. The discussion on 2026-11-22 clarified the immediate purpose: users need control over how existing machines and their roles behave, without copying or replacing those roles.

[Project rules](../double-agent/double-agent-concepts.md#concept-scoped-project-knowledge) already provide a way to direct machine behavior in a particular project. Styles add a portable, independently maintained library of behavioral preferences that project rules can reference. Users maintain styles globally and select them for each project through its rules. A new style motivated by project work is created directly in the global catalog.

The original workflow-oriented interpretation remains historical context. The current idea focuses on recommendations about agent behavior. Changing workflow stages or mandatory actions is outside this style model.

## 3. Problem / Motivation

Machines need a useful default way of working, but people and projects differ in their preferred communication, research effort, and analysis. Rewriting role definitions for each preference would duplicate machine operating material and make updates difficult.

Keeping all preferences inside project rules would also make reuse inconvenient. A person should be able to define a style once in the global catalog and connect it to one or several projects through their rules.

The mechanism should make the effective behavior understandable: what comes from the role, what comes from a connected style, and which style the project has selected.

## 4. Raw Description

### Roles, modes, and the default Double style

A role defines responsibility for a result: its purpose, inputs, expected outputs, duties, and constraints. A mode defines how the current work is performed within that responsibility: its purpose, permitted actions, and mandatory conditions. A style supplies behavioral recommendations for performing that work.

Roles and modes retain the conditions necessary to preserve their meaning. Behavioral preferences are moved into the separate default style `styles/double.md`, rather than being scattered across role and mode contracts. The default style may contain general recommendations and contextual guidance for particular roles or modes, all in that one resource.

For example, concept extraction remains responsible for concepts grounded in the source idea. Strict research preserves the distinction between supported conclusions and assumptions. The style can recommend informal communication, concise explanations, or deeper comparison of alternatives without removing those obligations.

This supersedes the earlier decision to keep basic style recommendations inside roles. Refactoring must classify existing instructions by meaning: obligations stay in roles and modes, while preferences move to the default style. A change in the location of a preference must not accidentally weaken a required condition.

Behavioral preferences include:

- communication tone and degree of formality;
- explanation length and detail;
- depth of search and examination of assumptions;
- breadth and depth of alternative analysis;
- manner of criticism and discussion.

These dimensions can vary independently. Informal communication does not imply shallow analysis, and gentle criticism does not imply weak scrutiny.

### Styles as portable resources

A style is guidance for an AI agent rather than a rigid machine-specific configuration. It does not require an explicit list of compatible machines or roles. Its recommendations may be general or describe behavior for a particular role; the role context makes the relevant machine understandable without a mandatory machine binding. Project rules choose where to apply the guidance.

A selected custom or official style completely replaces the default Double style. It does not inherit unspecified preferences from `double.md` or a previously selected style. Matters it does not address are governed by role responsibilities, mode conditions, applicable project rules, and the current request. The style is a resource that can be connected to all machines, one machine, or a particular role without copying or replacing the role itself.

Machines consume applicable styles. Double Agent owns assistance with defining, capturing, changing, and connecting them; this does not require a separate Style Agent.

### Global library and the Double repository

The main Double repository can maintain a shared library of styles. `double-installer` should be able to install styles from that library into the user's global styles catalog.

The same global catalog can hold the user's own styles. Installed Double styles are changed only by the Double project and delivered as new style versions. Users do not edit those installed styles directly. Any user override is created as an independent style with a new name in the user's style library and selected through project rules. It has no inheritance or source-style link. Installer updates must preserve these user-created styles. There is one global styles catalog for the user, shared across projects and AI clients. It belongs under the existing Double service-artifact root: `~/.local/state/double` by default, or the root selected by `DOUBLE_STATE_DIR`. The installer already keeps its machine registry at `installer/registry.json` under that root. Styles use this same root rather than a separate client-specific location. The catalog is `styles/` under that root. Official style files are stored directly in `styles/`; user-created style files are stored in its `custom/` subdirectory. There are no separate `double/` and `user/` directories. Installer updates must preserve `styles/custom/`. Each style is initially a Markdown file with a name and free-form recommendations for the AI agent. No mandatory parameter schema, structured metadata, or fixed section layout is required. The format can be refined through practical use. The library is released as a whole under stable-only `styles-X.Y.Z` tags, independently of machine releases. Its `manifest.json` records a version and official file hashes without imposing metadata on individual style files. After changes to `styles/` reach `main`, the existing release workflow publishes the versioned archive silently. Double Installer obtains that release on machine installation/update and never downloads styles directly from the repository.

```text
~/.local/state/double/
  installer/
    registry.json
  styles/
    double.md
    <other-official-style>.md
    custom/
      <user-style>.md
```

The location where a style is stored is separate from its application scope. A globally stored style can be used by one project only. A personal style does not need to be published or contributed to Double.

### Connection through project rules

Project rules determine style selection and application scope, including machine-wide selections and role-specific overrides. The global catalog stores style resources; storing a style there does not itself activate it. Project rules connect machines to selected styles in the global catalog. A connection identifies the intended style and its application scope: all machines, a selected machine, or a selected role. A rule should identify a particular resource rather than merely directing the machine to browse a catalog and choose arbitrarily.

A user can also establish global defaults and override them in a project. Project settings take precedence over global settings, even when a global setting targets a particular role and the project setting applies to all machines. Greater specificity at global scope does not defeat a project override. Selection precedence determines one effective style for the active role and mode; without an explicit selection, `double.md` is used. Selecting a project or role-specific style fully replaces the previously selected external style; styles are not merged or layered. The selected style applies within the mandatory role and mode contracts, without loading default-style recommendations alongside it. Project overrides can select a style for a whole machine or select a different style only for a particular role. A role-specific project selection takes precedence for that role; other roles keep using the applicable machine-wide style, which remains global unless the project has also overridden it. These are scoped style selections: a user need not describe every role inside one machine-wide style resource.

When a user wants different behavior for a project, the new style is created directly as an artifact in the global catalog. Project rules then select that style for the intended machine or role. There is no project-local style artifact, source-style link, inheritance chain, or local-to-global promotion step. Defining a style and connecting it through rules is sufficient.

### Assistance from Double Agent

Double Agent should help a user:

- inspect the role and mode obligations, the default style resource, and the currently selected style;
- express desired behavioral changes and distinguish them from changes to responsibilities;
- create a style artifact directly in the global catalog or select an existing style;
- give user overrides new names and preserve installed Double styles unchanged;
- connect it at the requested global, project, machine, or role scope;
- help define a new style for the desired project behavior and select it through project rules;
- prepare a contribution to the main Double library only when requested.

Creating, selecting, editing, and sharing a style are independently available actions. There is no mandatory contribution pipeline or requirement to prepare a pull request.

### Using updated styles

Project rules select a style without pinning an older version. Once a new version is installed in the global catalog, the project uses that version without a separate switch or approval. This concerns the current installed resource, not an automatic download from the remote library.

Machine instructions must require the AI agent to reread the selected style before starting each new task rather than relying on an earlier reading in the conversation. When a style is updated during ongoing work and the agent becomes aware of it, the agent rereads it before continuing. During long-running work, the contracts require a file recheck at stage handoffs and before resuming after a pause; changed contents are reread before work continues. Agents do not continuously watch the filesystem. The desired behavior is to apply the updated recommendations as soon as the update is observed, without reconnecting the style through project rules.

### Unavailable style

If a connected style is missing, empty (including whitespace-only content), or unreadable, it is treated as unavailable. The machine warns the user and automatically uses the separate default style `styles/double.md`. With no explicit style selection, it uses `double.md` normally without a failure warning. No approval is required and work does not stop to ask permission for this fallback.

The warning must make the fallback visible rather than suggesting that the requested style was applied. If `double.md` itself cannot be loaded, the agent warns and continues under mandatory contracts and the current request without claiming to have applied a style. This recovery does not remove independently applicable project rules or mandatory role and mode conditions.

## 5. Key Elements

- role responsibilities and applicable contracts;
- role responsibility, mode conditions, and style recommendations as distinct contracts;
- the default Double style centralized in `styles/double.md`;
- portable style resource containing behavioral overrides;
- global styles catalog;
- shared styles maintained in the main Double repository;
- personal styles and preservation during installer updates;
- style connection through project rules;
- global defaults and machine- or role-specific application;
- direct creation of all style artifacts in the global catalog;
- Double Agent assistance with the style lifecycle;
- warning and automatic fallback to the separate default Double style;
- optional contribution through a pull request.

## 6. Assumptions

- Mandatory role and mode conditions can be distinguished from behavioral preferences.
- Roles and modes retain meaningful obligations independently of a selected style.
- A style can describe selected overrides without repeating an entire role.
- A shared global catalog can accommodate both installed and personal styles while preserving ownership.
- Project rules can reference external style resources without embedding their full contents.
- Some preferences apply across machines; others require a particular machine or role.
- Users benefit from seeing which sources determine effective behavior.
- The idea defines intended behavior; working contracts and offline installer/release tests establish the local implementation. Publication and use by installed clients require the corresponding releases.

## 7. Examples / Scenarios

### Personal style across projects

A user maintains a style that favors plain, informal language and thorough examination of important assumptions. The style is stored in the global catalog and selected as a personal default. Projects can connect the same resource without copying its definition.

### A project connects a shared style

A user installs a style from the Double library through `double-installer`. A project rule connects it to Machine of Ideas. Other machines retain their applicable defaults unless the user connects the style more broadly.

### A project selects a style for one role

A machine uses global style A. A project selects style B for its critic role only. The critic uses B while other roles continue using A. Alternatively, the project can select style C for the whole machine, with a role-specific selection still taking precedence for its target role. Selecting a style for one role does not change the machine-wide selection.

### A project needs different critic behavior

A critic retains its basic responsibility to find weaknesses. The user wants it to state objections directly and compare more alternatives. Double Agent helps define a new style artifact directly in the global catalog. A project rule selects it for the critic role. Other roles retain their applicable style. No local style copy or link to a source style is needed; another project can later select the same catalog artifact.

### An optional contribution

A user chooses to share a personal style. Double Agent can help prepare the style for a pull request to the main Double library. This action is optional and can be requested independently of a prescribed sequence of prior steps.

### A connected style is unavailable

A project references a style that cannot be loaded. The machine warns that it is using `styles/double.md` and continues immediately, preserving the project's other applicable rules.

## 8. Signals of Value

- Users can adjust behavior without maintaining copies of machine roles.
- Roles retain a coherent basic Double experience after installation.
- One personal library can support multiple projects and machines.
- A style created for one project is immediately available in the global catalog for use elsewhere.
- Users can understand the source of effective behavior and notice fallback.
- Optional contributions can enrich the shared library without making publication a condition of personal use.

## 9. Open Questions

No open questions currently block this model. The working contracts use catalog-relative Markdown paths and check styles at task entry, role changes, stage handoffs, and resumption after a pause. The installer now synchronizes a separately versioned stable library release; publication is not yet performed.

## 10. Boundaries / Non-Goals

- This artifact captures an idea and agreed behavior; it does not implement style loading, installer changes, or new Double Agent operating contracts.
- Default behavioral recommendations are centralized in `styles/double.md`; role and mode definitions retain mandatory conditions.
- User style artifacts are created in the global catalog. Project-local style storage, source-style links, inheritance, and promotion between local and global storage are outside this model.
- Styles do not remove role responsibilities, mode conditions, required validation, or applicable contracts.
- The initial style format is free-form Markdown. Working contracts identify styles by catalog-relative Markdown paths and reread them at defined work boundaries. A rigid schema is not required at this stage.
- Mandatory declarations of machine or role compatibility are not required; styles remain recommendations interpreted in the active role context.
- Styles are not mixed: one style is active, either `double.md` or a selected replacement. Replacement styles do not inherit default-style recommendations.
- A pull request, publication, or contribution to Double is never a mandatory lifecycle stage.
- Single-pass and multi-pass plan behavior is not defined or changed by this idea.
- Output formats are not automatically styles merely because they change artifact representation.

## 11. Related Ideas

- [Double](../../Double.md)
- [Double Agent](../double-agent/double-agent.md)
- [Machine of Ideas](../machine-of-ideas/machine-of-ideas.md)
- [Machine of Goals](../machine-of-goals/machine-of-goals.md)

## 12. Notes

The current relationship is:

```text
role responsibilities + mandatory mode conditions
  + one style: double.md OR a selected replacement
  -> effective machine behavior
```

Storage and application are separate concerns:

```text
Double library / personal styles
  -> user's global styles catalog
  <- references from project rules
  -> selected machine or role
```

Working contracts now describe style selection, loading, and Double Agent assistance. The default source is `styles/double.md` in the repository. The local installer implementation synchronizes stable `styles-X.Y.Z` releases. The existing release workflow now contains a separate silent library job for changes on `main`; no release has been published by this local work.


## 13. Development Artifacts

### 13.1 Concepts

Concept artifact: [Double Styles: Concepts](./double-styles-concepts.md)

| Concept | Summary |
| --- | --- |
| [Style](./double-styles-concepts.md#concept-style) | Reusable behavioral recommendations separate from role and mode obligations. |
| [Style Selection](./double-styles-concepts.md#concept-style-selection) | Rule-based association of one style with a project, machine, or role context. |

### 13.2 Principles

Principle artifact: [Double Styles: Principles](./double-styles-principles.md)

| Principle | Statement | Related Concepts |
| --- | --- | --- |
| [Vary Behavior, Preserve Responsibility](./double-styles-principles.md#principle-preserve-role-responsibility) | Change behavioral preferences while preserving role and mode obligations. | [Style](./double-styles-concepts.md#concept-style) |
| [Select One Style Through Rules](./double-styles-principles.md#principle-select-one-style) | Select one style for the context without mixing styles. | [Style Selection](./double-styles-concepts.md#concept-style-selection) |
| [Keep User Styles Independent](./double-styles-principles.md#principle-independent-style-ownership) | Give user overrides independent names and preserve them across official updates. | [Style](./double-styles-concepts.md#concept-style), [Style Selection](./double-styles-concepts.md#concept-style-selection) |
| [Apply Current Content or Reveal Fallback](./double-styles-principles.md#principle-current-style-or-visible-baseline) | Apply current installed content or warn and automatically use basic behavior. | [Style Selection](./double-styles-concepts.md#concept-style-selection) |
