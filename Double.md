---
double-state: [null, state-0, null]
---

# Double

>
> **The program that does not exist… *yet* !**
> 


## General Considerations

This document outlines the core ideas that serve as shared rules and community-endorsed concepts for the **Double** project.

If you do not agree with the ideas and concepts below, you have two options:

1. Do not participate in the **Double** project and try to implement your ideas as a separate project.
2. Present your ideas as described in the [Ideas](#ideas) section and, together with other contributors, help the project evolve by merging individual knowledge and concepts into the **Double** knowledge space.


## Grand Idea

The central idea of the project is to create a personal digital twin, **Double**, that represents a person’s knowledge, skills, and capabilities for interacting with the digital world and computing ecosystems.

At the beginning, a personal digital twin is a bundle of skills for interacting with information systems in the broadest sense: interactions through computing devices (computers, smartphones and gadgets) and interactions directed at you from the digital world.

The digital twin exists both as a personal asset and as a community-shared body of skills, and it should continually evolve and improve.

With the consent of project participants, local personal digital twins can be merged to create a shared community agent validated by **Double** contributors and built from the best personal skills contributed by participants.

The universal community **Double** agent can act as a mentor for the local digital twins of new participants or customers of the **Double** project.

This establishes the project’s foundational principle:

 **Build an open system for accumulating and exchanging knowledge among all *Double* project participants.**

*The accumulated knowledge and skills may be **open**, available to any participant or external user, or **restricted**, available only to specific individuals or behind a paywall.*


## Ideas

Despite the presence of many files in the project directory, ***at the very beginning*** there is nothing except ideas.Therefore, the project needs an agreement on how to manage them.

Ideas are the most general concepts and principles to develop and grow **Double** project. They should describe a philosophy behind a technical solution accepted for the project.

### Double layout naming convention

* create any directory
* create a Markdown file inside the directory with the same name as the directory
* use [kebab case](https://en.wikipedia.org/wiki/Letter_case#Kebab_case) for naming

Example:

```
any-directory-name\
any-directory-name\any-directory-name.md
```

Keep all ideas in the [ideas](ideas/ideas.md) directory.



## Participants

As mentioned in the [Grand Idea](#grand-idea), the **Double** project is intended to grow within a community of enthusiasts. So, ***at the very beginning***, one more thing is required: a place to keep personal contributions to the project.

The [people](people/people.md) directory is that place.


# At the Very Beginning

This is the starting point for any other Double-based project.

There are only these core concepts:

1. [General Considerations](#general-considerations)
1. [Grand Idea](#grand-idea)
1. [Double Layout Naming Convention](#double-layout-naming-convention)
1. [Ideas' Catalog](#ideas)
1. [Supposed Community Catalog](#participants)
1. Main project language is English

## State of the Double Project

There is a need for one more core concept. It is the **"State of the Double project"**. The state concept defines a control point, or checkpoint, that allows the project to move through its history and to fork a new line of development from any recorded state.

As the main project develops further, anyone can return to an earlier state and create their own development path. In that case, there will be a common ancestor (*'state-N'*) and, potentially, a common descendant if a fork is later merged back into the main line. Think of ***states*** as divergence and convergence points in the lifetime of the project.

A state is tracked by keeping special tags in both in-file metadata (Markdown properties) and Git annotated tags in sync:

- there is a property named `double-state` that stores a bidirectional list: [`prev`, `current`, `next`] as an array of pointers,
- if a pointer is not defined, use `null` or `none` for that value,
- project states are published as Git annotated tags: `state-0`, `state-1`, etc.,
- ***states*** can be traversed easily after cloning by using tag names.

Example commands:

- `git tag -a state-0 -m "State 0: initial baseline"`
- `git tag -a state-1 -m "State 1: added state tracing section"`
- `git push origin --tags`
- `git fetch --tags`
- `git tag --list "state-*"`
- `git checkout state-0`

Update policy:

- when moving forward, set `prev` to the old `current`, set `current` to the new value, and optionally set `next` to the anticipated successor,
- keep past state tags immutable as possible,
- add new annotated tags for each new state.


# What to Do Next

To move to the next state, `state-1`, the following things must be clarified:

* how to maintain ideas in the [Ideas](./ideas/ideas.md) folder and define the direction of the project's development
* how to maintain participants in the [People](./people/people.md) folder
