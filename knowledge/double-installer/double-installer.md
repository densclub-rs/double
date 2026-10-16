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
observed-at: 2026-10-13
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

S01 through S05 are accepted by the user. All listed commands have
implementations. S06 final validation is in progress; macOS fixture and published
package lifecycle checks pass. Linux and Windows/Git Bash validation remain
unconfirmed. This is an interim installer with explicit validation limits.

Release commands use the REST API of `densclub-rs/double`, enumerate all pages,
and filter by machine and channel. Download verifies SHA-256 and tar member
paths/types before caching; it never extracts into a project. An existing
release cache entry is preserved and reported as an error rather than overwritten.
Temporary downloads are discarded on handled errors/signals. API requests use
unauthenticated access and report HTTP/rate-limit errors; token support is not
implemented. SHA-256 checks detect corruption against the published checksum,
not an independent authenticity signature.

### Environment and dependencies

Use Bash on Linux/macOS and Git Bash from Git for Windows on Windows. Invoke
the script with Bash even if your interactive shell is Zsh. The implementation
targets Bash 3.2-compatible syntax; tested minimum OS/tool versions remain to
be established in the platform validation stage.

Required tools: curl, jq, tar, awk, find, sort, uniq, wc, cp, mv, mkdir, rm, mktemp,
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
| `releases` | List published release packages; stable channel by default |
| `download` | Cache a selected machine release and verify its checksum |
| `add` | Install machine files in a project and register the version |
| `remove` | Remove owned machine files and its registry entry |
| `list` | Show registered project-machine installations and versions |
| `update` | Update one installation, backing up previous contents first |
| `update-all` | Update registered installations and report per-installation results |
| `backups-clean` | Delete selected installer backups after explicit confirmation |
| `cron-add` | Create one marked update task with the specified schedule |
| `cron-remove` | Remove only this installer's marked tasks |
| `uninstall-all` | Remove all registered machines, cron tasks, and installer-owned state |

`--project` must identify an existing project directory. `--machine` selects
a published machine identifier; it is not a filesystem path. `--version`
selects an exact version; absence means highest applicable numeric version.
`--channel` is `stable`, `rc`, or `dev`; stable is the default. No implicit
prerelease fallback or downgrade. Persist an explicitly selected channel per
installation; a bulk override applies explicitly to targeted installations.
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

An initial add refuses unowned path collisions and re-verifies cached packages.
Repeated addition of a registered machine fails with a suggestion to use update.
`remove` shows its scope and requires terminal confirmation or `--yes`; it removes
only inventoried files, including local edits, and unregisters the machine.
`list` displays persisted installation records as JSON.

Implemented update behavior: Updates back up all old managed
files, including local edits, before replacing them. A failed backup prevents
replacement. Remove obsolete files using the old inventory, not a broad delete
of `.double/`. Removal affects owned files and prunes only created empty
directories. Other machines, project `ideas/`, `goals/`, `knowledge/`, and
unrelated files remain unchanged. Untracked manual machine installations
require a future explicit adoption policy and are not silently claimed.

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

Backups use `installer/backups/backup.<generated-id>/` with old files, the
previous installation record, and a `complete` marker after successful copying.
An interrupted/incomplete backup does not permit replacement. Updating uses
validated packages, removes obsolete inventoried files, and commits the new
version after successful writes. Handled failures restore old files; backups
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

```bash
bash scripts/double-installer.sh doctor
bash scripts/double-installer.sh releases
bash scripts/double-installer.sh releases --channel rc
bash scripts/double-installer.sh add --project /path/to/project --machine machine-of-ideas --channel rc
bash scripts/double-installer.sh list
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
