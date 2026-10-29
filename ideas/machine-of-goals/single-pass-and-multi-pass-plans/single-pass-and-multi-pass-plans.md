---
id: single-pass-and-multi-pass-plans
kind: mini-idea-artifact
status: release-candidate
produced-by: machine-of-ideas/idea-capture-agent
interaction-language: Russian
artifact-language: English
parent-idea:
  id: machine-of-goals
  artifact: ../machine-of-goals.md
integration-targets:
  concepts: ../machine-of-goals-concepts.md
  principles: ../machine-of-goals-principles.md
derived-from:
  - user observation on 2026-08-26
  - ideas/styles/styles.md
---

<a id="single-pass-and-multi-pass-plans"></a>

# Mini-Idea: One-Time and Repeated Plan Execution

## 1. Summary

A plan model can guide one execution or be reused for further executions. Reuse does not depend on registering an automatic implementation: interactive execution can also produce a repeatable, documented example.

## 2. Main Idea Context

- Main idea: [Machine of Goals](../machine-of-goals.md#machine-of-goals).
- Related idea: [Styles](../../styles/styles.md).
- This clarification concerns the distinction between a reusable model and the facts of its execution within Machine of Goals.

## 3. Motivation

A person needs to understand the current stage, verify its conditions, and retain useful experience without navigating redundant registries and logs. Another person should be able to use the same model and compare their execution with a documented example.

## 4. Raw Description

### Model and Parallel Branches

The model describes the expected transition toward the goal. Independent approaches may coexist as named branches. Versions describe evolution within one branch; another version and another branch are distinct choices. Progress belongs to a concrete realization, not to the model.

### One-Time and Repeated Execution

A user may execute the model once or repeat it in another context. Each realization records its start time, selected branch and model version, current stage, and stage map. Stage records present input state, actions, and output state, together with the evidence supporting verification. Documentary evidence is offered first; an explicit user statement can provide the recorded basis when documents are unavailable.

The same documented execution supports both verification and readable walkthroughs. Publication requires preparing copies with personal data removed. Sharing may include only the goal and model or also selected execution experience.

### Evolution and Retained Experience

A model change ends the current realization. A linked successor uses the changed model and may inherit unchanged stages after checking their dependencies, input conditions, and applicability. Inherited records keep their origin. Cleanup is a separate requested action and preserves the useful context of retained realizations.

### Optional Collapse

On request, an executed model and its walkthrough may be collapsed into a skill for an AI agent, an automated action, or a combination of both. This capability does not determine whether interactive execution may be repeated. The result retains its relationship to the goal, branch, model version, and documentation. Invoking the resulting skill/action creates no additional Machine of Goals execution directory, snapshot or journal; its state checks and authorized boundaries still apply.

## 5. Key Points

- Reusability belongs to the model and retained experience; automation is optional.
- Branches distinguish independent approaches; versions distinguish evolution.
- Concrete progress and evidence belong to realizations and their stages.
- Input conditions are checked before action; output conditions are checked before completion.
- Minimal records should serve verification and readable documentation together.
- Changes create successors without rewriting previous execution facts.

## 6. Main Idea Impact

- Concept impact: plan model, branch, branch-local version, realization, stage evidence, succession, shared experience, and optional collapse.
- Principle impact: separate models from progress, verify transitions, preserve provenance, and prepare safe publication copies.
- Parent impact: the current model and documented-execution sections in the defining idea, concepts, and principles.
- Semantic mismatch with the main idea: none.
- The earlier automatic-registration-based single-pass/multi-pass distinction is superseded for this idea by the model and realization distinction. The operating contract follows the same distinction; there is no separate legacy execution scheme or computed plan style.

## 7. Open Questions

No unresolved questions block the documented interactive-execution model. Detailed contracts for collapse and publication remain outside this clarification.

## 8. Boundaries / Non-Goals

This clarification does not prescribe a collapse workflow, executable implementation, publishing platform, or automatic cleanup. It does not require separate registration, execution-index or evidence-manifest artifacts for interactive execution.

## 9. Parent Integration

- Parent concept integration: `[completed]`.
- Parent principle integration: `[completed]`.
- Parent artifacts: [idea](../machine-of-goals.md#machine-of-goals), [concepts](../machine-of-goals-concepts.md), and [principles](../machine-of-goals-principles.md).
- The existing artifact path and ID remain stable for incoming references.
