---
id: double-project
kind: idea-artifact
status: draft
produced-by: idea-capture-agent
workflow-version: 0.2.0
interaction-language: Russian
artifact-language: English
derived-from:
  - user request on 2026-05-24
---

# Idea: Double Project

## 1. Summary

Double Project is an idea about turning Double into a coherent software ecosystem for working with private knowledge, ideas, and personal intellectual artifacts. The project should clarify what kind of CLI program Double should become, what architectural principles should guide it, how private knowledge exchange can work, and how the ecosystem may support monetization through subscriptions or the sale of ideas.

## 2. Context / Origin

The idea emerged from a request to start a new Machine of Ideas artifact named `double-project`. The user wants to think through the software architecture of the Double project and understand how it can become more than a local knowledge base: a CLI-centered ecosystem for private knowledge, idea exchange, installation across target operating systems, and possible commercial models.

This capture is intentionally at the idea level. It records the areas that need to be understood before moving into concept extraction, architectural design, or implementation planning.

## 3. Problem / Motivation

Double currently needs a clearer project-level shape. The user wants to understand:

- what Double is as a software product
- why a CLI is the right or central interface
- which architectural principles should guide development
- how Double can support private knowledge rather than only public publishing
- how knowledge, skills, workflows, and ideas can be exchanged safely
- how the project could become economically sustainable
- how installation and operating system support should be approached

The motivation is to avoid treating Double as a loose collection of files, prompts, skills, and ideas. Instead, the project should be understood as a coherent system with a technical architecture, distribution strategy, ecosystem model, and economic path.

## 4. Raw Description

Double Project should explore the architecture and direction of the Double ecosystem.

One important part is the CLI. Double may need to become a command-line program that can initialize a workspace, manage ideas, run workflows, install or update skills, inspect project state, and help users move between local knowledge work and agent-assisted development. The CLI may become the stable operational surface of the ecosystem.

Another important part is the architecture. The project needs to clarify what belongs in the local workspace, what belongs in `.double/`, what belongs in user artifacts such as `ideas/`, and what belongs in external services. The system should likely preserve the user's ownership of private knowledge while still enabling exchange, synchronization, collaboration, and monetization.

The ecosystem question is central. Double should not only be a local tool; it may become a network of private knowledge artifacts, reusable skills, workflows, agent roles, idea artifacts, and possibly marketplaces. The ecosystem should make it possible to exchange private or semi-private knowledge in a controlled way.

Monetization should be explored early enough to influence the shape of the ecosystem, but not so early that it distorts the project into a purely commercial platform. Possible paths include subscriptions, paid access to advanced tooling, paid synchronization or hosting, sale of ideas, sale of curated knowledge packages, paid skills or workflows, private collaboration spaces, and revenue sharing for creators.

Installation strategy is another major part of the idea. Double needs a clear answer for which operating systems to support, how installation should work, and how much the project should rely on native packaging, language-specific package managers, standalone binaries, or platform-specific installers.

## 5. Key Elements

- Double as a project and product
- A CLI program as the primary operational interface
- Local knowledge workspaces
- The `.double/` working catalog
- User-owned idea artifacts and knowledge artifacts
- Skills, workflows, roles, prompts, templates, and registries
- Private knowledge exchange
- Optional external services for sync, identity, payments, hosting, or marketplace features
- Monetization models such as subscriptions or idea sales
- Installation strategy across target operating systems
- Supported operating systems and distribution channels

## 6. Assumptions

- Double should remain strongly oriented around local files and user-owned knowledge.
- A CLI may be the most durable first interface because it can work across editors, shells, automation, and agents.
- Private knowledge exchange requires explicit trust, access, and ownership boundaries.
- The project may eventually need cloud services, but the local workspace should remain meaningful without them.
- Monetization should support the knowledge ecosystem rather than replace the user's ownership of artifacts.
- Operating system support decisions will influence architecture, packaging, update strategy, and onboarding.

These assumptions may turn out to be incomplete or wrong after concept extraction and architecture research.

## 7. Examples / Scenarios

- A user installs Double, initializes a local workspace, and starts capturing ideas through a CLI command.
- A user runs a Machine of Ideas workflow through the CLI and produces idea, concept, and principle artifacts.
- A user installs a skill or workflow package into `.double/`.
- A user shares a private idea package with another trusted user without making it public.
- A creator sells a curated idea artifact, skill, workflow, or knowledge package.
- A subscriber pays for hosted sync, private collaboration, marketplace access, or advanced agent-assisted workflows.
- A team uses Double as a private knowledge ecosystem while keeping sensitive artifacts local or encrypted.
- Double supports multiple operating systems through a consistent CLI installation and update story.

## 8. Signals of Value

- The idea connects existing local knowledge work with a more coherent product architecture.
- A CLI-first design could make Double scriptable, portable, and editor-independent.
- Private knowledge exchange is a differentiated direction compared with fully public publishing platforms.
- The Machine of Ideas workflow already suggests that Double can formalize thinking, not only store notes.
- Monetization through skills, workflows, subscriptions, or idea packages may align with the value of structured knowledge.
- A clear installation strategy can make the project usable outside the original development environment.

## 9. Open Questions

- What is the core promise of Double in one sentence?
- Should the CLI be the center of the product, or only one interface among several?
- What are the first essential CLI commands?
- What should remain local-only by design?
- What kinds of private knowledge exchange should Double support first?
- How should trust, permissions, encryption, licensing, and provenance work for shared knowledge artifacts?
- What is the right boundary between open-source core, paid services, paid content, and marketplace features?
- Should ideas themselves be sellable objects, or should monetization focus on workflows, skills, curation, and services?
- Which operating systems should be officially supported first?
- What installation strategy best fits the desired audience?
- Should Double be distributed as a standalone binary, package-manager package, language-specific tool, desktop companion, or some combination?
- What parts of the architecture are needed now, and what should remain future-facing?

## 10. Resolved Questions

- The idea artifact should be named `double-project`.
- The artifact should be written in English.
- The interaction language for this capture is Russian.

## 11. Boundaries / Non-Goals

- This artifact does not define the final software architecture.
- This artifact does not choose the final technology stack.
- This artifact does not specify the complete CLI command set.
- This artifact does not decide the final monetization model.
- This artifact does not define legal, security, or licensing details for idea sales.
- This artifact does not replace later concept extraction, principle synthesis, product strategy, or implementation planning.

## 12. Related Ideas

- Machine of Ideas
- Double skills
- Double workflows
- Local-first knowledge systems
- Private knowledge marketplaces
- CLI-first developer tools
- Personal knowledge management
- Agent-assisted thinking systems

## 13. Maturity Level

- [ ] Raw thought
- [x] Developed idea
- [ ] Near-concept

## 14. Notes

This idea is broad and strategic. It may benefit from being split later into sub-ideas:

- Double CLI
- Double architecture
- Double private knowledge exchange
- Double monetization
- Double installation and operating system support
- Double marketplace
- Double local-first model

For the next workflow step, concept extraction should separate product concepts, architecture concepts, ecosystem concepts, and economic concepts without prematurely turning them into implementation decisions.

## 15. Development Artifacts

- Concepts: `[pending]`
- Principles: `[pending]`
