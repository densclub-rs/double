---
id: gitclarity-2026-11-09t16-21-27-s05
kind: stage-realization
template-id: stage-realization-template
project-id: double
produced-by: machine-of-goals/plan-realization-agent
interaction-language: ru
artifact-language: en
realization-id: gitclarity-2026-11-09t16-21-27
stage-id: S05
branch: incremental-inspection
plan-artifact: ../../plan.md
---

<a id="gitclarity-2026-11-09t16-21-27-s05"></a>

# S05: Remote Comparison

Plan stage: [S05](../../plan.md#stage-s05)

## Input State

#### S05-I01: Local Inspection

- Establish S04-O01 and the S03 repository, transport and availability contract.

Evidence requested and supplied: S04 documentary validation, approved S03
command behavior and its source/transport contracts. Decision: S05-I01 accepted.
User explicitly authorized S05 with “да”. Revision-7 source digest was rechecked
unchanged before action. All implementation stays inside scripts/git-double as
separate readable functions; tests stay in tests/git-double. No S06 permission
configuration or helper delivery to other projects is authorized here.

## Actions

Captured intended actions:

- Read remote tags without fetching or changing local refs; retain annotated
  tag-object and peeled-commit identities.
- Read GitHub Releases separately, including tag association, draft/prerelease,
  URL and published asset inventory; handle all pages.
- Produce one comparison per machine: local-only/remote-only tags, conflicting
  identities/targets, missing Releases and version/channel discrepancies.
- Preserve useful partial results while reporting authentication, network and
  rate-limit errors as unavailable/unknown sources with appropriate error exit codes.

Implementation completed inside [scripts/git-double](../../../../../scripts/git-double),
with separate functions for remote selection, sanitized transport, tag parsing,
Release pagination, version-channel summaries, per-source collection, comparison
and human/JSON rendering. No adjacent implementation module or design file was
created in scripts/. Tests remain in tests/git-double/.

Delivered behavior:

- versions now combines local knowledge with remote latest stable and latest RC
  only when newer (or RC alone when stable is absent). It rejects unsupported
  consumer-project contexts before network reads. Numeric-alias ambiguity is
  explicit; remote-tags listing preserves aliases without selecting a summary.
- remote-tags reads direct/peeled advertisements without fetch or ref mutation.
  HTTPS transport is isolated from repository/global Git config, URL rewrites,
  shell credential helpers and debug tracing. Recognized GitHub SSH repository
  addresses are translated to HTTPS without invoking SSH. Existing GitHub
  credentials are supplied privately, outside argv and persisted configuration.
- releases performs bounded explicit GitHub GET requests with pagination,
  per-request/total deadlines and validated records/assets. Partial records are
  retained on failure. Draft visibility remains explicitly unknown rather than
  claiming unavailable drafts are absent.
- compare collects local knowledge, HEAD provenance, local tags, remote tags
  and Releases independently. It reports version differences, missing tags,
  object/commit conflicts, invalid local tagged contracts, missing published
  Releases and channel mismatches. Unavailable/incomplete counterpart sources
  suppress absence claims. Exit 2 takes precedence over mismatch exit 1.

Observed commands (Double project root):

1. `python3 -m unittest discover -s tests/git-double -p 'test_*.py'`
   — exit 0; 35 tests passed in 5.678 seconds after final source changes.
   Includes [local fixtures](../../../../../tests/git-double/test_inspection.py)
   and [remote protocol/comparison fixtures](../../../../../tests/git-double/test_remote.py).
   Tests exercise complete and partial inventories, agreement/discrepancies,
   pagination, authentication/rate-limit/malformed responses, timeout, missing
   executables, repository mismatch, channel policy, transport isolation and
   human/JSON output. Disposable repository byte snapshots verify preserved
   worktrees, indexes, config, refs and Git objects.
2. `python3 scripts/test-git-double.py` — exit 0; 8 original tests passed in
   1.534 seconds. Existing check/sync/watch behavior remains applicable.
3. `git diff --check` — exit 0. versions/compare `--help` invocations also exit 0.
4. `python3 scripts/git-double versions --machine machine-of-goals --json`
   — attempted against the real configured GitHub origin; exit 2. Local version
   0.0.20 was retained and the remote source reported unavailable, without
   inventing absent tags. Repeated with sandbox escalation and received the
   same unavailable result. A diagnostic read classified Git failure as DNS
   resolution, without printing credentials or raw transport diagnostics.
   Production error classification now includes network-dns/network-tls.

Live GitHub success is NOT established: this environment could not resolve the
remote host, even after sandbox escalation. No tags, Releases, aliases, executor
permissions or publication settings were changed. No credentials were configured.

Step-05 result handed to step 06 for output verification below.

## Output State

#### S05-O01: Four Source Comparison

- Test deterministic transport fixtures for agreement, all discrepancy classes, pagination and failures; check human/structured output and exit codes. Perform an authorized read-only live smoke check when access is available; unavailable live evidence remains an explicit limitation.

Step-06 documentary decision: S05-O01 accepted for the deterministic fixture
scope and the completed command implementation. All specified fixture checks
and regression checks passed. The conditional live smoke check was attempted;
its environmental DNS limitation is preserved above and does not establish
successful end-to-end GitHub access. Recheck live operation when access exists.

This is stage acceptance, not final goal acceptance. S06 agent setup/rules and
scoped permission verification, then S07 overall validation, remain required.
The next stage needs the user's executor, project-scope and command selections
before any permission configuration. Project W delivery remains excluded.
