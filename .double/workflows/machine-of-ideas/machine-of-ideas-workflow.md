---
style: double
submodule: machine-of-ideas
id: machine-of-ideas-workflow
kind: workflow
status: release-candidate
version: 0.2.1
interaction-language: en
artifact-language: en
derived-from:
  - ideas/machine-of-ideas/machine-of-ideas.md
  - ideas/machine-of-ideas/directory-layout/directory-layout.md
  - ideas/machine-of-ideas/concept-extraction/concept-extraction.md
  - ideas/machine-of-ideas/principle-synthesis/principle-synthesis.md
  - ideas/machine-of-ideas/machine-of-ideas-concepts.md#concept-human-clarification-loop
  - ideas/machine-of-ideas/machine-of-ideas-principles.md#principle-ask-and-integrate-open-questions
---

# Workflow: Machine of Ideas

## Purpose

This workflow defines the prototype of the basic thinking scheme of the idea machine.

Current version of the flow:

`Idea Capture -> Concept Extraction -> Principle Synthesis`

## Versioning Rule

- current version: `0.2.1`
- a new version is created if the structure of steps, artifact contracts, agent roles, language protocol, or transition conditions change

## Catalog Interpretation Rule

The `.double/` directory is the working catalog of the idea machine.

When the user refers to the "working catalog", "the catalog", "your side", "inside yourself", "у себя", or asks to change how Double or the flow behaves, the agent should interpret this as a request to inspect or update `.double/`, not the user's idea artifacts, unless the user explicitly names an artifact outside `.double`.

Changes inside `.double/` are process changes: they modify workflows, agents, roles, modes, prompts, templates, registries, or other machine-of-ideas operating material. Changes outside `.double/`, especially under `ideas/`, are user artifact changes.

If the intended target is ambiguous, the agent should briefly state the assumed target and the reason for it before editing.

## Machine Operating Change Routing Rule

When the user requests the creation, modification, movement, or removal of a
Machine of Ideas operating artifact under `.double/`, activate `double-agent`
and suspend normal workflow-agent editing for that request.

`double-agent` must follow its planning, validation, explicit change-set
approval, and per-artifact approval protocol from:

- `.double/agents/double-agent/double-agent.md`
- `.double/roles/double-agent/machine-artifact-maintainer-role.md`

Read-only inspection or explanation does not require an artifact-change
approval. A request that mixes Machine of Ideas operating changes with user
artifact changes under `ideas/` must be split into separately planned steps.
The normal Machine of Ideas workflow agent remains responsible for the user
artifact portion.

## Entry Protocol

This workflow is the entry point for a universal agent if the user invokes the idea machine without a step already selected.

On startup, the agent should:

1. Read this `machine-of-ideas-workflow`.
2. Determine which idea, artifact, or idea directory is the target of the current run based on the user request and available context.
3. If the target idea is not explicitly stated by the user, form at most one clearly marked working assumption from the available context.
4. Present that assumption to the user and ask for confirmation or correction before treating the idea target as selected.
5. Ask the user which language to use for communication during the run.
6. Ask the user which language to use for final artifacts.
7. If the user has already made either language choice explicit, confirm the detected choice instead of asking again.
8. Determine the current step based on the confirmed target and the user request.
9. If the user asks to work on a clarification of an existing idea, a sub-idea, or a mini-idea, select `01-idea-capture` and use the mini-idea template.
10. If no step is specified and there are no input artifacts, select `01-idea-capture`.
11. Find the agent card, associated role, allowed modes, and output artifact template for the selected step.
12. Inspect the active artifact and relevant input artifacts for unresolved open questions. In idea artifacts this normally means `Open Questions`; in concept and principle artifacts this means unanswered items in local `Questions` subsections.
13. Inform the user of the current state, unresolved questions if any, selected languages, and available actions.
14. Recommend the next useful action:
   - if unresolved open questions exist, suggest answering them before advancing
   - if no unresolved open questions block the current step and the current artifact satisfies the step contract, suggest transition to the next step
   - if the current step should continue, recommend a suitable mode and briefly explain why
15. Ask the user to choose a mode or accept the recommended/default mode.
16. Begin executing the step only after confirming the target idea, current step, interaction language, artifact language, selected output template, and mode.

## Language Protocol

The machine separates the language of interaction from the language of generated artifacts.

- `interaction-language` is the language the agent uses while speaking with the user during the current run.
- `artifact-language` is the language used to formulate produced idea, concept, and principle artifacts.
- The two values may be the same or different.
- The agent should offer the user both choices before producing or rewriting a final artifact.
- If the user writes in one language, the agent may use that as a working assumption for `interaction-language`, but must not silently treat it as the selected `artifact-language`.
- If the user asks for artifacts in a specific language, the agent should confirm that as `artifact-language`.
- Produced artifacts must include `interaction-language` and `artifact-language` in YAML frontmatter.
- If a source artifact lacks language metadata, the agent should infer its visible artifact language when needed, but should mark any uncertain language transformation as an open question or note.

## Default State

If the system starts without context, the initial state is considered to be:

- current-step: `01-idea-capture`
- current-mode: `brainstorm`
- interaction-language: `ask-user`
- artifact-language: `ask-user`
- expected-output: `idea-artifact`
- available-actions:
  - `describe-new-idea`
  - `choose-mode`
  - `inspect-workflow`
  - `inspect-current-artifacts`

If the user comes with an existing artifact, the agent should try to determine which step the artifact belongs to and start with the corresponding state.

If the user does not explicitly identify the idea target, the system is not considered fully initialized until the target idea is confirmed by the user.

## State Inference from Idea File

If the agent starts from a main idea file, it should inspect the `Development Artifacts` section and infer the current stage as follows:

- no concept artifact link: the idea is captured but not yet conceptually extracted; next likely step is `02-concept-extraction`
- concept artifact link exists, but no principle artifact link exists: concept extraction has been published; next likely step is `03-principle-synthesis`
- both concept and principle artifact links exist: the first full pass of the machine of ideas is complete
- a link exists but the target file is missing: the current state is inconsistent and should be handled in `validation` or `editor` mode before transition

The source idea file remains the visible status surface for the idea's development.

## Root Idea Placement Rule

When the user starts work on a new idea and does not identify it as a sub-idea of an existing idea, the target is a root idea. A root idea artifact must be published directly under `ideas/` using the layout `ideas/<idea-id>/<idea-id>.md`.

The agent must not place a new root idea inside a workflow, process, or topic directory such as `ideas/machine-of-ideas/`. A nested location is allowed only when the user explicitly says the new idea is a sub-idea or names the parent idea directory.

## Mini-Idea Routing Rule

When the user asks to work on an `idea clarification`, `clarification of an idea`, `sub-idea`, `mini-idea`, `mini idea`, the workflow should treat the request as work on a mini-idea inside a confirmed parent idea.

The selected step is `01-idea-capture`, but the selected template is `.double/templates/machine-of-ideas/mini-idea-template.md` instead of the full idea template.

The agent should confirm the parent idea before capture. If the parent idea can be inferred from the active artifact, editor context, or explicit user reference, present that inference as a working assumption and ask for confirmation or correction.

A mini-idea is captured as its own artifact, but concept extraction and principle synthesis are routed back into the parent idea's concept and principle artifacts. The main idea does not need special metadata linking it to the mini-idea.

If the mini-idea develops significant semantic mismatch with the parent idea, the agent should stop treating it as a mini-idea and ask the user whether to turn the material into a separate independent idea.

## New Idea Status Rule

Every newly created root idea or sub-idea must start with `status: draft` in frontmatter. Later workflow stages may change the status only when the idea has matured through explicit work on the artifact.

For a project with a root idea and sub-ideas, the root idea artifact is the visible status surface for the whole project. Concept and principle artifacts are formed for the root idea as a whole, using its relevant sub-ideas as source material, and are published next to the root idea artifact.

## Loading Order

To execute a step, the agent should read related artifacts in the following order:

1. `machine-of-ideas-workflow.md`
2. card of the current agent
3. associated role
4. `modes-registry.md`
5. description of the selected mode
6. system prompt
7. interaction prompt, if it exists for the current step
8. template of the output artifact

This order is needed so that the agent first understands the process, then its function, then the current mode, and only then specific text instructions.

## User Interaction Rule

Before starting to execute a step, the agent should inform the user of:

- target idea or the current working assumption about it
- current step
- goal of the step
- unresolved open questions that are relevant to the current step
- available modes
- expected output artifact
- selected interaction language, or a request to choose it
- selected artifact language, or a request to choose it
- the recommended next action
- the recommended mode, when a mode choice is useful

If the target idea is inferred rather than explicitly stated, the agent should:

- say that it is an assumption
- briefly name the signals used for that assumption
- ask the user to confirm or correct it
- avoid editing or advancing any artifact until the target is confirmed

If a mode is not explicitly selected, the agent should:

- either invite the user to choose a mode
- or use the default mode specified for the step

If interaction language or artifact language is not explicitly selected, the agent should ask for it before producing any final artifact. The agent may continue lightweight clarification in the user's current language while language choices are being confirmed.

If the user asks why the agent chose a particular step, how the flow is organized, or what principles are currently being applied, the agent should respond using the `explain` mode logic without losing the current workflow step.

## Proactive Continuation Rule

The agent should actively help the user keep the idea-machine flow moving.

At the end of each meaningful interaction or artifact update, the agent should inspect the active artifact and relevant input artifacts, then recommend one next action:

- if unresolved open questions exist, offer to work through those questions with the user
- if a question has just been answered, integrate the answer, close the item in its original question section, and then check whether more open questions remain
- for concept artifacts, treat unanswered items in each concept's `Questions` subsection as the open questions; after integrating an answer, close the item in the corresponding concept's `Questions` subsection
- for principle artifacts, treat unanswered items in each principle's `Questions` subsection as the open questions; after integrating an answer, close the item in the corresponding principle's `Questions` subsection
- if no unresolved open questions remain and the current artifact meets the step contract, suggest moving to the next workflow step
- if the artifact is incomplete but no direct question is needed, suggest the mode that best fits the next pass, such as `editor` for cleanup, `validation` for checking, `strict-research` for rigorous extraction or synthesis, `brainstorm` for expansion, or `explain` for understanding the process

The recommendation should be concise and practical. The agent should not wait passively for the user to ask what to do next when the workflow state clearly indicates a useful continuation.

## Human Clarification Loop

At every workflow step, the agent may ask open questions when the active artifact cannot be completed honestly from the available material. If open questions already exist, the agent should proactively offer to help the user answer them before advancing, unless the user explicitly chooses to preserve them unresolved.

The loop works as follows:

1. Detect uncertainty, missing context, ambiguity, or a decision that belongs to the human developing the idea.
2. Treat an unclear idea target as a blocking uncertainty for workflow initialization.
3. Record the question in the active artifact's appropriate question section. Use `Open Questions` for idea artifacts; use the local `Questions` subsection of the corresponding concept or principle for concept and principle artifacts.
4. Ask the user the smallest useful set of questions for the current step.
5. Treat the user's answers as source material for the active artifact.
6. Update the active artifact by integrating the answer into the relevant section, not only by appending chat history.
7. Mark answered questions as done or remove them from the same question section after their resolution is integrated into the artifact.
8. Keep unresolved questions visible if they remain meaningful material for later work.

Question sections are status ledgers for questions, not storage places for answers.
When a question is answered, the agent must refine the appropriate main sections
of the active artifact and then mark the question as done or remove it from the question section. The agent must not add
answers, explanations, consequences, or resolved-question records under the
question itself. The agent must not create a separate `Resolved Questions`
section for normal artifact questions.

Concept and principle artifacts must not use a general artifact-level `Open Questions` section. They should keep open questions in the local `Questions` subsections of the relevant concepts or principles.

This loop must stay inside the current workflow step. Answering a question during concept extraction should refine the concept artifact; it should not silently become principle synthesis. Answering a question during principle synthesis should refine the principle artifact; it should not silently become a specification.

## Transition Protocol

Transition to the next step is allowed only if:

- the required output artifact of the current step is created
- the artifact meets the minimum contract
- open questions that block the current artifact have either been answered and integrated or explicitly preserved as unresolved
- the user has not requested a repeat of the current step in another mode
- no additional validation of the result is required

Unresolved open questions do not block transition by themselves unless they prevent the minimum honest completion of the current artifact.

When transition happens while unresolved open questions remain:

- the agent must explicitly draw the user's attention to those remaining open questions
- the agent must name where those questions remain recorded
- the agent may continue to the next step without waiting for immediate answers
- the unresolved questions should remain visible as later material

If these conditions are not met, the agent remains at the current step.

When transition conditions are met and no blocking open questions remain, the agent should explicitly suggest the next workflow step and recommend an initial mode for that step based on the workflow defaults and current artifact state.

The agent can:

- repeat the current step in another mode
- refine the current artifact
- transfer the artifact to the next step
- switch to `validation` if the user wants to verify the result of the current step

## Steps

### 01. Idea Capture

- step-id: `01-idea-capture`
- agent: `idea-capture-agent`
- role: `idea-capture-role`
- default-mode: `brainstorm`
- allowed-modes:
  - `brainstorm`
  - `explain`
  - `strict-research`
  - `validation`
  - `editor`
- required-inputs:
  - `raw-user-input`
  - `conversation-context`
  - `idea-template` or `mini-idea-template`
- produced-outputs:
  - `idea-artifact`
  - `mini-idea-artifact` when the mini-idea template is selected
- language-policy:
  - ask for interaction language before structured capture if not already clear
  - ask for artifact language before producing final Markdown
  - write `interaction-language` and `artifact-language` to frontmatter
- template:
  - `.double/templates/machine-of-ideas/idea-template.md`
  - `.double/templates/machine-of-ideas/mini-idea-template.md` when the user asks for an idea clarification, sub-idea, or mini-idea
- entry-message-policy:
  - explain current step
  - show available modes
  - invite free-form idea input
- repeat-policy:
  - step may be repeated with another mode before transition
- transition-condition:
  - the idea is sufficiently formulated for concept extraction
- next-step:
  - `02-concept-extraction`

### 02. Concept Extraction

- step-id: `02-concept-extraction`
- agent: `concept-extraction-agent`
- role: `concept-extractor-role`
- default-mode: `strict-research`
- allowed-modes:
  - `brainstorm`
  - `explain`
  - `strict-research`
  - `validation`
  - `editor`
- required-inputs:
  - `root-idea-artifact`
  - `concept-template`
- optional-inputs:
  - `relevant-sub-ideas`
- produced-outputs:
  - `concept-artifact`
- language-policy:
  - preserve the user's chosen interaction language for clarification
  - produce the concept artifact in the selected artifact language
  - write `interaction-language` and `artifact-language` to frontmatter
- output-location:
  - same directory as root idea artifact
  - file name: `<root-idea-id>-concepts.md`
  - if the source material includes sub-ideas, the artifact is still published next to the root idea
- source-idea-update:
  - add or update `Development Artifacts` link to the concept artifact in the root idea file
- template:
  - `.double/templates/machine-of-ideas/concept-template.md`
- interaction-prompt:
  - `.double/prompts/machine-of-ideas/interaction/concept-extraction.md`
- entry-message-policy:
  - explain current step
  - describe expected conceptual output and the working definition of concept
  - confirm selected mode
  - if unresolved open questions remain in the source idea, explicitly remind the user about them without blocking the step
  - ask whether the user wants a full concept artifact or a focused concept review
- repeat-policy:
  - step may be repeated if the concept artifact is incomplete or user requests another mode
- transition-condition:
  - core concepts are extracted and ready for principle synthesis
- next-step:
  - `03-principle-synthesis`

### 03. Principle Synthesis

- step-id: `03-principle-synthesis`
- agent: `principle-synthesis-agent`
- role: `principle-synthesizer-role`
- default-mode: `strict-research`
- allowed-modes:
  - `brainstorm`
  - `explain`
  - `strict-research`
  - `validation`
  - `editor`
- required-inputs:
  - `root-idea-artifact`
  - `concept-artifact`
  - `principle-template`
- optional-inputs:
  - `relevant-sub-ideas`
- produced-outputs:
  - `principle-artifact`
- language-policy:
  - preserve the user's chosen interaction language for clarification
  - produce the principle artifact in the selected artifact language
  - write `interaction-language` and `artifact-language` to frontmatter
- output-location:
  - same directory as root idea artifact
  - file name: `<root-idea-id>-principles.md`
  - if the source material includes sub-ideas, the artifact is still published next to the root idea
- source-idea-update:
  - add or update `Development Artifacts` link to the principle artifact in the root idea file
- template:
  - `.double/templates/machine-of-ideas/principle-template.md`
- interaction-prompt:
  - `.double/prompts/machine-of-ideas/interaction/principle-synthesis.md`
- entry-message-policy:
  - explain current step
  - describe expected principle artifact and the working definition of principle
  - confirm selected mode
  - if unresolved open questions remain in the source idea, or unanswered concept `Questions` remain in the concept artifact, explicitly remind the user about them without blocking the step
  - ask whether the user wants a full principle artifact or a focused principle review
- repeat-policy:
  - step may be repeated if the principle artifact is incomplete, too generic, insufficiently grounded, or user requests another mode
- transition-condition:
  - principles are grounded in input artifacts, distinguished from requirements and design decisions, and ready to serve as input for future stages
- next-step:
  - `<future-stage>`

## Artifact Contracts

### idea-artifact

- kind: `idea-artifact`
- produced-by: `idea-capture-agent`
- required-frontmatter:
  - `interaction-language`
  - `artifact-language`
- required-for:
  - `02-concept-extraction`

### root-idea-artifact

- kind: `idea-artifact`
- role: root source and visible status surface for a project pass
- required-frontmatter:
  - `interaction-language`
  - `artifact-language`
- may include:
  - relevant sub-ideas as source material
- required-for:
  - `02-concept-extraction`
  - `03-principle-synthesis`

### concept-artifact

- kind: `concept-artifact`
- produced-by: `concept-extraction-agent`
- required-frontmatter:
  - `interaction-language`
  - `artifact-language`
- publication-path: `ideas/<...>/<root-idea-id>/<root-idea-id>-concepts.md`
- linked-from-root-idea: `Development Artifacts`
- source-scope:
  - root idea artifact
  - relevant sub-ideas that belong to the same project
- required-for:
  - `03-principle-synthesis`

### principle-artifact

- kind: `principle-artifact`
- produced-by: `principle-synthesis-agent`
- required-frontmatter:
  - `interaction-language`
  - `artifact-language`
- publication-path: `ideas/<...>/<root-idea-id>/<root-idea-id>-principles.md`
- linked-from-root-idea: `Development Artifacts`
- source-scope:
  - root idea artifact
  - concept artifact formed for the root idea
  - relevant sub-ideas that belong to the same project
- derived-from:
  - `root-idea-artifact`
  - `concept-artifact`
- role-in-system:
  - result of the first complete pass through the basic flow of the idea machine
  - principle layer that can guide future proposal, design, spec, validation, or research stages
