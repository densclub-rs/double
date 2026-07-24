---
style: double
submodule: machine-of-ideas
id: agents-registry
kind: registry
status: release-candidate
---

# Agents Registry

## Idea Capture Agent

- id: `idea-capture-agent`
- role: `idea-capture-role`
- stage: `01-idea-capture`
- input: `raw-user-input`, `conversation-context`, `interaction-language`, `artifact-language`, `idea-template`
- optional-input: `mini-idea-template`, `parent-idea-artifact`
- output: `idea-artifact`, `mini-idea-artifact`
- output-frontmatter: `interaction-language`, `artifact-language`
- template-routing: use `mini-idea-template` when the user asks for an idea clarification, sub-idea, or mini-idea
- supported-modes: `brainstorm`, `explain`, `strict-research`, `validation`, `editor`
- system-prompt: `.double/prompts/machine-of-ideas/system/idea-capture.md`
- interaction-prompt: `.double/prompts/machine-of-ideas/interaction/idea-capture.md`
- definition: `.double/agents/machine-of-ideas/idea-capture/idea-capture.md`

## Concept Extraction Agent

- id: `concept-extraction-agent`
- role: `concept-extractor-role`
- stage: `02-concept-extraction`
- input: `root-idea-artifact`, `interaction-language`, `artifact-language`, `concept-template`
- optional-input: `relevant-sub-ideas`
- output: `concept-artifact`
- output-frontmatter: `interaction-language`, `artifact-language`
- output-location: root idea directory as `<root-idea-id>-concepts.md`
- supported-modes: `brainstorm`, `explain`, `strict-research`, `validation`, `editor`
- system-prompt: `.double/prompts/machine-of-ideas/system/concept-extraction.md`
- interaction-prompt: `.double/prompts/machine-of-ideas/interaction/concept-extraction.md`
- definition: `.double/agents/machine-of-ideas/concept-extraction/concept-extraction.md`

## Principle Synthesis Agent

- id: `principle-synthesis-agent`
- role: `principle-synthesizer-role`
- stage: `03-principle-synthesis`
- input: `root-idea-artifact`, `concept-artifact`, `interaction-language`, `artifact-language`, `principle-template`
- optional-input: `relevant-sub-ideas`
- output: `principle-artifact`
- output-frontmatter: `interaction-language`, `artifact-language`
- output-location: root idea directory as `<root-idea-id>-principles.md`
- supported-modes: `brainstorm`, `explain`, `strict-research`, `validation`, `editor`
- system-prompt: `.double/prompts/machine-of-ideas/system/principle-synthesis.md`
- interaction-prompt: `.double/prompts/machine-of-ideas/interaction/principle-synthesis.md`
- definition: `.double/agents/machine-of-ideas/principle-synthesis/principle-synthesis.md`
