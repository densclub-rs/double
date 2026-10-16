#!/usr/bin/env bash
# Download and exercise the actual installer release, never the checkout copy.
set -euo pipefail
root=$(cd "$(dirname "$0")/.." && pwd -P)
source "$root/tests/test-log.sh"
test_log 'START published installer verification'
tag=${RELEASE_TAG:?RELEASE_TAG is required}
expected=${EXPECTED_COMMIT:?EXPECTED_COMMIT is required}
repo=${GITHUB_REPOSITORY:?GITHUB_REPOSITORY is required}
fixture=$(mktemp -d "${TMPDIR:-/tmp}/double-published.XXXXXX")
fixture=$(cd "$fixture" && pwd -P)
trap 'rm -rf "$fixture"' EXIT
# HTTPS public assets; validate an independent Git checkout identity as well.
[[ "$tag" =~ ^double-installer-[0-9]+\.[0-9]+\.[0-9]+(-(rc|dev))?$ ]]
test "$(git -C "$root" rev-parse --verify --end-of-options "refs/tags/${tag}^{commit}")" = "$expected"
base="https://github.com/$repo/releases/download/$tag"
for asset in double-installer.sh SHA256SUMS.txt; do
  curl --fail --location --retry 3 --proto '=https' --tlsv1.2 "$base/$asset" -o "$fixture/$asset"
done
# Require exactly the intended basename, not arbitrary checksum-file paths.
python3 - "$fixture/SHA256SUMS.txt" <<'PY'
import re,sys
from pathlib import Path
assert re.fullmatch(r'[0-9a-f]{64} [ *]double-installer\.sh\n?',Path(sys.argv[1]).read_text()), 'Invalid checksum manifest'
PY
(cd "$fixture"; if command -v sha256sum >/dev/null; then sha256sum -c SHA256SUMS.txt; else shasum -a 256 -c SHA256SUMS.txt; fi)
# Compare immutable blob bytes, not Windows checkout's CRLF conversion.
git -C "$root" show "$expected:scripts/double-installer.sh" > "$fixture/expected-source.sh"
cmp "$fixture/double-installer.sh" "$fixture/expected-source.sh"

export DOUBLE_TEST_INSTALLER="$fixture/double-installer.sh"
bash "$DOUBLE_TEST_INSTALLER" help
bash "$root/tests/test-double-installer-live.sh"
if [ "${DOUBLE_DISPOSABLE_CRON:-}" = 1 ]; then
  bash "$root/tests/test-double-installer-cron.sh"
fi
test_log "END published installer verification; PASS tag=$tag commit=$expected"
