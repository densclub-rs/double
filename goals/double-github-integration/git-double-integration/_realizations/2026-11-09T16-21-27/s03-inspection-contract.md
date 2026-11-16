---
id: gitclarity-2026-11-09t16-21-27-s03
kind: stage-realization
template-id: stage-realization-template
project-id: double
produced-by: machine-of-goals/plan-realization-agent
interaction-language: ru
artifact-language: en
realization-id: gitclarity-2026-11-09t16-21-27
stage-id: S03
branch: incremental-inspection
plan-artifact: ../../plan.md
---

<a id="gitclarity-2026-11-09t16-21-27-s03"></a>

# S03: Inspection Contract

Plan stage: [S03](../../plan.md#stage-s03)
Realization: [gitclarity](./realization.md#gitclarity-2026-11-09t16-21-27)

## Input State

Captured input contract:

#### S03-I01: Applicable Baseline

- Establish S01-O01 and S02-O01; read goal criteria and existing version, tag, changelog and packaging contracts.

Documentary evidence requested: applicable prior outputs and current source/rules.
Supplied: S01-O01 and S02-O01 have current documentary validation. Goal criteria, version/changelog knowledge, release_common.py, package() and approved_changelog() were inspected; their strict tagged-tree behavior is available as the release authority.
Decision: S03-I01 accepted on documentary inspection.

## Actions

Captured intended actions:

- Specify exact subcommands/options, human and machine-readable output,
  schema expectations and exit codes 0/1/2 (agreement/mismatch/error).
- Define working-tree versus committed/tagged versions, source provenance,
  machine/version/channel parsing and annotation/changelog agreement.
- Define explicit repository/remote selection, GitHub authentication and pagination,
  source availability, partial results and comparison identity. Unknown is not absent.
- Choose supported read transports and dependencies, keeping check/sync/watch lightweight.
  Do not execute release tooling merely to inspect its state.

Actual actions:

1. Read the local release parser, source resolver, packager and changelog validator.
   Confirmed numeric-only knowledge versus channel-bearing tags, and ordinary
   versus strict tagged-tree source contracts. No release entry point was run.
2. Produced the proposed [inspection contract](./s03-inspection-contract.md#command-contract).
   It specifies five read commands, explicit remote/repository selection,
   human/JSON output, source states, issue codes, error precedence, bounded
   transports and implementation acceptance fixtures.
3. Reviewed the proposal against every captured S03 action and goal sections
   5–7. Preserved existing check/sync/watch and excluded project W delivery.
   HTTPS-only remote reads and initial GitHub.com support are explicit limits.
   The implementation must demonstrate controlled transport configuration;
   this document does not claim that boundary already exists.
4. Handed the proposed output to step 06 for review before S04. CLI behavior,
   source data structures and permission safety have not yet been implemented.

Design deliverable: the linked contract, not a new workflow process artifact.
No plan revision, publication, local config change or remote call was performed.

<a id="command-contract"></a>

### Command Contract

This is the proposed S03 interface for the [Git Double Integration plan](../../plan.md#stage-s03).
It records the existing ignore-management interface and specifies proposed
inspection commands. Only `check`, `sync` and `watch` are implemented today;
they retain their behavior and invocation syntax.
Distribution to other projects and systemic integration for project W are outside scope.

#### Existing file-ignore commands

Confirmed against `scripts/git-double` and its `--help` output. These commands
already implement the visibility policy; S03 reuses their contract from S01–S02.

| Command | Purpose | Effects |
| --- | --- | --- |
| `check [PATH ...]` | Compare document status with actual Git ignoring | Read-only |
| `sync [PATH ...]` | Apply status-based ignore rules in the selected scope | Write only the managed local `info/exclude` block |
| `watch [PATH ...] [--interval SECONDS]` | Repeat sync; default interval two seconds | Same local writes as sync until interrupted |

Default roots are `.double`, `ideas`, `goals`, `knowledge`. Untracked Markdown
`draft` files are excluded; `release-candidate` and `stable` should be visible.
Tracked files are exempt; unknown/missing statuses are unmanaged. Sync removes
obsolete managed entries while preserving unrelated/out-of-scope rules, and
reports external ignore conflicts without overriding them. Explicit paths,
frontmatter parsing and path restrictions retain their documented behavior.

These exclusions affect ordinary staging visibility, not whether Git permits
a commit: tracked changes and explicit `git add -f` remain possible. No staging,
commit or hook action occurs. Polling is opt-in and has a delay. Ctrl-C exits
watch cleanly. Check/sync exit 0 for agreement, 1 for mismatches, 2 for errors.
Their existing text output is retained; `--json` below applies only to proposed
inspection commands. The existing tests supply baseline evidence, not proof
that proposed inspection commands exist. No new `ignore` wrapper is proposed.

#### Proposed inspection commands and source selection

Until an entry point is configured, examples use `python3 scripts/git-double`.
After setup, `git double` has the same command arguments.

| Command | Sources read | Network |
| --- | --- | --- |
| `versions [--machine ID] [--remote NAME] [--json]` | Local version knowledge resolved through Double rules and remote machine versions from GitHub tags | Yes |
| `tags [--machine ID] [--json]` | All matching local tags and each tagged version/changelog contract | No |
| `remote-tags [--machine ID] [--remote NAME] [--json]` | Tags advertised by one configured remote | Yes |
| `releases [--machine ID] [--repo OWNER/REPO] [--json]` | GitHub Releases for one repository | Yes |
| `compare [--machine ID] [--remote NAME] [--repo OWNER/REPO] [--json]` | Working-tree and HEAD versions, local tags, remote tags and Releases | Yes |

`--machine` selects one of the machine identifiers currently supported by
`scripts/double-release/release_common.py`. Omission selects all supported
machines, sorted by identifier. Unknown IDs are usage errors; no loose name
matching or automatic fallback to another machine. Installer releases are excluded.

`--remote` defaults to `origin`, never the first remote found. Accept only a
configured remote name, not a shell expression or arbitrary URL. Read its fetch
URL as data. Missing, ambiguous or unsupported selection is an error. One
configured remote must resolve to one unambiguous fetch URL for inspection.

`--repo` is an explicit GitHub.com `OWNER/REPO`, validated as two nonempty
repository-name components with no URL, query, fragment, traversal or option
syntax. Otherwise derive it from origin's single GitHub.com HTTPS or SSH fetch
URL, stripping a final `.git`. `compare` derives it from its selected remote.
No `gh` repository autodetection: every API call names the selected repository.
If explicit `--repo` and the selected comparison remote identify different
GitHub repositories, fail rather than combine unrelated sources. Other Git
hosts may supply public HTTPS `remote-tags`; Releases require an explicit GitHub repository.
GitHub Enterprise is unsupported initially and reported as such.

<a id="versions-command"></a>

#### Versions: Double source projects only

User clarification: `versions` operates on the main Double project or its forks,
not arbitrary projects containing installed Double machines. Identify the project
using declared Double identity and source layout; a remote name alone does not
prove it is Double. The implementation must define a reproducible check against
existing project artifacts, not add a new project marker. Report unsupported
context rather than inspecting consumer installations.

For each selected machine, output exactly two version entries:

1. **Local:** check for usable `<machine>-version` knowledge, resolving its source
   through applicable Double project rules. Read its current numeric version;
   retain the knowledge path/provenance for diagnosis. Do not hard-code the
   grouped knowledge layout or infer a version from installed payloads.
2. **Remote:** obtain machine version information from release tags in the
   selected Double/fork GitHub repository. Use the existing tag name/channel
   contract, not local cached refs or GitHub Releases. The selected remote
   defaults to origin; a fork therefore inspects its own repository unless an
   explicit configured remote is selected. Never silently substitute upstream.

`versions` has no `--ref` mode and does not read HEAD/tagged knowledge as a
third version entry. The committed/tagged rules below apply to other commands.
Remote-tag reads reuse the bounded read-only transport specified below. No fetch,
local tag creation, release publication or GitHub Release query is required.

Missing/unusable local knowledge, a complete remote inventory containing no
matching tag, and unavailable remote access must remain distinguishable. Retain
local output when the remote fails. A tag confirms a remote tag version, not
successful publication. The existing 0/1/2 agreement/mismatch/error convention
applies, with incomplete sources taking precedence over mismatches.

Remote summary policy, selected by the user:

- Always show the latest stable tag when present, comparing numeric version
  components rather than lexicographic tag names or tag creation dates.
- Also show the latest RC tag when its numeric version is newer than the latest
  stable version. If stable is absent, show the latest available RC.
- An RC equal to or older than the latest stable is omitted from the summary.
  Legacy dev tags are not selected for either channel.
- Retain the full tag name and channel. A complete inventory without a selected
  stable/RC tag is reported as absent; unavailable access remains unknown.
- If different exact tag spellings map to the same numeric version/channel,
  preserve the candidates and report ambiguity rather than arbitrarily choosing.

The remote entry therefore has stable and newer-RC channel values, not a single
merged "latest" version. For example, stable `1.2.0` and RC `1.3.0-rc` are both
shown; stable `1.3.0` suppresses RC `1.3.0-rc` and `1.2.0-rc`. The latest RC
summarizes its channel rather than listing every historical RC; the tag inventory
commands retain detailed history. JSON retains separate nullable `stable` and
`rc` fields inside the remote entry, with source availability and full tag names.
The two top-level version entries per machine remain local and remote.

Required versions fixtures: Double versus unsupported consumer context; fork
with distinct origin/upstream; indexed version knowledge and ordinary-rule
fallback; missing/invalid knowledge; stable plus newer RC, equal/older RC suppression, RC-only, stable-only,
legacy dev exclusion and ambiguous numeric tag spellings; empty complete tag list; unavailable remote with local value
preserved. No implementation-test success is claimed.

#### Version and tag interpretation

Version knowledge observations report machine, value, knowledge path and owning
rule scope. `versions` uses current knowledge only, as specified above. Other
commands may report source mode (`working-tree` or `commit`) and commit. Compare
reports both working-tree and HEAD sources, including source-path changes and
version differences. Global worktree dirtiness is informational; do not call a
version dirty solely because unrelated project files changed.

Working-tree resolution follows the existing ordinary project/group rule
protocol at the project and two nearest parent levels, with readiness, validity,
duplicate-id exclusion and nearest usable scope selection. Invalid closer
knowledge may fall back, retaining provenance and diagnostics. If no indexed
source applies, use the existing historical knowledge path. Do not invent
new `.double-rules` configuration or assume grouped file locations.

Committed and tagged checks resolve their index, version and changelog from
one exact Git tree. Follow strict release source selection: broken, conflicting
or external-only sources cannot establish a reproducible tagged release.
Report issues instead of falling back to the current checkout or parent files.
Reuse side-effect-free release parsing/resolution where applicable; do not use
the strict resolver as a substitute for ordinary working-tree fallback.

Numeric version knowledge uses `X.Y.Z`, matching the current packager. Preserve
its spelling, including leading zeros, while using numeric tuples for ordering.
Tags use `<machine>-X.Y.Z[-rc|-dev]`; no suffix means stable. The tag supplies
the channel independently of numeric knowledge. A matching `0.0.19` knowledge
value is compatible with the numeric part of `0.0.19-rc`; a full-version
changelog heading must still include `-rc`. Legacy dev tags/releases are
reported as historical observations, not eligible new publication candidates.

Local tags report full ref, tag-object OID, object type, peeled commit OID,
annotation (nullable), numeric version, channel, knowledge source and validation
issues. A lightweight tag is observable but cannot meet the annotated release
contract. Non-commit targets are invalid release candidates. Unknown tag names
are excluded from machine comparison and counted as unrecognized, not errors.

For each recognized local tag, inspect the tagged numeric version and the
exact full-version changelog entry, including heading/date and change bullets.
Compare annotation using the release-note contract, including its existing
signature handling. Report a separate issue for each discrepancy. A valid local
tag means those checks passed; it does not establish package validation,
approval, publication, workflow success or goal acceptance.

#### Remote reads and availability

Remote tag transport is a bounded `git ls-remote --tags` read against the
selected fetch URL, retaining direct OIDs and advertised `^{}` peeled OIDs.
It never fetches objects, updates refs, writes FETCH_HEAD or loads remote
annotations into the local object database. Annotation content for remote-only
objects is therefore unknown. If peeling is unavailable, keep an unknown
commit rather than guessing that a tag object is a commit.

Use `gh api --method GET` for GitHub Releases, with an explicit GitHub.com host
and repository and pagination until exhausted. No login, token setup, release
creation or credential output. Report ID, tag name, draft/prerelease flags,
HTML URL, published timestamp and assets (name, size and download URL).
Do not download assets. Release `target_commitish` is descriptive data and
does not replace the remote tag's resolved commit identity.

All reads have finite timeouts; initial defaults are 30 seconds per Git/API
request and 120 seconds for a complete remote source. Exceeding a time or page
budget makes that source incomplete, never a complete empty inventory. Do not
silently truncate. Pagination implementation must retain a completion signal.
Commands do not prompt for credentials or launch authentication flows; missing
or interactive-only credentials produce an unavailable source.

Availability is `ok`, `unavailable` or `incomplete`. Authentication failures,
timeouts, rate limits, access denials and malformed responses are errors.
Successful empty inventories are `ok` with empty arrays. GitHub 404 may mean
absent or inaccessible: report unavailable, not an empty Releases list.
Unauthenticated API success cannot prove the absence of nonpublic drafts;
report draft visibility as unknown unless accessible draft visibility is
established. Public published-Release absence checks may still use a complete
public inventory with that limitation visible.

Transport dependencies are Python 3.9+, Git and GitHub CLI for Releases/compare
or authenticated GitHub tag reads. Retain standard-library-only Python.
Invoke subprocesses with argument arrays, `shell=False`, bounded timeouts and
fixed read operations. No user-provided executable argument or release entry
point is executed. Normal trusted-tool resolution applies to Git and gh.

For remote tag reads, use HTTPS only. Recognized GitHub SSH fetch URLs are
converted to the corresponding HTTPS URL; do not execute SSH. Reject other SSH,
file, ext, custom helper and unsupported URL schemes. Pass the validated URL
to Git rather than the remote name, avoiding remote-specific upload commands.
Disable credential helpers and interactive prompting and override URL rewriting,
protocol and upload-command settings by using a controlled read-only Git
configuration/environment, not the repository's transport configuration. The
implementation must test this boundary before permission grants. Local config
is read only as data for remote selection.

For private GitHub HTTPS tag reads, read an existing credential through
`gh auth token --hostname github.com`, capture it privately and supply a
host-scoped HTTP authorization header to the Git subprocess via protected
per-process environment configuration. Never place tokens in argv, reports,
fixtures or persisted config. No `gh auth login`, credential setup, shell
credential helpers or config mutation. Missing usable credentials produce
unavailable, not an anonymous-empty result. Non-GitHub private tag authentication
is unsupported initially. Public GitHub reads can proceed anonymously with
visibility limits explicit. Do not retry after a definitive authentication or
rate-limit error as an anonymous request that could conceal private state.

#### Comparison

Emit one comparison per selected machine, with every recognized tag as an
addressable item. Never hide older conflicts by reporting only a latest tag.
Sort versions numerically, then channel, then full tag name, retaining exact
names rather than merging differently spelled refs. Source availability is
independent of discrepancy results.

| Issue code | Established condition |
| --- | --- |
| `working-version-differs` | Working-tree version/source differs from HEAD |
| `version-tag-missing` | Current numeric version has no local stable/RC tag; legacy dev alone does not count |
| `local-only-tag` | Local tag missing from a complete remote inventory |
| `remote-only-tag` | Remote tag missing from a complete local inventory |
| `tag-object-conflict` | Same tag name has different direct OIDs |
| `tag-target-conflict` | Same tag name has different known peeled commits |
| `invalid-local-tag` | Local annotation, target, tagged version or changelog fails its release contract |
| `release-missing` | Remote tag has no matching accessible Release in a complete applicable inventory |
| `release-tag-missing` | A Release tag is missing from a complete remote tag inventory |
| `release-channel-mismatch` | Stable Release is prerelease, or RC Release is not prerelease |

A draft is reported explicitly and is not a published Release; distinguish
`draft-only` from `published` and from unknown draft visibility. Publication
status is not inferred from a tag. Unknown prerequisites suppress absence
claims for the affected comparison while preserving all known observations.
No issue means only agreement for the requested observable checks. Asset
inventory is reported, without claiming checksum/package validity.

#### Output and exit status

Human output has one section/line per machine, source provenance/availability,
tag/Release observations and actionable issue codes. It explicitly says when
sources or checks are unknown. Diagnostics must redact credentials embedded
in URLs or subprocess errors.

`--json` emits exactly one JSON object to stdout, including on operational
errors. Argparse-level usage errors may emit diagnostics only to stderr and
exit 2. No progress text is mixed into JSON. The schema uses:

```json
{
  "schema_version": 1,
  "command": "compare",
  "repository": {"root": "/example/double", "remote": "origin", "github": "owner/repo"},
  "sources": {
    "versions": {"state": "ok", "errors": []},
    "local_tags": {"state": "ok", "errors": []},
    "remote_tags": {"state": "unavailable", "errors": [{"code": "authentication", "message": "Remote access unavailable"}]},
    "releases": {"state": "unavailable", "errors": [{"code": "authentication", "message": "GitHub access unavailable"}]}
  },
  "machines": [{
    "machine": "machine-of-goals",
    "versions": [],
    "local_tags": [],
    "remote_tags": [],
    "releases": [],
    "issues": [],
    "unknown_checks": ["remote-tag-comparison", "release-comparison"]
  }],
  "exit_code": 2
}
```

This abbreviated example illustrates unknown remote sources; empty arrays do
not independently assert absence. Commands include only requested sources;
version/tag/Release items carry the fields defined above. Missing values are
null, not fabricated strings. Each issue has `code`, `machine`, nullable `tag`,
`message` and supporting source references. Unknown checks identify their
unavailable prerequisites. Source errors use stable codes and sanitized text.

- **0:** requested sources complete and observable checks agree.
- **1:** requested sources complete and at least one mismatch exists.
- **2:** usage, dependency, source, parsing or execution error; retain available
  observations and mismatches. Errors take precedence over exit 1.

Unavailable working-tree version knowledge is an error; a confirmed missing
expected tag/Release in otherwise complete inventories is a mismatch. Per-tag version/changelog/annotation violations are mismatches (exit 1), while
unreadable inventories or malformed transport data are source errors (exit 2).
Commands that only list a source still report its applicable checks. An empty
tag/Release inventory is not itself a mismatch unless a required relationship
is being checked.

#### Required implementation fixtures

These are specified acceptance cases for S04–S05, not passing-test claims.

| Fixture | Expected observations |
| --- | --- |
| Indexed version and fallback; invalid closer rules; duplicate IDs; external group source | Correct ordinary source/provenance; strict tagged-tree rejection where applicable |
| Worktree edits, source move, HEAD difference, unborn HEAD | Independent worktree/commit observations; unknown committed source never substituted |
| Annotated RC/stable, lightweight tag, non-commit tag, signed annotation | Numeric knowledge/channel separation; exact applicable changelog comparison |
| Same commit with different tag objects; different peeled commits | Object conflict and target conflict remain distinct |
| Only local or only remote tag | Absence established only by complete counterpart inventory |
| Published Release, draft-only Release, missing Release, orphan Release, channel mismatch, assets | Separate publication/channel/asset observations with no inferred publication |
| Multiple API pages, rate limit, 404, timeout, malformed JSON, missing gh | Complete pagination or explicit incomplete/unavailable; exit 2 with partial data |
| Public-only access with invisible drafts | No proof of draft absence; public published inventory and limit remain explicit |
| Multiple remotes, no origin, non-GitHub remote, repo mismatch, embedded credentials | Explicit selection/error and redaction; no accidental cross-repository comparison |
| Read commands with configured aliases, credential helpers, hooks and hostile transport config | No arbitrary execution; unsupported configurations fail clearly |
| Snapshot refs/config/index/exclude/worktree before and after every read | No local mutation, no fetch or release actions |
| Existing eight visibility tests alongside inspection tests | Existing CLI behavior preserved |

Review this contract before implementing S04. Exact executor permission scope
remains a separate user choice in S06; no permissions are granted by this document.


## Output State

Captured output contract:

#### S03-O01: Inspection Specification

- Review a concrete CLI/output contract and fixtures for all four sources, mismatches, unavailable sources and unsupported inputs. Resolve design choices before implementation; return model changes to review.

Documentary evidence requested: deliverables and checks against this contract.
Agent documentary review: the linked contract covers all captured design
subjects and specifies deterministic fixture cases for implementation. Link and
anchor checks passed. No implementation-test success is asserted.

Decision: S03-O01 unconfirmed pending user review of the proposed CLI, output
semantics and transport limits. This required review is the remaining stage
exit condition; S04 is not started. User approval of the plan/start does not
assert acceptance of a contract that did not yet exist.

<a id="command-design-review"></a>

### Command Design Review

The user requested a separate S03 design item per command. Revision 4 of the
main plan expands its existing action accordingly; stage composition, IDs and
captured revision-3 conditions above remain unchanged. No prior design approval
is inferred from the user's plan-organization request.

Legend: 🟠 draft designed, awaiting review; ✅ existing baseline contract confirmed
or new command design explicitly accepted, as identified in the evidence column.
These confirmations do not establish implementation of new commands.
These are design states, not implementation or passing-test claims.

| Command | Design state | Existing design evidence | Remaining review |
| --- | --- | --- | --- |
| `check` | ✅ | [Existing ignore contract](./s03-inspection-contract.md#command-contract), source and S01–S02 checks | Preserve read-only scope/status/mismatch behavior in the combined CLI |
| `sync` | ✅ | [Existing ignore contract](./s03-inspection-contract.md#command-contract), source and S01–S02 checks | Preserve managed local exclude writes and index/content exemption |
| `watch` | ✅ | [Existing ignore contract](./s03-inspection-contract.md#command-contract), source and S01–S02 checks | Preserve opt-in polling; retain recorded SIGINT test coverage limitation |
| `versions` | ✅ | [User-refined contract](./s03-inspection-contract.md#versions-command); user explicitly accepted the versions design | Design accepted; implementation not started |
| `tags` | ✅ | [Contract](./s03-inspection-contract.md#command-contract): local tags; user explicitly accepted the presented design including version/changelog checks | Design accepted; implementation not started |
| `remote-tags` | ✅ | [Contract](./s03-inspection-contract.md#command-contract): remote tags; user explicitly accepted the presented behavior | Design accepted; implementation not started |
| `releases` | ✅ | [Contract](./s03-inspection-contract.md#command-contract): Releases; user explicitly accepted the presented behavior | Design accepted; implementation not started |
| `compare` | ✅ | [Contract](./s03-inspection-contract.md#command-contract): comparison; user explicitly accepted the presented behavior | Design accepted; implementation not started |

The five new commands have draft designs and are not accepted or implemented.
The three ignore commands already exist and have baseline documentary checks.
Review the combined ignore interface first, then `versions`, followed by `tags`,
`remote-tags`, `releases`, then `compare`. S03-O01 remains unconfirmed until
the complete shared contract is reviewed.

User correction: S03 must include existing file-ignore management. Re-read the
full script and ran `python3 scripts/git-double --help` in the project root:
exit 0, commands `{check,sync,watch}`. Added these three existing contracts to
the S03 review table and proposed combined command document. Plan revision 5
clarifies existing actions without changing stage/substage composition or IDs.
Original captured conditions remain above; the expanded model needs review
before future execution. No helper code or local exclusions were changed.

### Versions clarification from the user

User states that versions is only for the main Double project or its forks,
reads machine version knowledge according to Double project rules, checks that
knowledge exists, and shows local knowledge versions plus remote versions from
GitHub repository tags. Recorded this scope and the two-source output in the
command contract and plan revision 6. Removed the proposed `versions --ref`
mode; committed/tagged inspection remains in other commands. No implementation
or new approval of the remaining commands is implied. Multiple-tag/channel
selection remains a concrete open design question; S03-O01 stays unconfirmed.

### Versions remote-channel decision

The user selected separate channel reporting: show stable and more recent RC
versions. Recorded latest stable plus latest numerically newer RC; if stable is
absent, show latest RC. Equal/older RC and dev tags are omitted from this summary.
Full tag/channel identity and unavailable-versus-absent semantics are retained.
This resolves the prior channel-policy question. The consolidated versions
contract reflects the user's decisions; no CLI implementation or S03-wide
acceptance is claimed. Main plan revision is now 7. Other commands remain drafts.

### Versions accepted; tags review opened

User decision: “по команде Versions всё нормально, давай переходим к следующей
команде.” Accepted the versions design based on the user's explicit review
of the scope, two sources and remote channel summary. This is design acceptance,
not independent implementation evidence. The next command review is `tags`;
its proposed behavior remains unaccepted. No implementation action is authorized
by this command-review transition and S03-O01 remains unconfirmed overall.

### Tags design accepted

User decision: “Да, согласую команду Tex. Это мне нравится.” In the immediate
context, “Tex” refers to the presented `tags` command, not a new command name.
Accepted scope: local machine release tags, machine/version/channel, target
commit, annotation and version/changelog checks from the same tagged commit;
read-only and no GitHub access. This is explicit user design acceptance, not
implementation validation. Next proposed command review: `remote-tags`.

### Remote-tags design accepted

User decision: “Да, хорошо.” This answers the immediately preceding remote-tags
review. Accepted behavior: selected GitHub repository tag inventory, machine,
version/channel, tag-object and available peeled-commit identity; default origin
and explicit configured --remote selection. No fetch or local mutation. Access
failure is unknown/unavailable, not no tags. Remote annotation/changelog checks
are excluded because their objects are not fetched. This accepts the presented
command behavior, not unreviewed transport implementation details or implemented
functionality. Next proposed review: releases.

### Releases design accepted

User decision: “Хорошо, согласую.” Accepted the presented releases behavior:
GitHub machine releases with name, associated tag, publication/draft/prerelease
state, publication timestamp, URL and asset names/sizes/links. Default repository
comes from origin; explicit --repo OWNER/REPO is supported. Read-only, tags do not
imply Releases, access failures remain distinct and draft visibility depends on
existing authorization. This accepts the presented command behavior, not
implementation evidence. The final proposed command review is compare.

### Compare accepted; S03 output validation

User decision: “Отличная команда, да, тоже ее согласую.” Accepted the presented
per-machine comparison: local knowledge versus remote stable/newer RC, local-only
and remote-only tags, direct-object/commit conflicts, local tagged contract
violations, remote tags without published Releases and channel/prerelease
mismatches. Unavailable checks stay unknown while available results remain;
no automatic repairs. Human/JSON output and exit 0/1/2 were explicitly presented
and accepted. This is design acceptance, not implementation validation.

Step-06 decision for captured S03-O01: accepted on the concrete command contract,
specified fixture cases, agent documentary coverage review and the user's
successive explicit command decisions. The original pending review decisions
above record history and are superseded by this validation. User refinements
restrict versions to Double/forks, local knowledge and remote GitHub tags with
latest stable/newer RC reporting; these are the effective agreed requirements.
The existing ignore commands are reused from the checked baseline. All five
new command behaviors are accepted, with no passing-implementation claim.

Detailed transport mechanisms and unsupported-environment diagnostics remain
implementation proposals to validate, not separate user permission grants.
The current main plan is revision 7; the realization's original revision-3
approval is preserved. Before future execution, renew review of revision 7 as
required for changed model content. Next eligible implementation stage is S04;
remote portions of versions are completed with the S05 remote tag transport.

### Contract location correction

The user requires scripts/ to contain scripts, not a standalone command design
artifact. Moved the complete proposed contract into this existing S03 record,
retaining the versions anchor and all design decisions. Removed the separate
Markdown file and rebased references. No new workflow artifact was introduced;
captured stage conditions and user acceptance history remain intact.
