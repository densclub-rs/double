---
id: gitclarity-2026-11-09t16-21-27-s04
kind: stage-realization
template-id: stage-realization-template
project-id: double
produced-by: machine-of-goals/plan-realization-agent
interaction-language: ru
artifact-language: en
realization-id: gitclarity-2026-11-09t16-21-27
stage-id: S04
branch: incremental-inspection
plan-artifact: ../../plan.md
---

<a id="gitclarity-2026-11-09t16-21-27-s04"></a>

# S04: Local Release Inspection

Plan stage: [S04](../../plan.md#stage-s04)
Realization: [gitclarity](./realization.md#gitclarity-2026-11-09t16-21-27)

## Input State

Captured revision-7 contract:

#### S04-I01: Local Contract

- Establish S03-O01 and available fixture repositories/version knowledge.

Documentary evidence requested and supplied: S03 command contract, explicit user
design decisions and local release parsing/resolution code. S03-O01 accepted
in its stage record. Disposable Git repositories can provide candidate knowledge,
tags and dirty worktrees. Decision: S04-I01 accepted by documentary inspection.
The versions command reads current knowledge only; committed provenance is
exposed through local tag inspection. Remote versions remain unavailable until S05.

## Actions

Captured intended actions:

- Implement resolved machine versions with source paths and working-tree versus
  committed/tagged provenance, reusing ordinary lookup and strict release rules appropriately.
- Inspect local annotated/lightweight tags, tag objects, peeled commits, channels
  and annotations. Compare the corresponding tagged version and changelog contract.
- Keep local preparation claims limited to the checks actually made.

Implementation:

- Added all inspection implementation inside [scripts/git-double](../../../../../scripts/git-double),
  as requested by the user. Named functions separate ordinary knowledge lookup,
  validity checks, strict tagged-tree resolution, annotation/version/changelog
  validation, report construction, argument handling and output. The entry point
  dispatches versions/tags without changing existing check/sync/watch semantics.
- The script is standalone, uses Python's standard library and does not import
  an adjacent implementation module. Release tag grammar and strict knowledge
  resolution preserve the release subsystem's existing contracts in this file.
- Local versions is limited to Double/forks using existing double-project
  knowledge and source layout. It reports knowledge paths and scope, skips
  unusable/conflicting rules and follows nearest usable scopes/default knowledge.
- tags resolves each local tag object/commit and reads knowledge from that exact
  tree. It reports annotation and source paths in text and JSON, and checks full
  version/channel changelog identity. It does not fetch or repair old tags.
- Remote versions is explicitly unavailable with exit 2 until S05. Local results
  are preserved. This is not a claim that complete versions is implemented.
- User clarified S04/S05 implement features rather than being standalone testing
  stages; tests below verify the implementation outcome. No plan structural edit.

Commands and observations (working directory: Double project root):

1. `python3 -m unittest discover -s tests/git-double -p 'test_*.py' -v`
   — exit 0; 19 tests passed in 3.588 seconds after single-file refactoring.
   [Test source](../../../../../tests/git-double/test_inspection.py) uses disposable
   real repositories. Every CLI fixture snapshots all repository file bytes,
   including index, config, excludes, refs and Git objects, before/after reads.
2. `python3 scripts/test-git-double.py` — exit 0; all 8 original visibility tests
   passed in 1.363 seconds after the final source changes.
3. `git diff --check` — exit 0, no whitespace errors.
4. `python3 scripts/git-double versions --machine machine-of-goals --json`
   — expected exit 2; local knowledge resolved to 0.0.20 in the current checkout,
   with its .double-rules source, and remote state explicitly unavailable/pending
   S05. That observed version is a workspace value, not a release/publication claim.
5. `python3 scripts/git-double tags --machine machine-of-goals --json`
   — exit 1, source complete, 12 local tags and 8 reported issues. Reviewing those
   issues found historical missing changelog sources, one lightweight tag and one
   annotation mismatch. These are observed input discrepancies; no tags changed.

Coverage includes dirty worktrees versus tagged trees, numeric-only knowledge
and RC/stable tags, annotation mismatch, missing/duplicate/channel-mismatched
changelog entries, non-commit/lightweight tags, signature-text normalization,
external/symlink tagged sources, invalid/expired/conflicting ordinary sources,
parent/default fallback, source context checks, JSON errors and human output.
Signature text normalization does not verify cryptographic signatures.

Step-05 action result handed off to step 06; verification below compares these
observations to captured S04-O01. No network, alias/permission configuration,
staging, release publication or S05 implementation was performed.

## Output State

Captured output contract:

#### S04-O01: Local Inspection Evidence

- Use isolated fixtures for valid and conflicting version sources, dirty worktrees, missing/incorrect annotations, channel mismatches and tagged-tree differences. Verify reads preserve refs, index and configuration.

Documentary evidence supplied: the source, isolated test output and smoke
observations above. The fixture suite establishes valid/conflicting sources,
dirty/tagged separation, annotation/channel failures and no local read mutation.
The original suite confirms the existing exclusion behavior remains applicable.

Step-06 decision: S04-O01 accepted on documentary evidence for the implemented
local scope. The complete versions command still requires S05 remote data;
remote transport, GitHub Releases, comparison and permissions remain unvalidated.
S04 completion is not overall goal acceptance. Next eligible stage is S05,
subject to continuation authorization.
