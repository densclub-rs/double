# Project rules through Double

## Ownership and discovery

Rules belong to the active user project, not the installed Double distribution.
Every machine, including Double Agent, reads `.double-rules/double-rules.md`
before choosing catalogs or starting work. A new project needs no rules folder.
The workflows carry the canonical loading protocol; external integrations only
need to activate the selected machine. No AGENTS.md or CLAUDE.md is required.

## Markdown organization

The root index contains ordinary Markdown links grouped under `Common Rules`
and the applicable machine-id headings: `double-agent`, `machine-of-knowledge`,
`machine-of-ideas`, and `machine-of-goals`. Common links are always loaded;
individual machine links add context for that machine. One artifact can have
links under several machine headings without duplicating its value.

A rule uses the existing Machine of Knowledge artifact and template at
`.double-rules/<knowledge-id>/<knowledge-id>.md`. There is no new rule type,
configuration language, metadata schema, or required rule-specific section.
Existing artifact metadata remains unchanged by this feature. The value can
specify a base knowledge, idea, or goal catalog, or other project constraints.
Catalog paths are relative to the active project root unless explicitly absolute.

## Recognition and acceptance

Machine of Knowledge infers project-rule intent and common or named-machine
scope from the preservation request. It confirms successful identification
before registration. An explicit already-confirmed decision is not asked again.
Failed inference defaults to ordinary knowledge. An explicit project-rule request
with missing scope requires clarification instead of silent ordinary publication.

Conversion moves the existing artifact, preserving identity, updating inbound
and outgoing links and catalog navigation, and leaving one authoritative copy.
Existing access, observation, validity and source requirements still apply.
Draft or expired knowledge cannot silently become an active trusted rule.

## Release boundary

Each machine ships its own loading instructions in its owned workflow and skill.
No runtime dependency on another installed machine is added for rules discovery.
Machine of Knowledge owns rule publication. Project rules remain outside the
installer-managed tree and are not copied, replaced or removed by machine
installation or update. Git commits and release tags snapshot the repository's
rules, while machine archives omit them. Changing only a project's rule does
not require releasing a machine; changing the reading contract does.

This branch implements the mechanism. It does not publish releases, create tags,
or establish a new active GitHub branching policy artifact. That policy can be
preserved through Machine of Knowledge with its required source and temporal
metadata. Existing project knowledge is not automatically promoted to rules.

## Acceptance scenarios

- New project: no rules directory; workflow defaults apply.
- Common rule: every machine loads it regardless of task.
- Specific rule: only its listed machines load it, in addition to common rules.
- Configured catalog: new artifacts use the configured project base catalog.
- Global installation: rules are read from the user project, not installation root.
- Clear inferred rule: classification and scope are confirmed before registration.
- Unclear preservation request: ordinary knowledge is saved.
- Explicit rule without scope: scope is clarified before publication.
- Conversion: identity and working links survive; no second active copy remains.
- Broken, expired or conflicting rule: dependent work waits for resolution.
- Machine package: loading protocol is included; source-project policies are excluded.

The packaging boundary is exercised by the release pytest suite. Interpretation
and confirmation are agent workflow contracts, not deterministic runtime code;
these scenarios also define manual acceptance criteria for agent sessions.
