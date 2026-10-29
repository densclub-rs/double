---
id: double-project
kind: knowledge-artifact
status: stable
produced-by: machine-of-knowledge/knowledge-extraction-agent
interaction-language: ru
artifact-language: en
knowledge-type: static
type: static
value-type: text
access: free-of-charge
observed-at: 2026-10-21
ttl: one year
derived-from:
  - user decision in conversation on 2026-10-01
  - user decision in conversation on 2026-10-15
  - user decision in conversation on 2026-10-21
---

<a id="double-project"></a>

# Double Project

## Description

The agreed basic rules and agreements for the Double project.

## Value

### Double software project directory

Directory `src/` contains the Double software project itself. It has its own internal structure for source code, tests and other software development artifacts.

Tests belonging to the Double software project reside within its own structure under `src/`.

### Knowledge artifacts language for the Double project

Knowledge artifacts of the Double project must be written and preserved in English, with `artifact-language: en`.

### Repository utility scripts directory

The root-level `scripts/` directory contains standalone utility scripts for maintaining the Double repository and its artifacts. These scripts are separate from the software project developed in `src/`.

### Repository utility tests directory

The root-level `tests/` directory contains tests, fixtures and test-only helpers for repository utilities and artifact validation. CI workflows invoke these same tests.

### Test framework and organization

Each Double subsystem selects and documents its own implementation language and test framework according to its requirements. There is no project-wide requirement to use one language or test framework, and no blanket migration to Vitest or TypeScript.

The GitHub release subsystem owned by `double-github-integration` and its `github-actions-maintenance` subgoal uses Python for release tooling and pytest for its tests as its migration target. This decision does not claim that the existing Shell/Python implementation and tests have already been migrated, or prescribe a stack for other subsystems.

Repository utility tests under the root-level `tests/` directory are organized by purpose. The machine release subsystem keeps its tooling under `scripts/double-release/` and its pytest suite, configuration and test dependencies under `tests/double-release/`. Other tests supporting GitHub Actions use `tests/github-actions/`, including installer, platform validation and live integration scenarios. Tests for `git-double` and Machine of Goals navigation belong under `tests/git-double/` and `tests/machine-of-goals/`, respectively.

Fixtures and test-only helpers stay with their owning area; only helpers shared across areas belong under `tests/helpers/`. Tests supporting GitHub Actions can also run locally. Live scenarios involving real network access or system scheduling have a separate explicit invocation from the default isolated suite.

Tests of the Double software project remain within `src/`; subsystem-specific framework choices do not move them into the repository utility test tree.


## Sources

* The user confirmed these project rules in the conversation on 2026-10-01 and requested that they be preserved through Machine of Knowledge in the `double-project` artifact.
* On 2026-10-15 the user selected `tests/` for test scenarios and requested this rule be recorded here. Existing TTL one year is retained.
* On 2026-10-21 the user replaced the project-wide Vitest/TypeScript rule with subsystem-specific language and test-framework choices. Organization by purpose, including `tests/github-actions/`, is retained. The GitHub release subsystem is to migrate to Python and pytest; earlier Vitest migration documents do not override this decision.

* On 2026-10-21 the user requested `double-release` subsystem directories under `scripts/` and the existing `tests/` catalog; this supersedes `tests/github-actions/release/` for machine release tests.
