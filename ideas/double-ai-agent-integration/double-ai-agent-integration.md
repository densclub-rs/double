---
id: double-ai-agent-integration
kind: idea-artifact
status: release-candidate
produced-by: idea-capture-agent
workflow-version: 0.1.0
derived-from:
  - conversation
  - .double/workflows/machine-of-ideas/machine-of-ideas-workflow.md
  - ideas/machine-of-ideas/directory-layout/directory-layout.md
---

# Idea: Double AI Agent Integration

## 1. Summary

`Double AI Agent Integration` explores whether the current `.double` working catalog can be used directly by major AI vendor agents without refactoring the catalog and without adding custom CLI tools, plugins, skills, or other integration-specific runtime layers.

The central question is which agent ecosystems can understand the `Machine of Ideas` workflow, guide a user through its steps, and create or update the required Markdown artifacts by relying only on the current `.double` files and the entities already defined there.

## 2. Context / Origin

- This idea emerged while developing the `Machine of Ideas` and its current `.double` directory layout.
- The existing layout already separates workflows, agents, roles, modes, prompts, templates, registries, and drafts into a readable Markdown working catalog.
- The user wants to understand whether this structure is already compatible with major AI vendor agents in its current form, before designing any dedicated packaging or runtime adaptation.
- The user explicitly wants to treat `Double CLI` as a separate future idea and keep it out of scope here.
- The investigation is intentionally started from a vendor-agnostic perspective before going into any one specific agent ecosystem.

## 3. Problem / Motivation

- If `.double` already works as a usable integration surface for some major AI agents, Double may be able to operate inside those ecosystems much earlier than expected.
- If the current layout is not directly usable, it becomes important to identify whether the gap is structural, semantic, or specific to particular agent platforms.
- The `Machine of Ideas` depends on agents being able to understand workflows, roles, modes, prompts, templates, and registries as coherent operational material rather than as unrelated notes.
- The user wants to know which major AI agents could react to the flow of thought inside the `Machine of Ideas`, guide the user through the workflow, and maintain the required artifacts without the user having to explain the internal structure manually.
- This matters because a strong Markdown-based working catalog may provide a universal integration layer for several agent ecosystems, while also revealing which adaptations are necessarily platform-specific.

## 4. Raw Description

The idea is to study the current `.double` working catalog as it already exists and ask whether it can be adopted by major AI vendor agents without any special refactoring.

The interest is not in building a custom integration stack yet. It is not about writing a CLI, publishing plugins, creating custom skills, or adding proprietary wrappers. The question is more basic and more demanding: can a large AI agent, as delivered by its vendor, enter a repository with the current `.double` catalog, understand that this catalog contains a workflow called `Machine of Ideas`, understand that the workflow has steps, modes, prompts, templates, registries, and roles, and then actually use those files to guide a human through the process and maintain the corresponding Markdown artifacts.

This idea therefore treats `.double` as a candidate agent-readable operational layer. The layout already has a visible organization: workflows, agents, modes, prompts, templates, roles, registries, and drafts all live in stable locations and are represented as Markdown. The key question is whether this is already enough for some major agent ecosystems to behave correctly without any explicit packaging effort.

The target ecosystems are the most popular major AI vendor agents as of May 2026, with the primary scope covering OpenAI, Google, Microsoft, Anthropic, xAI, and DeepSeek. Perplexity is not a core target for this pass, but it should remain visible as a note because it may represent an adjacent class of assistant with strong research-oriented behavior. The future solution is not limited to agents shipped directly by AI model vendors: it may also apply to agentic environments that build on vendor models, including Cursor, Antigravity, and OpenCode.

The expected outcome is not a final implementation decision. It is a clarified set of principles for agent-readable Double integration: principles that are concrete enough to give to major AI agents for review and to ask those agents to propose possible implementation approaches.

## 5. Key Elements

- the current `.double/` working catalog
- the `Machine of Ideas` workflow
- Markdown-based operational artifacts
- `workflows`
- `agents`
- `roles`
- `modes`
- `prompts`
- `templates`
- `registries`
- the ability of an AI agent to read repository files directly
- the ability of an AI agent to guide a user through workflow steps
- the ability of an AI agent to create and update Markdown artifacts
- zero-refactor compatibility
- zero-plugin / zero-skill / zero-CLI integration
- vendor-agnostic comparison across major AI agent ecosystems
- reuse by agents built on top of vendor models, not only vendor-shipped agents
- a note about Perplexity as a related but secondary target

## 6. Assumptions

- The current `.double` directory is already sufficiently structured to be interpreted as an operational catalog rather than as loose documentation.
- All subdirectories and Markdown files inside `.double` should be considered part of the agent-usable working catalog for this idea.
- The current `.double` catalog does not contain provider-specific decisions; any future provider-specific solutions should live in separate directories if they are created.
- Some major AI vendor agents can read and reason over repository Markdown files directly.
- Some major AI vendor agents can follow procedural instructions encoded across multiple Markdown files without needing a custom runtime layer.
- The current file organization of `.double` exposes enough semantic signals for an agent to infer how workflows, modes, roles, prompts, templates, and registries relate to each other.
- A human user may ask for help with idea development without knowing that `.double` exists, and a strong integration candidate should still be able to discover and use the structure automatically.
- Compatibility may differ substantially between agent ecosystems even if they appear similar at the chat level.
- Popularity is relevant here because the idea is about practical integration targets rather than only technically interesting ones.
- Entry-point discovery is useful but not essential; a human may explicitly point the agent to the `Machine of Ideas` entry workflow if needed.

## 7. Examples / Scenarios

- A user opens a repository in a major AI coding agent and simply asks to start working on a new idea. The agent discovers `.double`, loads the `Machine of Ideas` workflow, chooses the correct entry step, and begins guiding the user through idea capture while creating the necessary artifact files.
- A user asks the agent to continue an already started idea. The agent follows the links in the idea artifact, infers the current workflow stage from the `Development Artifacts` section, and resumes at concept extraction or principle synthesis without requiring manual explanation.
- A user knows nothing about the internal `.double` structure and only asks for help reasoning about an idea. The agent still uses the workflow, prompts, roles, modes, registries, and templates implicitly, only exposing that structure if the user asks for explanation.
- One agent ecosystem can interpret the current `.double` structure directly because it is file-native and instruction-friendly, while another may fail because it does not reliably discover or honor repository-local workflow files unless they are mapped into a vendor-specific construct.
- Perplexity may be useful for research or explanation around the idea, but may or may not fit the same file-driven workflow execution model as repository-native coding agents.
- Cursor, Antigravity, or OpenCode may use `.double` as a repository-local operational catalog even if their behavior depends on underlying vendor models rather than on fully proprietary model stacks.

## 8. Signals of Value

- It becomes possible to identify which major AI vendor agents are realistic near-term homes for Double without building new infrastructure first.
- The current `.double` layout may prove to be a strong universal integration surface across multiple ecosystems.
- The investigation can separate universal structural strengths from platform-specific requirements.
- If compatibility is already high for some agents, Double can prioritize documentation and workflow clarity instead of immediately investing in tooling.
- If compatibility is low, the result still reveals where the real friction lies: discoverability, instruction binding, file mutation, or workflow-state inference.
- The outcome can guide later dedicated integration ideas, including but not limited to CLI, plugins, skills, or vendor-specific packaging.
- A compatible agent should be able to preserve workflow discipline over time instead of only giving one-off correct answers.
- The first successful output should be a clear principle set that can be handed to major AI agents for critique, comparison, and concrete solution proposals.
- The idea becomes practically successful if Codex, Claude, or Gemini can use the idea, concept, and principle artifacts to propose a concrete integration variant that actually works.
- Once a working integration variant exists, later work can focus on refinement, optimization, and platform-specific improvement rather than proving the idea from scratch.

## 9. Open Questions

- No blocking open questions at the idea-capture level.

## 10. Resolved Questions

- `Double CLI` is explicitly outside the scope of this idea and should be developed separately.
- The primary targets for the first pass are OpenAI, Google, Microsoft, Anthropic, xAI, and DeepSeek.
- Perplexity should remain visible as a note, but not as a core target of this first pass.
- “Integration without special modifications” means that the agent should understand the `Machine of Ideas` workflow, guide the user through its steps, and create or update the required artifacts using the current Markdown files and defined entities in `.double`.
- A strong fit means the agent can use the current `.double` structure automatically, without requiring the human to know or explain the existence of that working structure, except when the human asks for an explanation.
- A stronger success criterion is not mere discovery of `.double`, but stable navigation across workflow, roles, modes, prompts, and templates without confusion or loss of artifact integrity.
- A compatible agent should reliably infer the correct workflow step, preserve artifact updates over time, and suggest valid continuation modes.
- Entry-point discovery is secondary because a human can point the agent to the starting workflow if needed.
- The main working hypothesis for practical integration focus is that Codex, Claude, and Gemini are the most important initial targets, and that all three should in principle be able to work with the current structure, though Gemini is the least certain case.
- The main structural risk in the current approach is the use of Markdown itself, because it can make logical relationships less explicit and increase token consumption during agent execution.
- All subdirectories and Markdown files in `.double` are intended to be usable by agents as part of the working catalog; the current catalog is not organized around provider-specific choices.
- Future provider-specific decisions or adaptations, if needed, should be placed in separate directories rather than embedded into the universal `.double` working catalog.
- The evaluation should not focus only on agents shipped directly by AI vendors. It should also include agentic environments that use base vendor models, including Cursor, Antigravity, and OpenCode.
- Success for the current stage means producing clear principles that can be handed to major AI agents for review, so those agents can critique the principles and suggest concrete solution variants.
- The first agents to review the artifacts should be Codex, Claude, and Gemini.
- The review package should include the idea artifact, the concept artifact, and the principle artifact.
- The agents should be asked to propose a concrete integration variant based on those artifacts.
- If at least one proposed integration variant works in practice, the idea should be considered successful enough to continue into refinement and optimization.
- The working review prompt can be: "Using the developed principles of this idea, propose implementation options for Codex, Claude, or Gemini. If needed, use additional information from the concept artifact and the idea artifact."

## 11. Boundaries / Non-Goals

- This idea does not design a `Double CLI`.
- This idea does not define plugins, skills, vendor SDK integrations, or special commands.
- This idea does not refactor `.double` yet.
- This idea does not commit to one vendor ecosystem in advance.
- This idea does not yet evaluate all possible AI assistants or open-source agent runtimes.
- This idea does not produce a final compatibility matrix at the idea-capture stage.
- This idea does not place provider-specific decisions inside the universal `.double` catalog.

## 12. Related Ideas

- The root idea [Machine of Ideas](../machine-of-ideas/machine-of-ideas.md)
- The sub-idea [Directory Layout](../machine-of-ideas/directory-layout/directory-layout.md)
- The placeholder [Double Integration](../double-integration.save/double-integration.md)

## 13. Maturity Level

- [ ] Raw thought
- [x] Developed idea
- [ ] Near-concept

## 14. Notes

Current `.double` already includes visible directories for:

```text
.double/
  agents/
  drafts/
  modes/
  prompts/
  registries/
  roles/
  templates/
  workflows/
```

This makes the current integration question concrete rather than hypothetical: the layout is not merely proposed, it already exists in a usable Markdown form inside the repository.

Practical near-term emphasis currently centers on `Codex`, `Claude`, and `Gemini`, even though the broader first-pass scope remains larger.

The universal `.double` catalog should remain clean of provider-specific implementation decisions. If future work creates dedicated support for a specific vendor, agent, or environment, that material should live in a separate location so the common catalog remains usable across agents.

## 15. Development Artifacts

- Concepts: [double-ai-agent-integration-concepts](./double-ai-agent-integration-concepts.md)
- Principles: [double-ai-agent-integration-principles](./double-ai-agent-integration-principles.md)
