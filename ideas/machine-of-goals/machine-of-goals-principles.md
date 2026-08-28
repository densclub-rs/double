---
id: machine-of-goals-principles
kind: principle-artifact
produced-by: machine-of-ideas/principle-synthesis-agent
interaction-language: English
artifact-language: English
publication-path: ideas/machine-of-goals/machine-of-goals-principles.md
derived-from:
  - machine-of-goals
  - machine-of-goals-concepts
---

# Principle Artifact: Machine of Goals

Idea: [Machine of Goals](./machine-of-goals.md#machine-of-goals)

## 1. Principle Synthesis Summary

Machine of Goals is built around a normative transition from intention to verifiable action. A goal should first become a verifiable target state, then be connected with the initial state through an understandable plan graph, and only after that move toward algorithmization, automation, or a collapsed executable form.

The main tension of the idea is that the machine should strive toward automatic execution of plans, but it should not turn into an opaque automaton. Therefore, automation is acceptable only while preserving understandability, explanation, dry run, user choice of execution boundaries, the connection between plan and goal, and the working context of realization.

## 2. Working Definition of Principle

A principle is a stable normative foundation derived from an idea and its conceptual structure.
It guides or constrains future decisions, but is not yet a requirement, task, design decision, implementation step, or generic value statement.

## 3. Core Principles

<a id="principle-goal-verifiability-before-planning"></a>

### principle-goal-verifiability-before-planning: Goal Verifiability Before Planning

#### Statement

Machine of Goals should begin with the goal as a verifiable target state, not with a set of tasks or wishes.

#### Derived From

- Source concept(s): [Goal as Verifiable Target State](./machine-of-goals-concepts.md#concept-goal-as-verifiable-target-state), [Success Criteria](./machine-of-goals-concepts.md#concept-success-criteria), [Initial State and Target State](./machine-of-goals-concepts.md#concept-initial-state-and-target-state)
- Source relationship, boundary, or tension: a goal becomes manageable only through comparison of the result with the original specification and success criteria
- Source idea support: `Summary`, `Raw Description`, `Assumptions`
- Explicit or inferred: explicit

#### Rationale

If a goal is not represented as a verifiable state, the machine cannot honestly build a path, compare plan variants, complete execution, or evaluate partial achievement. At the same time, the degree of specification formality should depend on the type of goal and be determined during goal design.

#### Implications Without Implementation

- Future stages should evaluate the goal through result verifiability.
- Success criteria should appear before choosing the final plan.
- The formality of the target state should be selected according to the goal domain, not imposed universally.
- The principle does not define the format of the goal specification.

#### Boundaries

- The principle does not require numeric metrics for all goals.
- The principle does not claim that every verifiable goal is achievable.
- The principle does not replace motivation, constraints, and the subject's context.

#### Anti-Patterns

- Starting with a task list without a target state.
- Automating actions before defining what counts as success.
- Requiring the same level of formal specification for software, personal, social, and research goals.

#### Questions

- None.

<a id="principle-plan-as-an-understandable-transition-graph"></a>

### principle-plan-as-an-understandable-transition-graph: Plan as an Understandable Transition Graph

#### Statement

A plan should be an understandable graph of transition from the initial state to the target state; it may be incomplete or imprecise, but it must preserve a meaningful connection between these states.

#### Derived From

- Source concept(s): [Plan as Transition Model](./machine-of-goals-concepts.md#concept-plan-as-transition-model), [Initial State and Target State](./machine-of-goals-concepts.md#concept-initial-state-and-target-state), [Subgoal and Partial Achievement](./machine-of-goals-concepts.md#concept-subgoal-and-partial-achievement)
- Source relationship, boundary, or tension: the plan is the bridge between goal and executable action, but is not equal to an algorithm
- Source idea support: `Raw Description`, `Assumptions`, `Examples / Scenarios`
- Explicit or inferred: explicit

#### Rationale

The understandability of the plan is the minimal contract for moving to realization. Without an understandable connection between the initial and target states, it is impossible to explain further movement, choose the next stage, verify achievement, or safely change the plan during execution.

#### Implications Without Implementation

- Future plan artifacts should preserve the initial state, target state, stages, subgoals, and possible transitions.
- The plan may be clarified during execution if controlled movement toward the goal is preserved.
- The graph nature of the plan should be considered when choosing a path, reviewing stages, and introducing new subgoals.
- The principle does not prescribe a concrete graph format.

#### Boundaries

- The plan does not have to be complete before realization begins.
- The plan is not a simple list of tasks.
- Plan understandability does not mean that all details have already been algorithmized.

#### Anti-Patterns

- Treating a plan as ready only because there is a list of actions.
- Starting realization without understanding how the actions are connected to the target state.
- Forbidding changes to the plan when new stages, paths, or subgoals appear.

#### Questions

- None.

<a id="principle-goal-and-plan-must-not-be-separated"></a>

### principle-goal-and-plan-must-not-be-separated: Goal and Plan Must Not Be Separated

#### Statement

A plan should remain connected to the goal for which it was built; reuse is possible as transfer or adaptation of the bundle of goal, initial state, success criteria, and plan, not as use of the plan outside its context.

#### Derived From

- Source concept(s): [Plan Exchange](./machine-of-goals-concepts.md#concept-plan-exchange), [Goal Artifact Context](./machine-of-goals-concepts.md#concept-goal-artifact-context), [Plan as Transition Model](./machine-of-goals-concepts.md#concept-plan-as-transition-model)
- Source relationship, boundary, or tension: plan exchange creates value, but the plan is not an independent universal mechanism
- Source idea support: `Raw Description`, `Signals of Value`, `Notes`
- Explicit or inferred: explicit

#### Rationale

Machine of Goals strives toward reuse of successful ways of achievement, but the plan itself is inseparable from the goal. If a plan is transferred without the goal statement, initial conditions, and verification criteria, the foundation for safe execution and result evaluation is lost.

#### Implications Without Implementation

- Plan exchange should preserve the connection to the goal context.
- Transfer of a similar subgoal is acceptable only together with its purpose, inputs, outputs, and connection to the parent goal.
- Stage success metrics do not make stages universal outside the goal.
- The principle does not define a marketplace or social model of exchange.

#### Boundaries

- The principle does not forbid reusing similar subgoals.
- The principle does not require copying the entire original goal without adaptation.
- The principle does not claim that different goals cannot have similar plan fragments.

#### Anti-Patterns

- Publishing a "bare plan" without a goal and success criteria.
- Copying plan stages into a new goal without checking the initial state and constraints.
- Treating a counter of successful realizations as proof of a stage's universal applicability.

#### Questions

- None.

<a id="principle-automation-under-user-control"></a>

### principle-automation-under-user-control: Automation Under User Control

#### Statement

Machine of Goals should strive toward automatic plan execution, but should ask the user each time which items to execute automatically and where control boundaries should remain.

#### Derived From

- Source concept(s): [Interactive and Automatic Execution](./machine-of-goals-concepts.md#concept-interactive-and-automatic-execution), [Plan Explanation and Control](./machine-of-goals-concepts.md#concept-plan-explanation-and-control), [Executable Collapsed Plan](./machine-of-goals-concepts.md#concept-executable-collapsed-plan)
- Source relationship, boundary, or tension: automation is valuable, but should not cancel control, explanation, and the possibility of stopping
- Source idea support: `Raw Description`, `Assumptions`, `Signals of Value`
- Explicit or inferred: explicit

#### Rationale

The value of Machine of Goals is that a plan can reach an executable mechanism. But goals often differ by risk, domain, and need for human decision-making. Therefore, automation should be a direction of movement, not the unconditional destiny of every goal or every stage.

#### Implications Without Implementation

- The user should choose the execution mode: up to a specified stage, by a list of stages, or fully controlled.
- Fully controlled execution remains acceptable even when the plan is technically automatable.
- Automatic execution should preserve stop points and the possibility of review.
- The principle does not define a UI or confirmation protocol.

#### Boundaries

- The principle does not forbid full automation.
- The principle does not require manual confirmation of every safe step.
- The principle does not turn automation into an end in itself.

#### Anti-Patterns

- Automatically executing stages without user-selected boundaries.
- Treating interactive execution as a sign of a bad plan.
- Hiding from the user which parts of the plan will be executed automatically.

#### Questions

- None.

<a id="principle-explanation-before-execution"></a>

### principle-explanation-before-execution: Explanation Before Execution

#### Statement

Before automatic or agentic execution, the plan should be explained through the selected stage, the reason for selection, the state of completed stages, and the further path through the plan graph; the user should be able to request `dry run`.

#### Derived From

- Source concept(s): [Plan Explanation and Control](./machine-of-goals-concepts.md#concept-plan-explanation-and-control), [Plan as Transition Model](./machine-of-goals-concepts.md#concept-plan-as-transition-model), [Interactive and Automatic Execution](./machine-of-goals-concepts.md#concept-interactive-and-automatic-execution)
- Source relationship, boundary, or tension: execution should be controllable, stoppable, and explainable, especially under automation
- Source idea support: `Raw Description`, `Examples / Scenarios`, `Signals of Value`
- Explicit or inferred: explicit

#### Rationale

Explanation keeps Machine of Goals away from blind automation. If the agent cannot explain which stage it is executing, why it was selected, and how the state of completed stages affects the next path, the user cannot control plan execution.

#### Implications Without Implementation

- `Dry run` should serve to check understandability and expected behavior before real actions.
- Explanation of the next step should take execution history into account.
- The choice of path through the plan graph should be justified by the state of already completed stages.
- The principle does not require complete documentation of the whole system before every step.

#### Boundaries

- `Dry run` is not real execution.
- Explanation should not turn every step into endless approval.
- The principle does not claim that all internal execution details should be disclosed with the same level of detail.

#### Anti-Patterns

- Launching agentic execution without explaining the selected stage.
- Ignoring the state of already completed stages when choosing the next path.
- Using `dry run` as an appearance of control if the agent still performs real actions.

#### Questions

- None.

<a id="principle-plan-is-project-algorithm-is-realization"></a>

### principle-plan-is-project-algorithm-is-realization: Plan Is Project, Algorithm Is Realization

#### Statement

Machine of Goals should distinguish the plan as the project of achieving the goal from the algorithm as the realization of this project in the working catalog.

#### Derived From

- Source concept(s): [Plan Algorithmization](./machine-of-goals-concepts.md#concept-plan-algorithmization), [Goal Artifact Context](./machine-of-goals-concepts.md#concept-goal-artifact-context), [Executable Collapsed Plan](./machine-of-goals-concepts.md#concept-executable-collapsed-plan)
- Source relationship, boundary, or tension: a plan may be sufficiently explainable, but becomes an algorithm only as a realized form
- Source idea support: `Raw Description`, `Assumptions`, `Notes`
- Explicit or inferred: explicit

#### Rationale

The distinction between plan and algorithm prevents thinking about goal achievement from being mixed with executable realization. The plan defines the structure of the transition, while the algorithm appears where this structure is embodied in a working environment: a Git repository, site generation catalog, workflow, or another form of execution.

#### Implications Without Implementation

- The goal and the plan should indicate the realization working catalog.
- The realization working catalog should differ from the goal catalog if it contains the executable or publishable form of the algorithm.
- Algorithmization should preserve the connection to the plan, checks, stops, and parameters.
- The principle does not prescribe that realization is always code.

#### Boundaries

- A plan does not become an algorithm only because it is detailed.
- Algorithmization does not mean arbitrary code generation.
- Not all goals should fully transition into an algorithm.

#### Anti-Patterns

- Storing executable realization without a connection to the goal and plan.
- Calling a plan an algorithm before a working realization appears.
- Mixing the goal catalog and the realization working catalog so that the semantic context is lost.

#### Questions

- None.

<a id="principle-collapsing-format-should-follow-goal-type"></a>

### principle-collapsing-format-should-follow-goal-type: Collapsing Format Should Follow Goal Type

#### Statement

A collapsed plan should receive its primary format according to the goal type, achievement environment, verification method, and expected form of result usage.

#### Derived From

- Source concept(s): [Executable Collapsed Plan](./machine-of-goals-concepts.md#concept-executable-collapsed-plan), [Goal as Verifiable Target State](./machine-of-goals-concepts.md#concept-goal-as-verifiable-target-state), [Goal Artifact Context](./machine-of-goals-concepts.md#concept-goal-artifact-context)
- Source relationship, boundary, or tension: Double should not have a single universal collapsed-plan format
- Source idea support: `Raw Description`, `Assumptions`, `Signals of Value`
- Explicit or inferred: explicit

#### Rationale

Goals differ by execution environment. For a computational environment, the natural format may be a script; for design, SDD; for social goals, Markdown with export capability to a website or another readable format. A universal format would distort the specificity of the goal and verification.

#### Implications Without Implementation

- Future stages should choose the collapsed-plan format by domain.
- SDD may be a primary format for design goals without becoming an internal concept of Machine of Goals.
- Markdown, scripts, workflows, specs, and site-exportable artifacts should be treated as possible forms, not as one mandatory form.
- The principle does not define the full list of supported formats.

#### Boundaries

- The principle does not forbid having a default format for a concrete workflow.
- The principle does not claim that every plan should be collapsed.
- The principle does not turn the format into a criterion of goal achievement.

#### Anti-Patterns

- Requiring one collapsed-plan format for all types of goals.
- Choosing the format for the convenience of the machine rather than by the achievement environment and result verification.
- Treating SDD as a universal format for any goal.

#### Questions

- None.

<a id="principle-subgoal-as-its-own-context"></a>

### principle-subgoal-as-its-own-context: Subgoal as Its Own Context

#### Statement

A stable subgoal should be represented as a separate catalog with its own subplan, especially if it repeats across different goals.

#### Derived From

- Source concept(s): [Subgoal and Partial Achievement](./machine-of-goals-concepts.md#concept-subgoal-and-partial-achievement), [Goal Artifact Context](./machine-of-goals-concepts.md#concept-goal-artifact-context), [Plan Exchange](./machine-of-goals-concepts.md#concept-plan-exchange)
- Source relationship, boundary, or tension: a subgoal is part of the parent goal, but may have its own inputs, outputs, and subplan
- Source idea support: `Raw Description`, `Assumptions`, `Notes`
- Explicit or inferred: explicit

#### Rationale

Subgoals make it possible to work with goals that cannot be achieved through one linear transition. If a subgoal becomes a stable part of the achievement graph, a separate catalog and subplan preserve its structure, verifiability, and reusability without detaching it from the parent goal.

#### Implications Without Implementation

- Repeatable subgoals such as determining the operating system or creating the goal working catalog may become reusable fragments.
- A subgoal should preserve its purpose, inputs, outputs, and connection to the parent goal.
- The subgoal subplan should be available as a separate artifact inside its catalog.
- The principle does not require a full Machine of Goals pass for every subgoal.

#### Boundaries

- A subgoal is not an arbitrary task.
- A subgoal should not hide non-achievement of the original goal.
- A repeatable subgoal does not become a universal plan outside context.

#### Anti-Patterns

- Mixing all subgoals into one large plan without visible structure.
- Reusing a subgoal without its inputs, outputs, and parent purpose.
- Creating a separate catalog for any small step that is not a stable subgoal.

#### Questions

- None.

<a id="principle-cost-should-accumulate-from-execution"></a>

### principle-cost-should-accumulate-from-execution: Cost Should Accumulate From Execution

#### Statement

Machine of Goals should evaluate plan cost through basic metrics of stage execution and domain-specific criteria that are clarified as work with plans proceeds.

#### Derived From

- Source concept(s): [Plan Cost and Efficiency](./machine-of-goals-concepts.md#concept-plan-cost-and-efficiency), [Plan as Transition Model](./machine-of-goals-concepts.md#concept-plan-as-transition-model), [Plan Exchange](./machine-of-goals-concepts.md#concept-plan-exchange)
- Source relationship, boundary, or tension: plans should be comparable, but cost is not reducible to money or a universal score
- Source idea support: `Raw Description`, `Assumptions`, `Examples / Scenarios`
- Explicit or inferred: explicit

#### Rationale

Plan comparison requires measurable grounds. Basic metrics - the number of successful realizations of a stage, execution time, and number of errors - provide a shared observation layer. The remaining cost criteria depend on the goal domain and should be clarified through real experience of working with plans.

#### Implications Without Implementation

- Stage cost should consider success, time, and errors as a common foundation.
- Domain-specific costs may include attention, money, computational resources, social effort, risk, or other costs.
- Accumulated execution experience should help compare plans and stages.
- The principle does not define an efficiency formula.

#### Boundaries

- Low cost does not always mean the best plan.
- High stage success does not prove applicability to any goal.
- Efficiency is not equal to maximum automation.

#### Anti-Patterns

- Comparing plans only by subjective impression.
- Reducing cost to money or time without considering errors and success.
- Using accumulated metrics outside the goal context.

#### Questions

- None.

## 4. Trade-offs and Tensions

- `Automation` vs `user control`: the machine should strive toward automatic execution, but each launch requires automation boundaries selected by the user.
- `Plan understandability` vs `plan incompleteness`: a plan may start incomplete if it preserves an understandable transition, but too weak an understanding blocks controlled realization.
- `Reuse` vs `inseparability from goal`: useful plans and subgoals should be reused, but only together with purpose, inputs, outputs, and success criteria.
- `Unified artifact order` vs `domain-dependent formats`: the goal catalog should be the structural anchor, but collapsed forms depend on the type of goal.
- `Execution metrics` vs `domain-specific costs`: shared metrics are needed for comparison, but they should not displace the specific costs of a concrete goal.

## 5. Candidate Inputs for Future Stages

- Design the Machine of Goals workflow around the transition `Goal Capture -> Path Discovery -> Plan Synthesis -> Plan Automation`.
- Define the goal artifact contract: target state, initial state, success criteria, constraints, realization working catalog.
- Define the plan artifact contract: `plan.md`, transition graph, subgoals, checks, stop points, automation modes, execution metrics.
- Define the subgoal artifact contract: separate catalog, subplan, inputs, outputs, completion criteria, and connection to the parent goal.
- Define a dry run protocol for agentic execution without real actions.
- Define the policy for choosing execution mode: up to a stage, by a list of stages, fully controlled.
- Define the mapping from goal types to collapsed-plan formats: scripts, SDD, Markdown export, workflow, agent runbook.
- Define rules for linking the goal catalog and the realization working catalog.

## 6. Rejected or Deferred Candidate Principles

- `All goals should be fully automatable`: rejected, because the source explicitly preserves manual, interactive, and partially automatic execution.
- `Double should have one unified collapsed-plan format`: rejected, because the format depends on the goal type and achievement environment.
- `A plan can be reused as an independent universal mechanism`: rejected, because the plan is inseparable from the goal and target context.
- `A subgoal always requires a full separate Machine of Goals workflow`: deferred/rejected, because a subgoal should have a catalog and subplan, but not necessarily a full separate pass.
- `Plan cost can be expressed by one universal metric`: rejected, because there are basic execution metrics, but domain-specific criteria are clarified during work with plans.
