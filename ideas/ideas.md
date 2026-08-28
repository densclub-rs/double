# Ideas

![A human thinker and an AI presence transforming vague thoughts into diamonds and pearls of ideas.](../_media/ideas-illustration.png)

**Ideas** are considered as a common sense term for:
* formulating thought or opinion
* a suggestion or plan for doing something
* a purpose or reason for doing something
* whatever is known or supposed about something
* the central meaning or chief end of a particular action or situation
* a transcendent entity that is a real pattern of which existing things are imperfect representations
* an entity such as a thought, concept, sensation, or image, actually or potentially present to consciousness

**Ideas** are described as Markdown files in this directory, and obey to common [Double layout naming convention](../Double.md#double-layout-naming-convention).

Here is a place where defined **ideas** should be described, stored and linked  for the Double-based projects.

**Ideas** should be formulated and described in a way that is compatible with the principles of [scientific knowledge](https://en.wikipedia.org/wiki/Science) and [epistemology](https://en.wikipedia.org/wiki/Epistemology). In practical terms, this means clarity of terms, explicit assumptions, openness to criticism, attention to falsifiability where applicable, and a clear distinction between observations, interpretations, hypotheses, and conclusions. 

This approach is explicitly grounded in the epistemological traditions associated with [John Locke](https://en.wikipedia.org/wiki/John_Locke), [Karl Popper](https://en.wikipedia.org/wiki/Karl_Popper), [Thomas Kuhn](https://en.wikipedia.org/wiki/Thomas_Kuhn), especially including Kuhn's attention to *paradigms*, *conceptual frameworks*, and *shifts in scientific understanding*. It also draw on [Aristotle](https://en.wikipedia.org/wiki/Aristotle) and [Plato](https://en.wikipedia.org/wiki/Plato) where their concepts remain consistent with modern scientific thinking about knowledge. 

The same spirit is gained from major thinkers such as [Francis Bacon](https://en.wikipedia.org/wiki/Francis_Bacon), [David Hume](https://en.wikipedia.org/wiki/David_Hume), [Immanuel Kant](https://en.wikipedia.org/wiki/Immanuel_Kant), [Charles Sanders Peirce](https://en.wikipedia.org/wiki/Charles_Sanders_Peirce), and others who helped shape serious inquiry into how [knowledge](https://en.wikipedia.org/wiki/Knowledge) is formed, tested, revised, and justified.


## Ideas Description Template

Template for describing **ideas** should be developed, maintained and located as a separate file.

Here is just an example or a prototype for the ideas template file:

```md
---
id: <idea-artifact-id>
kind: idea-artifact
status: draft
produced-by: idea-capture-agent
interaction-language: <language-code-or-name-used-for-dialogue>
artifact-language: <language-code-or-name-used-for-this-artifact>
derived-from:
  - <source-idea-or-conversation>
---

<a id="<idea-artifact-id>"></a>

# Idea: <Short title>

## 1. Summary

A short description of the idea in 2 to 3 sentences.

## 2. Context / Origin

- What was the source of this idea?
- Was it an observation, a problem, a conversation, or an insight?
- In what context did it emerge?

## 3. Problem / Motivation

- What problem or need does it address?
- Why does it matter?

## 4. Raw Description

A detailed, unstructured description of the idea.
Write freely, without unnecessary constraints.

## 5. Key Elements

- Entities involved in the idea
- Participants / objects / systems

## 6. Assumptions

- What is being treated as given?
- What may turn out to be wrong?

## 7. Examples / Scenarios

- Concrete examples
- How could this work in practice?

## 8. Signals of Value

- Why could this be useful?
- What signals suggest that the idea is worth pursuing?

## 9. Open Questions

- What is still unclear?
- Where does uncertainty remain?

## 10. Boundaries / Non-Goals

- What is explicitly outside the scope of the idea?
- Where are the boundaries?

## 11. Related Ideas

- Similar or related thoughts

## 12. Notes

Any additional thoughts
```


## Ideas Presentation Rules

The baseline layout comes from the section [Double layout naming convention](../Double.md#double-layout-naming-convention) in [Double.md](../Double.md). Every idea must follow that convention first, and then the additional rules below.

1. Each idea must be represented by its own directory and by a Markdown file inside that directory with the same base name.
1. The directory name must be written in [kebab case](https://en.wikipedia.org/wiki/Letter_case#Kebab_case) and must describe the idea in no more than 5 to 7 words.
1. The directory name is the idea's unique identifier within the `ideas` tree.
1. The recommended naming format is `short-idea-name`.
1. The main note for an idea must use the same file name as the directory.
1. Additional files may be created inside an idea directory to support the idea workflow as it evolves over time.
1. An idea may contain other smaller ideas, thoughts, or sub-ideas. These must be stored in subdirectories inside the main idea directory.
1. Each nested idea must follow the same rules as a top-level idea: its own directory, its own same-named Markdown file as a main note, and the same naming discipline.
1. Cross-references to other Markdown files must use standard Markdown reference links, not wiki-style links.
1. An idea may link to any other idea or nested thought located anywhere inside the base `ideas` directory.


### Example of idea directory layout

```text
ideas/
  brilliant-idea/
    brilliant-idea.md
    something-even-more-congenius/
      something-even-more-congenius.md
```


### Ideas link example

Use Markdown reference-style:

```md
See [something even more congenius](../brilliant-idea/something-even-more-congenius/something-even-more-congenius.md).
```

## Ideas realization

The thoughts, concepts and principles of the **Idea** are developed in the [Double Machine of Ideas](./machine-of-ideas/machine-of-ideas.md).
