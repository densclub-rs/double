# Installer and GitHub Actions tests

Run from the repository root using Bash. On Windows use Git Bash, not WSL.
The shared entry point pins its Bash executable for Python subprocesses and
normalizes jq output to LF. Python fixtures send input as LF bytes so native
Windows text streams cannot add carriage returns. POSIX terminal color tests use a PTY and are skipped
on Windows; ordering, failure isolation, input and plain-output checks still run.

```sh
# Default release CI: isolated lifecycle, local development and grouped-output checks.
bash tests/github-actions/run-installer-tests.sh --quick

# Comprehensive fixtures: explicit manual invocation while long tests are paused in CI.
bash tests/github-actions/run-installer-tests.sh

# Local development: offline copy, recovery and published-release replacement.
bash tests/github-actions/test-double-installer-dev.sh

# Offline packaging, exact-tag source, publication guards and announcement checks.
bash tests/github-actions/test-double-installer-release.sh
python3 tests/github-actions/test-installer-notes.py
```

Live checks are separate from the isolated suite:

```sh
# Downloads a published machine into disposable project/state directories.
bash tests/github-actions/test-double-installer-live.sh
```

`test-double-installer-cron.sh` is restricted to an explicitly designated,
disposable GitHub Linux runner (`DOUBLE_DISPOSABLE_CRON=1`). It exercises the
runner's real scheduler and restores its previous crontab. Do not invoke it on
a developer host.

`.github/workflows/double-installer.yml` runs the quick suite on five OS/architecture
combinations. Repository regressions and live/cron integration also gate tagged
publication. Branch pushes validate only. Eligible annotated installer tags can
publish `double-installer.sh` and `SHA256SUMS.txt`, followed by the approved
annotation-derived Telegram announcement. Failed validation blocks both actions.
