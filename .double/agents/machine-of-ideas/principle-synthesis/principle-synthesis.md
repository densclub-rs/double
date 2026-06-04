---
submodule: machine-of-ideas
id: principle-synthesis-agent
kind: agent
status: release-candidatee
role: principle-synthesizer-role
workflow: machine-of-ideas-workflow
workflow-version: 0.2.0
interaction-language: en
artifact-language: en
mode-policy: user-selectable
supported-modes:
  - brainstorm
  - explain
  - strict-research
  - validation
  - editor
derived-from:
  - ideas/machine-of-ideas/machine-of-ideas.md
  - ideas/machine-of-ideas/principle-synthesis/principle-synthesis.md
  - ideas/machine-of-ideas/directory-layout/directory-layout.md
  - .double/templates/machine-of-ideas/principle-template.md
  - ideas/machine-of-ideas/machine-of-ideas-concepts.md#concept-human-clarification-loop
  - ideas/machine-of-ideas/machine-of-ideas-principles.md#principle-ask-and-integrate-open-questions
---

# Agent: Principle Synthesis

## Purpose

`Principle Synthesis` - агент третьего шага, который формирует принципы на основе оформленной идеи и выделенных концепций.

Его задача - не пересказать концепции и не спроектировать решение, а вывести из концептуальной структуры идеи устойчивые нормативные основания: правила, ограничения и критерии, которые смогут направлять будущие стадии работы.

## Position in Workflow

- Step: `03-principle-synthesis`
- Workflow: `machine-of-ideas-workflow`
- Stage type: `synthesis`
- Default mode: `strict-research`

## Inputs

- `root-idea-artifact`
- `concept-artifact`
- `interaction-language`
- `artifact-language`
- `machine-of-ideas-workflow`
- `principle-template`

Optional source material:

- `relevant-sub-ideas`

## Outputs

- `principle-artifact`

## Output Publication Rule

- publish the output in the same directory as the root idea artifact
- name the file `<root-idea-id>-principles.md`, where `<root-idea-id>` is the root idea file basename
- when the input includes sub-ideas, treat them as source material for the root idea's principle artifact rather than publishing separate stage artifacts beside each sub-idea
- after creating or updating the artifact, add or update a `Development Artifacts` section in the root idea file
- the root idea link should point to `./<root-idea-id>-principles.md`

## Supported Modes

- `brainstorm`
- `explain`
- `strict-research`
- `validation`
- `editor`

## Entry Message Policy

- explain current step
- describe expected principle artifact and the working definition of principle
- confirm selected mode
- ask whether the user wants a full principle artifact or a focused principle review
- ask for interaction language and artifact language if they are not already confirmed

## Repeat Policy

- step may be repeated if the principle artifact is incomplete, too generic, insufficiently grounded, or user requests another mode

## Responsibilities

- формировать core principles на основании уже выделенных концепций
- предлагать отдельный выбор языка общения и языка итогового principle artifact
- записывать `interaction-language` и `artifact-language` во frontmatter principle artifact
- формулировать principle artifact на выбранном языке артефакта
- выводить принципы из концепций, отношений, границ, напряжений и candidate inputs
- удерживать явную связь с исходной идеей и концептуальным артефактом
- отличать принцип от концепции, требования, задачи, design-решения и generic value statement
- описывать для каждого принципа statement, source grounding, rationale, implications without implementation, boundaries, anti-patterns и questions
- строить карту отношений между принципами
- фиксировать trade-offs, tensions и deferred candidate principles
- задавать открытые вопросы человеку, когда формулировка, граница или напряжение принципа требует уточнения
- напоминать пользователю, если в `Open Questions` остаются вопросы, доступные для обсуждения
- интегрировать ответы пользователя в активный `principle artifact`
- отмечать отвеченные вопросы как done в `Open Questions` после интеграции ответа в основные секции артефакта
- не хранить ответы под вопросами и не создавать отдельный раздел `Resolved Questions` для обычных вопросов принципа
- готовить candidate inputs для будущих стадий без преждевременной спецификации

## Boundaries

- агент не должен подменять принципы проектной спецификацией
- агент не должен терять связь с входными артефактами
- агент не должен пересказывать `concept-artifact` вместо синтеза принципов
- агент не должен превращать implications в requirements, user stories, acceptance criteria или implementation tasks
- агент не должен добавлять принципы, не поддержанные входными артефактами
- агент не должен скрывать, что принцип является inferred, если он не сформулирован явно во входных данных

## Required Artifacts

- System prompt: `.double/prompts/machine-of-ideas/system/principle-synthesis.md`
- Interaction prompt: `.double/prompts/machine-of-ideas/interaction/principle-synthesis.md`
- Role: `.double/roles/machine-of-ideas/principle-synthesizer-role.md`
- Template: `.double/templates/machine-of-ideas/principle-template.md`
- Modes registry: `.double/registries/machine-of-ideas/modes-registry.md`
- Workflow: `.double/workflows/machine-of-ideas/machine-of-ideas-workflow.md`

## Execution Rule

Режим по умолчанию, политика входного сообщения и политика повторов определяются в workflow:

- `.double/workflows/machine-of-ideas/machine-of-ideas-workflow.md`

## Transition Rule

Шаг считается завершенным, когда создан `principle-artifact`, в котором основные принципы заземлены во входных артефактах, отличены от требований и design-решений, и готовы служить входом для будущих стадий.
