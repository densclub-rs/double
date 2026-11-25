---
id: double-styles-concepts
kind: concept-artifact
status: stable
mindmap-plugin: basic
double-repository: https://github.com/densclub-rs/double
project-repository: https://github.com/densclub-rs/double
produced-by: machine-of-ideas/concept-extraction-agent
interaction-language: Russian
artifact-language: English
publication-path: ideas/double-styles/double-styles-concepts.md
derived-from:
  - double-styles
---

# Double Styles: Concepts

Idea: [Double Styles](./double-styles.md#double-styles)

## 1. Conceptual Summary

A reusable style describes how an AI agent behaves; project rules select which style applies in the current context. Role responsibilities and mandatory mode conditions remain stable while the selected recommendations can change. Default recommendations are centralized in `styles/double.md`.

## 2. Working Definition of Concept

A concept is a stable meaning unit: an entity, relationship, or distinction, rather than a requirement or implementation decision.

## 3. Core Concepts

<a id="concept-style"></a>

### concept-style: Style

#### Definition

A named, reusable set of recommendations about how an AI agent acts, including communication, search, and analysis. The default Double style is a separate resource, `styles/double.md`; a replacement style changes recommendations without replacing role responsibilities or mandatory mode conditions.

#### Source in Idea

Explicit: sections 1 and 4, “Roles, modes, and the default Double style,” “Styles as portable resources,” and “Global library and the Double repository.”

#### Role in the Idea

Makes behavioral preferences reusable independently of a project or a machine's role definitions.

#### Related Concepts

- [Role](../machine-of-ideas/machine-of-ideas-concepts.md#concept-role): supplies responsibilities, not behavioral defaults.
- [Mode](../machine-of-ideas/machine-of-ideas-concepts.md#concept-mode): supplies the current execution purpose and mandatory conditions.
- [Style Selection](#concept-style-selection): determines where the recommendations apply.
- [Active Assistance](../double-agent/double-agent-concepts.md#concept-active-assistance): Double Agent helps define and connect styles.

#### Boundaries

A style is guidance, not a replacement workflow or a mandatory machine-compatibility declaration. Selected styles do not inherit from or merge with one another, including the default Double style. Official and custom styles are independently maintained resources; sharing a personal style is optional. Markdown and catalog layout express this concept without defining its meaning.

#### Questions

None at the conceptual level. Working contracts identify resources by catalog-relative Markdown paths.

<a id="concept-style-selection"></a>

### concept-style-selection: Style Selection

#### Definition

The association, expressed through project rules, between an application scope and one external style. Selection is distinct from storage: a globally stored style may apply only to one project, machine, or role.

#### Source in Idea

Explicit: section 4, “Connection through project rules,” “Using updated styles,” and “Unavailable style”; section 7, machine-wide and role-specific examples.

#### Role in the Idea

Explains how shared resources produce context-specific behavior without copies of roles, project-local styles, or style mixing.

#### Related Concepts

- [Style](#concept-style): the selected recommendations.
- [Project and Group Knowledge](../double-agent/double-agent-concepts.md#concept-scoped-project-knowledge): existing rules carry the selection.
- [Role](../machine-of-ideas/machine-of-ideas-concepts.md#concept-role): provides the responsibility context.
- [Mode](../machine-of-ideas/machine-of-ideas-concepts.md#concept-mode): supplies the execution context without changing style selection by itself.

#### Boundaries

Project selections supersede global selections; within the project, a role-specific selection supersedes a machine-wide selection for that role only. The selected style replaces the previous one completely, including `double.md`. Unspecified preferences are not inherited from another style; the role, mode, project constraints, and current request still govern the work. Selection follows the installed resource's current contents. A missing, empty, or unreadable resource leads to a warning and automatic fallback to `styles/double.md`, without approval. These are properties of selection, not separate concepts.

#### Questions

None at the conceptual level. Working contracts check the file at task entry, role changes, stage handoffs, and resumption after a pause.

## 4. Terms and Non-Concepts

Existing concepts are reused rather than defined again:

| Existing concept | Use here |
| --- | --- |
| [Role](../machine-of-ideas/machine-of-ideas-concepts.md#concept-role) | Responsibility model independent of behavioral defaults. |
| [Mode](../machine-of-ideas/machine-of-ideas-concepts.md#concept-mode) | Execution lens whose essential purpose and conditions remain binding. |
| [Project and Group Knowledge](../double-agent/double-agent-concepts.md#concept-scoped-project-knowledge) | Rules that select styles and their scope. |
| [Active Assistance](../double-agent/double-agent-concepts.md#concept-active-assistance) | Double Agent's help with defining and connecting styles. |

The global catalog, `custom/`, Markdown files, `double-installer`, rereading, warnings, and optional pull requests are storage forms, tools, mechanisms, or actions. They do not need separate concepts for this idea.

## 5. Candidate Inputs for Principle Synthesis

- The distinction between role responsibility, mandatory mode conditions, and adjustable behavior.
- The separation of resource ownership and storage from application scope.
- Exclusive selection, current-content use, and visible fallback to basic behavior.
