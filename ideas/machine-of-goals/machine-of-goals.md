---
id: machine-of-goals
kind: idea-artifact
status: release-candidate
produced-by: machine-of-ideas/idea-capture-agent
interaction-language: English
artifact-language: English
derived-from:
  - user request on 2026-05-24
---

<a id="machine-of-goals"></a>

# Idea: Machine of Goals

## 1. Summary

Machine of Goals is the idea of a system that helps a person formulate goals as verifiable target states, search for paths toward their realization, compose variants of achievement plans, and bring the selected plan to an explainable algorithm. If the plan can be collapsed into an executable form, the machine can prepare an automatically executable algorithm: a workflow, an agentic execution scenario, or a script that performs the plan itself. Such a machine should be connected with thinking, planning, and execution: it should not only describe the desired result, but also help move from a goal to an active mechanism for achieving it.

Within this idea, a goal is understood as a sufficiently clear specification of a verifiable state that can be reached through the execution of a plan. At the end of plan execution, the result is compared with the original description of the goal, and on the basis of this comparison it becomes possible to judge whether the goal has been achieved, or how much the execution has brought the subject closer to the goal.

## 2. Context / Origin

The idea appeared as a separate new idea after work on Machine of Ideas and Double Project. Machine of Goals is considered not as an opposition to Machine of Ideas and not as a mandatory stage after it, but as an independent module of Double.

At the same time, a hierarchical relationship may exist between Double artifacts. Goals, concepts, and principles that appear in the Machine of Ideas workflow can be used as material for Machine of Goals, but this is not a mandatory condition. Machine of Goals can work both with goals that have grown out of ideas and with goals that have come from other contexts.

For now, the idea is fixed at the level of an initial artifact. The architecture, principles, agent roles, workflow, and execution of collapsed plans should be worked through later.

## 3. Problem / Motivation

Goals often remain too abstract: a person knows what they want, but does not always understand how to decompose it into achievable steps, how to verify the realism of the goal, how to choose a path, how to turn a plan into action, and how to bring action to an automatable procedure.

Machine of Goals should help close the gap between intention and execution. Its value may lie in guiding a goal through several levels of maturity:

- goal formulation
- clarification of motivation and success criteria
- search for possible paths of achievement
- strategy selection
- plan construction
- decomposition of the plan into actions
- transformation of the plan into an algorithm
- preparation of an automatically executable algorithm, if the plan can be collapsed into such a form

## 4. Raw Description

Machine of Goals should become a machine for working with goals. It should help not merely record a goal, but guide it through the path of becoming an achievable structure.

A goal in this machine can be understood as a desired verifiable target state that can be achieved through the execution of a plan. Moving through the stages of the plan from the entry point to the exit, the subject achieves the goal or comes closer to it. A goal may be a program, a script, a website; or a social process: obtaining a document, celebrating a birthday, preparing food; or another result, if it can be described as a verifiable state.

First, the system helps formulate the goal: what exactly should change, why it is needed, who is the subject of the goal, what result counts as success, what constraints exist, and why the goal matters.

Then the machine searches for paths of realization. One goal may have several strategies: a direct path, a workaround path, a research path, a minimal path, a long-term path, a path through learning, a path through creating a tool, a path through delegation or automation.

After that, the system helps compose a plan for achieving the goal. The plan should be not merely a list of tasks, but a connected model: steps, dependencies, resources, completion criteria, risks, checks, and review points. The plan moves the subject from the initial state to the target state. Alternative achievement paths are represented as selectable options or subplans inside this model; plans may include sequential, parallel, cyclic, and alternative sections.

A plan may have several entry and exit points. In this case, subgoals, intermediate results, and partial states of achievement appear. Each stage of the plan has a cost: time, attention, money, computational resources, social effort, risk, or another price of execution. By estimating the cost of stages and of the whole plan, plans can be compared by efficiency.

Next, Machine of Goals can turn the plan into an algorithm. This is especially important if the goal is connected with repeatable activity, a software project, a research process, knowledge management, or automation.

Before algorithm execution, the machine should provide a mechanism for explaining the plan: which steps are performed, why they are performed in exactly this way, which plan parameters are controlled, which checks are mandatory, and where the stop points are located. The plan can be executed fully automatically, partially automatically, or interactively by stages. The user should be able to stop execution, change parameters, review a section of the plan, choose another exit, or return to the expanded form of the plan.

The progress of plan execution should be stored separately from the plan itself. The plan describes the model of transition from the initial state to the target state. After the user approves an achievement path and chooses a manual or automatic realization, the machine creates a persistent realization artifact under `realizations/` before the first run begins. This artifact is the stable execution context for that registered choice: it connects the decision, selected path, exact plan and realization revisions, control boundaries, and the retained runs created from it. Each concrete execution then creates a working run artifact under `run/` that records completed or blocked stages, checks, concise execution notes, and result. Run artifacts are short-lived working logs retained only to a configured bounded depth, normally the latest three to five runs per realization.

`path-options.md` remains useful after planning as a living catalog of achievement paths. Section 10 of `plan.md` records which manual or automatic realizations exist, which paths or subplans they support, how many times they have been run, the latest run time, and the latest result. These aggregate statistics remain after old working run logs are removed and do not require links to individual run files.

Machine of Goals artifacts should remain understandable when goals become
deeply nested or when one project directly uses a goal, plan, subplan, or
realization from another project. Human navigation is therefore expressed by
contextual Markdown links placed where the relationship is described. A
frontmatter id or path remains machine-readable provenance and does not replace
a useful link in the artifact body. Direct reference does not require export or
import: the consumer records the source project, artifact, link scope, and
revision while the source remains in its original goal context.

Run count and latest run time are updated when a run starts, with latest result
set to `running`. Terminal validation replaces latest result without incrementing
the count again.

Finally, the machine can help prepare project documentation for external software implementation or for collapsing the plan into an executable mechanism: a CLI command, workflow, script, agentic process, project template, integration, or another execution format. The integration of the machine of goals with the Spec-Driven Development approach is especially interesting. The machine itself does not implement this approach. But the artifacts generated by the machine should be maximally suitable for using the SDD approach.

It is quite possible that other methodologies exist or will appear; in that case, the machine of goals should adapt to these new methodologies.

The realization of a plan may be expanded, when the steps are explicitly performed by a human or an agent, or it may be collapsed and automatic, when the plan is projected into an executable mechanism. A realization may cover the complete plan or particular subplans and may take the form of a manual procedure, shell script, Python program, workflow, agentic process, or another mechanism. An automatic realization must validate the initial state, required intermediate results, and final state defined by the plan. **Obtaining the most automatic plans and exchanging them within the Double ecosystem is one of the central ideas of Machine of Goals.**

Plan working style is computed rather than manually fixed. A plan without a registered automatic realization uses the `single-pass` style. Registration of an automatic realization for the plan or one of its subplans changes the style to `multi-pass`; creating a file is not sufficient, and the transition does not wait for the first successful validation. Readiness and alignment of the registered realization remain separate statuses.

Multi-pass operation makes the plan an evolving reusable mechanism. It supports importing the plan into another project and changing the plan or its realizations from experience gathered during later executions. Exchange preserves the goal, plan, path and realization registry, and validation contracts; bounded working run logs are operational context rather than required permanent exchange history.

The idea of Machine of Goals is part of the Double ecosystem, just like the idea of Machine of Ideas. Both "modules" are independent: Machine of Ideas works with ideas, concepts, and principles, while Machine of Goals works with goals, plans, algorithms, and realizations. Machine of Ideas artifacts can be used as source material for Machine of Goals.

## 5. Key Elements

- goal
- initial state
- target state
- subject of the goal
- motivation
- success criteria
- constraints
- resources
- paths of realization
- achievement strategy
- plan
- selectable path and subplan options
- plan realization registry
- manual and automatic plan realizations
- computed single-pass and multi-pass styles
- realization registration
- aggregate realization statistics
- bounded working run log
- contextual artifact navigation
- direct cross-project artifact reference
- pinned plan and realization revision
- steps and dependencies
- sequential sections of the plan
- parallel sections of the plan
- cyclic sections of the plan
- entry and exit points
- subgoals
- intermediate and partial results
- cost of plan stages
- plan efficiency
- risks and checks
- achievement algorithm
- plan explanation
- controlled plan parameters
- stop points
- interactive execution of stages
- expanded realization of the plan
- collapsed or automatic realization of the plan
- automatically executable algorithm
- exchange of automatic plans
- `double/goals` catalog
- catalog of a separate goal
- subgoals
- goal artifacts
- imported multi-pass plans and realizations
- connection with Double
- possible connection with Machine of Ideas

## 6. Assumptions

- A goal can be represented as a structured artifact that develops through stages.
- A goal can be described as a verifiable target state whose achievement is checked by comparing the result with the original description of the goal.
- A good goal should have success criteria and a context of constraints.
- For many goals, several possible paths of realization exist.
- A plan moves the subject from the initial state to the target state, or to a state that is closer to the goal.
- One plan may contain several selectable paths or subplans with different costs and efficiencies.
- Alternative achievement paths are selectable options or subplans inside the plan rather than separate plans for the same goal.
- The plan artifact and working run artifacts should be separated: the plan describes the model of achievement, while a run records concrete execution progress.
- `path-options.md` is a living catalog of achievement paths; section 10 of `plan.md` is the realization registry and aggregate-statistics source.
- A run file is named `run/<realization-id>--<YYYYMMDDTHHMMSSZ>.md` and retained only to a configured bounded depth, normally three to five runs per realization.
- A plan without a registered automatic realization is single-pass; registering an automatic realization for the plan or a subplan computes the multi-pass style.
- Automatic realization readiness and alignment are separate from the computed plan style.
- Contextual Markdown links should connect goals, plan elements, realizations,
  decisions, revisions, runs, and evidence where those relationships are used;
  artifacts should not repeat a universal navigation menu.
- Planning may use an explicitly mutable `current` reference, but a realization
  decision and every concrete run should pin the exact plan and realization
  revisions used for execution.
- A goal, subgoal, plan, or realization in another project may be used by
  direct reference without first exporting or importing it.
- A plan may contain sequential, parallel, and cyclic sections, as well as several entry and exit points.
- Subgoals and partial results appear where the plan has intermediate verifiable states.
- A goal achievement plan can be transformed into an algorithm if the steps, checks, and transitions are clear enough.
- Machine of Goals does not generate arbitrary code, but variants of plans and, in the limiting case, an automatically executable algorithm if the plan can be collapsed into a program, script, or workflow.
- Before executing an algorithm, Machine of Goals should explain the plan: which steps are performed, why they were chosen, which parameters are controlled, and where the check points are located.
- The plan should support flexible execution: stop points, interactive execution of stages, parameter review, and movement between expanded and collapsed forms.
- The most valuable plans in the Double ecosystem may become collapsed, automatic, and suitable for exchange.
- Machine of Goals is a separate workflow inside Double.
- For Machine of Goals, it is necessary to work through agent roles for executing the workflow of the machine of goals.
- Machine of Ideas artifacts can be used as material for Machine of Goals; this is desirable, but not mandatory.
- Constraints, resources, dependencies, risks, stage costs, and so on will need to be modeled and stored in Markdown artifact files produced by the machine of goals.
- Goals are stored in the `double/goals` catalog.
- Each goal is represented by a separate catalog and follows the universal naming principle [`Double layout naming convention`](../../Double.md#double-layout-naming-convention): the catalog name is written in `kebab-case`, and a Markdown file with the same name is created inside the catalog.
- Subgoals can be created as nested catalogs inside the goal catalog and use the same naming principle.
- Machine of Goals artifacts are stored in the main catalog of the corresponding goal, so that the goal, its plans, explanations, parameters, checks, and executable algorithms remain in one working context.
- Multi-pass plans may be imported into another project together with their goal context, path and realization registry, and validation contracts.
- Bounded working run logs are not required permanent import or export history.

## 7. Examples / Scenarios

- The user formulates a goal: "create a CLI for Double".
- Machine of Goals clarifies what counts as the achieved result.
- The system proposes several selectable paths inside the plan: a minimal research path, a prototype path, a full CLI path, a path for preparing a specification for SDD, and a packaging and distribution path.
- For each plan, the machine shows stages, dependencies, cost, risks, completion criteria, and parameters that need to be controlled.
- The user selects a plan or assembles a hybrid plan from several variants.
- The machine explains the selected plan: why the stages go in this order, which checks must be performed, and which decisions remain interactive.
- Stop points are added to the plan: for example, after clarifying CLI commands, after choosing the architecture, after preparing the specification, and before handing the plan over to implementation.
- If the plan is clear enough, Machine of Goals can collapse it into an automatically executable algorithm: a workflow, an agentic execution scenario, or a script that performs only the plan itself and controls its parameters.

Another example:

- The user wants to "monetize the exchange of ideas".
- Machine of Goals helps clarify the business goal, constraints, ethical frame, and success criteria.
- Then the system proposes plan paths: testing a subscription, testing a marketplace, paid workflows, private spaces, selling curated knowledge packages.
- For each variant, the machine describes entry conditions, required resources, expected intermediate results, the cost of validation, and stop criteria.
- The user chooses a hypothesis-validation plan and marks the stages that should be performed interactively.
- The machine explains which plan parameters need to be controlled: number of participants, quality of curated packages, willingness to pay, support cost, legal and ethical constraints.
- If part of the plan can be automated, the machine can prepare an executable algorithm for data collection, experiment management, reminders, or metric checks, but this does not replace the business plan itself.

## 8. Signals of Value

- This idea closes the practical gap between reflection and action.
- Machine of Goals is an independent workflow for transforming a goal into a plan with selectable paths, an explainable algorithm, and, if necessary, registered executable realizations.
- The system can be useful for personal goals as well as project, research, and software goals.
- The ability to bring a goal to an explainable algorithm and, if necessary, collapse the plan into an executable mechanism makes the idea especially suitable for Double.
- Machine of Goals is a foundation for agent-assisted planning inside the Double ecosystem.
- Plan explanation, controlled parameters, stop points, and interactive execution make work with goals manageable rather than blindly automatic.
- The exchange of collapsed plans creates practical value: successful ways of achieving goals can be reused, adapted, and improved.

## 9. Open Questions


## 10. Boundaries / Non-Goals

- This artifact does not define the final Machine of Goals workflow.
- This artifact does not design the software architecture.
- This artifact does not create ready CLI commands.
- This artifact does not claim that Machine of Goals should generate arbitrary code; its software result is limited to the automatically executable algorithm of a collapsed plan.
- This artifact does not replace future conceptual work.
- This artifact does not claim that all human goals should be algorithmizable.
- This artifact does not fully resolve the question of motivation, psychology, and ethics in working with goals.

## 11. Related Ideas

- Double Project
- planning
- goal setting
- agent-assisted planning
- algorithmization of actions
- executable algorithms
- collapsed plans
- personal knowledge management
- project planning

## 12. Notes

Machine of Goals is a separate workflow in Double. The early workflow chain:

`Goal Capture -> Path Discovery -> Plan Synthesis -> Plan Automation`

This chain is the current working architecture of the idea at the draft stage. It may be refined, but it is no longer considered an external hypothesis.

Basic goal storage structure:

```text
double/
  goals/
    goals.md
    my-first-goal/
      my-first-goal.md
      path-options.md
      plan.md
      run/
        <realization-id>--<YYYYMMDDTHHMMSSZ>.md
      my-first-subgoal/
        my-first-subgoal.md
        plan.md
```

The `double/goals` catalog is the root catalog of goals, and the `double/goals/goals.md` file describes this catalog. The `my-first-goal` catalog represents a separate goal, and its main artifact is `my-first-goal.md`. The nested `my-first-subgoal` catalog represents a subgoal, and its main artifact is `my-first-subgoal.md`. The goal plan is stored as a separate file according to the `plan.md` template; a subgoal may also have its own subplan in its catalog. Files of Machine of Goals artifacts are placed in the working context of the corresponding goal or subgoal.

`path-options.md` begins as the project artifact for discovering and comparing achievement paths, then remains their living catalog. Section 10 of `plan.md` stores registered realizations, aggregate run count, latest run time, and latest result without links to individual run files.

Each concrete execution creates a bounded working log under `run/`. Its name contains the realization identity and UTC start time:

```text
run/<realization-id>--<YYYYMMDDTHHMMSSZ>.md
```

The run log is working context for understanding current execution effort, not permanent history. Its notes remain concise, but every command generated for a human to execute while manually performing a plan stage is recorded in generation order before or when it is presented; corrected or superseded commands remain as separate entries. Generated commands use protected-input references or placeholders rather than literal secrets. Normally only the latest three to five logs per realization are retained. Aggregate statistics remain after old run files are removed.

## 13. Development Artifacts

### 13.1 Concepts

Concept artifact: [Machine of Goals Concepts](./machine-of-goals-concepts.md)

| Concept | Summary |
| --- | --- |
| [`concept-goal-as-verifiable-target-state: Goal as Verifiable Target State`](./machine-of-goals-concepts.md#concept-goal-as-verifiable-target-state) | A goal expressed as a desired state whose achievement can be verified. |
| [`concept-success-criteria: Success Criteria`](./machine-of-goals-concepts.md#concept-success-criteria) | Criteria for distinguishing achievement, partial achievement, failure, or the need for review. |
| [`concept-initial-state-and-target-state: Initial State and Target State`](./machine-of-goals-concepts.md#concept-initial-state-and-target-state) | The pair of states that frames goal achievement as a transition. |
| [`concept-realization-path: Realization Path`](./machine-of-goals-concepts.md#concept-realization-path) | A possible strategy for approaching a goal before composing a concrete plan. |
| [`concept-plan-as-transition-model: Plan as Transition Model`](./machine-of-goals-concepts.md#concept-plan-as-transition-model) | A structured model for moving from the initial state to the target state. |
| [`concept-plan-realization-registry: Plan Realization Registry`](./machine-of-goals-concepts.md#concept-plan-realization-registry) | A living plan section of registered realizations and aggregate execution statistics. |
| [`concept-computed-plan-style: Computed Plan Style`](./machine-of-goals-concepts.md#concept-computed-plan-style) | The transition from single-pass to multi-pass when an automatic realization is registered. |
| [`concept-plan-realization-artifact: Plan Realization Artifact`](./machine-of-goals-concepts.md#concept-plan-realization-artifact) | The persistent execution context created for an approved manual or automatic realization before its first run. |
| [`concept-working-plan-run: Working Plan Run`](./machine-of-goals-concepts.md#concept-working-plan-run) | A bounded working log for one concrete execution of a registered realization. |
| [`concept-contextual-artifact-navigation: Contextual Artifact Navigation`](./machine-of-goals-concepts.md#concept-contextual-artifact-navigation) | Useful Markdown links placed where artifact relationships are explained, with exact revisions pinned for execution. |
| [`concept-subgoal-and-partial-achievement: Subgoal and Partial Achievement`](./machine-of-goals-concepts.md#concept-subgoal-and-partial-achievement) | Intermediate verifiable states that contribute to a parent goal. |
| [`concept-plan-cost-and-efficiency: Plan Cost and Efficiency`](./machine-of-goals-concepts.md#concept-plan-cost-and-efficiency) | Measures for comparing execution cost with expected results. |
| [`concept-plan-algorithmization: Plan Algorithmization`](./machine-of-goals-concepts.md#concept-plan-algorithmization) | The transformation of a sufficiently clear plan into a controlled achievement algorithm. |
| [`concept-plan-explanation-and-control: Plan Explanation and Control`](./machine-of-goals-concepts.md#concept-plan-explanation-and-control) | Visibility of steps, reasons, checks, parameters, stop points, and review opportunities. |
| [`concept-interactive-and-automatic-execution: Interactive and Automatic Execution`](./machine-of-goals-concepts.md#concept-interactive-and-automatic-execution) | The range of execution modes from manual through fully automatic. |
| [`concept-executable-collapsed-plan: Executable Collapsed Plan`](./machine-of-goals-concepts.md#concept-executable-collapsed-plan) | A reusable form of a plan suitable for automatic execution, handoff, or publication. |
| [`concept-plan-exchange: Plan Exchange`](./machine-of-goals-concepts.md#concept-plan-exchange) | Reuse and adaptation of successful plans together with their goal context. |
| [`concept-goal-artifact-context: Goal Artifact Context`](./machine-of-goals-concepts.md#concept-goal-artifact-context) | The context that keeps a goal, its plan, realization, and evidence together. |

### 13.2 Principles

Principle artifact: [Machine of Goals Principles](./machine-of-goals-principles.md)

| Principle | Statement | Related Concepts |
| --- | --- | --- |
| [Goal Verifiability Before Planning](./machine-of-goals-principles.md#principle-goal-verifiability-before-planning) | Begin with a verifiable target state, not with tasks or wishes. | [Goal as Verifiable Target State](./machine-of-goals-concepts.md#concept-goal-as-verifiable-target-state), [Success Criteria](./machine-of-goals-concepts.md#concept-success-criteria), [Initial State and Target State](./machine-of-goals-concepts.md#concept-initial-state-and-target-state) |
| [Plan as an Understandable Transition Graph](./machine-of-goals-principles.md#principle-plan-as-an-understandable-transition-graph) | Preserve an understandable connection from the initial state to the target state. | [Plan as Transition Model](./machine-of-goals-concepts.md#concept-plan-as-transition-model), [Initial State and Target State](./machine-of-goals-concepts.md#concept-initial-state-and-target-state), [Subgoal and Partial Achievement](./machine-of-goals-concepts.md#concept-subgoal-and-partial-achievement) |
| [Goal and Plan Must Not Be Separated](./machine-of-goals-principles.md#principle-goal-and-plan-must-not-be-separated) | Keep a plan connected to the goal for which it was built. | [Plan Exchange](./machine-of-goals-concepts.md#concept-plan-exchange), [Goal Artifact Context](./machine-of-goals-concepts.md#concept-goal-artifact-context), [Plan as Transition Model](./machine-of-goals-concepts.md#concept-plan-as-transition-model) |
| [Automation Under User Control](./machine-of-goals-principles.md#principle-automation-under-user-control) | Automate plan execution only within boundaries selected by the user. | [Interactive and Automatic Execution](./machine-of-goals-concepts.md#concept-interactive-and-automatic-execution), [Plan Explanation and Control](./machine-of-goals-concepts.md#concept-plan-explanation-and-control), [Executable Collapsed Plan](./machine-of-goals-concepts.md#concept-executable-collapsed-plan) |
| [Explanation Before Execution](./machine-of-goals-principles.md#principle-explanation-before-execution) | Explain the selected path and allow a dry run before automatic or agentic execution. | [Plan Explanation and Control](./machine-of-goals-concepts.md#concept-plan-explanation-and-control), [Plan as Transition Model](./machine-of-goals-concepts.md#concept-plan-as-transition-model), [Interactive and Automatic Execution](./machine-of-goals-concepts.md#concept-interactive-and-automatic-execution) |
| [Plan Is Project, Algorithm Is Realization](./machine-of-goals-principles.md#principle-plan-is-project-algorithm-is-realization) | Distinguish the plan as a project from the algorithm as its realized form. | [Plan Algorithmization](./machine-of-goals-concepts.md#concept-plan-algorithmization), [Goal Artifact Context](./machine-of-goals-concepts.md#concept-goal-artifact-context), [Executable Collapsed Plan](./machine-of-goals-concepts.md#concept-executable-collapsed-plan) |
| [Automatic Realization Registration Makes a Plan Multi-Pass](./machine-of-goals-principles.md#principle-automatic-realization-registration-makes-plan-multi-pass) | Compute the multi-pass style when an automatic realization is registered. | [Computed Plan Style](./machine-of-goals-concepts.md#concept-computed-plan-style), [Plan Realization Registry](./machine-of-goals-concepts.md#concept-plan-realization-registry), [Executable Collapsed Plan](./machine-of-goals-concepts.md#concept-executable-collapsed-plan) |
| [Approved Realization Has an Artifact Before Runs](./machine-of-goals-principles.md#principle-approved-realization-has-artifact-before-runs) | Materialize every approved manual or automatic realization as a persistent artifact before creating a run. | [Plan Realization Artifact](./machine-of-goals-concepts.md#concept-plan-realization-artifact), [Working Plan Run](./machine-of-goals-concepts.md#concept-working-plan-run), [Contextual Artifact Navigation](./machine-of-goals-concepts.md#concept-contextual-artifact-navigation) |
| [Working Logs Are Bounded, Statistics Persist](./machine-of-goals-principles.md#principle-working-logs-are-bounded-statistics-persist) | Retain only recent working run logs while preserving aggregate realization statistics. | [Working Plan Run](./machine-of-goals-concepts.md#concept-working-plan-run), [Plan Realization Registry](./machine-of-goals-concepts.md#concept-plan-realization-registry), [Plan Cost and Efficiency](./machine-of-goals-concepts.md#concept-plan-cost-and-efficiency) |
| [Navigation Follows Context](./machine-of-goals-principles.md#principle-navigation-follows-context) | Place a link where its artifact relationship is meaningful instead of repeating a global navigation block. | [Contextual Artifact Navigation](./machine-of-goals-concepts.md#concept-contextual-artifact-navigation), [Goal Artifact Context](./machine-of-goals-concepts.md#concept-goal-artifact-context), [Working Plan Run](./machine-of-goals-concepts.md#concept-working-plan-run) |
| [Collapsing Format Should Follow Goal Type](./machine-of-goals-principles.md#principle-collapsing-format-should-follow-goal-type) | Select the primary collapsed-plan format according to the goal and its environment. | [Executable Collapsed Plan](./machine-of-goals-concepts.md#concept-executable-collapsed-plan), [Goal as Verifiable Target State](./machine-of-goals-concepts.md#concept-goal-as-verifiable-target-state), [Goal Artifact Context](./machine-of-goals-concepts.md#concept-goal-artifact-context) |
| [Subgoal as Its Own Context](./machine-of-goals-principles.md#principle-subgoal-as-its-own-context) | Represent a stable subgoal as a separate context with its own subplan. | [Subgoal and Partial Achievement](./machine-of-goals-concepts.md#concept-subgoal-and-partial-achievement), [Goal Artifact Context](./machine-of-goals-concepts.md#concept-goal-artifact-context), [Plan Exchange](./machine-of-goals-concepts.md#concept-plan-exchange) |
| [Cost Should Accumulate From Execution](./machine-of-goals-principles.md#principle-cost-should-accumulate-from-execution) | Evaluate plan cost through execution metrics and domain-specific criteria. | [Plan Cost and Efficiency](./machine-of-goals-concepts.md#concept-plan-cost-and-efficiency), [Plan as Transition Model](./machine-of-goals-concepts.md#concept-plan-as-transition-model), [Plan Exchange](./machine-of-goals-concepts.md#concept-plan-exchange) |
