---
id: machine-of-goals
kind: idea-artifact
status: draft
produced-by: idea-capture-agent
workflow-version: 0.2.0
interaction-language: English
artifact-language: English
derived-from:
  - user request on 2026-05-24
---

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

After that, the system helps compose a plan for achieving the goal. The plan should be not merely a list of tasks, but a connected model: steps, dependencies, resources, completion criteria, risks, checks, and review points. The plan moves the subject from the initial state to the target state. One goal may have several plans; plans may include sequential, parallel, and cyclic sections.

A plan may have several entry and exit points. In this case, subgoals, intermediate results, and partial states of achievement appear. Each stage of the plan has a cost: time, attention, money, computational resources, social effort, risk, or another price of execution. By estimating the cost of stages and of the whole plan, plans can be compared by efficiency.

Next, Machine of Goals can turn the plan into an algorithm. This is especially important if the goal is connected with repeatable activity, a software project, a research process, knowledge management, or automation.

Before algorithm execution, the machine should provide a mechanism for explaining the plan: which steps are performed, why they are performed in exactly this way, which plan parameters are controlled, which checks are mandatory, and where the stop points are located. The plan can be executed fully automatically, partially automatically, or interactively by stages. The user should be able to stop execution, change parameters, review a section of the plan, choose another exit, or return to the expanded form of the plan.

The progress of plan execution should be stored separately from the plan itself. The plan describes the model of transition from the initial state to the target state, while the plan state artifact records a concrete realization of this model: which stages have already been completed, which are blocked, which checks have passed, and which costs and risks have manifested. Several such realizations may exist for one plan. This makes it possible to compare the current execution progress with previous realizations of the same or a similar plan.

Finally, the machine can help prepare project documentation for external software implementation or for collapsing the plan into an executable mechanism: a CLI command, workflow, script, agentic process, project template, integration, or another execution format. The integration of the machine of goals with the Spec-Driven Development approach is especially interesting. The machine itself does not implement this approach. But the artifacts generated by the machine should be maximally suitable for using the SDD approach.

It is quite possible that other methodologies exist or will appear; in that case, the machine of goals should adapt to these new methodologies.

The realization of a plan may be expanded, when the steps are explicitly performed by a human or an agent, or it may be collapsed and automatic, when the plan is transformed into an executable mechanism. **Obtaining the most automatic plans and exchanging them within the Double ecosystem is one of the central ideas of Machine of Goals.**

When exchanging a goal or a plan, it is important to preserve not only the ideal plan, but also the traces of its real realizations. During export, a plan state artifact receives a name with labels for the author, device or execution environment, and time with precision down to the second. During import, such artifacts should not replace the current execution progress: they are attached to the plan artifact as existing realizations, so that they can serve as reference material and a source of verification.

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
- plan state artifact
- existing realizations of the plan
- comparison of plan realizations
- alternative plans
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
- imported plan realizations
- exported plan states
- connection with Double
- possible connection with Machine of Ideas

## 6. Assumptions

- A goal can be represented as a structured artifact that develops through stages.
- A goal can be described as a verifiable target state whose achievement is checked by comparing the result with the original description of the goal.
- A good goal should have success criteria and a context of constraints.
- For many goals, several possible paths of realization exist.
- A plan moves the subject from the initial state to the target state, or to a state that is closer to the goal.
- For one goal, several plans with different costs and efficiencies may exist.
- For one plan, several plan state artifacts may exist: the current realization, previous realizations, and imported realizations.
- The plan artifact and the plan state artifact should be separated: the plan describes the model of achievement, while the plan state describes the concrete progress of realizing this model.
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
- During export, a plan state artifact should receive a name with labels for the author, device or execution environment, and time with precision down to the second.
- During import, existing plan state artifacts are added to the plan artifact as links to previous realizations, rather than replacing the current realization.

## 7. Examples / Scenarios

- The user formulates a goal: "create a CLI for Double".
- Machine of Goals clarifies what counts as the achieved result.
- The system proposes several plan variants: a minimal research plan, a prototype plan, a full CLI plan, a plan for preparing a specification for SDD, and a packaging and distribution plan.
- For each plan, the machine shows stages, dependencies, cost, risks, completion criteria, and parameters that need to be controlled.
- The user selects a plan or assembles a hybrid plan from several variants.
- The machine explains the selected plan: why the stages go in this order, which checks must be performed, and which decisions remain interactive.
- Stop points are added to the plan: for example, after clarifying CLI commands, after choosing the architecture, after preparing the specification, and before handing the plan over to implementation.
- If the plan is clear enough, Machine of Goals can collapse it into an automatically executable algorithm: a workflow, an agentic execution scenario, or a script that performs only the plan itself and controls its parameters.

Another example:

- The user wants to "monetize the exchange of ideas".
- Machine of Goals helps clarify the business goal, constraints, ethical frame, and success criteria.
- Then the system proposes plan variants: testing a subscription, testing a marketplace, paid workflows, private spaces, selling curated knowledge packages.
- For each variant, the machine describes entry conditions, required resources, expected intermediate results, the cost of validation, and stop criteria.
- The user chooses a hypothesis-validation plan and marks the stages that should be performed interactively.
- The machine explains which plan parameters need to be controlled: number of participants, quality of curated packages, willingness to pay, support cost, legal and ethical constraints.
- If part of the plan can be automated, the machine can prepare an executable algorithm for data collection, experiment management, reminders, or metric checks, but this does not replace the business plan itself.

## 8. Signals of Value

- This idea closes the practical gap between reflection and action.
- Machine of Goals is an independent workflow for transforming a goal into plan variants, an explainable algorithm, and, if necessary, an executable mechanism.
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

## 12. Maturity Level

- [ ] Raw thought
- [x] Developed idea
- [ ] Near-concept

## 13. Notes

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
      plan.md
      plan-state.md
      my-first-subgoal/
        my-first-subgoal.md
        plan.md
        plan-state.md
```

The `double/goals` catalog is the root catalog of goals, and the `double/goals/goals.md` file describes this catalog. The `my-first-goal` catalog represents a separate goal, and its main artifact is `my-first-goal.md`. The nested `my-first-subgoal` catalog represents a subgoal, and its main artifact is `my-first-subgoal.md`. The goal plan is stored as a separate file according to the `plan.md` template; a subgoal may also have its own subplan in its catalog. Files of machine of goals artifacts are placed in the working context of the corresponding goal or subgoal.

The plan execution state is stored as a separate file according to the `plan-state.md` template. During export of a concrete realization, the name of such an artifact is extended with labels for the author, device or execution environment, and time with precision down to the second, for example:

```text
plan-state--author-oliver--device-macbook--time-20260707T153012.md
```

During import, existing `plan-state` artifacts are added to the plan artifact as links to existing realizations. This makes it possible to compare the current realization progress with previous realizations and use them to verify decisions, cost, risks, and the success of individual stages.

## 14. Development Artifacts

- Concepts: [machine-of-goals-concepts.md](./machine-of-goals-concepts.md)
- Principles: [machine-of-goals-principles.md](./machine-of-goals-principles.md)
