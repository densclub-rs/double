---
id: double-installer
kind: knowledge-artifact
status: stable
produced-by: machine-of-knowledge/knowledge-extraction-agent
interaction-language: ru
artifact-language: en
knowledge-type: static
type: static
value-type: text
access: free-of-charge
observed-at: 2026-10-20
ttl: two years
derived-from:
  - ../../scripts/double-installer.sh
  - ../../tests/test-double-installer.sh
  - ../../goals/double-installer/plan.md
  - ../../goals/double-installer/run/interactive-rest--20261013T153107Z.md
  - user classification decision in conversation on 2026-10-13
---

<a id="double-installer"></a>

# Double Installer

## Description

Preserved installer contract and observed implementation results. Sections
marked planned are design commitments, not implemented capabilities. This
static design knowledge must be updated when the implementation changes.

The resulting installer script resides in the Double project's `scripts/`
directory at `scripts/double-installer.sh`.

## Value

### Observed implementation status

S01 through S05 are accepted. Published installer 0.1.1-rc has historical
six-platform CI evidence; see the goal run for exact product/harness commits.
The approved S05A extension below is implemented and tested locally on macOS
with Bash 3.2; fresh Linux/Windows CI and real agent loading are not confirmed
for this changed source. It has not been published as a new release.

Release commands use the REST API of `densclub-rs/double`, enumerate all pages,
and filter by machine and channel. Download verifies SHA-256 and tar member
paths/types before caching; it never extracts into a project. An existing
release cache entry is preserved. A single download reports a duplicate as an
error; bulk --all verifies and reuses intact cached entries.
Temporary downloads are discarded on handled errors/signals. API requests use
unauthenticated access and report HTTP/rate-limit errors; token support is not
implemented. SHA-256 checks detect corruption against the published checksum,
not an independent authenticity signature.

### Environment and dependencies

Use Bash on Linux/macOS and Git Bash from Git for Windows on Windows. Invoke
the script with Bash even if your interactive shell is Zsh. The implementation
targets Bash 3.2-compatible syntax; tested minimum OS/tool versions remain to
be established in the platform validation stage.

Required tools: cat, curl, jq, tar, awk, find, sort, uniq, wc, cp, mv, mkdir, rm, mktemp,
dirname, basename, rmdir, tr, cmp, and either sha256sum or shasum. cron/crontab is optional. Additional
dependencies may be installed by the user; the installer will not silently
install system packages. Use your platform's package manager to install jq
and curl; on Windows install Git for Windows and place a jq executable on Git
Bash's PATH. Concrete installation instructions and tested baselines are recorded below. Missing required tools cause a nonzero exit before any
project mutation. `doctor` checks command availability, not full compatibility.

### Command contract

See `scripts/double-installer.sh help` for syntax.

| Command | Intended behavior |
| --- | --- |
| `doctor` | Check dependencies and report evidence for eight supported detection candidates |
| `explain` | Explain the installer and every command in detail |
| `releases` | List published release packages; stable channel by default |
| `download` / `install` | Cache selected releases, or all machines by default, and verify checksums |
| `add` | Install machine files in a project and register the version |
| `remove` | Remove owned machine files and its registry entry |
| `status` | Show downloaded machine archives and registered installations |
| `update` | Update one installation, backing up previous contents first |
| `update-all` | Update registered installations and report per-installation results |
| `backups-clean` | Delete selected installer backups after explicit confirmation |
| `cron-add` | Create one marked update task with the specified schedule |
| `cron-remove` | Remove only this installer's marked tasks |
| `uninstall-all` | Remove all registered machines, cron tasks, and installer-owned state |

`--project` must identify an existing project directory. `--machine` selects
a published machine identifier; it is not a filesystem path. `--version`
selects an exact version; absence means highest applicable numeric version.
`--channel` is `stable`, `rc`, or `dev`. releases and explicit download
default to stable. add defaults to stable → rc → dev, choosing the newest
numeric version in the first available channel. Prerelease installation requires
affirmative terminal consent (also for explicit --channel), or add --yes.
Updates do not downgrade; project updates retain the registered channel unless
overridden. A bulk override applies explicitly to targeted installations.
Ignore drafts and automatic repository source archives.

Interactive destructive commands show their scope and ask confirmation;
`--yes` confirms that displayed scope without prompting. Unattended updates
use `--non-interactive`, never prompt, and retain backups. Interactive updates
offer backup deletion afterward. Full uninstall deletes backups as requested,
without preserving them as an exception to cleanup.

Exit contract: 0 success (including no applicable newer version), 1 operational
failure, 2 usage error.
For explicit installation/download, an unavailable requested release is an
operational failure. Bulk update reports individual failures and returns 1
if any installation failed. Human-readable output identifies project and
machine; diagnostics go to stderr. Secrets must not appear in output.

### Shared state and registry

Default root: `~/.local/state/double`; Git Bash resolves `~` on Windows.
`DOUBLE_STATE_DIR` is a test override for the root, not a different default.
The installer owns only the `installer/` subtree beneath this root:

```text
installer/
  releases/<release-tag>/        # package, checksum, release metadata
  backups/backup.<generated-id>/
  registry.json
  transactions/<transaction-id>/
  cron.log
  scheduling.json
  mutation.lock/                # transient exclusive mutation lock
```

Implemented registry schema version 1 has an `installations` array. Each record contains
a canonical absolute project path, machine id,
installed version/tag, selected channel, owned relative file inventory,
and installer-created directory inventory. Inventories are embedded in records;
opaque ids and separate inventory files in the proposed layout are not currently used. No shell evaluation of stored data.
Write via a temporary file and atomic rename; reject invalid/unknown schemas.
The unique installation key is `(canonical project path, machine id)`.
JSON preserves spaces and Unicode. Normalize paths through physical project
directory resolution; on Git Bash store POSIX paths. Initially reject newline
and control characters in paths explicitly rather than claiming support.

Implemented add/remove operations keep transaction metadata and rollback data.
Handled write errors roll back file changes; a hard kill may leave partial files,
a lock, and transaction data. Subsequent mutations stop for manual inspection;
automatic hard-kill recovery is not implemented.

Transactions describe intended changes and recovery data. A failed operation
must retain enough information for retry/recovery; it must not claim the new
version installed. Serialize all mutations, including cron and cleanup, with
a portable exclusive directory lock. Diagnose stale locks; do not blindly
delete another process's lock.

### File ownership and replacement

Install only regular files in validated machine-scoped `.double/` paths from
the selected published package. Reject absolute/traversing paths, links,
special files, and destinations escaping through project symlinks. Track the
exact inventory; archive listing is validated before extraction or writes.

An initial add detects existing unregistered .double/<category>/<machine>
directories and asks permission to adopt/update them. Decline, EOF, or
non-terminal input without --yes leaves those directories untouched. Acceptance
backs up whole directories, replaces only that machine and registers published
files. Repeated registered add repairs/attaches skills; use update for payload
upgrades. Cached packages are re-verified.
`remove` shows its scope and requires terminal confirmation or `--yes`; it removes
only inventoried files, including local edits, and unregisters the machine.
`status` displays downloaded machine archives in a readable table (machine, version, channel and local path), followed by a list of projects with nested machine/version/channel entries. Detailed persisted installation records are available only through status --json. Archive inventory is local and does not reverify checksums.

Implemented update behavior: Updates back up complete machine directories,
including local edits and untracked nested files, before replacing managed files. A failed backup prevents
replacement. Remove obsolete files using the old inventory, not a broad delete
of `.double/`. Removal affects owned files and prunes only created empty
directories. Other machines, project `ideas/`, `goals/`, `knowledge/`, and
unrelated files remain unchanged. Manual adoption is the explicit exception:
after consent it replaces the selected machine directories, preserving their
complete previous contents in a backup. Foreign agent skills are still refused.

### Cron, cleanup, and bootstrap boundary

Cron creation is user requested, idempotent, and marked with installer ownership.
Use absolute Bash/script paths and an explicit environment. A missing crontab
command leaves interactive updating available; no Windows scheduler alternative
is required. Development tests use a fake crontab adapter, never live user cron.

Full uninstall removes owned scheduling first, then managed machine files in
all registered projects, downloads, backups, registry and recovery state.
On failure retain the remaining cleanup inventory and report incomplete cleanup.
Remove the shared root only when empty; preserve other Double components' data.
No downloaded machine archive is executed as code.

`cron-add --schedule '0 3 * * *'` creates one task per state root. Numeric
five-field expressions are accepted; crontab validates ranges. A state-root
hash marker identifies owned lines. The command includes absolute Bash/script
paths, explicit PATH/HOME/state environment, shell quoting and cron percent
escaping. Output appends to `installer/cron.log`. Intent metadata remains
available if crontab installation fails; read failures never overwrite existing
tasks. `cron-remove` preserves unrelated entries. If crontab is absent, creation
fails with guidance to use interactive updates; removal succeeds only when no
owned scheduling metadata needs verification.

`uninstall-all` shows scope and requires confirmation or `--yes`. It holds the
mutation lock, removes owned cron tasks first, then registered machines, then
the entire installer-owned state subtree, including backups and logs. Shared
root removal happens only when empty. Failure during project removal preserves
the registry and remaining state for retry; scheduling may already be removed.

[Double System Installer](../../goals/double-system-installer/double-system-installer.md#double-system-installer)
owns executable placement/bootstrap. Machine cleanup does not delete an
arbitrary script invocation path or third-party tools. Cleanup of an installed
entry point requires that component's explicit ownership interface.

### Validation still required

Hosted release discovery currently found only Machine of Ideas `rc` releases.
Stable and multi-machine scenarios need fixtures until packages are published.
Release, installation, update and backup checks are covered by isolated fixtures,
including handled write-failure rollback, lock contention and symlink refusal.
Hard-kill recovery, real scheduler execution, and actual Linux/Windows compatibility remain
unverified. Cron management and generated-command execution have been checked
using an isolated crontab adapter. Hard-kill recovery currently requires manual inspection. Run the fixture suite with
`bash tests/test-double-installer.sh` (requires Python 3 for test fixtures
and the fake HTTP client; Python is not an installer runtime dependency).

### S04 observed update semantics

Backups use `installer/backups/backup.<generated-id>/` with full directories
below old/, a roots inventory, previous installation metadata (or manual source
metadata), and a complete marker after successful copying. Machine roots are
.double/<category>/<machine>; agent roots are skills/<machine> relative to the
agent root. Hidden files and extra nested directories are included. Transaction
rollback snapshots use the same directory granularity; registry JSON is metadata.
An interrupted/incomplete backup does not permit replacement. Updating uses
validated packages, removes obsolete inventoried files, and commits the new
version after successful writes. Handled failures restore complete old directories; backups
remain available. No downgrade is allowed; promotion of the same numeric version
from dev to rc or rc to stable is allowed when that channel is explicitly selected.

`update-all` reports each installation independently and returns failure if any
fails. Each child operation holds the shared mutation lock. A terminal update
asks whether to delete its new backup; `--non-interactive` retains it.
`backups-clean` optionally filters by canonical project and machine, lists the
matching copies, and requires confirmation or `--yes`. It does not delete
release downloads or project files.

### Usage

Run from the Double repository. Install required tools using your platform's
package manager, then check availability with `doctor`. On macOS with Homebrew,
`brew install jq` supplies jq if missing. On Debian/Ubuntu,
`sudo apt-get install bash curl jq tar coreutils` supplies the main runtime
requirements; cron is optional. On Windows install Git for Windows, use Git Bash,
and place jq on its PATH. These are prerequisite instructions, not permission
for the installer to install tools automatically. The installer itself does not
require Python; the fixture suite requires Python 3.

Minimal user flow: `[doctor] -> releases -> add`; doctor is optional, and a
separate download/install command is not required. add refreshes release metadata,
checks dependencies, downloads a missing selected archive using the same verified
mechanism as download, and revalidates existing cached bytes before installation.
It reports whether it is downloading or using cache. releases is informational;
pass the chosen machine/channel/version to add explicitly as appropriate.

```bash
bash scripts/double-installer.sh doctor
bash scripts/double-installer.sh releases
bash scripts/double-installer.sh releases --channel rc
bash scripts/double-installer.sh add --project /path/to/project --machine machine-of-ideas --channel rc
bash scripts/double-installer.sh status
bash scripts/double-installer.sh update-all --non-interactive
bash scripts/double-installer.sh backups-clean --project /path/to/project
bash scripts/double-installer.sh cron-add --schedule '0 3 * * *'
bash scripts/double-installer.sh cron-remove
bash scripts/double-installer.sh remove --project /path/to/project --machine machine-of-ideas
bash scripts/double-installer.sh uninstall-all
```

Use Git Bash POSIX project paths on Windows, for example `/c/Users/name/project`.
A previously selected rc/dev policy is retained for updates unless explicitly
overridden; bulk `--channel stable` explicitly returns targeted installations to
stable policy. Keep the script at a stable absolute location while cron is enabled.

### Platform evidence and limits (2026-10-13)

| Check | Evidence |
| --- | --- |
| macOS, Bash 3.2.57 | Full isolated suite passed, including fake cron, rollback and full cleanup |
| Published package | Downloaded `machine-of-ideas-0.2.3-rc`, SHA-256 verified; cached real archive installed 38 files, listed, removed, fully cleaned in a disposable project |
| Linux | Docker stopped; approved Podman VM startup failed because `krunkit` is missing; no Linux execution evidence |
| Windows/Git Bash | No runtime available in this session; not validated |
| Actual scheduler | Generated command tested through `/bin/sh` with minimal environment and fake crontab; no host crontab edits |

The published-package lifecycle check used the real cached release archive and
stubbed metadata/cron, not an actual scheduled task. Stable/multi-machine update
scenarios use fixtures because matching hosted releases were absent from the
observed inventory. Hard-kill recovery requires manual inspection of lock and
transaction data. The observed macOS baseline is 26.6.2 / Bash 3.2.57 / jq 1.7.1-apple /
bsdtar 3.5.3 / curl 8.7.1. No validated minimum OS versions are claimed yet.
Native Windows jq CRLF output and MSYS argument conversion require explicit
Windows checks; portability is not inferred from macOS tests.

## Sources

- Prerequisites: [jq installation](https://jqlang.org/download/) and [Git for Windows](https://gitforwindows.org/).
- [Implementation](../../scripts/double-installer.sh) and [fixture checks](../../tests/test-double-installer.sh).
- [Current plan](../../goals/double-installer/plan.md#double-installer-plan) and
  [run evidence](../../goals/double-installer/run/interactive-rest--20261013T153107Z.md#double-installer-run-interactive-rest-20261013T153107Z).
- User accepted S01 through S05, and requested knowledge publication in this conversation.
- The user confirmed a validity period of two years on 2026-10-13.


## Additional Linux Validation — 2026-10-14

The full isolated fixture suite passed in double-applehv using actual Linux
7.2.5-200.fc44.aarch64 tools: Bash 5.3.9, Python 3.14.8 (test dependency only),
jq 1.8.1 and GNU tar 1.35. Current checkout scripts were copied to a guest
/tmp test directory. Syntax checks and all transport, registry/lifecycle,
update/backup/rollback, fake-cron and cleanup checks passed (exit 0).
[Exact invocation and results](../../goals/double-installer/run/interactive-rest--20261014T161825Z.md#double-installer-run-interactive-rest-20261014T161825Z).
This supersedes the historical Linux-runtime-unavailable limitation above;
Windows/Git Bash, actual scheduling and live GitHub smoke on Linux remain
unverified. It does not extend the macOS-version-specific VM setup claim.

### Downloading the Installer Script

Installer releases use independent double-installer-<version> tags. Download
only double-installer.sh and SHA256SUMS.txt from the selected release. Stable
is the default; select rc/dev explicitly. Repository-wide releases/latest may
refer to a machine instead. Instructions remain in this project knowledge
artifact and are linked from release notes, not attached as INSTALL.md.

Requirements: Bash 3.2 or newer, curl, jq, tar and SHA-256 tooling. Windows
uses Git Bash from Git for Windows. In the download directory:

```bash
sha256sum -c SHA256SUMS.txt
# macOS alternative: shasum -a 256 -c SHA256SUMS.txt
bash double-installer.sh help
bash double-installer.sh doctor
```

Downloading the script does not install a permanent executable entry point
or create cron tasks. Follow the command contracts above before modifying
a project. Shared state is ~/.local/state/double.

### Approved CLI and Global Integration Extension

The current working source adds these commands (not present in 0.1.1-rc):

```bash
bash scripts/double-installer.sh install --machine machine-of-ideas
bash scripts/double-installer.sh download --all
bash scripts/double-installer.sh install --all
bash scripts/double-installer.sh add --global
bash scripts/double-installer.sh add --global --agent codex
bash scripts/double-installer.sh add --global --agent claude --machine machine-of-goals
bash scripts/double-installer.sh remove --global --agent codex --machine machine-of-goals --yes
```

install is an exact download alias: it populates verified cache, not a project
or agent configuration. --all chooses one package per machine: prefer stable,
then rc if no stable exists, then dev. Within that channel choose the highest
numeric version. Thus stable 1.0.0 wins over rc 2.0.0. Installer-script releases
and releases without machine archive/checksum assets are excluded. --all
cannot combine with --machine, --version or --channel; choose a single-machine
command for explicit channel/version. Repeated bulk downloads verify/reuse cache;
corrupt cached entries are reported, never silently replaced.

Global add lists detected agents and, with terminal input, asks whether to
integrate all. It always selects one shared skill; consent additionally selects
Claude's dedicated root if detected. No/empty/non-terminal input keeps shared-only.
Explicit --agent codex/claude requests that adapter without the list/question.
Shared-root support for Claude is not assumed.

Global machine payloads live at ~/.local/state/double/installer/global/.double
(or the overridden DOUBLE_STATE_DIR). Payload version is shared among connected
agents. --agent selects which skill entry points to connect/refresh, not an
independent per-agent payload version. Existing installations never downgrade
implicitly. update-all/cron also updates registered global payloads with channel
priority; it does not discover or add new agent connections.

Generated regular SKILL.md entry points are placed at:

- Codex: ~/.agents/skills/<machine>/SKILL.md.
- Claude Code: ${CLAUDE_CONFIG_DIR:-~/.claude}/skills/<machine>/SKILL.md.

The parent of a custom agent directory must already exist. The wrapper has
name/description metadata and points to the canonical published machine skill
or workflow in shared state, keeping operating references there and user
ideas/goals/knowledge in the active project. A package with neither entry point
cannot be integrated and reports an agent-specific failure. Payload installation
and agent registrations are independent; successful registrations are retained. These are skills, not newly spawned
agents, MCP services, plugins or daemons. Opening an agent's skills selector in
a fresh local session is still a required real integration check; fixture tests
prove files/ownership/lifecycle, not model behavior or an already-open session.

The registry retains schema_version 1 with optional scope: project/global and
integrations entries (agent, root, file, owned directories), preserving old
project rows. Only owned skills may be replaced; foreign skill directories and
symlink paths are refused. Registered wrapper edits are backed up before
replacement; write/delete failures roll back external files. Interactive payload
updates offer backup cleanup; unattended updates retain backups.
Removing one agent keeps the other connections and shared payload. Removing
all connections removes the payload; uninstall-all removes registered global
skills before cleaning owned state, preserving foreign settings/skills/files.

Official integration sources verified 2026-10-16:
[Codex skills](https://learn.chatgpt.com/docs/build-skills),
[Claude Code skills](https://code.claude.com/docs/en/skills), and
[Claude configuration directory](https://code.claude.com/docs/en/claude-directory).

## Unified Installer CI and Publication

The working-source workflow .github/workflows/double-installer.yml replaces the
two former installer workflows. PR/branch changes run validation only. Installer
tags or a manual tag run exact-commit six-platform checks, repository regressions
and Linux live/cron checks; every group must pass before script and checksum
publication. Publication is the final automated step; no post-publication
checks or manual existing-release recheck mode remain (user decision 2026-10-17).
release.yml independently validates
and publishes machine/Double Agent packages. This refactor has local evidence
only until a fresh hosted run; existing 0.1.1-rc results do not validate new source.

Status table headings and release channels use terminal colors (stable green,
rc yellow, dev magenta). Redirected output remains plain text. Set NO_COLOR to
disable styling; TERM=dumb also disables colors.

`status --json` emits one JSON object with `archives` and `installations` arrays.
Each archive record contains `machine`, `version`, `channel` and `archive` (local
absolute path). Installation records retain the registry schema. Empty collections
are `[]`; JSON output contains no headings, messages or ANSI colors, even in a
terminal. Plain `status` retains its human-readable presentation.

`download` and `install` without options are equivalent to `download --all`:
cache one release per available machine, preferring stable, then rc, then dev;
choose the latest numeric version within the preferred available channel.
Explicit machine/channel/version options retain their existing semantics.

## Built-In Command Explanations

`explain` prints an overview and detailed explanations of every command.
`COMMAND --help` and `COMMAND --explain` print only that command's explanation,
including usage, selection rules, effects and limitations. Both flags short-circuit
execution before dependency checks, network requests or state mutation, even
when other command arguments are present. `help` / `--help` retain the concise
overview and documentation link; top-level `--explain` aliases `explain`.

Explanations use cyan headings, green usage lines and yellow option names in
terminals. The same NO_COLOR, TERM=dumb and redirected-output rules as status
apply; formatting does not change the explanatory text.

## Project Agent Integration and Install/Update Separation

`add --project DIR --machine ID [--agent codex|claude]` installs the machine and
one shared skill at DIR/.agents/skills/<machine>/SKILL.md by default. Global add
uses ~/.agents/skills. Explicit --agent claude requests DIR/.claude/skills or
${CLAUDE_CONFIG_DIR:-~/.claude}/skills globally; explicit codex uses the standard
shared .agents root. No installed-agent prerequisite applies to the default.
An explicit --agent does not require an installed CLI. Payload packages must
provide a canonical skill/workflow whenever agent integration is requested.
Foreign skill directories and symlinks are refused. Every agent operation has
its own rollback. If one fails, retain the installed payload and successful
connections, continue remaining agents and return nonzero with per-agent results.
Repeat add to retry/repair skills without reinstalling or upgrading the payload.

`add --global [--agent codex|claude] [--machine ID] [--channel stable|rc|dev]`
installs globally into the shared skills root by default. Without --machine it selects all available machines; the
channel fallback is stable, then rc, then dev.
repeated global add may attach or repair selected skills but does not upgrade
an existing payload. Global exact --version selection is not supported.

`update --global` now updates registered global machines only; --agent filters
existing connections and does not discover new agents. No registration produces
an error directing users to add --global. Project update/update-all refresh
already registered project skill entry points and preserve their recorded scope.
Project remove removes all its registered agent skills along with the payload;
global --agent removal can detach one global connection. Full uninstall handles
both scopes and preserves foreign skills. Existing legacy project registrations
without integrations are not automatically connected by update-all.

Agent removal is independent too: successful detaches remain committed even if
another agent fails. Failed detaches remain registered for retry; keep the machine
payload until all its agent detaches succeed, then remove the payload. A failure
never restores another agent's successfully removed or installed skill.

## Shared Default and Pi Compatibility — Observed 2026-10-17

Default add writes one shared integration, recorded as agent: shared. It does not
claim every installed agent has loaded the skill. Agent-specific directories are
created only by explicit --agent or consent to integrate all detected agents. Existing shared/Codex records may reference the
same owned file; removal retains it until the last recorded reference is removed.
Existing explicit Claude records remain managed; changing defaults does not delete
them. Unknown foreign shared skills are still refused.

Pi implements Agent Skills and discovers .agents/skills in the project and
~/.agents/skills globally. The generated SKILL.md is compatible by documented
format and location; actual Pi discovery/model execution has not been tested.
Pi's own paths are .pi/skills and ~/.pi/agent/skills; PI_CODING_AGENT_DIR can
override its agent directory. Invoke /skill:<machine> and /reload in Pi.
Dedicated --agent pi is not implemented yet.

Sources checked 2026-10-17:
- https://github.com/earendil-works/pi/blob/main/packages/coding-agent/docs/skills.md
- https://github.com/earendil-works/pi/blob/main/packages/coding-agent/docs/configuration.md
- https://code.claude.com/docs/en/skills (documents .claude roots, not .agents).

## Doctor Agent Inventory — 2026-10-17

Doctor lists Codex, Claude Code, Cursor, GitHub Copilot, Gemini CLI, OpenCode,
Cascade/Windsurf/Devin and Pi with DETECTED/NOT FOUND and evidence. CLI probes:
codex; claude; cursor-agent/cursor; copilot; gemini; opencode; windsurf/devin; pi.
Only executable locations are checked; agent binaries are never launched.
Config probes include CODEX_HOME or ~/.codex; CLAUDE_CONFIG_DIR or ~/.claude;
~/.cursor; COPILOT_HOME or ~/.copilot; ~/.gemini;
${XDG_CONFIG_HOME:-~/.config}/opencode and /devin; ~/.codeium/windsurf;
PI_CODING_AGENT_DIR or ~/.pi/agent. Shared .agents folders do not prove a
specific agent is installed. Config contents/credentials are not read.

Known macOS app bundles and Windows per-user Cursor/Windsurf program paths
provide additional evidence. Native Windows drive-letter environment paths are
converted with Git Bash cygpath when available. Local VS Code/Insiders
GitHub Copilot extension directories also count as extension evidence.
This is heuristic discovery: config may be stale, installations outside known
locations may be missed, and no version/login/skill loading is verified. Missing
agents do not fail doctor; missing required tools retain the nonzero exit.
Detection is independent of shared add and existing --agent codex/claude adapters.

Primary references for directory/command conventions:
- https://docs.github.com/en/copilot/reference/copilot-cli-reference/cli-command-reference
- https://docs.cursor.com/en/cli/overview
- https://geminicli.com/docs/cli/using-agent-skills/
- https://opencode.ai/docs/skills/
- https://docs.devin.ai/desktop/cascade/skills
- https://github.com/earendil-works/pi/blob/main/packages/coding-agent/docs/configuration.md

Doctor uses cyan headings, green successful checks and detected statuses, yellow
NOT FOUND/optional-cron absence and red missing required dependencies. Colors
are terminal-only, with NO_COLOR and TERM=dumb support. Redirected output is
plain text; diagnostic stderr has its own terminal check. Exit codes and agent
detection semantics are unchanged.

## Add Agent Discovery and Consent — 2026-10-17

Without --agent, add now displays found agents using doctor evidence. In a
terminal it asks whether to integrate all of them, default No. Yes selects one
shared .agents/skills entry for compatible Codex/Cursor/Copilot/Gemini/OpenCode/
Cascade/Pi and an additional .claude/skills entry if Claude Code was detected.
Decline, empty answer or EOF selects only the common root. No detected agents
or non-terminal stdin also uses common-only without waiting for input. Explicit
--agent codex/claude skips the list/question and selects that adapter directly.

Selection happens once for project or global add, including a bulk global add.
Discovery is a heuristic; it does not prove login/version/actual skill loading.
Dedicated roots are created only after all-agent consent or an explicit adapter
request. Previously registered connections are preserved when the user declines;
shared-only is the scope of the current action, not an uninstall request.
Per-agent rollback remains independent and partial failures return nonzero.
A package/install error does not trigger new agent writes before payload setup.

Releases output uses a cyan header and channel colors (stable green, rc yellow,
dev magenta) in terminals. NO_COLOR, TERM=dumb or redirected output disables
styling; the plain TSV format and release selection are unchanged.

Add, update and update-all prefix messages with status labels: [INFO], [OK],
[WARN] and [ERROR]. Only the label is colored (cyan, green, yellow or red);
the message body uses the default terminal color. Labels remain in plain output.
NO_COLOR, TERM=dumb or stdout redirection disables ANSI styling; redirected
stderr receives no ANSI. Interaction and exit codes are unchanged. update-all
retains label colors in child update processes when attached to a terminal.

## Release Consent, Manual Adoption and Directory Recovery — 2026-10-19

Example: add --machine machine-of-goals --project /path/to/project searches
stable, then rc, then dev when --channel is omitted. A newer dev never outranks
an available rc or stable. Missing stable produces an explicit prerelease
installation question. Download/install only cache packages and do not require
installation consent. An existing unregistered machine produces a separate
question before adoption. add --yes acknowledges both questions for automation;
it does not answer the separate all-agent integration question.

Every payload/skill backup and rollback snapshot captures whole bounded
directories, not individual files. Snapshot copying must complete before project
replacement. Existing symlinks and special entries are refused rather than
traversed. Other machines are outside these snapshot/replacement scopes.
After successful interactive adoption, update or wrapper replacement, offer to
delete the corresponding backup; No/EOF retains it. backups-clean remains the
explicit later cleanup command. A failed agent operation restores only its own
skill directory; successful other agents and payload remain committed.

## Release Validation Portability Fixes — 2026-10-19

status --json supplies registry JSON to native Windows jq through Bash stdin,
avoiding --slurpfile filename handling for Unicode paths. The test harness's
restricted no-cron PATH includes gzip: GNU tar invokes gzip externally, whereas
macOS tar may handle compressed archives internally. Failed 0.1.2-rc hosted
checks prevented publication; these fixes require a new exact candidate/tag.

Windows ARM64 CI has a 60-minute bounded job budget: the hosted ARM64 runner
currently executes x64 Git Bash through emulation. The 20-minute budget stopped
0.1.3-rc after fixture 114/175 despite ongoing progress. Other installer rows
retain a 20-minute bound. All six rows remain mandatory for publication.

## Temporary Quick Release Validation — 2026-10-20

User explicitly authorizes temporarily excluding long tests and publishing the
installer with quick checks. Required: syntax and platform lifecycle smoke on
all six OS/architecture rows, fast repository regressions, live package and real
cron checks, then the strict gate and two-asset publication. CI invokes
run-installer-tests.sh --quick and bounds installer jobs at ten minutes.
The 175-case comprehensive fixture suite is preserved for explicit/manual runs;
it is not required for this temporary release policy. This reduced coverage must
not be reported as full regression coverage. User plans to refactor slow tests.
No branch duplicate, tag overwrite, manual gate bypass or post-publication tests.
Baseline 5 / realization 5 capture the changed acceptance contract before action.

## Published Quick-Validated Release — 2026-10-20

[Installer 0.1.5-rc](https://github.com/densclub-rs/double/releases/tag/double-installer-0.1.5-rc)
was published from 49fd814cf68b45eb115f4fd76d28bff9cd246b8f after the
six-platform quick matrix, repository checks, live package and real cron passed.
[Hosted evidence](https://github.com/densclub-rs/double/actions/runs/39410313514).
Windows ARM64 quick job took 3m1s. Comprehensive fixtures remain manual until
refactored; this release does not claim full regression coverage.


### RC 0.1.6 update-all output and release preparation

`update-all` groups registered installations by machine, then visits projects
in path order. Indented results retain independent failure handling and
interactive input. Machine headings use cyan; project headings use bold
blue-gray; result labels carry semantic colors. Redirected output and
`NO_COLOR` contain no ANSI styling. A final summary counts completed and
failed checks, including already-current installations among completed checks.

Installer CI tests and helpers reside under `tests/github-actions/`. The six
OS/architecture jobs retain the temporary quick-suite policy; comprehensive
fixtures and live/cron integration checks have separate entry points.
Installer release notes and the Telegram announcement are generated from the
English annotated installer tag. Telegram is attempted only after successful
publication of an eligible stable or RC release, using the configured release
notification destination. Delivery failure does not undo the GitHub release.
