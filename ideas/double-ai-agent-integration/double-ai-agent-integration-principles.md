---
id: double-ai-agent-integration-principles
kind: principle-artifact
status: release-candidate
produced-by: principle-synthesis-agent
workflow-version: 0.1.0
publication-path: ideas/double-ai-agent-integration/double-ai-agent-integration-principles.md
derived-from:
  - double-ai-agent-integration
  - double-ai-agent-integration-concepts
  - directory-layout
---

# Principle Artifact: Double AI Agent Integration

## 1. Source Artifacts

- Source idea artifact: `double-ai-agent-integration` -> `ideas/double-ai-agent-integration/double-ai-agent-integration.md`
- Source concept artifact: `double-ai-agent-integration-concepts` -> `ideas/double-ai-agent-integration/double-ai-agent-integration-concepts.md`
- Root idea artifact: `double-ai-agent-integration` -> `ideas/double-ai-agent-integration/double-ai-agent-integration.md`
- Root idea directory: `ideas/double-ai-agent-integration`
- Relevant sub-ideas: `directory-layout` -> `ideas/machine-of-ideas/directory-layout/directory-layout.md`
- Published as: `double-ai-agent-integration-principles.md`
- Synthesis mode: `strict-research`

## 2. Principle Synthesis Summary

The normative center of this idea is that `.double` should be treated as a universal, agent-readable working catalog first, and only later as material for platform-specific adaptation. Integration quality should therefore be judged by whether an agent can execute the `Machine of Ideas` workflow through durable artifact updates, not by whether it can merely read files or produce a plausible integration proposal.

The principles below preserve that distinction. They require the universal catalog to remain provider-neutral, require target environments to be evaluated by workflow behavior rather than vendor identity alone, require review artifacts to guide implementation proposals, and define practical validation as an end-to-end human collaboration through the whole idea workflow.

## 3. Working Definition of Principle

A principle is a stable normative ground derived from an idea and its conceptual structure.
It guides or constrains future decisions, but it is not yet a requirement, task, design decision, implementation step, or generic value statement.

## 4. Core Principles

### Principle: Preserve the Universal Working Catalog

#### Statement

The `.double` catalog should remain a provider-neutral working catalog, and provider-specific decisions should be kept outside the universal catalog unless they become general process knowledge.

#### Derived From

- Source concept(s): `Universal Working Catalog`, `Agent-Readable Operational Catalog`, `Universal vs Vendor-Specific Compatibility`
- Source relationship, boundary, or tension: the common catalog must stay usable across agents while still allowing future platform-specific adaptations
- Source idea support: the idea states that current `.double` files are not provider-specific and future provider-specific solutions should live separately
- Explicit or inferred: explicit

#### Rationale

The value of the current `.double` structure depends on it being a shared operational surface. If platform-specific assumptions are embedded into the universal catalog too early, the catalog stops being a neutral test of agent compatibility and becomes a collection of hidden local adaptations.

#### Implications Without Implementation

- Future integration proposals should distinguish common catalog rules from platform-specific support material.
- `.double` should be evaluated as a shared structure before it is optimized for one environment.
- A vendor-specific adaptation may be useful, but it should not redefine the universal catalog by default.

#### Boundaries

- This principle does not forbid provider-specific support.
- It does not require all agents to use every `.double` file identically.
- It does not imply that the universal catalog can never evolve.

#### Anti-Patterns

- Adding Codex-only, Claude-only, or Gemini-only behavior directly into shared workflow files without a general reason.
- Treating one successful vendor path as the universal structure.
- Hiding platform-specific assumptions inside generic prompts or templates.

#### Questions

- No open questions at the current principle level.

### Principle: Evaluate Agent Behavior, Not Vendor Identity Alone

#### Statement

Compatibility should be judged by the agent environment's ability to execute the workflow in a repository, not only by the identity of the underlying model vendor.

#### Derived From

- Source concept(s): `Model-Backed Agent Environment`, `Universal vs Vendor-Specific Compatibility`, `Workflow-Native Agent Execution`
- Source relationship, boundary, or tension: Cursor, Antigravity, and OpenCode may differ from vendor-shipped agents even when they use similar base models
- Source idea support: the idea explicitly expands scope beyond vendor-shipped agents to agentic environments built on vendor models
- Explicit or inferred: explicit

#### Rationale

The practical integration surface is shaped by repository access, file mutation, instruction loading, state handling, and user interaction flow. Those capabilities may differ more between agent environments than between base models.

#### Implications Without Implementation

- Evaluation should include Codex, Claude, and Gemini, but should not stop there.
- Agent environments such as Cursor, Antigravity, and OpenCode should be considered relevant when they can use repository-local files and sustain workflow state.
- Future comparisons should describe operational capabilities, not only model names.

#### Boundaries

- This principle does not make every LLM wrapper a relevant target.
- It excludes passive chat interfaces that cannot work with repository files or maintain workflow continuity.
- It does not remove the usefulness of vendor-level comparison.

#### Anti-Patterns

- Assuming a model is compatible because another environment using a similar model worked.
- Ranking targets only by brand or popularity.
- Ignoring file access and artifact mutation behavior.

#### Questions

- No open questions at the current principle level.

### Principle: Treat Workflow Execution as the Core Integration Test

#### Statement

An integration should count as meaningful only if the agent can use `.double` to guide the user through workflow steps and maintain the required artifacts, not merely discover or summarize the catalog.

#### Derived From

- Source concept(s): `Workflow-Native Agent Execution`, `Workflow-State Inference`, `Artifact Integrity Preservation`
- Source relationship, boundary, or tension: structural legibility is insufficient without operational continuity
- Source idea support: success is defined as understanding the workflow, guiding the user, and creating or updating Markdown artifacts
- Explicit or inferred: explicit

#### Rationale

The Machine of Ideas is a process, not just a document set. An agent that can explain `.double` but cannot continue the workflow, infer state, ask questions, or update artifacts has not integrated with the idea machine in the intended sense.

#### Implications Without Implementation

- Compatibility reviews should ask what the agent can do across steps, not only what files it can read.
- State inference and artifact updates should be central evaluation points.
- One-off correct answers should be treated as weaker evidence than repeated workflow discipline.

#### Boundaries

- This principle does not require perfect automatic discovery of `.double`.
- It allows the user to point the agent to the workflow entry point.
- It does not prescribe a particular implementation mechanism.

#### Anti-Patterns

- Calling a system compatible because it summarized the workflow correctly once.
- Treating repository browsing as equivalent to workflow execution.
- Advancing stages without checking artifact state or unresolved questions.

#### Questions

- No open questions at the current principle level.

### Principle: Preserve Artifact Integrity Over Conversational Convenience

#### Statement

Agents should preserve artifact structure, links, open questions, resolved decisions, and workflow traceability even when conversational shortcuts would be easier.

#### Derived From

- Source concept(s): `Artifact Integrity Preservation`, `Markdown as Operational Substrate`, `Workflow-State Inference`
- Source relationship, boundary, or tension: Markdown is easy to edit, but semantic continuity can be lost if updates are casual
- Source idea support: compatible agents must create and update required artifacts without loss of structure or workflow state
- Explicit or inferred: explicit

#### Rationale

The artifacts are the durable memory and state surface of the idea machine. If an agent resolves questions only in chat, breaks links, collapses sections, or loses workflow metadata, later state inference becomes unreliable.

#### Implications Without Implementation

- Answers to open questions should be integrated into the active artifact.
- Resolved questions should be closed in their original question section after their answers have been integrated into the artifact's main content.
- Dedicated `Resolved Questions` sections should be used only when a specific artifact contract requires them.
- Artifact updates should maintain the template contract and visible development links.

#### Boundaries

- This principle is not only about valid Markdown syntax.
- It does not require preserving every historical phrase if the artifact clearly integrates the answer.
- It does not prevent editorial cleanup when structure and meaning are preserved.

#### Anti-Patterns

- Leaving answered questions in their original question section.
- Updating chat memory but not the artifact.
- Breaking `Development Artifacts` links or changing section semantics casually.

#### Questions

- No open questions at the current principle level.

### Principle: Keep Human Clarification Inside the Active Step

#### Statement

When the agent asks or receives answers to open questions, those answers should refine the active workflow artifact rather than silently moving the work into another stage.

#### Derived From

- Source concept(s): `Workflow-Native Agent Execution`, `Workflow-State Inference`, `Working Integration as Validation`
- Source relationship, boundary, or tension: human collaboration is necessary, but it must not blur stage boundaries
- Source idea support: the workflow requires agents to close open questions and maintain all required artifacts through the full flow
- Explicit or inferred: inferred from workflow and validation criteria

#### Rationale

The Machine of Ideas depends on a staged transformation: idea capture, concept extraction, and principle synthesis. Human answers are source material for the current stage. If the agent turns an answer during concept extraction into design work or implementation planning, the process loses its discipline.

#### Implications Without Implementation

- Open questions should be asked at the smallest useful scope for the current step.
- User answers should be integrated into the artifact of the current step.
- Stage transitions should happen only after the current artifact is ready.

#### Boundaries

- This principle does not prevent the agent from naming future implications.
- It does not require suppressing useful future material; such material can be recorded as candidate input for later stages.
- It does not forbid repeating a step in another mode.

#### Anti-Patterns

- Treating a clarification answer as permission to jump into implementation.
- Moving to principle synthesis while concept boundaries are still unresolved.
- Creating future-stage artifacts before the current stage is honestly complete.

#### Questions

- No open questions at the current principle level.

### Principle: Use Reviewable Principles as the Bridge to Implementation

#### Statement

The output of this idea should first be a clear principle set that other major agents can review and use to propose implementation variants.

#### Derived From

- Source concept(s): `Artifact-Grounded Integration Review`, `Universal Working Catalog`, `Working Integration as Validation`
- Source relationship, boundary, or tension: the idea should not jump directly from compatibility analysis into a single chosen implementation
- Source idea support: success for the current stage is defined as principles that can be given to Codex, Claude, and Gemini for review
- Explicit or inferred: explicit

#### Rationale

Principles are the right handoff layer because they preserve the general integration logic without overcommitting to one platform. They allow Codex, Claude, and Gemini to propose concrete variants while keeping those proposals accountable to the same conceptual base.

#### Implications Without Implementation

- The review package should include the idea artifact, concept artifact, and principle artifact.
- Principles should be concrete enough to constrain proposals, but not so specific that they become implementation tasks.
- Agent review should compare proposed variants against the principles.

#### Boundaries

- This principle does not treat review as final validation.
- It does not require all reviewed agents to produce the same solution.
- It does not replace practical testing.

#### Anti-Patterns

- Asking agents for implementation ideas before the principles are clear.
- Treating a persuasive proposal as successful without execution.
- Producing principles so generic that they cannot constrain integration options.

#### Questions

- No open questions at the current principle level.

### Principle: Validate by End-to-End Human Collaboration

#### Statement

A proposed integration variant should be considered working only when an agent can complete the full idea workflow with a human, create all required artifacts, and close all open questions.

#### Derived From

- Source concept(s): `Working Integration as Validation`, `Artifact-Grounded Integration Review`, `Workflow-Native Agent Execution`
- Source relationship, boundary, or tension: practical success requires an executed workflow, not just a plausible plan
- Source idea support: the user defined the minimum working demonstration as the whole flow with all artifacts and open questions closed
- Explicit or inferred: explicit

#### Rationale

The idea is successful only if the integration can sustain the actual process. A partial demo may show promise, but it does not prove that the agent can maintain workflow state, artifact integrity, and human clarification across the full Machine of Ideas pass.

#### Implications Without Implementation

- The minimum demo should include idea capture, concept extraction, and principle synthesis.
- The agent should guide the human, not only process static files.
- All required artifacts should be created or updated, and open questions should be resolved or intentionally preserved only when the workflow allows it.

#### Boundaries

- This principle does not require the first working variant to be optimized.
- It does not require all reviewed agents to pass before the idea is useful.
- It does not define the later refinement or optimization roadmap.

#### Anti-Patterns

- Counting a single artifact update as a successful integration.
- Accepting a proposal that has not been executed.
- Ignoring unresolved open questions at the end of the demo.

#### Questions

- No open questions at the current principle level.

## 5. Principle Map

- `Preserve the Universal Working Catalog` is the structural guardrail for the whole integration effort.
- `Evaluate Agent Behavior, Not Vendor Identity Alone` broadens the target set while keeping the focus on operational capability.
- `Treat Workflow Execution as the Core Integration Test` defines what compatibility must mean in practice.
- `Preserve Artifact Integrity Over Conversational Convenience` protects the durable state surface that makes workflow execution possible.
- `Keep Human Clarification Inside the Active Step` preserves the staged logic of the Machine of Ideas.
- `Use Reviewable Principles as the Bridge to Implementation` defines how the current artifact should be used by Codex, Claude, and Gemini.
- `Validate by End-to-End Human Collaboration` defines the practical success threshold.

In compact form:

`Preserve the Universal Working Catalog`
-> enables fair evaluation across `Agent Behavior, Not Vendor Identity Alone`
-> where compatibility means `Workflow Execution`
-> protected by `Artifact Integrity` and `Human Clarification Inside the Active Step`
-> packaged as `Reviewable Principles`
-> tested through `End-to-End Human Collaboration`

## 6. Trade-offs and Tensions

- Universal catalog vs provider-specific optimization: keeping `.double` neutral may slow targeted optimization, but protects the shared integration surface.
- Markdown readability vs machine precision: Markdown supports human-readable workflow material, but requires disciplined linking, templates, and artifact updates to remain reliable.
- Manual entry-point guidance vs automatic discovery: allowing the human to point to the workflow makes early integration easier, but later stronger integrations may need better discovery.
- Principle review vs immediate implementation: asking agents to review principles first delays implementation, but reduces the risk of building a platform-specific solution before the general structure is clear.
- End-to-end validation vs fast demos: a full workflow demonstration is stricter than a small proof of concept, but better matches the actual value claim of the idea.

## 7. Candidate Inputs for Future Stages

- Ask Codex, Claude, and Gemini to review this principle artifact together with the idea and concept artifacts.
- Use the working review prompt: "Using the developed principles of this idea, propose implementation options for Codex, Claude, or Gemini. If needed, use additional information from the concept artifact and the idea artifact."
- Compare proposed integration variants by whether they preserve the universal `.double` catalog, avoid hidden provider-specific assumptions, and support full workflow execution.
- Design a minimum end-to-end demonstration that includes idea capture, concept extraction, principle synthesis, artifact updates, and closure of open questions.
- If a proposed integration works, move into refinement, optimization, and platform-specific support material.

## 8. Rejected or Deferred Candidate Principles

- `Automatic Discovery Is Required`: deferred. Entry-point discovery is useful, but the source idea treats it as secondary because a human may point the agent to the workflow.
- `Markdown Must Be Replaced`: rejected at this stage. Markdown is a risk and a trade-off, but it is also the current operational substrate being tested.
- `All Major Agents Must Work`: rejected. The idea can be practically successful if at least one concrete integration variant works.
- `Vendor-Specific Packaging Comes First`: rejected. The idea explicitly begins from a vendor-agnostic and zero-refactor perspective.
- `A Proposal Alone Validates the Idea`: rejected. Practical validation requires an executed end-to-end workflow with artifacts and open questions handled.

## 9. Development Notes

- The first review agents are `Codex`, `Claude`, and `Gemini`.
- The review package should include the idea artifact, concept artifact, and principle artifact.
- The primary review prompt asks agents to use the developed principles and consult the concept and idea artifacts if needed.
- Provider-specific material should remain separate from the universal `.double` working catalog.
- Agent environments built on vendor models, such as Cursor, Antigravity, and OpenCode, remain relevant evaluation targets.
- The minimum working demonstration is end-to-end human collaboration through the full idea workflow: the agent guides the human, creates all required artifacts, and closes all open questions.
