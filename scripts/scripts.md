# Double maintenance scripts and utilities

Helpers, scripts and utilities to maintain Double project.

## Release management

Support for:
* GitHub Actions

### `double-release.sh`

#### List machines

List the machine identifiers discovered in the current workspace:

```sh
scripts/double-release.sh list-machines
```

The command reads directories matching `.double/<category>/<machine>` in the
current working directory and prints their names, sorted and deduplicated.
New machines appear automatically; no fixed list or Git repository is required.
An empty catalog produces no machine names; a missing `.double/` produces a warning.
Local packaging currently supports the three `machine-of-*` identifiers below.

#### Package the current workspace

Run the packager from the workspace containing `.double/` and `knowledge/`.
The script path may be absolute when packaging another workspace.

```sh
scripts/double-release.sh package --machine machine-of-ideas
scripts/double-release.sh package --machine machine-of-goals
scripts/double-release.sh package --machine machine-of-knowledge
```

Without a tag, the source is the current working directory, including modified
and untracked files; Git is not required. The archive includes Markdown files
under `.double/` whose path contains the selected machine directory, regardless
of status. Other machines and user artifacts are excluded. The version comes
from `knowledge/<machine>-version/<machine>-version.md` and is injected into
distribution copies only. Missing or invalid version knowledge is an error.

Output is `dist/double-<machine>-<version>-local.tar.gz` and
`dist/SHA256SUMS.txt`. Repeating the command replaces the same archive;
the checksum file describes the latest package.

#### Package a Git tag and publish

Tagged packaging continues to read the tagged Git tree and filter by status:

```sh
scripts/double-release.sh package --tag machine-of-ideas-0.2.3-rc
```

Use either `--machine` or `--tag`. `publish` requires a tag and publishes only
inside GitHub Actions.

### `test-double-release.sh`

Run the release script tests:

```sh
scripts/test-double-release.sh
```

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
