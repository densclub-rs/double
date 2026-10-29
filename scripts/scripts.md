# Double maintenance scripts and utilities

Helpers, scripts and utilities to maintain Double project.

## Local machine development

Every installer command accepting `--machine` also accepts these aliases:
`mog` = `machine-of-goals`, `moi` = `machine-of-ideas`,
`mok` = `machine-of-knowledge`, and `da` = `double-agent`.
Aliases are case-insensitive and may contain hyphens: `MOG` and `M-O-G`
both select `machine-of-goals`. Registry records, package names and installation
directories always use the full identifier. The mappings appear in `help`,
`explain`, and the help for commands accepting `--machine`.

Use the installer directly from a Double working directory to test a machine
before publishing a release:

```sh
bash scripts/double-installer.sh dev \
  --source /path/to/double \
  --project /path/to/test-project \
  --machine machine-of-goals
```

Both directories must exist and must be separate, without nesting. The command
copies all regular files in `.double/<category>/<machine>/`, including skills
and their support files. It includes modified, untracked and ignored working
files regardless of document status. It excludes other machines and project
artifacts in `ideas/`, `goals/` and `knowledge/`. Links and special files are
refused. The source checkout and machine version knowledge stay unchanged.

The command works offline and creates a project skill in
`.agents/skills/<machine>/SKILL.md` by default. As with `add`, an interactive
agent-discovery question can additionally select dedicated agent directories.
Use `--agent codex` or `--agent claude` to select an adapter explicitly.
Existing foreign skill directories are preserved and reported as integration
failures; the payload and successful agent registrations remain installed.

The installer registry records `version: development`, `channel: dev`,
`tag: local-development` and `source: {type: development, path: ABSOLUTE_PATH}`.
`status` displays that source, and `status --json` returns the full record.
The installer ignores published GitHub `dev` packages. Release commands accept
only `stable` and `rc`; `dev` exclusively means a local development directory.
Legacy dev-release cache entries and registrations remain readable for cleanup
and migration to stable/RC; new installations never select those packages.

Repeat the same `dev` command after editing the machine to refresh the test
project. Obsolete managed files are removed, local extra files are preserved,
and previous machine directories are backed up. A write failure restores the
previous payload and registry. Adopting unregistered machine directories asks
for confirmation; `--yes` explicitly authorizes that adoption for automation.

To return to published packages, run:

```sh
bash scripts/double-installer.sh update \
  --project /path/to/test-project --machine machine-of-goals
# Or check every registered installation:
bash scripts/double-installer.sh update-all --non-interactive
```

For a local development installation, updates prefer the newest stable release,
then the newest RC if no stable exists, regardless of numeric version. An
already published stable may therefore replace the development copy immediately.
With no eligible release, the local copy and its source registration remain.
`--channel stable` or `--channel rc` explicitly selects a published channel.
Successful replacement removes the local source marker and resumes normal
release version comparisons. Updates never recopy the working source; use
`dev` for that. Normal `remove` removes the registered machine and its owned
agent skills.

## Release management

Support for:
* GitHub Actions

### `double-release/`

Tooling lives in `scripts/double-release/`; its pytest suite and dependencies
live in `tests/double-release/`.

#### List machines

List the machine identifiers discovered in the current workspace:

```sh
python3 scripts/double-release/double-release.py list-machines
```

The command reads directories matching `.double/<category>/<machine>` in the
current working directory and prints their names, sorted and deduplicated.
New machines appear automatically; no fixed list or Git repository is required.
An empty catalog produces no machine names; a missing `.double/` produces a warning.
Local packaging supports the three `machine-of-*` identifiers and `double-agent`.

#### Package the current workspace

Run the packager from the workspace containing `.double/` and `knowledge/`.
The script path may be absolute when packaging another workspace.

```sh
python3 scripts/double-release/double-release.py package --machine machine-of-ideas
python3 scripts/double-release/double-release.py package --machine machine-of-goals
python3 scripts/double-release/double-release.py package --machine machine-of-knowledge
```

Without a tag, the source is the current working directory, including modified
and untracked files; Git is not required. The archive includes Markdown files
under `.double/` whose path contains the selected machine directory, regardless
of status. Other machines and user artifacts are excluded. The version comes
from the project index `.double-rules/double-rules.md` when it identifies a
version artifact directly or through a link in a project's knowledge `Value`.
The artifact id is `<machine>-version`. Read `Common Rules`, `double-agent`
and the selected machine's section. If no source is established, use
`knowledge/<machine>-version/<machine>-version.md`. Broken or conflicting
project sources are errors rather than permission to fall back. The resolved
version is injected into distribution copies only. Tagged packaging resolves
both the index and source from the tagged tree, never the working checkout.
Index links may select a grouped layout such as
`.double-rules/<machine>/<machine>-version.md`; resolution uses the artifact id
and link rather than requiring a directory with the same name as the file.

Output is `dist/double-<machine>-<version>-local.tar.gz` and
`dist/SHA256SUMS.txt`. Repeating the command replaces the same archive;
the checksum file describes the latest package.

#### Package a Git tag and publish

Tagged packaging continues to read the tagged Git tree and filter by status:

```sh
python3 scripts/double-release/double-release.py package --tag machine-of-ideas-0.2.3-rc
```

Use either `--machine` or `--tag`. `publish` requires a tag and publishes only
inside GitHub Actions.

### Release changelog

The generator resolves `<machine>-changelog` through the project index using
the same source-selection rules as version knowledge. If no override exists,
it uses `knowledge/<machine>-changelog/<machine>-changelog.md`. Both the index
and source come from the exact tagged tree. Inside `Value`, select exactly
one nonempty `### X.Y.Z[-rc|-dev] — YYYY-MM-DD` entry matching the full release
version, including its channel suffix. Its complete text must match the
annotated tag message. Create annotated tags with `--cleanup=verbatim` so Git
preserves Markdown headings. Missing, duplicate, empty or mismatched entries stop
publication. GitHub release notes contain that full text. Telegram uses the
same text, truncates it as needed to fit, and links to the full release. RC and
stable tags select their respective entries in their tagged trees. The full
approved entry includes its version/date heading and change bullets.
Double Agent obtains explicit approval of each entry before creating its tag,
and separately obtains approval of the final publication and Telegram preview.

### Release tests

Python 3.11+, pytest and the explicit test-only dependencies are used locally
and in GitHub Actions. See [release test commands](../tests/double-release/README.md).
The retired machine Shell release entry points are removed. The workflow can
validate an existing tag with `validation_only=true`, retaining test/package
artifacts without publishing a release or sending a Telegram message.

## Git Helpers

### `git-double` (`git double`)

`scripts/git-double` is a Python 3.9+ Git extension with no third-party
dependencies. It never stages, unstages, removes, or commits documents and
installs no hooks. Already tracked files (including files staged with
`git add -f`) are exempt, regardless of their status.

#### Setup

Run it directly, or register the command in this repository:

```sh
git config --local alias.double '!python3 scripts/git-double'
git double check
git double sync
git double watch
```

Alternatively, put the executable `scripts/git-double` on your `PATH` to use
`git double` in other repositories. Each clone needs its own setup and sync.

#### Commands

- `check` is read-only. For untracked documents, `draft` should be ignored;
  `release-candidate` and `stable` should be visible. It reports actual Git
  ignoring, including rules outside the extension's control. `TRACKED (exempt)`
  is informational and never a mismatch. Unknown/missing statuses are shown as
  `UNMANAGED`, with no enforced expectation.
- `sync` adds literal paths for untracked drafts to a managed block in Git's
  local `info/exclude`. It removes its own rules when documents become eligible,
  tracked, lose their recognized status, or disappear. Other exclusion rules
  remain untouched. A ready document still ignored by another rule is reported
  as a mismatch; the extension does not override that rule.
- `watch` runs sync every two seconds, reporting changes until Ctrl-C. Set
  `--interval 1` to change the polling interval. There is a delay between saving
  and syncing; this is a convenience tool, not a commit gate.

#### Scope and path handling

Without paths, the scope is `.double/`, `ideas/`, `goals/`, and `knowledge/`
under the repository root. Supply paths to opt in only selected documents or
folders; rules managed outside that scope are preserved:

```sh
git double check ideas/styles/styles.md
git double sync ideas/styles
git double watch ideas knowledge --interval 1
```

Direct script invocations resolve paths relative to the current directory.
Git shell aliases run from the repository root, so paths with the alias above
are repository-relative.

#### Status parsing and limitations

The utility reads only a simple top-level `status:`
scalar in the document's opening YAML frontmatter, including quoted values
and inline comments. It does not interpret embedded examples, YAML aliases,
multiline status values, or inherited folder statuses. Symlink traversal is
not supported. Markdown filenames containing line breaks are rejected.

#### Exit codes and synchronization

Exit codes for `check` and `sync`: **0** = no status/ignoring mismatches,
**1** = mismatches, **2** = execution error. These codes do not block Git:
there is no hook, and explicitly adding a draft with `git add -f path.md`
remains permitted. Ignored documents stay local and are not backed up by Git.
Changing a status does not update exclusions until the next sync/watch pass.


### `test-git-double.py`

Run the isolated Git integration tests:

```sh
python3 scripts/test-git-double.py
```
