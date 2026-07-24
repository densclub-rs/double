---
id: directory-layout
kind: idea-artifact
produced-by: machine-of-ideas/idea-capture-agent
derived-from:
  - ideas/machine-of-ideas/machine-of-ideas.md
---

# Idea: Directory Layout

![Directory Layout of Machine of Ideas](../../../_media/machine-of-ideas/directory-layout-illustration.png)

## 1. Summary

`Directory Layout` develops a possible organization of the working catalog for the `Machine of Ideas`. It does not describe a final implementation, but clarifies how the machine's future working space could be arranged so that ideas, concepts, principles, roles, modes, prompts, templates, drafts, and other operational artifacts do not collapse into one undifferentiated collection of notes.

The central distinction of this idea is between the conceptual documentation of the machine in `ideas/machine-of-ideas/` and a possible working catalog, such as `.double/`, where the machine's operational forms could later be expressed. At this stage, the layout is treated as a conceptual and principled model of organization: it describes what kinds of places the machine may need, what responsibilities those places carry, and how future implementation decisions should remain traceable to the broader idea of the machine.

In this sense, `.double` is conceived not only as a possible working catalog for the `Machine of Ideas`, but as a shared working catalog for the Double project as a whole. If new ideas in Double eventually require operational artifacts of their own, their working forms could also be placed in `.double`, while their conceptual descriptions would remain in the public idea space.

## 2. Context / Origin

- This idea belongs to [machine-of-ideas](../machine-of-ideas.md).
- It grows from the need to distinguish the conceptual description of an idea from the working artifacts that may later be derived from it.
- The possible `.double` catalog is conceived as a universal working space for different projects built on the basis of Double, not only for the `Machine of Ideas`.
- This working space should be general enough to receive final operational artifacts from different Double projects: templates, role variants, agent variants, prompts, registries, modes, workflow descriptions, drafts, and other files needed for actual use.
- The structure should preserve the Double rule that project ideas remain readable Markdown artifacts, while finalized working files are published in a shared operational catalog.

## 3. Problem / Motivation

- The machine of ideas, and potentially other Double-based projects, use several different kinds of artifacts: workflows, agents, roles, modes, prompts, templates, registries, and output contracts.
- These artifact types need stable homes so they do not collapse into one mixed draft.
- The repository needs a clear distinction between conceptual project documentation and the working schemes that may later make those ideas usable.
- Without a shared working catalog, each new idea risks inventing its own ad hoc operational structure, making roles, agents, templates, prompts, and registries difficult to compare, reuse, or evolve.
- A directory layout for `.double` should give each working artifact type a specific place, keep public idea documentation clean, and make final operational files discoverable across the broader Double project.

## 4. Raw Description

The `Machine of Ideas` needs a distinction between the place where the idea is described and the place where its possible working forms can be organized.

The catalog `ideas/machine-of-ideas/` is the project documentation of the machine. It contains the root idea, sub-ideas, conceptual decisions, and human-readable explanations of how the machine was formed and why it is structured this way.

The catalog `.double/` is conceived as a possible working catalog for the Double project. It is the place where finalized operational artifacts may be published when an idea becomes mature enough to need reusable working forms.

This distinction matters because conceptual documentation and working artifacts have different responsibilities. The idea space should remain readable, explanatory, and historically traceable. The working catalog should provide stable places for artifacts that are meant to be used, reused, combined, or extended by people and AI systems.

For the `Machine of Ideas`, such a layout becomes an organizing beginning: it prevents roles, prompts, modes, templates, and other working forms from being scattered through the conceptual notes. It also makes it possible to discuss future implementation without confusing implementation details with the conceptual development of the machine itself.

The same principle can be reused by other projects based on Double. If a later idea develops its own workflows, roles, agents, templates, or other operational forms, those files can be placed in the shared `.double` catalog according to the same organizing logic. This gives Double a common working layer while allowing each idea to preserve its own conceptual documentation.

The value of the directory layout is therefore not only technical. It expresses a principle of knowledge organization: ideas should remain understandable as ideas, while the working forms derived from them should have a clear, shared, and discoverable home.

## 5. Key Elements

- `ideas/machine-of-ideas/` as the project documentation of the machine of ideas
- `.double/` as a possible shared working catalog for Double projects
- `.double/<artifact-type>/` as a shared top-level container for each operational artifact type
- `.double/<artifact-type>/machine-of-ideas/` as the namespace for artifacts that belong to the `Machine of Ideas`
- `.double/workflows/machine-of-ideas/` as the namespace for workflow protocols of the machine
- `.double/registries/machine-of-ideas/` as the namespace for indexes, routing, and stable lookup
- `.double/agents/machine-of-ideas/` as the namespace for agent definitions or agent variants
- `.double/roles/machine-of-ideas/` as the namespace for stable responsibilities and role variants
- `.double/modes/machine-of-ideas/` as the namespace for user-selectable execution modes
- `.double/prompts/machine-of-ideas/` as the namespace for system and interaction prompt fragments
- `.double/templates/machine-of-ideas/` as the namespace for reusable output artifact contracts
- `.double/skills/machine-of-ideas/` as the namespace for the AI-agent skill entry point into the machine workflow
- `.double/drafts/` as a possible place for temporary and unprocessed working material
- workflow-centered organization of operational artifacts
- explicit links between project documentation and working artifacts

## 6. Assumptions

- Markdown is the canonical representation for both project documentation and working artifacts.
- Project documentation and working artifacts are different kinds of knowledge and belong in different directories.
- The `.double` directory can become the shared working catalog for operational artifacts derived from Double ideas.
- The `.double` directory can become a primary integration surface for connecting Double to larger AI ecosystems.
- A skill entry point can help external AI agents recognize when to activate a Double workflow, while leaving the workflow itself as the canonical process definition.
- Workflow descriptions, agents, roles, modes, prompts, templates, and registries may need separate but connected places.
- Agents may become primary working units inside particular workflows, but the layout should not depend on only one possible execution model.
- Modes are separate from roles and agents.
- Registries are used for navigation, routing, and stable lookup.
- Public development artifacts can remain close to their source ideas, while finalized working artifacts can be published in `.double`.

## 7. Examples / Scenarios

- A raw idea is described in `ideas/` as a readable project artifact. Its later concept and principle files can be published beside it, for example as `<idea-id>-concepts.md` and `<idea-id>-principles.md`, so the development path remains visible.
- A reusable template for concept extraction is no longer stored inside one idea folder after it becomes general. It can be published in `.double/templates/machine-of-ideas/`, where it remains clearly attached to the machine while still being discoverable from the shared working catalog.
- A role or agent pattern first appears while developing the `Machine of Ideas`. Its finalized working form can be published under `.double/roles/machine-of-ideas/` or `.double/agents/machine-of-ideas/` instead of remaining hidden in conceptual notes.
- A workflow description can refer to idea-level artifacts, concept artifacts, and principle artifacts without storing all of them in the same place. The idea remains part of the public knowledge tree, while the reusable working rules live in the shared working catalog.
- A later Double-based project can follow the same distinction: its conceptual files remain in `ideas/`, while its finalized prompts, templates, roles, agents, modes, registries, or workflow schemes are placed in its own namespace under the relevant `.double/<artifact-type>/` directories.

## 8. Signals of Value

- Each operational artifact type has a clear and discoverable location.
- The machine of ideas can grow without mixing prompts, roles, templates, registries, and research notes into the conceptual documentation.
- Other Double-based projects can reuse the same organizing principle instead of inventing unrelated working structures.
- Codex or another agentic environment could load working artifacts by following registries, workflow files, templates, and other stable entry points.
- A skill file can make the machine discoverable to AI agents without moving the canonical workflow rules out of `.double/workflows/machine-of-ideas/`.
- The same Markdown-based structure can remain understandable to both humans and agents.
- The distinction between public idea artifacts and finalized working artifacts remains visible over time.

## 9. Boundaries / Non-Goals

- This idea does not define an agent runtime outside Markdown.
- This idea does not replace the broader rules for ideas in [ideas.md](../../ideas.md).
- This idea does not make `.double` a project documentation layer; `.double` is treated as a possible shared working catalog.
- This idea does not define integration packaging for Codex or other external systems; it only describes the kind of directory structure that such integrations could use as a base.
- This idea does not decide the final internal structure of every future Double project.
- This idea does not require every idea to produce operational artifacts; some ideas may remain only conceptual.

## 10. Related Ideas

- The root idea [machine-of-ideas](../machine-of-ideas.md)
- The idea rules in [ideas.md](../../ideas.md)

## 11. Maturity Level

- [ ] Raw thought
- [x] Developed idea
- [ ] Near-concept

## 12. Notes

Possible working-catalog shape:

```text
.double/
  agents/
    machine-of-ideas/
  drafts/
  modes/
    machine-of-ideas/
  prompts/
    machine-of-ideas/
      interaction/
      system/
  registries/
    machine-of-ideas/
  roles/
    machine-of-ideas/
  skills/
    machine-of-ideas/
      SKILL.md
  templates/
    machine-of-ideas/
  workflows/
    machine-of-ideas/
```

This structure is not a final implementation contract. It is a candidate organizing pattern for separating public idea documentation from reusable working artifacts.

## 13. Development Artifacts

- Candidate working catalog reference: [.double](../../../.double)
