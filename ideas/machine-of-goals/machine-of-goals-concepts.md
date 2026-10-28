---
id: machine-of-goals-concepts
kind: concept-artifact
status: release-candidate
mindmap-plugin: basic
produced-by: machine-of-ideas/concept-extraction-agent
interaction-language: Russian
artifact-language: English
publication-path: ideas/machine-of-goals/machine-of-goals-concepts.md
derived-from:
  - machine-of-goals
  - ideas/machine-of-ideas/machine-of-ideas-concepts.md
---

# Concept Artifact: Machine of Goals

Idea: [Machine of Goals](./machine-of-goals.md#machine-of-goals)

## 1. Conceptual Summary

`Machine of Goals` connects a verifiable goal with independently evolving plan branches, concrete execution, and reusable experience. A model describes expected transitions; branch-local versions identify its evolution; a documented realization records actual stages and evidence. Succession preserves applicable results across model changes, while requested cleanup keeps retained context manageable. Publication preparation and comparison of shared walkthroughs connect individual execution with small-group knowledge.

As a specialized machine within Double, `Machine of Goals` realizes all foundational concepts defined by the [`Machine of Ideas` concept artifact](../machine-of-ideas/machine-of-ideas-concepts.md). Its goal-specific concepts extend that common conceptual foundation rather than replace it.

The idea rests on a distinction between several levels: a goal is not the same as a plan, a plan is not the same as an algorithm, an algorithm is not the same as automatic execution, and neither reuse nor repeatability requires automatic execution. Explanation, control, and actual evidence remain meaningful in each form. This makes Machine of Goals not merely a task manager, but a machine for transforming a goal into a controllable structure of action.

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

A possible strategy for approaching a goal, considered before or during plan development. Paths can become selectable routes or subplans within a model, or independently maintained plan branches for the same goal.

#### Source in Idea

- Explicit in `Raw Description`, `Assumptions`, and `Examples / Scenarios` of the [root idea](./machine-of-goals.md#machine-of-goals).

#### Role in the Idea

Paths make alternatives comparable before the person commits to a detailed model. The path catalog preserves their purpose, applicability, and relation to the resulting plans.

#### Related Concepts

- [Plan as Transition Model](#concept-plan-as-transition-model): gives a selected strategy a connected structure
- [Plan Branch](#concept-plan-branch): represents an independently maintained alternative
- [Plan Cost and Efficiency](#concept-plan-cost-and-efficiency): supports comparison of alternatives

#### Boundaries

- A path is not yet a detailed plan or a concrete execution.
- A selectable route inside a model is distinct from an independent plan branch.
- Removing a path does not silently invalidate retained execution evidence or references.

#### Questions

- None.

<a id="concept-plan-as-transition-model"></a>

### concept-plan-as-transition-model: Plan as Transition Model

#### Definition

A connected model of movement from an initial state to a target or intermediate state through stages, dependencies, checks, and possible routes. Each stage connects required input conditions, an intended action, an expected output, and a way to check it. The abstract-class analogy expresses the distinction between this model and its concrete executions.

#### Source in Idea

- Explicit in `Raw Description`, `Key Elements`, and `Assumptions` of the [root idea](./machine-of-goals.md#machine-of-goals).

#### Role in the Idea

The model is the bridge from a verifiable goal to understandable action. Stable stage anchors and short English names connect its structure with stage documents. The model can evolve, while progress and actual observations belong to a realization.

#### Related Concepts

- [Plan Branch](#concept-plan-branch): identifies a line of model development
- [Plan Model Version](#concept-plan-model-version): identifies an evolutionary state
- [Documented Plan Realization](#concept-documented-plan-realization): records an actual passage through the model

#### Boundaries

- Understandability can be sufficient to begin even when later details remain open.
- The model contains expected states and checks, not in-progress or completed markers.
- Model changes during execution create a realization boundary; they do not rewrite what already happened.

#### Questions

- None.

<a id="concept-plan-branch"></a>

### concept-plan-branch: Plan Branch

#### Definition

An independently evolving line of plan models within one goal, identified by the Markdown frontmatter value `branch`. Different versions in one branch represent evolution; different branch values distinguish parallel plans.

#### Source in Idea

- Explicit in `Summary`, `Raw Description`, `Assumptions`, and the branch evolution example of the [root idea](./machine-of-goals.md#machine-of-goals).

#### Role in the Idea

Branch identity makes it possible to maintain alternatives without confusing them with historical versions. For example, `double` and `lightweight` can each have their own current model and version history. A branch derived from another can retain its source branch and version.

#### Related Concepts

- [Plan Model Version](#concept-plan-model-version): changes within an identified branch
- [Realization Path](#concept-realization-path): may develop into an independent branch
- [Branch Cleanup](#concept-branch-cleanup): uses one branch as the scope of selection and removal

#### Boundaries

- Several retained major versions of one branch do not create several branches.
- A selectable route within one model need not become an independent branch.
- A higher version in another branch does not supersede this branch.

#### Questions

- None.

<a id="concept-plan-model-version"></a>

### concept-plan-model-version: Plan Model Version

#### Definition

A branch-local MAJOR.MINOR.PATCH identity for a state of the plan model. PATCH corrects wording without changing meaning; MINOR adds or refines compatible obligations; MAJOR introduces an incompatible model of achieving the goal. Compatibility concerns stage conditions, required results, and dependencies rather than the size of the edit.

#### Source in Idea

- Explicit in `Raw Description`, `Assumptions`, and the branch evolution example of the [root idea](./machine-of-goals.md#machine-of-goals).

#### Role in the Idea

Versions connect executions to the model they used. MINOR and PATCH updates remain in the same Markdown file; a MAJOR change preserves the former model and creates another file, such as `plan-double-v2.md`. The current version is chosen within the selected branch.

#### Related Concepts

- [Plan Branch](#concept-plan-branch): provides the identity within which versions evolve
- [Realization Succession and Inheritance](#concept-realization-succession-and-inheritance): connects execution across model changes
- [Branch Cleanup](#concept-branch-cleanup): selects which historical model context remains necessary

#### Boundaries

- A small new prerequisite may be incompatible and therefore major.
- Changing execution from manual to a skill or script need not change the model.
- A version label cannot reconstruct earlier text overwritten by a compatible update; retained stage records preserve actual execution context and checks.

#### Questions

- None.

<a id="concept-documented-plan-realization"></a>

### concept-documented-plan-realization: Documented Plan Realization

#### Definition

A concrete manual or interactive passage through an identified plan model, preserved as both factual evidence and readable documentation. Its start creates a main Markdown document in a directory named by year, month, day, hour, minute, and second. Frontmatter records the start, timezone, model file, branch, and version; the body presents the stage map and current progress.

#### Source in Idea

- Explicit in `Raw Description`, `Assumptions`, and `Notes` of the [root idea](./machine-of-goals.md#machine-of-goals).

#### Role in the Idea

The realization gives execution one understandable home. It records what happened in a computer, social, or mixed environment and connects stage documents and attachments without an additional registration artifact or goal-wide execution index.

#### Related Concepts

- [Plan as Transition Model](#concept-plan-as-transition-model): supplies the expected transitions
- [Stage Execution Record](#concept-stage-execution-record): contains the detailed passage through one stage
- [Realization Succession and Inheritance](#concept-realization-succession-and-inheritance): preserves continuity when the model changes

#### Boundaries

- A concrete realization is distinct from a reusable skill or program that can guide or perform many executions.
- A progress marker is not evidence of a verified result.
- The creation timestamp stays fixed; subsequent updates do not rename the realization.
- A change to the model ends the current realization and starts a linked successor.

#### Questions

- None.

<a id="concept-stage-execution-record"></a>

### concept-stage-execution-record: Stage Execution Record

#### Definition

A readable record of one plan stage in a realization, structured into actual input state, performed actions, and observed output state. Commands, checks, deviations, decisions, and supporting materials appear within the corresponding part. A stable stage anchor such as `S01` connects the record to the model; a short English name supplies a readable filename.

#### Source in Idea

- Explicit in `Raw Description`, `Assumptions`, and `Notes` of the [root idea](./machine-of-goals.md#machine-of-goals).

#### Role in the Idea

Stage records keep a walkthrough readable at human scale. The realization map opens them directly, and they can become documentation pages while remaining factual evidence of the actions and results.

#### Related Concepts

- [Documented Plan Realization](#concept-documented-plan-realization): owns the stage map and execution context
- [Success Criteria](#concept-success-criteria): defines what the evidence can establish
- [Publication Preparation](#concept-publication-preparation): prepares selected records and evidence for sharing

#### Boundaries

- Expected output and observed output remain distinguishable; an unfinished stage may have no verified output yet.
- A report, an observation, and a completed check have different evidentiary meaning.
- Corrected commands remain alongside earlier generated commands in generation order; commands use protected-input references rather than literal secrets.
- A collapsed skill/action invocation creates no Machine of Goals stage journal; native operational logs follow the mechanism's own contract.

#### Questions

- None.

<a id="concept-realization-succession-and-inheritance"></a>

### concept-realization-succession-and-inheritance: Realization Succession and Inheritance

#### Definition

The relationship between a realization that ends because its model changed and a successor started against the updated model. The successor carries forward unchanged stage records and evidence; completed status carries forward where dependencies, inputs, and results remain applicable.

#### Source in Idea

- Explicit in `Raw Description`, `Assumptions`, and the branch evolution example of the [root idea](./machine-of-goals.md#machine-of-goals).

#### Role in the Idea

Succession allows a model to improve without mixing different model states into one execution or repeating work whose results are still valid. Its predecessor relationship remains in the main realization documents, while inherited material is included in the successor so it can be read on its own.

#### Related Concepts

- [Plan Model Version](#concept-plan-model-version): identifies the model states on each side of the change
- [Stage Execution Record](#concept-stage-execution-record): supplies inherited facts and checks
- [Branch Cleanup](#concept-branch-cleanup): preserves useful inherited material before removing earlier artifacts

#### Boundaries

- Creating a successor does not require another model file for every compatible change.
- Unchanged stage text does not prove that changed upstream inputs leave its result applicable.
- Inheritance preserves facts; it does not claim that the successor newly performed the inherited actions.

#### Questions

- None.

<a id="concept-contextual-artifact-navigation"></a>

### concept-contextual-artifact-navigation: Contextual Artifact Navigation

#### Definition

A useful relationship between goal, model, realization, stage, or evidence expressed as a Markdown link where the relationship is explained. Frontmatter carries structured identity and provenance, while the realization map provides direct access to its stage documents.

#### Source in Idea

- Explicit in `Raw Description`, `Assumptions`, and `Notes` of the [root idea](./machine-of-goals.md#machine-of-goals).

#### Role in the Idea

Contextual links keep complex and shared goal graphs understandable without multiplying indexes or repeating a global menu. They keep source goal, selected branch and version, and execution evidence intelligible within and across projects.

#### Related Concepts

- [Goal Artifact Context](#concept-goal-artifact-context): gives related materials their semantic home
- [Documented Plan Realization](#concept-documented-plan-realization): provides the main map
- [Branch Cleanup](#concept-branch-cleanup): retains enough context without dangling references

#### Boundaries

- A frontmatter path is not a substitute for a useful human-facing link.
- Direct cross-project reference does not itself import or copy the source.
- A mutable model link without recorded branch, version, and execution context does not explain an old realization.
- A self-contained inherited walkthrough need not make the reader traverse all predecessors.

#### Questions

- None.

<a id="concept-subgoal-and-partial-achievement"></a>

### concept-subgoal-and-partial-achievement: Subgoal and Partial Achievement

#### Definition

Intermediate verifiable states inside a larger transition toward the goal, which may have their own inputs, outputs, completion criteria, and nested artifacts. A subgoal is better represented as a separate catalog that stores its own subplan.

A subgoal is a goal used within another goal's plan, not a separate goal type. Any goal may serve as a subgoal, and any subgoal may be pursued as an autonomous goal. The same goal may play both roles at once. These roles are determined by explicit relationships and plan integration boundaries, not by a `goal-scope` field. Workflow depth and plan detail depend on the goal's needs, not on its role.

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

Clarification of how a plan model becomes an actionable sequence of transitions, checks, controlled parameters, stops, and review conditions. The model describes intended achievement; its realization embodies the way of acting in the relevant environment.

#### Source in Idea

- Explicit in `Raw Description`, `Assumptions`, and `Notes` of the [root idea](./machine-of-goals.md#machine-of-goals).

#### Role in the Idea

This concept connects understandable planning with guided or executable action. It can support the built-in interactive flow or, on request, the separate flow that collapses a model into a reusable realization.

#### Related Concepts

- [Plan as Transition Model](#concept-plan-as-transition-model): provides the structure being made actionable
- [Interactive and Automatic Execution](#concept-interactive-and-automatic-execution): describes ways of carrying out the actions
- [Collapsed Plan Realization](#concept-collapsed-plan-realization): packages a reusable way of acting

#### Boundaries

- Algorithmization does not require creating a program.
- It does not remove human choices or the social parts of execution.
- Creating a reusable realization differs from exporting an existing goal and its materials.

#### Questions

- None.

<a id="concept-plan-explanation-and-control"></a>

### concept-plan-explanation-and-control: Plan Explanation and Control

#### Definition

An account of the selected stage, required input, proposed action, expected output, check, and reason for the next transition, with opportunities to pause or review. The account uses actual progress from the realization rather than adding progress state to the model.

#### Source in Idea

- Explicit in `Raw Description`, `Assumptions`, and `Signals of Value` of the [root idea](./machine-of-goals.md#machine-of-goals).

#### Role in the Idea

Explanation supports the built-in manual flow as well as controlled automation. Before real action, a dry run can explain a stage without performing it. Evidence and the state of earlier stages inform the next choice.

#### Related Concepts

- [Stage Execution Record](#concept-stage-execution-record): preserves the actual action and result
- [Interactive and Automatic Execution](#concept-interactive-and-automatic-execution): places execution under chosen control boundaries
- [Success Criteria](#concept-success-criteria): gives the check its meaning

#### Boundaries

- A dry run is not actual execution.
- Explaining a step does not require a new approval for every action.
- Explanation is distinct from claiming that an expected result has been observed.

#### Questions

- None.

<a id="concept-interactive-and-automatic-execution"></a>

### concept-interactive-and-automatic-execution: Interactive and Automatic Execution

#### Definition

The range of execution forms from manual guidance through mixed action to automatic execution. The built-in manual flow accompanies the person through model stages in computer, social, or mixed environments; reusable skills and executable modules offer other forms when requested.

#### Source in Idea

- Explicit in `Summary`, `Raw Description`, and `Assumptions` of the [root idea](./machine-of-goals.md#machine-of-goals).

#### Role in the Idea

The execution form determines who acts and how checks are performed, independently of how many times the model may be used. A person can supply evidence of a social action while an agent guides the procedure or a program performs a computer step.

#### Related Concepts

- [Documented Plan Realization](#concept-documented-plan-realization): preserves a concrete walkthrough
- [Collapsed Plan Realization](#concept-collapsed-plan-realization): provides reusable agent guidance or executable action
- [Plan Explanation and Control](#concept-plan-explanation-and-control): makes boundaries and checks understandable

#### Boundaries

- A manual plan can be reused many times; automation can be used only once.
- Collapsing is optional and happens on request, not as a prerequisite to manual execution.
- An execution form does not change the plan version unless the model itself changes.
- Automatic execution remains within the boundaries chosen by the user.

#### Questions

- None.

<a id="concept-collapsed-plan-realization"></a>

### concept-collapsed-plan-realization: Collapsed Plan Realization

#### Definition

A reusable realization produced on request from the complete model or selected subplans: an AI-agent skill that guides users, an executable module that performs covered actions in an environment, or a combination. Its form preserves the relation to the goal, model, checks, and available documentation.

#### Source in Idea

- Explicit in `Summary`, `Raw Description`, and `Assumptions` of the [root idea](./machine-of-goals.md#machine-of-goals).

#### Role in the Idea

Collapsing turns an understood way of acting into a module for reuse. A skill supplies guidance and interaction rules; a shell script or another executable supplies automated actions and may produce ordinary logs. The form follows the goal and its environment.

#### Related Concepts

- [Plan Algorithmization](#concept-plan-algorithmization): makes the model actionable
- [Interactive and Automatic Execution](#concept-interactive-and-automatic-execution): uses the resulting guidance or actions
- [Plan Exchange](#concept-plan-exchange): can transfer a relevant realization with its goal context

#### Boundaries

- A skill is not necessarily an executable program.
- A documented manual walkthrough is already valuable without being collapsed.
- The covered initial, required intermediate, and final state checks remain meaningful in an automatic module.
- Collapsing is a separate activity from publication or export.
- Invoking a collapsed skill/action creates no Machine of Goals execution directory, frozen-plan copy, realization wrapper, stage journal or execution index. Covered checks and user-selected authority remain binding.

#### Questions

- None.

<a id="concept-plan-exchange"></a>

### concept-plan-exchange: Plan Exchange

#### Definition

Transfer or import of a goal together with selected branch models, relevant realizations, checks, and documented execution examples with evidence prepared for the intended audience. A recipient can inspect a reference walkthrough and begin their own execution.

#### Source in Idea

- Explicit in `Summary`, `Raw Description`, and the sharing example of the [root idea](./machine-of-goals.md#machine-of-goals).

#### Role in the Idea

Exchange carries both the method and experience of applying it. It supports reuse in the small group without treating a successful example as universal or disconnecting the plan from its goal and initial conditions.

#### Related Concepts

- [Publication Preparation](#concept-publication-preparation): selects and cleans sharing materials
- [Shared Execution Experience](#concept-shared-execution-experience): compares later walkthroughs with examples
- [Branch Cleanup](#concept-branch-cleanup): can simplify the package on request

#### Boundaries

- Manual examples can be exchanged without an automatic realization.
- A new execution is distinct from the reference walkthrough.
- Reuse requires checking initial conditions, constraints, and applicability.
- Direct reference to another project remains distinct from an exported copy.

#### Questions

- None.

<a id="concept-branch-cleanup"></a>

### concept-branch-cleanup: Branch Cleanup

#### Definition

A separately requested selection of retained model versions, realizations, and evidence within one branch, followed by removal of obsolete versions and dependent materials that are no longer needed. Useful inherited records remain included in the retained walkthroughs.

#### Source in Idea

- Explicit in `Summary`, `Raw Description`, `Assumptions`, and the cleanup example of the [root idea](./machine-of-goals.md#machine-of-goals).

#### Role in the Idea

Cleanup makes the working and documentary context manageable without an ever-growing release catalog. It can prepare a self-contained package for continued work, publication, or export while leaving independent branches unaffected.

#### Related Concepts

- [Plan Branch](#concept-plan-branch): defines the scope of cleanup
- [Realization Succession and Inheritance](#concept-realization-succession-and-inheritance): supplies material that may still be useful
- [Plan Exchange](#concept-plan-exchange): uses a coherent retained package

#### Boundaries

- Increasing a version does not itself delete history.
- A retained old realization remains an example of its original model and keeps the context needed to interpret it.
- Keeping the latest model does not by itself determine which execution examples remain valuable.
- Removal cannot leave retained evidence dangling or silently rebind historical facts.

#### Questions

- None.

<a id="concept-publication-preparation"></a>

### concept-publication-preparation: Publication Preparation

#### Definition

Preparation of selected goal, model, walkthrough, and evidence materials for an intended audience by identifying personal data, cleaning sharing copies, and reviewing the resulting package. Private originals remain separate.

#### Source in Idea

- Explicit in `Summary`, `Raw Description`, `Assumptions`, and the manual sharing example of the [root idea](./machine-of-goals.md#machine-of-goals).

#### Role in the Idea

The walkthrough already contains documentation. Preparation makes that documentation shareable while preserving its explanation of the stages and results. Cleanup includes text, images, documents, filenames, metadata, and links that could expose private originals.

#### Related Concepts

- [Stage Execution Record](#concept-stage-execution-record): provides readable documentary material
- [Plan Exchange](#concept-plan-exchange): transfers the prepared package
- [Success Criteria](#concept-success-criteria): helps explain any loss of verifiability after cleanup

#### Boundaries

- Publication does not automatically include all original attachments.
- A sharing copy does not replace the private factual original.
- Cleanup can limit what readers can verify; such limits remain clear.
- The concept does not choose cleanup tools, hosting, or an export format.

#### Questions

- None.

<a id="concept-shared-execution-experience"></a>

### concept-shared-execution-experience: Shared Execution Experience

#### Definition

Knowledge developed by comparing reference walkthroughs with later executions and discussing their differences within a small group. A useful divergence identifies the stage, input conditions, action, expected result, observed result, and supporting evidence.

#### Source in Idea

- Explicit in `Raw Description`, `Signals of Value`, and the sharing example of the [root idea](./machine-of-goals.md#machine-of-goals).

#### Role in the Idea

The reference makes experience inspectable, and later walkthroughs test applicability in other conditions. Discussion with the author or group can refine the model or clarify its limits without erasing earlier facts.

#### Related Concepts

- [Plan Exchange](#concept-plan-exchange): makes reference examples available
- [Stage Execution Record](#concept-stage-execution-record): locates the difference in concrete evidence
- [Plan as Transition Model](#concept-plan-as-transition-model): can improve from the comparison

#### Boundaries

- A difference is not automatically proof of an error in the model or the person.
- Changed environments and initial conditions can explain a divergence.
- A successful reference example does not establish universal applicability.

#### Questions

- None.

<a id="concept-goal-artifact-context"></a>

### concept-goal-artifact-context: Goal Artifact Context

#### Definition

The semantic and file context that keeps a goal, its path catalog, branch model files, timestamped realizations, stage records, evidence, reusable implementations, and nested subgoals understandable together. Structured metadata belongs in Markdown frontmatter.

#### Source in Idea

- Explicit in `Key Elements`, `Assumptions`, and `Notes` of the [root idea](./machine-of-goals.md#machine-of-goals).

#### Role in the Idea

The goal context connects the intention, models, and actual experience. A main realization document and direct stage documents provide readable execution context; an implementation may live in an appropriate external working catalog while remaining linked to the source goal and model.

#### Related Concepts

- [Contextual Artifact Navigation](#concept-contextual-artifact-navigation): connects related materials where useful
- [Documented Plan Realization](#concept-documented-plan-realization): provides the concrete execution context
- [Subgoal and Partial Achievement](#concept-subgoal-and-partial-achievement): can own a nested goal context

#### Boundaries

- Independent branches do not require separate goals.
- A model file is distinct from the goal description and from execution progress.
- Readable context does not require standalone YAML metadata files or extra indexes.
- Private originals and prepared sharing copies remain distinguishable.

#### Questions

- None.

## 4. Terms and Non-Concepts

- `Goal Capture`, `Path Discovery`, `Plan Synthesis`, `Execution Variant Choice`, and `Result Validation`: flow labels that operationalize the concepts above.
- `branch`, MAJOR.MINOR.PATCH, stage anchors such as `S01`, English stage names, and creation timestamps: identity and naming terms covered by branch, version, and realization concepts.
- `realization.md`, stage Markdown files, attachments, and frontmatter: supporting representations of the execution context, not independent concepts.
- `skill`, `shell script`, `workflow`, `program`, and mixed modules: possible reusable forms; a skill need not be an executable program.
- `SDD`: an external methodology with which generated material may be compatible, not an internal execution requirement.
- `pending`, `in progress`, and `completed`: realization progress labels, not model states or proof of success.
- `resources`, `risks`, `parameters`, and `checks`: attributes of the transition model and its execution.

## 5. Candidate Inputs for Principle Synthesis

- Keep the goal verifiable and the model understandable before acting.
- Separate expected model states from observed realization states and progress.
- Distinguish parallel branch identity from compatibility-based model evolution.
- Record the beginning and model identity of a concrete realization in one readable context.
- Preserve actual input, actions, output, and evidence as documentation of execution.
- End a realization at a model change and carry applicable results into an intelligible successor.
- Evaluate inheritance through dependencies and conditions rather than unchanged text alone.
- Keep repeatability independent of automation and collapse only on request.
- Preserve goal and model connections, state checks, and control boundaries in reusable forms.
- Reduce branch history only on request while retaining enough context to interpret surviving examples.
- Prepare sharing copies through selection, personal-data cleanup, and review without exposing private originals.
- Compare later walkthroughs with reference examples to improve shared understanding and models.
- Keep navigation contextual and artifacts readable without additional registries or repetitive indexes.
- Evaluate cost using execution experience and domain-specific criteria without equating efficiency with automation.
