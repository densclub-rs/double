---
id: machine-of-goals
kind: idea-artifact
status: release-candidate
produced-by: machine-of-ideas/idea-capture-agent
interaction-language: Russian
artifact-language: English
derived-from:
  - user request on 2026-05-24
  - user clarification on 2026-10-21
  - user clarification on 2026-10-22
---

<a id="machine-of-goals"></a>

# Idea: Machine of Goals

## 1. Summary

Machine of Goals is the idea of a system that helps a person formulate goals as verifiable target states, search for paths toward their realization, develop a model of a plan, and execute it. The machine includes a flow for interactive manual execution that guides a person through the model and preserves a documented walkthrough with evidence of the achieved results. A goal can be exported as source artifacts with a chosen scope, from the goal description and plan model to a set including selected or all walkthroughs. A manually executed model and its documented experience can also be collapsed, on request, into an AI-agent skill or an automated action.

Within this idea, a goal is understood as a sufficiently clear specification of a verifiable state that can be reached through the execution of a plan. At the end of plan execution, the result is compared with the original description of the goal, and on the basis of this comparison it becomes possible to judge whether the goal has been achieved, or how much the execution has brought the subject closer to the goal.

A documented walkthrough serves both as factual evidence and as documentation of how the plan was executed. A goal, its plan, and selected walkthrough materials can be shared together as a reference example. Preparing this material for publication or exchange includes removing personal data and checking the resulting package while preserving an understandable account of the execution.

A goal may have several independently evolving plan branches. Versions describe evolution within a branch; another branch describes a parallel plan. On request, a branch can be reduced to a selected current model and a self-contained set of useful realizations and evidence, removing obsolete versions and their unneeded artifacts.

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
- explanation of input states, actions, expected output states, and checks
- selection of an execution variant
- interactive execution with a documented walkthrough and evidence
- source-artifact export with a choice of whether to include execution experience
- optional collapsing of a manually executed model and its walkthrough into an AI-agent skill or an automated action
- preparation of a goal, plan, and walkthrough for publication or exchange, including personal-data cleanup

## 4. Raw Description

Machine of Goals should become a machine for working with goals. It should help not merely record a goal, but guide it through the path of becoming an achievable structure.

A goal in this machine can be understood as a desired verifiable target state that can be achieved through the execution of a plan. Moving through the stages of the plan from the entry point to the exit, the subject achieves the goal or comes closer to it. A goal may be a program, a script, a website; or a social process: obtaining a document, celebrating a birthday, preparing food; or another result, if it can be described as a verifiable state.

First, the system helps formulate the goal: what exactly should change, why it is needed, who is the subject of the goal, what result counts as success, what constraints exist, and why the goal matters.

Then the machine searches for paths of realization. One goal may have several strategies: a direct path, a workaround path, a research path, a minimal path, a long-term path, a path through learning, a path through creating a tool, a path through delegation or automation.

After that, the system helps compose a plan for achieving the goal. The plan should be not merely a list of tasks, but a connected model: steps, dependencies, resources, completion criteria, risks, checks, and review points. The plan moves the subject from the initial state to the target state. Alternative achievement paths may be selectable options or subplans inside this model; independently maintained alternatives may instead form parallel plan branches for the same goal. Plans may include sequential, parallel, cyclic, and alternative sections.

The plan is a model for future execution, comparable to an abstract class: it describes the structure of a transition, while a concrete execution supplies the actual conditions, actions, and results. Each stage explains its required input state, intended action, expected output state, and how that output can be checked. Stages have stable anchor IDs such as `S01` and short English names such as `Prepare Documents`, from which readable realization filenames such as `s01-prepare-documents.md` are formed. The model remains visible during execution; execution statuses belong to the realization, not to the model.

The `branch` value identifies an independent line of plan development within a goal. For example, `double` may be the main branch and `lightweight` a parallel branch. A version change within `double` is evolution of that plan; creating `lightweight` establishes a separate plan with its own version history. Several retained major versions within one branch do not by themselves constitute parallel branches. A branch created from another branch may record its source branch and version.

Plan versions use MAJOR.MINOR.PATCH to express the scale and compatibility of model changes. PATCH covers corrections that do not change the model's meaning. MINOR covers compatible additions or refinements, including stages or substages that preserve existing obligations. MAJOR covers changes that make the previous model incompatible with the new way of achieving the goal. Adding a prerequisite may be incompatible even if it is a small textual addition. Changing from manual guidance to a skill or script does not itself change the model version unless the model changes.

MINOR and PATCH updates stay in the same Markdown model file. A MAJOR change preserves the previous model and creates another file, for example `plan-double-v1.md` at version `1.4.0` and `plan-double-v2.md` at version `2.0.0`. A parallel model may be `plan-lightweight-v1.md` at version `1.0.0`. The current version is selected within a branch, not globally across the goal. Branch and version metadata are stored in Markdown frontmatter; the model does not require separate YAML files or a separate catalog of plan releases. Version metadata alone does not reconstruct the exact earlier text overwritten by a MINOR or PATCH update; retained stage records preserve the actual execution context and checks.

A subgoal is a goal used within another goal's plan, not a separate goal type. Any goal may serve as a subgoal, and any subgoal may be pursued as an autonomous goal. The same goal may play both roles at once. These roles are determined by explicit relationships and plan integration boundaries, not by a `goal-scope` field. Workflow depth and plan detail depend on the goal's needs, not on its role.

A plan may have several entry and exit points. In this case, subgoals, intermediate results, and partial states of achievement appear. Each stage of the plan has a cost: time, attention, money, computational resources, social effort, risk, or another price of execution. By estimating the cost of stages and of the whole plan, plans can be compared by efficiency.

Once the model is understandable enough to execute, the machine supports an interactive manual walkthrough. The model and the experience of carrying it out can subsequently be reused or shared in several forms. At the idea level, these are capabilities and intended results; the procedure for producing them is not specified here.

Before algorithm execution, the machine should provide a mechanism for explaining the plan: which steps are performed, why they are performed in exactly this way, which plan parameters are controlled, which checks are mandatory, and where the stop points are located. The plan can be executed fully automatically, partially automatically, or interactively by stages. The user should be able to stop execution, change parameters, review a section of the plan, choose another exit, or return to the expanded form of the plan.

Choosing manual execution moves the machine into an explicit execution state with a built-in flow that guides the person through the plan model. At each stage, the machine explains the input state, proposed action, expected output state, and check; helps carry out the action; records what happened and the supporting evidence; and uses the verified result to choose the next transition. A person can pause the walkthrough, supply evidence, or clarify the plan along the way.

This flow applies to computer, social, and mixed environments. A stage may be performed through commands and applications, by visiting an institution, or through another human action. Screenshots, photographs, documents, command output, and observations can provide evidence, with a clear account of what was reported, what was observed, and what was actually checked.

The basic retained unit is one documented walkthrough, or concrete realization, of an identified plan model. Starting the realization creates its main Markdown document and a directory named by its creation timestamp, including year, month, day, hour, minute, and second, for example `2026-10-21T14-30-25`. The main document records the start, timezone, model file, branch, and version in frontmatter and presents a readable stage map with statuses such as `pending`, `in progress`, and `completed`.

Each stage has its own Markdown document with three main parts: actual input state, performed actions, and observed output state. Checks, commands, deviations, decisions, and supporting evidence appear in the corresponding part. The main document opens these stage documents directly; additional indexes and repeated navigation are unnecessary. The walkthrough is both factual evidence of execution and readable documentation of how the result was obtained. Its main document can become an overview page and its stage documents a sequence of documentation pages without first reconstructing the experience from unrelated logs.

The plan describes the transition model, while the walkthrough preserves the facts of a concrete execution. During a realization, the machine monitors whether its model has changed. If the model changes, the current realization ends with that reason recorded and a successor starts against the changed model. This also applies when a compatible model change updates the same file without creating another model file. The relationship between predecessor and successor is recorded in their main documents. The successor carries forward the records and evidence of unchanged stages; completed status is retained where the result remains applicable after checking dependencies and current conditions. A stage with unchanged text may still need rechecking if its inputs have changed. Inherited materials are included in the retained walkthrough so that a reader does not have to follow a chain of previous realizations to understand it.

Execution progress is visible in the realization's stage map, alongside the model, with the current stage, checked results, and remaining path clear. The model itself does not acquire `in progress` or `completed` markers. Documented walkthroughs and their evidence are retained for verification, documentation, and reuse. The main realization document, stage documents, and attachments provide this context without separate registration artifacts or a full plan snapshot for every clarification.

`path-options.md` remains useful after planning as a living catalog of achievement paths. Available realizations and any useful execution statistics can be described in the plan context without introducing extra artifacts solely to register a manual walkthrough.

Machine of Goals artifacts should remain understandable when goals become
deeply nested or when one project directly uses a goal, plan, subplan, or
realization from another project. Human navigation is therefore expressed by
contextual Markdown links placed where the relationship is described. A
frontmatter id or path remains machine-readable provenance and does not replace
a useful link in the artifact body. Direct reference does not require export or
import: the consumer records the source project, artifact, link scope, and
revision while the source remains in its original goal context.

The goal, model, and documented walkthrough with evidence form a transferable account of goal achievement. Another person can inspect a reference walkthrough, begin their own execution, and compare the observed states and results. A divergence identifies a concrete point for discussion with the author or group: the stage, input conditions, action, expected result, and observed difference. Such a conflict may reveal different conditions, a changed environment, or an error in the model. Discussing these differences and refining the model builds shared knowledge within the small group for which Double is intended.

A goal can be exported externally in its source form: Markdown artifact files with frontmatter and any selected supporting materials. The export scope is chosen according to its purpose. It may contain only the goal description and plan model, or also include selected or all documented realizations, stage records, and evidence, for example so another person can study how the plan was carried out. Execution history is optional export content rather than a prerequisite for transferring the goal and model. Source export preserves the selected materials in their existing artifact form.

For a model already carried out manually, Machine of Goals also includes the possibility of making its method and experience reusable in two collapsed forms. The first is an AI-agent skill: the plan model and documented walkthrough become reusable guidance through which an agent can accompany users. The second is an automated action: the method demonstrated by the walkthrough is collapsed into action performed automatically in an appropriate environment. In the user's Vygotsky-inspired framing, both concern turning an acquired way of acting into a skill, while the second emphasizes a collapsed automatic action. An agent skill and an automated action are distinct possible results; neither implies the other, and they may be combined where useful.

These collapsed forms make the experience of a manually executed plan available beyond its source artifacts. They preserve their connection to the source goal, branch, model version, walkthrough, and available documentation. This describes what Machine of Goals should make possible, without choosing the generation flow, implementation technology, or operating contract that will govern it.

Preparing a goal for publication or exchange includes selecting the goal description, plan, walkthrough, and evidence to share; identifying personal data throughout the selected material; removing, redacting, or replacing that data in sharing copies; and reviewing the resulting package before release. Cleanup covers text, images, attached documents, filenames, metadata, and links that could reveal the original private material. Private originals remain separate from the prepared copies. The cleaned materials should retain the relationship between stages, actions, and results; where cleanup limits what a reader can verify, that limitation should be clear.

The documented walkthrough is already documentation suitable in substance for a blog, website, or exported goal package. Personal-data cleanup prepares that documentation for its intended audience. Publication and export preserve the connection between the goal, plan, and selected execution example without exposing the private source material. The concrete cleanup tools and publishing mechanisms remain matters for later design.

The machine can also help prepare project documentation for external software implementation or for collapsing the plan into a reusable realization. The integration of the machine of goals with the Spec-Driven Development approach is especially interesting. The machine itself does not implement this approach. But the artifacts generated by the machine should be maximally suitable for using the SDD approach.

It is quite possible that other methodologies exist or will appear; in that case, the machine of goals should adapt to these new methodologies.

A skill provides reusable guidance for an agent; an automated action performs the covered actions in its environment and can produce ordinary logs without narrating every action as a manual walkthrough. Invoking a collapsed skill or automated action creates no Machine of Goals timestamped execution directory, frozen-plan copy, realization document, stage journal or additional index. Its reusable mechanism is the realization; the machine does not impose a second execution-history layer. Checks and user-selected authority remain binding. An automatic realization must validate the initial state, required intermediate results, and final state defined by the plan. **Creating reusable ways to achieve goals and exchanging them with their execution experience within the Double ecosystem is one of the central ideas of Machine of Goals.**

Repeatability and automation are separate concerns. A manual walkthrough may serve as a reference for many later executions, while an executable realization may be used only once. Both manual and automatic experience can reveal changes needed in the model or its realizations. Exchange preserves the goal context, plan, relevant realizations, validation criteria, and selected documented walkthroughs with evidence prepared for the intended audience.

A branch is the boundary for selecting a current model and cleaning up obsolete working material. On explicit request, the user can keep a selected current version of that branch, choose the realizations and evidence needed for further work or documentation, include useful inherited material in the retained walkthroughs, and remove earlier versions and their unneeded dependent artifacts. A retained realization of an earlier version remains an example of that version and keeps the model context needed to understand it; it is not relabeled as execution of a newer model. Cleanup leaves a readable, self-contained set and does not affect independent branches. Increasing a version never deletes history automatically. Cleanup is a separate requested operation, for example during preparation for documentation or export.

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
- independently evolving plan branches
- branch-local model versions and major-version model files
- explicit cleanup of obsolete branch versions and dependent artifacts
- selectable path and subplan options
- execution variants
- built-in interactive manual execution flow
- documented walkthrough as both evidence and documentation
- stage-linked execution evidence
- stable stage anchors and short English stage names
- timestamp-named realization directories
- realization stage map and separate three-part stage documents
- successor realization and inherited stage results after a model change
- visible progress of a concrete walkthrough
- optional collapsing of manually demonstrated execution experience
- AI-agent skill and automated-action forms
- source-artifact export with optional walkthroughs and evidence
- repeated manual and automatic execution
- contextual artifact navigation
- direct cross-project artifact reference
- plan model refinement from execution experience
- preservation of the facts of a walkthrough
- reference walkthrough and comparison with later executions
- divergence reporting and shared group knowledge
- publication and exchange of a goal with its plan and walkthrough
- personal-data identification, cleanup, and review before sharing
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
- collapsed realization of the plan
- automatically executable algorithm
- exchange of plans and their execution experience
- `double/goals` catalog
- catalog of a separate goal
- subgoals
- goal artifacts
- imported goals, plans, realizations, and reference walkthroughs
- connection with Double
- possible connection with Machine of Ideas

## 6. Assumptions

- A goal can be represented as a structured artifact that develops through stages.
- A goal can be described as a verifiable target state whose achievement is checked by comparing the result with the original description of the goal.
- A good goal should have success criteria and a context of constraints.
- For many goals, several possible paths of realization exist.
- A plan moves the subject from the initial state to the target state, or to a state that is closer to the goal.
- One plan may contain several selectable paths or subplans with different costs and efficiencies.
- Alternative achievement paths may remain options or subplans within a model, while independently maintained plans for the same goal have different `branch` values.
- A version change within a branch is evolution; a new branch is a parallel plan with an independent version history.
- MINOR and PATCH updates keep the model file; MAJOR changes preserve the previous model and create another branch-named model file.
- The current version is chosen within a branch; earlier major versions in that branch do not by themselves represent parallel plans.
- The plan is a model for execution; each stage connects an input state, action, expected output state, and check.
- Stage anchor IDs remain stable and short English names produce readable stage filenames.
- A documented walkthrough records concrete execution and simultaneously serves as evidence and readable documentation.
- The machine includes an interactive manual execution flow for computer, social, and mixed environments.
- Walkthrough evidence remains connected to the stages and results it substantiates.
- A realization records its model file, branch, and starting version; a model change ends it and starts a linked successor while preserving the facts already recorded.
- The successor inherits unchanged stage records and evidence, and retains completed status where inputs, dependencies, and results remain applicable.
- Progress statuses belong to the realization's map, not to the plan model.
- A realization uses a timestamp-named directory, a main Markdown document, separate stage documents with input state, actions, and output state, and supporting attachments.
- Structured metadata remains in Markdown frontmatter; separate YAML files and extra navigation indexes are unnecessary.
- Simple manual execution should not require extra registration, release, or revision-snapshot artifacts merely to preserve the walkthrough.
- `path-options.md` is a living catalog of achievement paths. The goal links documented realizations; their own maps expose actual progress. The plan contains no execution registry, statistics or progress projection.
- Source export can transfer the goal description and plan model alone, or include selected or all documented realizations and supporting evidence.
- A manually executed model and its walkthrough can be collapsed on request into an AI-agent skill or an automated action; these are distinct possible results and may be combined.
- The idea establishes these reuse and export capabilities without assigning their generation flow to a particular operating contract.
- Repeatability does not depend on automation, and a manual execution example can support repeated use by other people.
- Contextual Markdown links should connect goals, plan elements, realizations,
  frozen plans, stage records and evidence where those relationships are used;
  artifacts should not repeat a universal navigation menu.
- A goal, subgoal, plan, or realization in another project may be used by
  direct reference without first exporting or importing it.
- A plan may contain sequential, parallel, and cyclic sections, as well as several entry and exit points.
- Subgoals and partial results appear where the plan has intermediate verifiable states.
- A goal achievement plan can be transformed into an algorithm if the steps, checks, and transitions are clear enough.
- Machine of Goals does not generate arbitrary code; an executable result implements the plan or its selected subplans.
- Before executing an algorithm, Machine of Goals should explain the plan: which steps are performed, why they were chosen, which parameters are controlled, and where the check points are located.
- The plan should support flexible execution: stop points, interactive execution of stages, parameter review, and movement between expanded and collapsed forms.
- A goal can be shared with its plan and a reference walkthrough, and may also include collapsed realizations.
- Publication or exchange includes selecting material, identifying personal data, cleaning sharing copies, and checking the prepared package.
- Cleanup preserves private originals separately and retains enough context to explain the execution without exposing personal data.
- Differences between a reference walkthrough and another person's execution can be reported and used to refine shared knowledge and the plan model.
- Machine of Goals is a separate workflow inside Double.
- For Machine of Goals, it is necessary to work through agent roles for executing the workflow of the machine of goals.
- Machine of Ideas artifacts can be used as material for Machine of Goals; this is desirable, but not mandatory.
- Constraints, resources, dependencies, risks, stage costs, and so on will need to be modeled and stored in Markdown artifact files produced by the machine of goals.
- Goals are stored in the `double/goals` catalog.
- Each goal is represented by a separate catalog and follows the universal naming principle [`Double layout naming convention`](../../Double.md#double-layout-naming-convention): the catalog name is written in `kebab-case`, and a Markdown file with the same name is created inside the catalog.
- Subgoals can be created as nested catalogs inside the goal catalog and use the same naming principle.
- Machine of Goals artifacts are stored in the main catalog of the corresponding goal, so that the goal, its plans, explanations, parameters, checks, and executable algorithms remain in one working context.
- Plans may be imported into another project with their goal context, relevant realizations, checks, and selected documented walkthroughs.
- A documented walkthrough and its evidence are retained for their verification and documentary value; automatic execution may produce ordinary operational logs.
- On request, branch cleanup can remove obsolete versions and dependent artifacts while preserving a self-contained selected model, realizations, and evidence.
- Retained historical realizations keep their original model context; a version increase does not automatically remove history or relabel previous execution.

## 7. Examples / Scenarios

- The user formulates a goal: "create a CLI for Double".
- Machine of Goals clarifies what counts as the achieved result.
- The system proposes several selectable paths inside the plan: a minimal research path, a prototype path, a full CLI path, a path for preparing a specification for SDD, and a packaging and distribution path.
- For each plan, the machine shows stages, dependencies, cost, risks, completion criteria, and parameters that need to be controlled.
- The user selects a plan or assembles a hybrid plan from several variants.
- The machine explains the selected plan: why the stages go in this order, which checks must be performed, and which decisions remain interactive.
- Stop points are added to the plan: for example, after clarifying CLI commands, after choosing the architecture, after preparing the specification, and before handing the plan over to implementation.
- After a manual walkthrough, the user may request the demonstrated model and execution experience in the form of an AI-agent skill or an automated action, while retaining the connection to the source goal and model.

Another example:

- The user wants to "monetize the exchange of ideas".
- Machine of Goals helps clarify the business goal, constraints, ethical frame, and success criteria.
- Then the system proposes plan paths: testing a subscription, testing a marketplace, paid workflows, private spaces, selling curated knowledge packages.
- For each variant, the machine describes entry conditions, required resources, expected intermediate results, the cost of validation, and stop criteria.
- The user chooses a hypothesis-validation plan and marks the stages that should be performed interactively.
- The machine explains which plan parameters need to be controlled: number of participants, quality of curated packages, willingness to pay, support cost, legal and ethical constraints.
- If part of the plan can be automated, the machine can prepare an executable algorithm for data collection, experiment management, reminders, or metric checks, but this does not replace the business plan itself.

A manual walkthrough and sharing example:

- The user wants to complete an administrative procedure and chooses interactive manual execution.
- The machine guides the user through the model, explaining each stage's input state, action, expected result, and check.
- The user performs actions both on a computer and in person, providing documents, screenshots, or photographs as evidence.
- The walkthrough records the actual actions and results alongside the corresponding plan stages, including deviations and any model clarifications.
- To share the experience, the user selects the goal, plan, and walkthrough materials, cleans personal data from sharing copies, and reviews the resulting package.
- The prepared walkthrough can be published as documentation or exchanged with the goal and plan as a reference example.
- Another person begins a separate walkthrough and reports a difference at a particular stage; the group compares conditions and results and refines the model where needed.

Export and reuse variants:

- To transfer only the intended method, the user exports the goal description and plan model as source Markdown artifacts without execution records.
- To share experience for study, the user exports the goal and model together with selected or all documented walkthroughs and their supporting materials, prepared for the intended audience.
- To reuse a manually demonstrated method through an AI agent, the user requests a skill based on the model and walkthrough.
- To reuse that method as automatic execution, the user requests an automated action based on the demonstrated passage through the model.

A branch evolution and cleanup example:

- The goal has a `double` branch with model `plan-double-v1.md` at version `1.4.0`; a major redesign creates `plan-double-v2.md` at version `2.0.0` within the same branch.
- A separately maintained alternative has branch `lightweight`, model `plan-lightweight-v1.md`, and its own version history.
- A realization records the selected branch, model file, and version. If its model changes, a successor realization carries forward applicable stage results and records the remaining work against the changed model.
- For export, the user requests keeping the current `double` model and selected walkthroughs, including useful inherited evidence. Earlier models and dependent materials that are no longer needed are removed; a retained historical example keeps its required model context. The `lightweight` branch remains independent.

## 8. Signals of Value

- This idea closes the practical gap between reflection and action.
- Machine of Goals is an independent workflow for transforming a goal into a plan with selectable paths, an explainable algorithm, and, if necessary, registered executable realizations.
- The system can be useful for personal goals as well as project, research, and software goals.
- The ability to bring a goal to an explainable algorithm and, if necessary, collapse the plan into an executable mechanism makes the idea especially suitable for Double.
- Machine of Goals is a foundation for agent-assisted planning inside the Double ecosystem.
- Plan explanation, controlled parameters, stop points, and interactive execution make work with goals manageable rather than blindly automatic.
- The exchange of collapsed plans creates practical value: successful ways of achieving goals can be reused, adapted, and improved.
- Manual execution produces evidence and documentation together, preserving experience that another person can follow.
- Sharing goals, plans, and reference walkthroughs supports practical knowledge within a small group.
- Personal-data cleanup makes publication and exchange part of a considered sharing process.
- Comparing later walkthroughs with reference examples reveals concrete differences that can improve the shared model.
- Branches distinguish parallel approaches from evolution, while requested cleanup keeps the retained working and documentary context manageable.

## 9. Open Questions


## 10. Boundaries / Non-Goals

- This artifact does not define the final Machine of Goals workflow.
- This artifact does not design the software architecture.
- This artifact does not create ready CLI commands.
- This artifact does not claim that Machine of Goals should generate arbitrary code; its software result is limited to the automatically executable algorithm of a collapsed plan.
- This artifact does not replace future conceptual work.
- This artifact does not claim that all human goals should be algorithmizable.
- This artifact does not fully resolve the question of motivation, psychology, and ethics in working with goals.
- This artifact includes personal-data cleanup and review as stages of preparing material for sharing, but does not design the cleanup tools, publishing system, or export format.
- Source-artifact export and the two collapsed forms are intended capabilities, not generation procedures. The idea does not yet assign their flow to Machine of Ideas contracts, the Double Agent, or another operating contract.

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

Machine of Goals is a separate workflow in Double. Its main flow develops a model and proceeds to execution:

`Goal Capture -> Path Discovery -> Plan Model -> Execution Variant Choice -> Plan Execution -> Result Validation`

Choosing interactive manual execution enters the built-in walkthrough flow. Source-artifact export may include the goal and model alone or add selected or all walkthroughs and evidence. A manually demonstrated method can also be made reusable as an AI-agent skill or an automated action. The concrete flow for producing these forms is outside this idea's scope. Preparing selected materials for publication or exchange includes personal-data cleanup and review.

Basic goal context:

```text
double/
  goals/
    goals.md
    my-first-goal/
      my-first-goal.md
      path-options.md
      plan-double-v1.md
      plan-double-v2.md
      plan-lightweight-v1.md
      realizations/
        2026-10-21T14-30-25/
          realization.md
          s01-prepare-documents.md
          s02-submit-application.md
          attachments/
      my-first-subgoal/
        my-first-subgoal.md
        plan-double-v1.md
```

The `double/goals` catalog is the root catalog of goals, and the `double/goals/goals.md` file describes this catalog. The `my-first-goal` catalog represents a separate goal, and its main artifact is `my-first-goal.md`. The nested `my-first-subgoal` catalog represents a subgoal, and its main artifact is `my-first-subgoal.md`. Separate Markdown model files distinguish branches and retained major versions; a subgoal can have its own models in its catalog. The example includes historical and parallel models to show the distinction, not to require several models for every goal. Files of Machine of Goals artifacts remain in the working context of the corresponding goal or subgoal.

`path-options.md` begins as the project artifact for discovering and comparing achievement paths, then remains their living catalog. The plan context identifies available execution variants and links the walkthroughs and supporting materials where they are relevant.

The realization directory's timestamp remains its creation time. Its main Markdown document holds the execution context and stage map; each stage document uses the three-part input, actions, and output structure. Branch, model version, timezone, and inheritance metadata belong in Markdown frontmatter. A reference example and a later person's walkthrough remain distinguishable. Commands, results, images, and documents preserve the context needed to understand what happened. Every command generated for a human to execute during a manual stage is recorded in generation order before or when it is presented; corrected or superseded commands and deviations remain visible. Generated commands use protected-input references or placeholders rather than literal secrets.

The branch is the scope of version selection and requested cleanup. Retained walkthroughs include useful inherited materials and sufficient original model context; deleting obsolete versions and unneeded dependent artifacts does not create dangling references or silently reinterpret historical results. A documentation or export package may select one branch or several explicitly identified branches.

Sharing copies are prepared separately from private source materials. The published or exported package retains the relationship between the goal, model, documented execution, and cleaned evidence, and its links must not expose private originals.

## 13. Development Artifacts

### 13.1 Concepts

Concept artifact: [Machine of Goals Concepts](./machine-of-goals-concepts.md)

| Concept | Summary |
| --- | --- |
| [Goal as Verifiable Target State](./machine-of-goals-concepts.md#concept-goal-as-verifiable-target-state) | A desired state whose achievement can be verified. |
| [Initial State and Target State](./machine-of-goals-concepts.md#concept-initial-state-and-target-state) | The state pair that frames the transition toward a goal. |
| [Success Criteria](./machine-of-goals-concepts.md#concept-success-criteria) | Criteria for achievement, partial achievement, failure, or review. |
| [Realization Path](./machine-of-goals-concepts.md#concept-realization-path) | A possible achievement strategy that may become a route within a model or a separate plan branch. |
| [Plan as Transition Model](./machine-of-goals-concepts.md#concept-plan-as-transition-model) | A graph of expected states, actions, and checks, separate from concrete execution progress. |
| [Plan Branch](./machine-of-goals-concepts.md#concept-plan-branch) | An independent plan lineage that distinguishes parallel alternatives from version evolution. |
| [Plan Model Version](./machine-of-goals-concepts.md#concept-plan-model-version) | A compatibility-based model identity within a branch, with separate files for major changes. |
| [Documented Plan Realization](./machine-of-goals-concepts.md#concept-documented-plan-realization) | One timestamped execution context with a stage map, model identity, and retained evidence. |
| [Stage Execution Record](./machine-of-goals-concepts.md#concept-stage-execution-record) | A three-part input, actions, and output document with stage-linked checks and evidence. |
| [Realization Succession and Inheritance](./machine-of-goals-concepts.md#concept-realization-succession-and-inheritance) | A linked successor preserves applicable results when a model change ends the current realization. |
| [Contextual Artifact Navigation](./machine-of-goals-concepts.md#concept-contextual-artifact-navigation) | Meaningful local links and a direct stage map, with provenance in Markdown frontmatter. |
| [Subgoal and Partial Achievement](./machine-of-goals-concepts.md#concept-subgoal-and-partial-achievement) | A goal used within another goal, with its own verifiable context. |
| [Plan Cost and Efficiency](./machine-of-goals-concepts.md#concept-plan-cost-and-efficiency) | Execution-based and domain-specific measures of cost and result. |
| [Plan Algorithmization](./machine-of-goals-concepts.md#concept-plan-algorithmization) | Making a model actionable through transitions, checks, parameters, and control boundaries. |
| [Plan Explanation and Control](./machine-of-goals-concepts.md#concept-plan-explanation-and-control) | Explanation of states, actions, checks, and next transitions under user control. |
| [Interactive and Automatic Execution](./machine-of-goals-concepts.md#concept-interactive-and-automatic-execution) | Manual, mixed, and automatic forms, independent of repeatability and chosen by the user. |
| [Collapsed Plan Realization](./machine-of-goals-concepts.md#concept-collapsed-plan-realization) | An optional reusable AI-agent skill, executable module, or combination linked to the source model. |
| [Plan Exchange](./machine-of-goals-concepts.md#concept-plan-exchange) | Sharing a goal, selected plan branches, and usable execution examples with their context. |
| [Branch Cleanup](./machine-of-goals-concepts.md#concept-branch-cleanup) | Explicit reduction of one branch to a self-contained useful model and execution context. |
| [Publication Preparation](./machine-of-goals-concepts.md#concept-publication-preparation) | Selection, personal-data cleanup of copies, and review before publication or exchange. |
| [Shared Execution Experience](./machine-of-goals-concepts.md#concept-shared-execution-experience) | Group learning from evidence-based comparison of reference and later walkthroughs. |
| [Goal Artifact Context](./machine-of-goals-concepts.md#concept-goal-artifact-context) | The Markdown-based home of a goal, branch models, walkthroughs, and supporting materials. |

### 13.2 Principles

Principle artifact: [Machine of Goals Principles](./machine-of-goals-principles.md)

| Principle | Statement | Related Concepts |
| --- | --- | --- |
| [Goal Verifiability Before Planning](./machine-of-goals-principles.md#principle-goal-verifiability-before-planning) | Begin with a verifiable target state before choosing tasks. | [Goal as Verifiable Target State](./machine-of-goals-concepts.md#concept-goal-as-verifiable-target-state), [Success Criteria](./machine-of-goals-concepts.md#concept-success-criteria), [Initial State and Target State](./machine-of-goals-concepts.md#concept-initial-state-and-target-state) |
| [Plan as an Understandable Transition Graph](./machine-of-goals-principles.md#principle-plan-as-an-understandable-transition-graph) | Keep an understandable transition model separate from concrete execution progress. | [Plan as Transition Model](./machine-of-goals-concepts.md#concept-plan-as-transition-model), [Initial State and Target State](./machine-of-goals-concepts.md#concept-initial-state-and-target-state), [Documented Plan Realization](./machine-of-goals-concepts.md#concept-documented-plan-realization) |
| [Distinguish Branches from Versions](./machine-of-goals-principles.md#principle-distinguish-branches-from-versions) | Distinguish parallel branch identity from compatibility-based evolution within a branch. | [Plan Branch](./machine-of-goals-concepts.md#concept-plan-branch), [Plan Model Version](./machine-of-goals-concepts.md#concept-plan-model-version), [Plan as Transition Model](./machine-of-goals-concepts.md#concept-plan-as-transition-model) |
| [Plan Is Project, Algorithm Is Realization](./machine-of-goals-principles.md#principle-plan-is-project-algorithm-is-realization) | Keep intended achievement distinct from its guided or executable embodiment. | [Plan as Transition Model](./machine-of-goals-concepts.md#concept-plan-as-transition-model), [Plan Algorithmization](./machine-of-goals-concepts.md#concept-plan-algorithmization), [Collapsed Plan Realization](./machine-of-goals-concepts.md#concept-collapsed-plan-realization) |
| [Record a Realization at Its Start](./machine-of-goals-principles.md#principle-record-realization-at-start) | Create a timestamped, model-bound realization context when execution begins. | [Documented Plan Realization](./machine-of-goals-concepts.md#concept-documented-plan-realization), [Stage Execution Record](./machine-of-goals-concepts.md#concept-stage-execution-record), [Contextual Artifact Navigation](./machine-of-goals-concepts.md#concept-contextual-artifact-navigation) |
| [Preserve Execution as Evidence and Documentation](./machine-of-goals-principles.md#principle-preserve-documented-execution) | Preserve actual input, actions, output, and evidence as reusable documentation. | [Stage Execution Record](./machine-of-goals-concepts.md#concept-stage-execution-record), [Documented Plan Realization](./machine-of-goals-concepts.md#concept-documented-plan-realization), [Success Criteria](./machine-of-goals-concepts.md#concept-success-criteria) |
| [Model Changes Start Successor Realizations](./machine-of-goals-principles.md#principle-model-changes-start-successor-realizations) | Make model changes explicit execution boundaries and inherit results by applicability. | [Realization Succession and Inheritance](./machine-of-goals-concepts.md#concept-realization-succession-and-inheritance), [Plan Model Version](./machine-of-goals-concepts.md#concept-plan-model-version), [Stage Execution Record](./machine-of-goals-concepts.md#concept-stage-execution-record) |
| [Repeatability Is Independent of Automation](./machine-of-goals-principles.md#principle-repeatability-independent-of-automation) | Allow repeated manual use without deriving lifecycle from automation registration. | [Interactive and Automatic Execution](./machine-of-goals-concepts.md#concept-interactive-and-automatic-execution), [Documented Plan Realization](./machine-of-goals-concepts.md#concept-documented-plan-realization), [Plan Exchange](./machine-of-goals-concepts.md#concept-plan-exchange) |
| [Automation Under User Control](./machine-of-goals-principles.md#principle-automation-under-user-control) | Choose execution and optional collapsing under user-selected control boundaries. | [Interactive and Automatic Execution](./machine-of-goals-concepts.md#concept-interactive-and-automatic-execution), [Collapsed Plan Realization](./machine-of-goals-concepts.md#concept-collapsed-plan-realization), [Plan Explanation and Control](./machine-of-goals-concepts.md#concept-plan-explanation-and-control) |
| [Explanation Before Execution](./machine-of-goals-principles.md#principle-explanation-before-execution) | Explain stage inputs, actions, expected outputs, and checks before acting. | [Plan Explanation and Control](./machine-of-goals-concepts.md#concept-plan-explanation-and-control), [Plan as Transition Model](./machine-of-goals-concepts.md#concept-plan-as-transition-model), [Stage Execution Record](./machine-of-goals-concepts.md#concept-stage-execution-record) |
| [Collapsing Format Should Follow Goal Type](./machine-of-goals-principles.md#principle-collapsing-format-should-follow-goal-type) | Choose skills, executable modules, or mixtures to fit the goal and its environment. | [Collapsed Plan Realization](./machine-of-goals-concepts.md#concept-collapsed-plan-realization), [Interactive and Automatic Execution](./machine-of-goals-concepts.md#concept-interactive-and-automatic-execution), [Goal Artifact Context](./machine-of-goals-concepts.md#concept-goal-artifact-context) |
| [Goal and Plan Must Not Be Separated](./machine-of-goals-principles.md#principle-goal-and-plan-must-not-be-separated) | Preserve goal, conditions, checks, and example context when reusing a plan. | [Plan Exchange](./machine-of-goals-concepts.md#concept-plan-exchange), [Goal Artifact Context](./machine-of-goals-concepts.md#concept-goal-artifact-context), [Shared Execution Experience](./machine-of-goals-concepts.md#concept-shared-execution-experience) |
| [Prepare Sharing Copies Before Publication](./machine-of-goals-principles.md#principle-prepare-sharing-copies-before-publication) | Select, clean, and review sharing copies while preserving private factual originals. | [Publication Preparation](./machine-of-goals-concepts.md#concept-publication-preparation), [Stage Execution Record](./machine-of-goals-concepts.md#concept-stage-execution-record), [Plan Exchange](./machine-of-goals-concepts.md#concept-plan-exchange) |
| [Use Divergence to Refine Shared Models](./machine-of-goals-principles.md#principle-use-divergence-to-refine-shared-models) | Use stage-specific differences and evidence to improve shared understanding and models. | [Shared Execution Experience](./machine-of-goals-concepts.md#concept-shared-execution-experience), [Stage Execution Record](./machine-of-goals-concepts.md#concept-stage-execution-record), [Plan as Transition Model](./machine-of-goals-concepts.md#concept-plan-as-transition-model) |
| [Clean Branches on Request](./machine-of-goals-principles.md#principle-clean-branches-on-request) | Remove obsolete branch history explicitly while keeping retained evidence self-contained. | [Branch Cleanup](./machine-of-goals-concepts.md#concept-branch-cleanup), [Plan Branch](./machine-of-goals-concepts.md#concept-plan-branch), [Realization Succession and Inheritance](./machine-of-goals-concepts.md#concept-realization-succession-and-inheritance) |
| [Navigation Follows Context](./machine-of-goals-principles.md#principle-navigation-follows-context) | Use direct stage navigation and meaningful local links with provenance in frontmatter. | [Contextual Artifact Navigation](./machine-of-goals-concepts.md#concept-contextual-artifact-navigation), [Goal Artifact Context](./machine-of-goals-concepts.md#concept-goal-artifact-context), [Documented Plan Realization](./machine-of-goals-concepts.md#concept-documented-plan-realization) |
| [Subgoal as Its Own Context](./machine-of-goals-principles.md#principle-subgoal-as-its-own-context) | Give a stable subgoal its own verifiable context and subplan. | [Subgoal and Partial Achievement](./machine-of-goals-concepts.md#concept-subgoal-and-partial-achievement), [Goal Artifact Context](./machine-of-goals-concepts.md#concept-goal-artifact-context), [Plan Exchange](./machine-of-goals-concepts.md#concept-plan-exchange) |
| [Cost Should Accumulate From Execution](./machine-of-goals-principles.md#principle-cost-should-accumulate-from-execution) | Evaluate cost through execution experience and domain-specific criteria. | [Plan Cost and Efficiency](./machine-of-goals-concepts.md#concept-plan-cost-and-efficiency), [Plan as Transition Model](./machine-of-goals-concepts.md#concept-plan-as-transition-model), [Plan Exchange](./machine-of-goals-concepts.md#concept-plan-exchange) |
