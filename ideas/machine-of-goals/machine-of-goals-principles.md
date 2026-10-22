---
id: machine-of-goals-principles
kind: principle-artifact
status: release-candidate
mindmap-plugin: basic
produced-by: machine-of-ideas/principle-synthesis-agent
interaction-language: Russian
artifact-language: English
publication-path: ideas/machine-of-goals/machine-of-goals-principles.md
derived-from:
  - machine-of-goals
  - machine-of-goals-concepts
---

# Principle Artifact: Machine of Goals

Idea: [Machine of Goals](./machine-of-goals.md#machine-of-goals)

## 1. Principle Synthesis Summary

Machine of Goals connects a verifiable goal with an understandable model, user-selected execution, and retained evidence. Its principles distinguish independent plan branches from evolution within a branch, and expected model states from the facts of a concrete realization. A model change creates a successor execution with applicable inherited results rather than rewriting history.

Manual walkthroughs already provide documentation and can be reused independently of automation. Optional collapsing, preparation of sharing copies, comparison of later experience, and requested branch cleanup preserve that value while keeping control, personal data, and factual context understandable.

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

If a goal is not represented as a verifiable state, the machine cannot honestly build a path, compare selectable plan paths or realizations, complete execution, or evaluate partial achievement. At the same time, the degree of specification formality should depend on the type of goal and be determined during goal design.

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

A plan should connect initial and target states through understandable stages, actions, dependencies, expected outputs, and checks. Concrete progress belongs to the realization rather than to this model.

#### Derived From

- Source concept(s): [Plan as Transition Model](./machine-of-goals-concepts.md#concept-plan-as-transition-model), [Initial State and Target State](./machine-of-goals-concepts.md#concept-initial-state-and-target-state), [Documented Plan Realization](./machine-of-goals-concepts.md#concept-documented-plan-realization)
- Source relationship, boundary, or tension: the model must be useful before execution without confusing expected states with observed progress
- Source idea support: `Raw Description`, `Assumptions`, `Examples / Scenarios`
- Explicit or inferred: explicit

#### Rationale

An understandable transition is the minimum basis for choosing the next action and checking its result. Keeping actual progress outside the model lets several people use the same model without mixing their executions.

#### Implications Without Implementation

- Preserve the relation between each stage and the goal it advances.
- Describe stage input, action, expected output, and check; use stable anchors and readable names.
- Clarify incomplete models through explicit changes and realization succession.

#### Boundaries

- The plan need not be complete before controlled execution can begin.
- Understandability does not require full automation or a particular graph notation.

#### Anti-Patterns

- Treating a task list as sufficient without explaining transitions.
- Putting in-progress or completed markers into the plan model.

#### Questions

- None.

<a id="principle-distinguish-branches-from-versions"></a>

### principle-distinguish-branches-from-versions: Distinguish Branches from Versions

#### Statement

Use branch identity to distinguish independently maintained plans for one goal, and versions to describe evolution within each branch. Judge version changes by model compatibility.

#### Derived From

- Source concept(s): [Plan Branch](./machine-of-goals-concepts.md#concept-plan-branch), [Plan Model Version](./machine-of-goals-concepts.md#concept-plan-model-version), [Plan as Transition Model](./machine-of-goals-concepts.md#concept-plan-as-transition-model)
- Source relationship, boundary, or tension: parallel alternatives and historical evolution can coexist but mean different things
- Source idea support: `Summary`, `Raw Description`, `Assumptions`, branch evolution example
- Explicit or inferred: explicit

#### Rationale

A file numbered Plan 2 does not explain whether it replaces an earlier model or offers another approach. Named branches with independent version histories make that relationship explicit and give current-version selection a clear scope.

#### Implications Without Implementation

- Keep branch identity stable through the evolution of its model.
- Treat compatible MINOR and PATCH changes within the model file; preserve a separate model for a MAJOR change.
- Evaluate new prerequisites and dependencies for compatibility rather than classifying by edit size.
- Select a current version within the chosen branch.

#### Boundaries

- A route or subplan inside a model need not become another branch.
- Changing the execution mechanism alone need not change the model.
- Version metadata does not reconstruct every overwritten intermediate text.

#### Anti-Patterns

- Inferring parallelism from the number of retained major-version files.
- Selecting the highest version across unrelated branches.
- Treating an added mandatory prerequisite as compatible solely because the edit is small.

#### Questions

- None.

<a id="principle-plan-is-project-algorithm-is-realization"></a>

### principle-plan-is-project-algorithm-is-realization: Plan Is Project, Algorithm Is Realization

#### Statement

Keep the model of intended achievement distinct from the way it is embodied in guided or executable action, while preserving the connection between them.

#### Derived From

- Source concept(s): [Plan as Transition Model](./machine-of-goals-concepts.md#concept-plan-as-transition-model), [Plan Algorithmization](./machine-of-goals-concepts.md#concept-plan-algorithmization), [Collapsed Plan Realization](./machine-of-goals-concepts.md#concept-collapsed-plan-realization)
- Source relationship, boundary, or tension: a reusable way of acting embodies the model but is not the model itself
- Source idea support: `Summary`, `Raw Description`, `Assumptions`
- Explicit or inferred: explicit

#### Rationale

The distinction permits the same model to guide a person, an AI agent, or an executable module. Its checks and context remain interpretable even when part of the action is packaged for reuse.

#### Implications Without Implementation

- Keep reusable skills and executable modules linked to their goal, source model, and available documentation.
- Make coverage, prerequisites, and control boundaries understandable.
- Preserve the covered initial, required intermediate, and final state checks in automatic action.

#### Boundaries

- A skill need not be an executable program.
- A manual walkthrough remains a valuable realization without collapsing.
- This principle does not authorize arbitrary software generation.

#### Anti-Patterns

- Publishing a skill or script without its goal and model context.
- Treating a change of execution form as necessarily a new plan model.

#### Questions

- None.

<a id="principle-record-realization-at-start"></a>

### principle-record-realization-at-start: Record a Realization at Its Start

#### Statement

The beginning of concrete execution should create one readable realization context that identifies the model and owns its stage map and records.

#### Derived From

- Source concept(s): [Documented Plan Realization](./machine-of-goals-concepts.md#concept-documented-plan-realization), [Stage Execution Record](./machine-of-goals-concepts.md#concept-stage-execution-record), [Contextual Artifact Navigation](./machine-of-goals-concepts.md#concept-contextual-artifact-navigation)
- Source relationship, boundary, or tension: execution needs a durable factual beginning without extra registration and index layers
- Source idea support: `Raw Description`, `Assumptions`, `Notes`
- Explicit or inferred: explicit

#### Rationale

A main realization document makes it clear when execution began, what model it follows, and where current work stands. Stage documents keep the detail readable without turning the main document into a long transcript.

#### Implications Without Implementation

- Record start time, timezone, model file, branch, and starting version in Markdown frontmatter.
- Use the creation timestamp to identify the realization directory and retain it during updates.
- Keep the stage map in the realization and open stage documents directly from it.

#### Boundaries

- Creating the document does not establish successful execution.
- No separate registration artifact, standalone YAML metadata file, or run index is required solely to record a manual start.

#### Anti-Patterns

- Starting work with no retained model identity or execution context.
- Changing the directory timestamp whenever progress is updated.
- Scattering stage evidence across unrelated files without context.

#### Questions

- None.

<a id="principle-preserve-documented-execution"></a>

### principle-preserve-documented-execution: Preserve Execution as Evidence and Documentation

#### Statement

Record actual execution so that the same materials both substantiate results and explain how they were obtained.

#### Derived From

- Source concept(s): [Stage Execution Record](./machine-of-goals-concepts.md#concept-stage-execution-record), [Documented Plan Realization](./machine-of-goals-concepts.md#concept-documented-plan-realization), [Success Criteria](./machine-of-goals-concepts.md#concept-success-criteria)
- Source relationship, boundary, or tension: factual proof and readable documentation should be preserved together
- Source idea support: `Summary`, `Raw Description`, `Assumptions`, manual walkthrough example
- Explicit or inferred: explicit

#### Rationale

A stage account with input, actions, output, and supporting evidence lets another person inspect the result and follow the experience. Treating the account as disposable operational logging would discard the very material needed for verification and reuse.

#### Implications Without Implementation

- Keep each stage account focused on actual input state, performed actions, and observed output state.
- Place checks, deviations, commands, and evidence where they explain those three parts.
- Preserve corrected or superseded generated commands in order and distinguish reports, observations, and checks.
- Retain useful walkthroughs and evidence according to their verification and documentary value.

#### Boundaries

- An expected output or completed marker alone is not evidence.
- Automatic modules may emit ordinary logs without narrating every action.
- Readable records need not reproduce an entire conversation or expose protected inputs.

#### Anti-Patterns

- Deleting documentary walkthroughs by a default short working-log retention limit.
- Rewriting failed actions out of the record after correcting them.
- Publishing a claimed outcome with no connection to its supporting material.

#### Questions

- None.

<a id="principle-model-changes-start-successor-realizations"></a>

### principle-model-changes-start-successor-realizations: Model Changes Start Successor Realizations

#### Statement

End the current realization when its model changes and continue in a linked successor, inheriting stage records and completed results only where they remain applicable.

#### Derived From

- Source concept(s): [Realization Succession and Inheritance](./machine-of-goals-concepts.md#concept-realization-succession-and-inheritance), [Plan Model Version](./machine-of-goals-concepts.md#concept-plan-model-version), [Stage Execution Record](./machine-of-goals-concepts.md#concept-stage-execution-record)
- Source relationship, boundary, or tension: model improvement must preserve both factual continuity and the validity of carried-forward results
- Source idea support: `Raw Description`, `Assumptions`, branch evolution example
- Explicit or inferred: explicit

#### Rationale

One realization should not silently change what model its actions are judged against. A successor preserves useful work while making the model boundary explicit. Applicability depends on inputs and dependencies as well as unchanged stage text.

#### Implications Without Implementation

- Record the closure reason and predecessor-successor relationship in the main documents.
- Identify the updated model in the successor even when it is a compatible update in the same file.
- Carry unchanged stage records and evidence forward; retain completed status after checking dependencies and current conditions.
- Include inherited materials in a readable retained walkthrough.

#### Boundaries

- Inherited facts are not newly performed actions.
- Unchanged wording does not prove unchanged applicability.
- Realization succession does not imply a new full model snapshot for every refinement.

#### Anti-Patterns

- Changing the model identity of an existing realization in place.
- Marking an inherited stage complete after its required inputs changed without rechecking.
- Requiring readers to traverse every predecessor to understand a retained example.

#### Questions

- None.

<a id="principle-repeatability-independent-of-automation"></a>

### principle-repeatability-independent-of-automation: Repeatability Is Independent of Automation

#### Statement

Treat repeatability and degree of automation as separate concerns; manual walkthroughs can support repeated use, and automated actions can be one-time.

#### Derived From

- Source concept(s): [Interactive and Automatic Execution](./machine-of-goals-concepts.md#concept-interactive-and-automatic-execution), [Documented Plan Realization](./machine-of-goals-concepts.md#concept-documented-plan-realization), [Plan Exchange](./machine-of-goals-concepts.md#concept-plan-exchange)
- Source relationship, boundary, or tension: reuse depends on understandable models and experience, not on registering an automatic mechanism
- Source idea support: `Raw Description`, `Assumptions`, `Signals of Value`
- Explicit or inferred: explicit

#### Rationale

A reference manual walkthrough can help many people achieve a goal. Requiring automation before supporting repetition or exchange would exclude the social and interactive experience at the center of the idea.

#### Implications Without Implementation

- Allow later users to begin their own walkthroughs from a shared reference.
- Evaluate a reusable skill, program, and manual example according to their actual role.
- Keep user-selected execution form distinct from model identity and version.

#### Boundaries

- Repeatability does not establish universal applicability.
- This principle does not require every execution to be repeated or collapsed.

#### Anti-Patterns

- Requiring an automatic realization before allowing reuse or export.
- Assuming that a script necessarily represents repeated use.

#### Questions

- None.

<a id="principle-automation-under-user-control"></a>

### principle-automation-under-user-control: Automation Under User Control

#### Statement

Offer interactive execution and optional collapsing according to user intent, and keep automated action within the boundaries selected by the user.

#### Derived From

- Source concept(s): [Interactive and Automatic Execution](./machine-of-goals-concepts.md#concept-interactive-and-automatic-execution), [Collapsed Plan Realization](./machine-of-goals-concepts.md#concept-collapsed-plan-realization), [Plan Explanation and Control](./machine-of-goals-concepts.md#concept-plan-explanation-and-control)
- Source relationship, boundary, or tension: automation is useful while manual and social action remain first-class ways of achieving goals
- Source idea support: `Summary`, `Raw Description`, `Assumptions`
- Explicit or inferred: explicit

#### Rationale

The same model may support guided action, a skill, an executable module, or a mixture. User control determines the form and scope of execution; creating a reusable form does not require using it for every walkthrough.

#### Implications Without Implementation

- Keep the built-in manual flow available without requiring collapsing.
- Collapse the model on request into a form suitable for its environment.
- Preserve stop points, review, and clear coverage of automated actions.

#### Boundaries

- The principle does not require repeated confirmation for every action within already selected boundaries.
- Full automation is possible where the goal and environment support it.

#### Anti-Patterns

- Collapsing or executing automatically as an unavoidable next stage.
- Treating manual guidance as an inferior or invalid plan form.
- Hiding which actions the program or agent will perform.

#### Questions

- None.

<a id="principle-explanation-before-execution"></a>

### principle-explanation-before-execution: Explanation Before Execution

#### Statement

Explain the selected stage through its input, proposed action, expected output, and check, using the state of already performed stages to justify the next transition.

#### Derived From

- Source concept(s): [Plan Explanation and Control](./machine-of-goals-concepts.md#concept-plan-explanation-and-control), [Plan as Transition Model](./machine-of-goals-concepts.md#concept-plan-as-transition-model), [Stage Execution Record](./machine-of-goals-concepts.md#concept-stage-execution-record)
- Source relationship, boundary, or tension: controlled action depends on understanding the transition and separating expectation from observation
- Source idea support: `Raw Description`, `Assumptions`, manual walkthrough example
- Explicit or inferred: explicit

#### Rationale

The explanation tells a person what they are about to do and what evidence to bring back. It also makes mixed and automatic action interpretable. Actual results then guide the following transition.

#### Implications Without Implementation

- Use the realization state when explaining the next stage.
- Keep expected output distinct from the output subsequently observed.
- Allow a dry run to explain an action without performing it.

#### Boundaries

- Explanation is not an endless approval loop.
- A dry run does not count as completed execution.
- The entire system need not be documented anew before each stage.

#### Anti-Patterns

- Ignoring failed prerequisites when choosing the next action.
- Presenting an anticipated result as a verified one.
- Performing real actions during an explanatory dry run.

#### Questions

- None.

<a id="principle-collapsing-format-should-follow-goal-type"></a>

### principle-collapsing-format-should-follow-goal-type: Collapsing Format Should Follow Goal Type

#### Statement

Choose a requested collapsed realization according to the goal, achievement environment, verification method, and intended use.

#### Derived From

- Source concept(s): [Collapsed Plan Realization](./machine-of-goals-concepts.md#concept-collapsed-plan-realization), [Interactive and Automatic Execution](./machine-of-goals-concepts.md#concept-interactive-and-automatic-execution), [Goal Artifact Context](./machine-of-goals-concepts.md#concept-goal-artifact-context)
- Source relationship, boundary, or tension: a reusable agent guide and an executable module support different kinds of action
- Source idea support: `Summary`, `Raw Description`, `Assumptions`
- Explicit or inferred: explicit

#### Rationale

A skill can guide a person through computer and social stages; an executable module can perform actions available in its environment. A mixed realization can combine them without forcing every stage into one format.

#### Implications Without Implementation

- Preserve the model connection, relevant checks, and documentation links in each form.
- Make clear which parts remain human actions.
- Keep publication of a walkthrough distinct from creating a reusable realization.

#### Boundaries

- Not every goal requires collapsing.
- No single skill or program format fits every environment.
- Compatibility with an external design methodology does not make that methodology mandatory.

#### Anti-Patterns

- Requiring a shell script for a social procedure.
- Calling any exported document an executable module.
- Choosing a format while losing checks or human decision boundaries.

#### Questions

- None.

<a id="principle-goal-and-plan-must-not-be-separated"></a>

### principle-goal-and-plan-must-not-be-separated: Goal and Plan Must Not Be Separated

#### Statement

Keep a reusable or shared plan connected to its goal, initial conditions, success criteria, and the context of any accompanying execution examples.

#### Derived From

- Source concept(s): [Plan Exchange](./machine-of-goals-concepts.md#concept-plan-exchange), [Goal Artifact Context](./machine-of-goals-concepts.md#concept-goal-artifact-context), [Shared Execution Experience](./machine-of-goals-concepts.md#concept-shared-execution-experience)
- Source relationship, boundary, or tension: experience can be transferred but its applicability depends on the original purpose and conditions
- Source idea support: `Summary`, `Raw Description`, `Assumptions`, sharing example
- Explicit or inferred: explicit

#### Rationale

A recipient needs both the model of achievement and the circumstances that make the reference understandable. The connection prevents a successful example from being mistaken for a universal procedure.

#### Implications Without Implementation

- Share selected branch models and examples with their goal and verification context.
- Keep reference and recipient walkthroughs distinguishable.
- Check applicability when adapting a plan or subgoal to a new context.

#### Boundaries

- The original goal need not be copied without adaptation.
- A prepared package may select useful materials rather than include all private history.

#### Anti-Patterns

- Publishing a bare sequence without the goal or result criteria.
- Treating reference success as sufficient proof that another person can follow it unchanged.

#### Questions

- None.

<a id="principle-prepare-sharing-copies-before-publication"></a>

### principle-prepare-sharing-copies-before-publication: Prepare Sharing Copies Before Publication

#### Statement

Prepare selected materials for their audience through personal-data identification, cleanup of sharing copies, and review while keeping private originals separate.

#### Derived From

- Source concept(s): [Publication Preparation](./machine-of-goals-concepts.md#concept-publication-preparation), [Stage Execution Record](./machine-of-goals-concepts.md#concept-stage-execution-record), [Plan Exchange](./machine-of-goals-concepts.md#concept-plan-exchange)
- Source relationship, boundary, or tension: the same evidence supports verification and documentation but may contain personal data
- Source idea support: `Summary`, `Raw Description`, `Assumptions`, manual sharing example
- Explicit or inferred: explicit

#### Rationale

A walkthrough already explains execution. Sharing it requires deliberate preparation across the goal, model, records, and attachments so that useful explanation survives without exposing private source material.

#### Implications Without Implementation

- Select the material appropriate for the intended publication or exchange.
- Review personal data in text, images, attached documents, filenames, metadata, and links.
- Preserve stage-to-result relationships in cleaned copies and make verification limits clear.
- Review the resulting package, including links that could reveal private originals.

#### Boundaries

- Cleanup tools, publishing platforms, and export formats are not prescribed here.
- An anonymized illustration is not automatically equivalent to the original evidence.

#### Anti-Patterns

- Publishing raw attachments because the surrounding prose is clean.
- Editing away private originals instead of preparing separate sharing copies.
- Leaving a public link that exposes the original private document.

#### Questions

- None.

<a id="principle-use-divergence-to-refine-shared-models"></a>

### principle-use-divergence-to-refine-shared-models: Use Divergence to Refine Shared Models

#### Statement

Treat differences between reference and later walkthroughs as concrete evidence for group discussion about model correctness, applicability, and environment.

#### Derived From

- Source concept(s): [Shared Execution Experience](./machine-of-goals-concepts.md#concept-shared-execution-experience), [Stage Execution Record](./machine-of-goals-concepts.md#concept-stage-execution-record), [Plan as Transition Model](./machine-of-goals-concepts.md#concept-plan-as-transition-model)
- Source relationship, boundary, or tension: a reusable example carries experience while another execution may encounter different conditions
- Source idea support: `Raw Description`, `Signals of Value`, sharing example
- Explicit or inferred: explicit

#### Rationale

A stage-specific difference makes the issue understandable to the author or group. Comparing conditions, actions, and results can improve the model without erasing the experience that revealed the difference.

#### Implications Without Implementation

- Locate the difference by stage and preserve its actual conditions, action, expected result, and observed result.
- Use the available evidence to discuss possible causes.
- Refine the model or clarify its limits while preserving the facts of each walkthrough.

#### Boundaries

- A difference does not automatically establish fault in the person or plan.
- No particular issue tracker or reporting service is required.

#### Anti-Patterns

- Reporting only that the plan does not work, with no execution context.
- Rewriting the reference example to hide a later conflict.
- Applying every local workaround to the shared model without considering conditions.

#### Questions

- None.

<a id="principle-clean-branches-on-request"></a>

### principle-clean-branches-on-request: Clean Branches on Request

#### Statement

Reduce branch history only on explicit request, retaining a selected model and the realizations, evidence, inherited material, and historical context needed for a self-contained useful set.

#### Derived From

- Source concept(s): [Branch Cleanup](./machine-of-goals-concepts.md#concept-branch-cleanup), [Plan Branch](./machine-of-goals-concepts.md#concept-plan-branch), [Realization Succession and Inheritance](./machine-of-goals-concepts.md#concept-realization-succession-and-inheritance)
- Source relationship, boundary, or tension: manageable working material and readable documentation must coexist with factual integrity
- Source idea support: `Summary`, `Raw Description`, `Assumptions`, branch cleanup example
- Explicit or inferred: explicit

#### Rationale

Keeping every version indefinitely can obscure the usable plan. Selection allows obsolete artifacts to be removed while retaining valuable examples and enough context to interpret them honestly.

#### Implications Without Implementation

- Select the retained version within the requested branch.
- Include useful inherited records before removing their unneeded predecessors.
- Keep necessary original model context for a retained historical realization.
- Leave independent branches and coherent retained references intact.

#### Boundaries

- A version increase is not itself a cleanup request.
- Latest model and most useful execution example need not be the same selection.
- A historical execution does not become an execution of the new version by relabeling.

#### Anti-Patterns

- Deleting history automatically when a version number increases.
- Removing a source still needed to understand a retained walkthrough.
- Keeping a predecessor link after deleting its target without resolving the retained context.

#### Questions

- None.

<a id="principle-navigation-follows-context"></a>

### principle-navigation-follows-context: Navigation Follows Context

#### Statement

Place useful Markdown links where relationships are explained and keep the realization map a direct route to its stages, without multiplying indexes or repeating global menus.

#### Derived From

- Source concept(s): [Contextual Artifact Navigation](./machine-of-goals-concepts.md#concept-contextual-artifact-navigation), [Goal Artifact Context](./machine-of-goals-concepts.md#concept-goal-artifact-context), [Documented Plan Realization](./machine-of-goals-concepts.md#concept-documented-plan-realization)
- Source relationship, boundary, or tension: structured provenance and human readability serve different but connected needs
- Source idea support: `Raw Description`, `Assumptions`, `Notes`
- Explicit or inferred: explicit

#### Rationale

Frontmatter identifies sources for processing, while links in the relevant context let a reader inspect the model, stage, or evidence. The same arrangement supports a documentation overview and stage pages.

#### Implications Without Implementation

- Keep branch, version, and model identity understandable beside execution records.
- Use direct stage links and contextual evidence links.
- Keep inherited documentation readable without requiring a chain of predecessor lookups.
- Distinguish direct cross-project reference from import and export.

#### Boundaries

- Every document need not link to every other document.
- A global registry or a standalone metadata file is not required for local navigation.

#### Anti-Patterns

- Repeating a universal menu in every stage file.
- Providing only frontmatter paths where a person needs a navigable link.
- Linking an old realization only to a mutable current model with no execution context.

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
- A subgoal has the same goal contract as an autonomous goal; any goal may serve either or both roles through explicit relationships.
- Workflow depth and plan detail depend on the goal's needs, not on whether it is used as a subgoal.

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

- `Model improvement` vs `execution continuity`: changing the model ends one realization, while applicable stage results carry into a successor.
- `Compatible updates` vs `exact historical text`: MINOR and PATCH updates avoid another model file, but a version label alone cannot reconstruct overwritten text; stage records preserve actual execution context.
- `Parallel alternatives` vs `simple selection`: independent branches may coexist, so current-version selection is branch-local.
- `Inheritance` vs `changed conditions`: carrying evidence forward avoids repeated work, but changed inputs may require another check.
- `Readable documentation` vs `factual detail`: stage records retain actions and proof while the main document stays a compact map.
- `Private evidence` vs `shareable examples`: cleaned copies preserve explanation while making any loss of verifiability clear.
- `Manageable history` vs `valuable experience`: requested cleanup removes unneeded artifacts without destroying retained examples or their context.
- `Reuse` vs `applicability`: the goal, conditions, checks, and divergence evidence remain meaningful when another person follows the model.
- `Automation` vs `human action`: skills, programs, and manual guidance can coexist; user intent and the environment determine their roles.
- `Common execution metrics` vs `domain-specific cost`: measurable experience supports comparison without reducing efficiency to automation, money, or time alone.

## 5. Candidate Inputs for Future Stages

- A flow from goal and path discovery through the model, execution choice, concrete execution, and result validation.
- Branch-local identity and model compatibility criteria, with major-version files and Markdown frontmatter.
- A realization start and model-change boundary, plus applicability checks for inherited results.
- A compact stage map and three-part stage documents with directly associated evidence.
- On-request collapsing into AI-agent skills, executable modules, and mixed forms that preserve model checks and links.
- Preparation of selected sharing copies through personal-data cleanup and package review.
- Export of a goal with selected branch models and reference walkthroughs, and comparison with later executions.
- Explicit branch cleanup that retains self-contained documentary context.
- Contextual navigation and subgoal reuse without additional mandatory index layers.

## 6. Rejected or Deferred Candidate Principles

- `Every goal should be fully automated`: rejected; manual, social, and mixed execution are first-class forms.
- `Repeatability requires registered automation`: rejected; a manual reference can support repeated use.
- `Every model edit requires a separate snapshot`: rejected; compatible updates can stay in one file while realization records preserve execution facts.
- `Adding a stage is always compatible`: rejected; a prerequisite may invalidate earlier obligations or results.
- `A successful reference guarantees the next result`: rejected; conditions and environments can differ.
- `Every old artifact must be retained forever`: rejected; explicit cleanup can remove unneeded history.
- `A newer version automatically makes all earlier examples obsolete`: rejected; retained examples are selected for their actual value and context.
- `Every goal uses one universal collapsed format`: rejected; agent guidance and executable action differ by environment and purpose.
- `One cleanup tool or publishing platform is mandatory`: deferred; the idea specifies preparation and review without choosing their implementation.
