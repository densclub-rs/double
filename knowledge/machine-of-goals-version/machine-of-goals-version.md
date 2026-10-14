---
id: machine-of-goals-version
kind: knowledge-artifact
status: release-candidate
produced-by: knowledge-extraction-agent
interaction-language: ru
artifact-language: en
knowledge-type: static
access: free-of-charge
value-type: text
observed-at: 2026-10-14
ttl: one month
derived-from:
  - knowledge/double-main-modules/double-main-modules.md
  - ideas/machine-of-goals/machine-of-goals.md
  - .double/workflows/machine-of-goals/machine-of-goals-workflow.md
  - user-provided project versioning decision
  - user-approved structured-choice interface update on 2026-10-14
  - user approval of successful-command contract and version 0.0.9 on 2026-10-14
---

<a id="machine-of-goals-version"></a>

# Machine of Goals Version

## Description

The version assigned to the `machine-of-goals` main module of the Double
project.

## Value

`0.0.10`

## Change Note

Version `0.0.10` updates the structured-choice interface for mode, path/subplan, realization and validation choices:

- prefer `request_user_input_async` only when exposed and permitted for the question
- wait for explicit user submission or equivalent direct instruction before
  dependent changes; preselection, silence, timeouts and tool acknowledgements
  do not grant approval
- respect runtime tool/mode restrictions and use a permitted structured
  alternative or concise text fallback when needed
- preserve free-form clarification, existing authorization and workflow gates

The successful-command contract introduced in version `0.0.9` remains supported:

- runs preserve successful commands implementing plan actions or validating
  conditions/results, regardless of whether a human, agent or automatic
  realization executed them
- entries keep execution order, stage, purpose, working context, exact safe
  command, observed result and replay/automation constraints
- this is a useful selection, not a full trace: failed attempts, redundant
  repeats and incidental bookkeeping need not be recorded as commands
- validation checks applicable command entries or an explicit statement that
  no applicable commands executed; group success is checked per command
- generated human instructions and their history remain a separate section;
  successful commands provide evidence for future automation, not permission
  to replay them or an automatic realization registration

The existing plan revision and execution contracts remain supported:

- compatible edits to unstarted stages are recorded in the current plan change
  log without creating a new plan revision
- each stage attempt captures its effective contract in the run before action;
  validation uses the captured criteria and evidence
- changes to frozen obligations require a new immutable plan revision and an
  explicit revalidation or rework decision
- historical baselines and completed runs remain unchanged; progress and
  continuation require contract and dependency compatibility checks
- existing release-candidate skill packaging remains supported
