#!/usr/bin/env bash
# Explicit rc smoke against real public release, in disposable project/state.
set -euo pipefail
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../test-log.sh"
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/github-api-auth.sh"
phase_started=$SECONDS
test_log "START live package smoke"
repo="$(cd "$(dirname "$0")/../.." && pwd -P)"
fixture="$(mktemp -d "${TMPDIR:-/tmp}/double-live.XXXXXX")"
fixture="$(cd "$fixture" && pwd -P)"
trap 'rm -rf "$fixture"' EXIT
export DOUBLE_STATE_DIR="$fixture/state"
mkdir "$fixture/project"
printf 'unowned\n' > "$fixture/project/keep"
installer="${DOUBLE_TEST_INSTALLER:-$repo/scripts/double-installer.sh}"
bash "$installer" releases --machine machine-of-ideas --channel rc
bash "$installer" add --project "$fixture/project" --machine machine-of-ideas --version 0.2.3 --channel rc --yes
archive="$DOUBLE_STATE_DIR/installer/releases/machine-of-ideas-0.2.3-rc/double-machine-of-ideas-0.2.3-rc.tar.gz"
# add verifies SHA256SUMS; independently record actual payload digest in evidence.
if command -v sha256sum >/dev/null; then sha256sum "$archive"; else shasum -a 256 "$archive"; fi
jq -e '.installations | length == 1 and .[0].tag == "machine-of-ideas-0.2.3-rc"' "$DOUBLE_STATE_DIR/installer/registry.json" >/dev/null
# Historical published versions expose list; current source exposes status.
help_output=$(bash "$installer" help)
case "$help_output" in
  *'double-installer.sh status'*) bash "$installer" status ;;
  *) bash "$installer" list ;;
esac
bash "$installer" remove --project "$fixture/project" --machine machine-of-ideas --yes
bash "$installer" uninstall-all --yes
test -f "$fixture/project/keep"
test ! -e "$DOUBLE_STATE_DIR/installer"
printf 'PASS: real machine-of-ideas-0.2.3-rc download, verified checksum, installation and cleanup\n'

test_log "END live package smoke; elapsed=$((SECONDS-phase_started))s"
