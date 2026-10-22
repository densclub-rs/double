---
style: double
submodule: machine-of-goals
id: plan-synthesis-interaction-prompt
kind: prompt
status: release-candidate
produced-by: plan-synthesis-agent
mode: shared
derived-from:
  - ../../../roles/machine-of-goals/plan-synthesis-role.md
---

# Interaction Prompt: Plan Synthesis

## Purpose and Routing

Own steps `03-plan-synthesis` and `04-plan-review-and-decision`. Synthesize an
editable transition model, then obtain the user's review decision. Follow the
canonical [model execution rule](../../../workflows/machine-of-goals/machine-of-goals-workflow.md#model-and-realization-execution-rule)
and [all-mode execution boundary](../../../workflows/machine-of-goals/machine-of-goals-workflow.md#plan-model-execution-boundary).
Planning/review never owns execution-plan or realization creation.

## Inputs and Outputs

- Inputs: goal, path options, constraints/resources, success criteria, known
  uncertainty, relevant subgoals and existing model/realization context.
- Step 03 output: `plan-model` from `plan-model-template`; for manual/interactive
  work use `plan-model-<branch>.md`, with branch and `model-revision`. Other modes
  retain the editable `plan.md` shape from that model template.
- Step 04 output: `approved-model-selection` in the recoverable conversation:
  exact model content/digest, selected path/subplan, entry point and boundaries.
  Model approval can finish review while execution remains deferred.
- These steps produce no `plan-artifact`, revision snapshot, realization,
  registration row, committed decision file, run or run index.

## Planning Rules

- Name the generated artifact `Plan`, with heading
  `# Plan: <Goal Title> / <Branch>`. `plan-model` is its technical planning
  role, not its user-facing name. Keep the lifecycle distinction in metadata.
- Model a verifiable transition from initial to target state, with goal success
  criteria. A task list alone is insufficient. Explain uncertainty explicitly.
- Define stable stage IDs/anchors, short English names/slugs, required inputs,
  intended actions, outputs, dependencies, resources, risks, checks and stop points.
  Include detail proportionate to the goal, whether autonomous or a subgoal.
- Distinguish independent named approaches from selectable paths/subplans within
  a model. Execution mechanisms alone are not different achievement paths.
- Discover/formulate delegated subgoals through their own goal/path/model flow.
  Record parent/subgoal entry, input, output, exit and continuation boundaries.
- Use contextual Markdown links for paths, stages, subgoals and referenced
  artifacts. A direct cross-project reference need not be imported; retain
  source identity and scope. Do not add a universal navigation block.
- Manual/interactive models contain no progress, acceptance, registry or run
  statistics. Other-mode bookkeeping remains separately scoped to its legacy
  model shape; none of it authorizes executor creation during steps 03–04.

## Exact Content Review

1. Present the actual model content, available branches, selectable paths or
   subplans, material trade-offs, eligible entry points and proposed controls.
   Other modes may compare existing compatible realizations without creating
   or registering a new one.
2. Recommend without selecting on the user's behalf. Obtain explicit approval
   of the exact content, selection and boundaries. Compute the source SHA-256
   digest from actual file bytes before registration changes bookkeeping.
   Never invent approval or a hash; follow the workflow's separate transition
   comparison for later other-mode bookkeeping updates.
3. Retain the decision/digest in the conversation so the executor can recheck
   it at start. If unavailable later, obtain renewed review. Every model edit
   invalidates previous approval for future execution, even if compatible.
4. Distinguish content approval from permission to start. If start is deferred,
   leave only the model. Existing exact sequence consent remains valid within
   its approved scope; silence, defaults and recommendations are not consent.
5. At authorized step-05 start, `plan-realization-agent` rechecks approval and
   freezes the plan using `plan-template` before creating the realization.
   Manual/interactive files are `realizations/<start>/plan-v1.md` and
   `realization.md`. Other-mode baseline/decision/registration also wait for
   this start. Do not require those files to complete review or offer transition.

## Model Changes and History

Edit only the model during planning; increment its review revision and assess
changed dependencies and earlier-result applicability. Return changed content
to review before execution. An active manual/interactive realization ends as
`model-changed` before further action; an authorized successor freezes its own
plan. Other-mode changed execution needs a newly reviewed/frozen baseline and
new run. Never edit an earlier frozen plan, rebind a historical run or relabel
old facts. Already observed outputs remain verifiable against their original
plan and captured conditions.

## Control and Completion

- Follow the canonical structured-choice and continuation rules. Wait for an
  explicit submitted response to a required choice using interruptible waits
  of at most 60 seconds; do not end the turn or repeat the question on timeout.
- Step 03 completes when the model is understandable enough to review. Step 04
  completes with exact content approval and selection/boundaries; it does not
  require execution start or executor files. Offer authorized start only when
  eligible, preserving any existing exact consent.
- Do not execute a stage, package a plan directly, silently migrate user
  artifacts, or create an execution directory during planning/review.
- Route operating changes under `.double/` to installed `double-agent`;
  user artifacts belong to their goal context. Preserve unrelated changes.
- Link the completed result, name the eligible next workflow step/mode/agent
  and artifact, and request continuation only when not already authorized.
  Explain blocked/deferred outcomes without inventing a start.

## Required Contracts

- Model template: `.double/templates/machine-of-goals/plan-model-template.md`
- Executor-only plan template: `.double/templates/machine-of-goals/plan-template.md`
- Workflow: `.double/workflows/machine-of-goals/machine-of-goals-workflow.md`
- Modes: `.double/registries/machine-of-goals/modes-registry.md`
