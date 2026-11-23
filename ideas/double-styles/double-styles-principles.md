---
id: double-styles-principles
kind: principle-artifact
status: release-candidate
mindmap-plugin: basic
double-repository: https://github.com/densclub-rs/double
project-repository: https://github.com/densclub-rs/double
produced-by: machine-of-ideas/principle-synthesis-agent
interaction-language: Russian
artifact-language: English
publication-path: ideas/double-styles/double-styles-principles.md
derived-from:
  - double-styles
  - double-styles-concepts
---

# Double Styles: Principles

Idea: [Double Styles](./double-styles.md#double-styles)

## 1. Principle Synthesis Summary

Behavior can vary while role responsibility and mandatory mode conditions remain stable. Default recommendations are centralized in one style resource. Rules select one independently maintained style for the current context; execution follows its current installed content or visibly returns to basic Double behavior.

## 2. Working Definition of Principle

A principle is a stable normative ground that guides decisions without prescribing an implementation.

## 3. Core Principles

<a id="principle-preserve-role-responsibility"></a>

### principle-preserve-role-responsibility: Vary Behavior, Preserve Responsibility

#### Statement

Let styles change how a role works while preserving its responsibilities, mandatory actions, mode conditions, and applicable constraints.

#### Derived From

Explicit: [Style](./double-styles-concepts.md#concept-style) and its boundary with [Role](../machine-of-ideas/machine-of-ideas-concepts.md#concept-role); idea section 4, “Roles, modes, and the default Double style” and “Styles as portable resources.”

#### Rationale

Reusable behavioral recommendations allow personal preferences without creating competing definitions of the same role.

#### Implications Without Implementation

Keep default behavioral recommendations in the separate `styles/double.md` resource, and mandatory conditions in role and mode contracts. Interpret external recommendations in the active context without requiring a machine-compatibility declaration or rigid preference schema.

#### Boundaries

Freedom of tone, search depth, or analysis does not authorize removal of required checks or replacement of workflow stages.

#### Anti-Patterns

Copying a role merely to change communication preferences; using a style to bypass an obligation.

#### Questions

None at the principle level.

<a id="principle-select-one-style"></a>

### principle-select-one-style: Select One Style Through Rules

#### Statement

Use project rules to select one external style for the active context. A new selection replaces the previous style completely, without mixing their recommendations.

#### Derived From

Explicit: [Style Selection](./double-styles-concepts.md#concept-style-selection), its relation to [Project and Group Knowledge](../double-agent/double-agent-concepts.md#concept-scoped-project-knowledge), and idea section 4, “Connection through project rules.”

#### Rationale

Separating selection from content makes the applied behavior explainable without reconstructing a chain of style inheritance.

#### Implications Without Implementation

Project selection takes precedence over global selection. Within the project, a role-specific selection overrides the machine-wide selection only for that role. Use `double.md` when no replacement is selected. A replacement does not inherit unspecified preferences from it; role and mode obligations, project constraints, and the current request continue to govern the work. Storing a replacement style does not activate it.

#### Boundaries

Independent project constraints still apply. Global storage does not imply application to every project or machine.

#### Anti-Patterns

Merging global and project styles or supplementing a replacement with default-style recommendations; changing every role when only one role was targeted; applying a style merely because it exists in the catalog.

#### Questions

None at the principle level.

<a id="principle-independent-style-ownership"></a>

### principle-independent-style-ownership: Keep User Styles Independent

#### Statement

Create user overrides as separately named styles in the global library, preserving official styles for updates by Double and keeping contribution optional.

#### Derived From

Explicit: [Style](./double-styles-concepts.md#concept-style), [Style Selection](./double-styles-concepts.md#concept-style-selection), and idea section 4, “Global library and the Double repository” and “Assistance from Double Agent.”

#### Rationale

Independent resources preserve user choices across official updates and make reuse possible without project-local copies or source-style dependencies.

#### Implications Without Implementation

A preference discovered in one project becomes a global catalog artifact immediately; project rules select it. Installation and updates preserve personal work. Double Agent assists with definition and connection without making publication a lifecycle gate.

#### Boundaries

Global availability does not require public sharing. The agreed catalog layout and free-form Markdown express this separation but are not additional principles.

#### Anti-Patterns

Editing an installed official style for a personal override; overwriting custom styles during updates; introducing local-to-global promotion or a required pull request.

#### Questions

None at the principle level.

<a id="principle-current-style-or-visible-baseline"></a>

### principle-current-style-or-visible-baseline: Apply Current Content or Reveal Fallback

#### Statement

Apply the selected style's current installed content. If it is missing, empty, or unreadable, warn and continue with the separate default style `styles/double.md` without requesting approval.

#### Derived From

Explicit: [Style Selection](./double-styles-concepts.md#concept-style-selection) and idea section 4, “Using updated styles” and “Unavailable style.”

#### Rationale

A selection should describe actual behavior: stale remembered recommendations and silent fallback both misrepresent what the user selected.

#### Implications Without Implementation

Refresh the selected recommendations at task entry and after an observed update before continuing. Installed updates take effect without reconnecting the style or pinning an earlier version. Recovery preserves unrelated project rules and role obligations.

#### Boundaries

Current means installed, not automatically downloaded. This principle does not assume continuous update detection or promise it without a checking mechanism. Fallback uses `double.md`, not an earlier replacement style.

#### Anti-Patterns

Relying indefinitely on an old reading; asking permission for the agreed fallback; claiming the unavailable style is active; silently reverting to a previously selected external style.

#### Questions

None at the principle level. Working contracts require rechecks at task entry and defined work boundaries, without continuous observation.

## 4. Trade-offs and Tensions

- User flexibility ends where role obligations, mandatory mode conditions, and project constraints begin.
- Following installed updates favors current behavior over reproducibility of past behavior; version pinning was not selected.
- Automatic fallback preserves continuity but changes behavior, making the warning essential.

## 5. Candidate Inputs for Future Stages

These principles can guide operating-contract proposals for Double Agent, consuming machines, and installer style support. Working contracts now use catalog-relative paths and rechecks at defined work boundaries. Installer delivery is implemented locally through independent stable library releases; these principles do not themselves establish publication.

## 6. Rejected or Deferred Candidate Principles

- Style composition, inheritance, and project-local style promotion: rejected by the agreed model.
- Workflow replacement and mandatory compatibility declarations: outside the style model.
- Fixed schemas, catalog paths, and naming algorithms: representation or design choices, not additional principles.
- Mandatory contribution to Double: explicitly rejected.
