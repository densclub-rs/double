# Double release scripts

List the machine identifiers discovered in the current workspace:

```sh
scripts/double-release.sh list-machines
```

The command reads directories matching `.double/<category>/<machine>` in the
current working directory and prints their names, sorted and deduplicated.
New machines appear automatically; no fixed list or Git repository is required.
An empty catalog produces no machine names; a missing `.double/` produces a warning.
Local packaging currently supports the three `machine-of-*` identifiers below.

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

Tagged packaging continues to read the tagged Git tree and filter by status:

```sh
scripts/double-release.sh package --tag machine-of-ideas-0.2.3-rc
scripts/test-double-release.sh
```

Use either `--machine` or `--tag`. `publish` requires a tag and publishes only
inside GitHub Actions.
