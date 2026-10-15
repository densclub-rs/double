#!/usr/bin/env bash
# Explicit rc smoke against real public release, in disposable project/state.
set -euo pipefail
repo="$(cd "$(dirname "$0")/.." && pwd -P)"
fixture="$(mktemp -d "${TMPDIR:-/tmp}/double-live.XXXXXX")"
fixture="$(cd "$fixture" && pwd -P)"
trap 'rm -rf "$fixture"' EXIT
export DOUBLE_STATE_DIR="$fixture/state"
mkdir "$fixture/project"
printf 'unowned\n' > "$fixture/project/keep"
installer="$repo/scripts/double-installer.sh"
bash "$installer" releases --machine machine-of-ideas --channel rc
bash "$installer" add --project "$fixture/project" --machine machine-of-ideas --version 0.2.3 --channel rc
archive="$DOUBLE_STATE_DIR/installer/releases/machine-of-ideas-0.2.3-rc/double-machine-of-ideas-0.2.3-rc.tar.gz"
# add verifies SHA256SUMS; independently record actual payload digest in evidence.
sha256sum "$archive"
jq -e '.installations | length == 1 and .[0].tag == "machine-of-ideas-0.2.3-rc"' "$DOUBLE_STATE_DIR/installer/registry.json" >/dev/null
bash "$installer" list
bash "$installer" remove --project "$fixture/project" --machine machine-of-ideas --yes
bash "$installer" uninstall-all --yes
test -f "$fixture/project/keep"
test ! -e "$DOUBLE_STATE_DIR/installer"
printf 'PASS: real machine-of-ideas-0.2.3-rc download, verified checksum, installation and cleanup\n'
