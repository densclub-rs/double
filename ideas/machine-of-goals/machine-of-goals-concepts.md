---
id: machine-of-goals-concepts
kind: concept-artifact
mindmap-plugin: basic
produced-by: machine-of-ideas/concept-extraction-agent
interaction-language: English
artifact-language: English
publication-path: ideas/machine-of-goals/machine-of-goals-concepts.md
derived-from:
  - machine-of-goals
  - ideas/machine-of-ideas/machine-of-ideas-concepts.md
---

# Concept Artifact: Machine of Goals

Idea: [Machine of Goals](./machine-of-goals.md#machine-of-goals)

## 1. Conceptual Summary

`Machine of Goals` describes a system for moving from intention to verifiable achievement. Its central conceptual pattern is this: a goal is defined as a verifiable target state; then possible paths, plans, algorithms, execution modes, and forms for collapsing the plan into an automatic mechanism are built around it.

As a specialized machine within Double, `Machine of Goals` realizes all foundational concepts defined by the [`Machine of Ideas` concept artifact](../machine-of-ideas/machine-of-ideas-concepts.md). Its goal-specific concepts extend that common conceptual foundation rather than replace it.

The idea rests on a distinction between several levels: a goal is not the same as a plan, a plan is not the same as an algorithm, an algorithm is not the same as automatic execution, and automatic execution does not cancel explanation, control, or the possibility of interactive review. This makes Machine of Goals not merely a task manager, but a machine for transforming a goal into a controllable structure of action.

## 2. Working Definition of Concept

A concept is a stable semantic unit of an idea.
It may describe an entity, relation, process, distinction, tension, or interpretive frame.
At this stage, a concept is not yet a principle, requirement, task, or design decision.

## 3. Core Concepts

<a id="concept-goal-as-verifiable-target-state"></a>

### concept-goal-as-verifiable-target-state: Goal as Verifiable Target State

#### Definition

A goal is a desired state that can be described clearly enough and then verified by comparing the result with the original specification. The necessary level of formality for this specification depends on the type of goal and should be determined during the design of the goal itself: software, personal, social, and research goals may require different forms of description, verification, and proof of achievement.

#### Source in Idea

- Explicit in sections `Summary`, `Raw Description`, and `Assumptions`.
- The idea repeatedly defines a goal as a verifiable target state reached through plan execution.

#### Role in the Idea

This concept sets the foundation for the whole machine: if a goal cannot be represented as a verifiable state, it is difficult to turn it into a path, plan, algorithm, and completion criterion.

#### Related Concepts

- Other relations: [`concept-initial-state-and-target-state`](#concept-initial-state-and-target-state): defines the transition within which the goal becomes achievable.
- Other relations: [`concept-success-criteria`](#concept-success-criteria): makes goal verification operationally meaningful.
- Other relations: [`concept-plan-as-transition-model`](#concept-plan-as-transition-model): describes the way of moving toward the target state.

#### Boundaries

- This is not motivation by itself.
- This is not a task list.
- This is not a guarantee of achievability: a goal may be verifiable while still lacking a realistic plan.
- This is not a universally identical formal specification for all goals: Machine of Goals should help choose a sufficient degree of formality for the goal type, verification context, and future possibility of planning.

#### Questions

- [x] How formal should the target-state specification be for different types of goals: software, personal, social, and research goals?

<a id="concept-initial-state-and-target-state"></a>

### concept-initial-state-and-target-state: Initial State and Target State

#### Definition

The pair of states through which a goal becomes a transition: from the subject's current position to the desired verifiable result. The initial state may be explicitly described in the goal artifact or remain implicit if it is reliably enough determined by the current context of the subject, environment, or already achieved goals.

#### Source in Idea

- Explicit in `Key Elements` and `Assumptions`.
- Inferred from the repeated description of plan execution as movement from input point to output point.

#### Role in the Idea

This concept helps separate the formulation of a wish from the model of change. The machine of goals should understand not only "where to arrive", but also "where the movement begins". At the same time, understanding the starting point does not always require a complete explicit description: for some goals, the current state of software on a PC or smartphone, the state of a working project, or the state of the subject recoverable from already achieved and realized goals may serve as context.

#### Related Concepts

- Other relations: [`concept-goal-as-verifiable-target-state`](#concept-goal-as-verifiable-target-state): the target state is the verifiable expression of the goal.
- Other relations: [`concept-plan-as-transition-model`](#concept-plan-as-transition-model): the plan connects the initial and target states.
- Other relations: [`concept-subgoal-and-partial-achievement`](#concept-subgoal-and-partial-achievement): intermediate states appear inside the transition.

#### Boundaries

- This is not a complete plan.
- This is not a success metric by itself.
- The initial state may be incomplete or clarified during the work.
- An implicit initial state is acceptable only when it is sufficiently clear from context and does not interfere with goal verification, path selection, or plan construction.
- If the plan depends on hidden assumptions about the environment, subject, or previous goals, the initial state should be explicitly reconstructed before algorithmization or automatic execution.

#### Questions

- [x] Should Machine of Goals always explicitly fix the initial state, or may it be left implicit for some goals?

<a id="concept-success-criteria"></a>

### concept-success-criteria: Success Criteria

#### Definition

Criteria by which one can judge whether the goal has been achieved, partially achieved, not achieved, or requires review.

#### Source in Idea

- Explicit in `Summary`, `Problem / Motivation`, `Raw Description`, and `Key Elements`.

#### Role in the Idea

Success criteria transform a goal from a declaration into a verifiable artifact. Without them, it is impossible to honestly complete a plan or compare variants of achievement. The user of the machine of goals should themselves identify the verifiable result that will serve as the defining criterion of success. For a software environment, this may be verification that some program can run. For a social environment, this may be a photo of a document confirming the achieved result.

#### Related Concepts

- Other relations: [`concept-goal-as-verifiable-target-state`](#concept-goal-as-verifiable-target-state): criteria make the state verifiable.
- Other relations: [`concept-plan-explanation-and-control`](#concept-plan-explanation-and-control): plan explanation shows which checks are mandatory.
- Other relations: [`concept-plan-cost-and-efficiency`](#concept-plan-cost-and-efficiency): success criteria are needed to compare cost and result.

#### Boundaries

- This is not motivation.
- This is not the whole set of constraints.
- Success criteria do not have to be numeric, but they should be sufficiently verifiable.
- For a software environment, a success criterion may be verification that a program can run, or a screenshot showing the achieved result.
- For a social environment, a success criterion may be a scan of a document confirming the achieved result.
- The user of the machine of goals defines the meaningful success criteria, which should be determined both at the level of the goal description and at the level of exits from the goal realization plan.
- Exiting the goal realization plan is possible only when the defined success criteria have been realized.

#### Questions

- [x] How should minimal achievement criteria be distinguished from high-quality-result criteria?

<a id="concept-realization-path"></a>

### concept-realization-path: Realization Path

#### Definition

A possible way to approach the goal before choosing a concrete plan: direct, workaround, research-oriented, minimal, long-term, through learning, delegation, a tool, or automation. The possibility of using ready-made goal realization plans. The possibility of comparing the estimated cost of realization plans. All discovered paths are preserved until the goal is achieved. After the goal is achieved, the user is offered the option to delete and forget unrealized paths, or keep them for the future as drafts.

#### Source in Idea

- Explicit in `Raw Description`, `Problem / Motivation`, and `Examples / Scenarios`.

#### Role in the Idea

A path sits between a goal and a plan. It makes it possible to first see different achievement strategies and then synthesize one or more concrete plans.

#### Related Concepts

- Other relations: [`concept-plan-as-transition-model`](#concept-plan-as-transition-model): a selected path is developed into a concrete plan.
- Other relations: [`concept-success-criteria`](#concept-success-criteria): paths remain comparable against the result the goal must verify.
- Other relations: [`concept-plan-cost-and-efficiency`](#concept-plan-cost-and-efficiency): paths are compared through expected cost, risk, and applicability.

#### Boundaries

- A path is not a detailed plan.
- A path does not guarantee goal achievement.
- A path should not prematurely become an architectural decision.
- Paths are stored until the goal is achieved.
- Unrealized paths may remain in drafts or be deleted at the person's request.

#### Questions

- [x] Should rejected paths be stored as a separate artifact in order to preserve the history of strategy selection?

<a id="concept-plan-as-transition-model"></a>

### concept-plan-as-transition-model: Plan as Transition Model

#### Definition

A plan is a connected model of transition from the initial state to the target or intermediate achievable state, including steps, dependencies, resources, checks, risks, and review points. Conceptually, a plan can be understood as a graph of transitions: it may be incomplete or imprecise, but it should connect some initial state with the target state through possible stages, subgoals, or paths.

#### Source in Idea

- Explicit in `Raw Description`, `Key Elements`, `Assumptions`, and `Examples / Scenarios`.

#### Role in the Idea

The plan is the main bridge between goal formulation and executable action. It turns the selected path into a structure that can be explained, checked, changed, and potentially automated. The minimal conceptual contract for moving to realization is the understandability of the plan: the subject or executing agent should understand how the plan connects the initial state with the target one, even if some stages will still be clarified during execution.

#### Related Concepts

- Other relations: [`concept-initial-state-and-target-state`](#concept-initial-state-and-target-state): the plan connects these states.
- Other relations: [`concept-subgoal-and-partial-achievement`](#concept-subgoal-and-partial-achievement): subgoals define intermediate sections of the plan.
- Other relations: [`concept-interactive-and-automatic-execution`](#concept-interactive-and-automatic-execution): automation becomes possible only after sufficient structuring of the plan.

#### Boundaries

- A plan is not merely a list of tasks.
- A plan is not equal to an algorithm until transitions, checks, and controlled parameters are described.
- A plan does not have to be fully automatable.
- A plan does not have to be complete or finally precise before realization begins, if it is understandable enough for controlled movement from the initial state to the target state.
- A plan is not an immutable construction: during execution, stages may appear or disappear, new paths to the goal may open, or new subgoals may arise.

#### Questions

- [x] What minimal contract should a plan have in order to be considered ready for the transition to algorithmization?

<a id="concept-subgoal-and-partial-achievement"></a>

### concept-subgoal-and-partial-achievement: Subgoal and Partial Achievement

#### Definition

Intermediate verifiable states inside a larger transition toward the goal, which may have their own inputs, outputs, completion criteria, and nested artifacts. A subgoal is better represented as a separate catalog that stores its own subplan.

#### Source in Idea

- Explicit in `Raw Description`, `Key Elements`, `Assumptions`, and storage layout notes.

#### Role in the Idea

This concept allows Machine of Goals to work with goals that cannot be achieved by one linear action. It also connects the logical decomposition of a goal with the file structure of Double. A subgoal and its subplan may become parts of other goals if those goals include similar repeated subgoals, such as determining the operating system or creating a working catalog for the goal.

#### Related Concepts

- Other relations: [`concept-plan-as-transition-model`](#concept-plan-as-transition-model): subgoals are parts of the plan.
- Other relations: [`concept-initial-state-and-target-state`](#concept-initial-state-and-target-state): each subgoal may have its own states.
- Other relations: [`concept-goal-artifact-context`](#concept-goal-artifact-context): subgoals may be nested catalogs.

#### Boundaries

- A subgoal is not an arbitrary task.
- Partial achievement should not hide non-achievement of the original goal.
- A subgoal does not necessarily require a separate full pass through Machine of Goals, but it should have its own catalog and subplan if it becomes a stable part of the achievement graph.
- A repeatable subgoal should not turn into a detached universal plan: it is transferred together with its purpose, inputs, outputs, and connection to the parent goal.

#### Questions

- [x] When should a subgoal become a separate catalog, and when should it remain part of the plan?

<a id="concept-plan-cost-and-efficiency"></a>

### concept-plan-cost-and-efficiency: Plan Cost and Efficiency

#### Definition

An estimate of the cost of executing a plan or its stages through measurable execution indicators and domain-specific costs, as well as a comparison of this cost with the expected result. General stage-cost criteria may include a counter of successful realizations, execution time for the stage, and number of errors during stage execution; the remaining criteria are clarified while working with concrete plans.

#### Source in Idea

- Explicit in `Raw Description`, `Key Elements`, and `Assumptions`.

#### Role in the Idea

Cost and efficiency make plans comparable. Without this, Machine of Goals could generate plans, but would not help choose between them. Basic execution metrics make it possible to accumulate experience across plan stages and, over time, evaluate which stages are performed reliably, quickly, or with a large number of errors.

#### Related Concepts

- Other relations: [`concept-realization-path`](#concept-realization-path): paths and the plans derived from them can be compared by cost and efficiency.
- Other relations: [`concept-success-criteria`](#concept-success-criteria): efficiency requires an understanding of the result.
- Other relations: [`concept-plan-as-transition-model`](#concept-plan-as-transition-model): plan selection relies on cost and risk.

#### Boundaries

- Cost is not reducible to money.
- Efficiency is not equal to maximum automation.
- Low cost does not always mean the best plan.
- Mandatory general metrics should not exhaust the cost of a plan: domain-specific cost criteria are clarified as work with plans proceeds.
- A counter of successful stage realizations is not a guarantee that the stage is applicable to any other goal, because the plan and subgoals preserve their connection to the goal context.

#### Questions

- [x] Which types of cost should be mandatory in every plan, and which depend on the goal domain?

<a id="concept-plan-algorithmization"></a>

### concept-plan-algorithmization: Plan Algorithmization

#### Definition

Transformation of a sufficiently clear plan into an achievement algorithm: a sequence of actions, transitions, checks, parameters, stops, and review conditions. The boundary between plan and algorithm passes like the boundary between a project and the realization of a project: the plan describes the intention of achieving the goal, while the algorithm is the realized form of this intention in the working catalog.

#### Source in Idea

- Explicit in `Summary`, `Problem / Motivation`, `Raw Description`, and `Assumptions`.

#### Role in the Idea

Algorithmization is the transition from planning to controlled execution. It does not necessarily create a program, but it makes the plan formal enough for explanation, interactive launch, or further collapsing. The realization of the algorithm should have a working catalog: this may be a separate Git repository with source code, a catalog for generating a site from the plan realization, or another working catalog appropriate to the type of goal.

#### Related Concepts

- Other relations: [`concept-plan-as-transition-model`](#concept-plan-as-transition-model): the algorithm emerges from a structured plan.
- Other relations: [`concept-plan-explanation-and-control`](#concept-plan-explanation-and-control): the algorithm should remain explainable and controllable.
- Other relations: [`concept-executable-collapsed-plan`](#concept-executable-collapsed-plan): some algorithms can be collapsed into executable form.

#### Boundaries

- Algorithmization does not mean arbitrary code generation.
- The algorithm does not cancel human decision-making at choice points.
- Not all goals should be fully algorithmizable.
- A plan is not an algorithm by itself: the plan remains the project of achievement, while the algorithm is the realization of this project.
- The realization of an algorithm should not be contextless: the working catalog of realization should be defined in the goal and in the plan.

#### Questions

- [x] Where is the boundary between a sufficiently explainable plan and a real achievement algorithm?

<a id="concept-plan-explanation-and-control"></a>

### concept-plan-explanation-and-control: Plan Explanation and Control

#### Definition

A mechanism that shows which steps are performed, why they were chosen, which parameters are controlled, where checks, stop points, and opportunities for review are located. Before automatic or agentic execution, the user can request `dry run` mode: the agent begins an explainable pass through a plan stage without real actions.

#### Source in Idea

- Explicit in `Raw Description`, `Assumptions`, and `Signals of Value`.

#### Role in the Idea

This concept keeps Machine of Goals away from blind automation. A plan should be not only executable, but also understandable, stoppable, and changeable. In the explanation before execution, the agent should name the plan stage it is going to execute, explain why that stage was selected, report on already completed stages and their state, and then, based on that state, explain the further choice of path through the plan graph.

#### Related Concepts

- Other relations: [`concept-plan-algorithmization`](#concept-plan-algorithmization): the algorithm should preserve explainability.
- Other relations: [`concept-interactive-and-automatic-execution`](#concept-interactive-and-automatic-execution): control defines execution modes.
- Other relations: [`concept-success-criteria`](#concept-success-criteria): checks connect execution with the goal.

#### Boundaries

- Plan explanation is not complete system documentation.
- Control does not mean manual execution of every step.
- Stop points should not turn every plan into endless approval.
- `Dry run` is not real plan execution: it serves to check understandability, next-stage selection, and the agent's expected behavior before irreversible actions are taken.
- Explanation of the next step should not be detached from execution history: the choice of path through the plan graph should take into account the state of already completed stages.

#### Questions

- [x] Which explanation elements should be mandatory before launching an automatically executable plan?

<a id="concept-interactive-and-automatic-execution"></a>

### concept-interactive-and-automatic-execution: Interactive and Automatic Execution

#### Definition

The range of plan execution modes: fully manual, interactive by stages, partially automatic, or fully automatic where this is acceptable. Machine of Goals should strive toward automatic plan execution, but the boundaries of automation are chosen by the user each time.

#### Source in Idea

- Explicit in `Raw Description`, `Assumptions`, and `Examples / Scenarios`.

#### Role in the Idea

This concept shows that Machine of Goals does not have to choose between human and automaton. Execution can change its degree of automation depending on risk, clarity, domain, and user control. Before execution, the machine should ask which plan items to execute automatically: up to a specific stage, according to a specified list of stages, or in a fully controlled mode with full explanation.

#### Related Concepts

- Other relations: [`concept-plan-explanation-and-control`](#concept-plan-explanation-and-control): control defines safe execution modes.
- Other relations: [`concept-executable-collapsed-plan`](#concept-executable-collapsed-plan): the automatic form is the limiting case of execution.
- Other relations: [`concept-plan-algorithmization`](#concept-plan-algorithmization): the algorithm makes execution controllable.

#### Boundaries

- Automatic execution is not the mandatory endpoint of every goal.
- Interactive execution does not mean absence of an algorithm.
- Manual execution does not make a plan less valuable if the goal is hard to automate.
- The drive toward automation does not cancel user control: the machine should not decide by itself which plan items to execute automatically without user confirmation.
- Fully controlled execution remains an acceptable mode even when the plan can technically be automated.

#### Questions

- [x] How should Machine of Goals choose or propose an acceptable execution mode for a concrete plan?

<a id="concept-executable-collapsed-plan"></a>

### concept-executable-collapsed-plan: Executable Collapsed Plan

#### Definition

A collapsed form of the plan suitable for automatic execution, handoff into design, or publication as a workflow, agentic execution scenario, script, CLI command, SDD specification, Markdown artifact with export capability, or another mechanism. The primary format of a collapsed plan depends on the type of goal: for goals in a computational environment, scripts may be a natural form; for design goals, SDD; for social goals, Markdown with the possibility of export to a website or another readable external format.

#### Source in Idea

- Explicit in `Summary`, `Raw Description`, `Assumptions`, and `Signals of Value`.

#### Role in the Idea

This is one of the central concepts of Machine of Goals: the most valuable plans can become reusable mechanisms of action inside Double.

#### Related Concepts

- Other relations: [`concept-plan-algorithmization`](#concept-plan-algorithmization): collapsing requires algorithmic form.
- Other relations: [`concept-plan-explanation-and-control`](#concept-plan-explanation-and-control): a collapsed plan should remain explainable and stoppable.
- Other relations: [`concept-plan-exchange`](#concept-plan-exchange): collapsed plans become suitable for exchange.

#### Boundaries

- This is not arbitrary code generation.
- This is not the whole goal achievement plan if human decisions remain outside the automatable part.
- A collapsed plan should not hide assumptions, constraints, and risks.
- Double should not have a single universal primary format for collapsed plans across all goal types: the format should be chosen according to the achievement environment, verification method, and expected form of result usage.

#### Questions

- [x] Which collapsed-plan formats should be considered primary for Double: Markdown workflow, agent runbook, CLI script, SDD spec, or another format?

<a id="concept-plan-exchange"></a>

### concept-plan-exchange: Plan Exchange

#### Definition

Exchange of successful collapsed or semi-automatic plans inside the Double ecosystem for reuse, adaptation, and improvement in the context of corresponding goals. A plan is always connected to a goal and can be used only as part of achieving the stated goal; it is not an independent artifact with an arbitrary other context.

#### Source in Idea

- Explicit in `Raw Description` and `Signals of Value`.
- The source idea names exchange of automatic plans as one of the central ideas.

#### Role in the Idea

This concept expands Machine of Goals from individual planning to ecosystem value: successful ways of achievement can become reusable together with the goal statement, initial conditions, and verification context. What is transferred is not a "bare plan", but the bundle of goal and plan.

#### Related Concepts

- Other relations: [`concept-executable-collapsed-plan`](#concept-executable-collapsed-plan): exchange is especially valuable for collapsed plans.
- Other relations: [`concept-goal-artifact-context`](#concept-goal-artifact-context): exchange requires a clear storage structure.
- Other relations: [`concept-plan-cost-and-efficiency`](#concept-plan-cost-and-efficiency): reuse can reduce the cost of achieving similar goals.

#### Boundaries

- Exchanging plans does not mean the plan is universal for every situation.
- Reuse should not detach the plan from the goal for which it was built.
- Reuse requires adapting the goal, initial state, constraints, and resources, not only copying the plan steps.
- This concept does not yet define a marketplace or social model of exchange.

#### Questions

- [x] What metadata does a plan need in order to be safely reused in another context?

<a id="concept-goal-artifact-context"></a>

### concept-goal-artifact-context: Goal Artifact Context

#### Definition

The file and semantic context of a goal inside Double: the goal catalog, main Markdown file, separate plan file, realization working catalog, explanations, parameters, checks, executable algorithms, and nested subgoals. The main goal artifact should use the same base name as the goal directory, for example `my-first-goal/my-first-goal.md`. The plan should be stored as a separate `plan.md` file in the goal catalog. The realization working catalog should be defined both in the goal and in the plan.

#### Source in Idea

- Explicit in `Key Elements`, `Assumptions`, and `Notes`.

#### Role in the Idea

This concept connects thinking about goals with reproducible artifact storage. A goal becomes not only an intention, but also a working catalog where related materials are preserved. A separate plan file makes the transition from goal to realization explicit and allows the plan to develop without rewriting the main goal artifact. The realization working catalog connects the plan with the place where the algorithm appears: a Git repository, a site generation catalog, or another working environment.

#### Related Concepts

- Other relations: [`concept-subgoal-and-partial-achievement`](#concept-subgoal-and-partial-achievement): subgoals may be nested catalogs.
- Other relations: [`concept-plan-exchange`](#concept-plan-exchange): plan portability depends on the artifact structure.
- Other relations: [`concept-executable-collapsed-plan`](#concept-executable-collapsed-plan): executable forms remain next to the goal.

#### Boundaries

- The artifact context is not the Machine of Goals workflow itself.
- The catalog does not replace the conceptual model of the goal.
- Markdown storage by itself does not solve verification, execution, or automation.
- The plan should not be hidden only inside the main goal file: it needs a separate file in the goal catalog.
- The realization working catalog does not replace the goal catalog: the goal catalog stores semantic artifacts, while the realization working catalog contains the executable or publishable form of the algorithm.

#### Questions

- [x] Should plans, explanations, parameters, and checks be separate files with fixed names or a flexible set of artifacts inside the goal catalog?

## 4. Terms and Non-Concepts

- `Goal Capture`: the name of an early workflow stage, not an independent key concept in this artifact.
- `Path Discovery`: the name of a stage that operationalizes the `Realization Path` concept.
- `Plan Synthesis`: the name of a stage that operationalizes the `Plan as Transition Model` concept.
- `Plan Automation`: the name of a stage that operationalizes the `Plan Algorithmization` and `Executable Collapsed Plan` concepts.
- `double/goals`: the proposed storage location; an important structural term, but conceptually it is covered by `Goal Artifact Context`.
- `SDD`: a reference to an external methodology; an important compatibility goal and possible primary format of a collapsed plan for design goals, but not yet an internal key concept of Machine of Goals.
- `CLI`, `workflow`, `script`, `agent process`, `template`, `integration`: possible forms of collapsed execution, not separate concepts at this stage.
- `resources`, `risks`, `dependencies`, `parameters`, `checks`: important plan attributes that are currently treated as components of `Plan as Transition Model` and `Plan Explanation and Control`.

## 5. Candidate Inputs for Principle Synthesis

- A goal should be formulated as a verifiable state, not only as an intention.
- The level of formality of the target state should be determined during goal design and depend on the type of goal, verification context, and subsequent planability.
- The plan should preserve its connection to the initial state, target state, and success criteria.
- A plan may be represented as a graph of transitions from the initial state to the target state; it may be incomplete or imprecise, but it should preserve an understandable connection between these states.
- The understandability of the plan is the minimal conceptual contract for moving to realization: the plan should be clear enough to the subject or executing agent to begin controlled execution and clarify it along the way.
- The machine should first distinguish paths of achievement and only then synthesize plans.
- The plan should be explainable before execution, especially before automation.
- Before automatic or agentic execution, the user should be able to request `dry run`, in which the agent explains the next stage without real actions.
- Mandatory explanation before execution should include the selected stage, the reason for selection, the state of already completed stages, and the justification for the further path through the plan graph.
- Automation should be a degree of execution, not the mandatory destiny of every goal.
- Machine of Goals should strive toward automatic plan execution, but should ask the user each time which items to execute automatically: up to a specified stage, by a list of stages, or in a fully controlled mode.
- A collapsed plan should preserve assumptions, constraints, controlled parameters, and stop points.
- The primary format of a collapsed plan should depend on the type of goal: scripts for a computational environment, SDD for design, Markdown with export capability for social goals, and other formats for other domains.
- Reusable plans should not be separated from the goal: what is portable is the bundle of goal, initial state, success criteria, and plan, not the plan as an independent universal mechanism.
- The goal storage structure should support goals, plans, subgoals, checks, explanations, and executable forms in one working context.
- The plan should be a separate `plan.md` file in the goal catalog.
- A subgoal should have a separate catalog and its own subplan, especially if it is a repeatable fragment of achieving different goals.
- General metrics of plan-stage cost: a counter of successful realizations, execution time, and number of errors; the remaining cost criteria should be clarified during work with plans.
- The goal and the plan should define the realization working catalog where the plan algorithm is embodied as code, a site, an executable workflow, or another working form.
