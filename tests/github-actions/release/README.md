# Machine release validation

Requires Python 3.11+ and Git. Install test-only dependencies and run from the
repository root:

```sh
python3 -m pip install -r tests/github-actions/release/requirements.txt
python3 -m pytest -c tests/github-actions/release/pytest.ini tests/github-actions/release
```

The default suite uses disposable repositories and fake GitHub responses. It
never publishes or sends Telegram messages. One candidate-only check is skipped
unless an existing tag is supplied:

```sh
python3 -m pytest -c tests/github-actions/release/pytest.ini tests/github-actions/release --release-tag <machine-tag>
```

That check writes the selected tag's archive and `SHA256SUMS.txt` to `dist/` in
the caller checkout. Tooling may reside in a separate checkout, as in Actions.

For a hosted check, dispatch `.github/workflows/release.yml` on the tooling
branch with `tag=<existing-machine-tag>` and `validation_only=true`. pytest and
exact-tag packaging run before any publication step. The validation-only mode
skips release notes/publication; Telegram cannot run without a verified publish
output. JUnit XML, archive and checksum evidence are retained for 14 days.

Machine release tooling is `python3 scripts/double-release.py`; the old
`scripts/double-release.sh`, `scripts/test-double-release.sh`,
`tests/test-double-release.sh` and `tests/test-double-release-notes.py` entry
points are retired. Installer tooling is an independent subsystem.
