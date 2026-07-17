---
style: double
submodule: machine-of-ideas
name: machine-of-ideas
description: >
  Use this skill when the user clearly wants to capture, develop, inspect, continue, or advance an idea through the Machine of Ideas. Trigger on direct
  requests such as "I have an idea", "let's work on an idea", "run machine of ideas", "I've catch it, let's go", or when the user
  asks to continue an existing idea artifact. Also trigger when the user asks to work on an idea clarification, sub-idea, mini-idea, `уточнение идеи`, `подидея`, `мини-идея`, or `миниидея`. Trigger and route to `double-agent` when the user asks to create, change, move, or remove Machine of Ideas operating artifacts under `.double/`. Do not trigger on casual mentions of ideas inside unrelated technical discussion unless the user asks to enter the idea workflow.
metadata:
  short-description: Formalize individual experience in working with ideas, knowledge, and system design into a reproducible process
  workflow-version: 0.2.1
---

# Machine of Ideas

This skill is an integration entry point for AI agents that can read local project instructions. It connects user intent to the operational materials in `.double/`.

The skill does not replace the workflow. The canonical process is defined in:

- `.double/workflows/machine-of-ideas/machine-of-ideas-workflow.md`

## Activation Rule

Activate this skill when the user clearly wants to work with the Machine of Ideas, including:

- capturing a new idea
- capturing a clarification of an existing idea as a mini-idea
- working on a sub-idea or mini-idea
- continuing an existing idea
- extracting concepts from an idea
- synthesizing principles from an idea or concept artifact
- inspecting the current state of an idea in the workflow
- asking what the next useful step is for an idea

If the user's intent is only weakly implied, offer activation instead of silently entering the workflow.

Requests to work on an idea clarification, sub-idea, or mini-idea should route to `01-idea-capture` with `.double/templates/machine-of-ideas/mini-idea-template.md`, after confirming the parent idea.

## Machine Operating Change Routing

Before normal workflow entry, detect whether the request creates, changes,
moves, or removes a Machine of Ideas operating artifact under `.double/`.

If it does:

1. Activate `double-agent`.
2. Load `.double/agents/double-agent/double-agent.md`.
3. Load `.double/roles/double-agent/machine-artifact-maintainer-role.md`.
4. Follow its read-only inspection, planning, versioning, validation, and
   explicit per-artifact approval protocol.
5. Do not route the operating-artifact change to a normal Machine of Ideas
   workflow agent.

If the request also changes a user artifact under `ideas/`, split that work
into a separate proposed step owned by the appropriate Machine of Ideas
workflow agent.

Example:

> I can treat this as a Machine of Ideas run and inspect the current idea state.
> Shall I start from the workflow entry protocol?

## Entry Protocol

When the skill is activated, follow the Entry Protocol from
`.double/workflows/machine-of-ideas/machine-of-ideas-workflow.md`.

The workflow file is the
canonical source for initialization, target confirmation, language selection,
mode selection, loading order, default state, transition rules, and proactive
continuation.

Before producing or changing workflow artifacts, make sure the canonical
workflow has confirmed:

- target idea, artifact, or idea directory
- current workflow step
- interaction language
- artifact language
- selected output template
- selected mode

## Loading Order

Use the Loading Order defined in
`.double/workflows/machine-of-ideas/machine-of-ideas-workflow.md`.

## Default State

Use the Default State defined in
`.double/workflows/machine-of-ideas/machine-of-ideas-workflow.md`.

## Proactive Continuation

Use the Proactive Continuation Rule defined in
`.double/workflows/machine-of-ideas/machine-of-ideas-workflow.md`.

## Boundaries

- This skill is a trigger and routing layer, not a separate workflow.
- The source of truth for process behavior remains the workflow file.
- The skill may offer activation when intent is ambiguous, but it should not
  silently edit or advance artifacts without confirming the idea target.
- Changes inside `.double/` are process changes.
- Changes inside `ideas/` are user artifact changes.
