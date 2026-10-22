#!/usr/bin/env bash
# Same installer validation entry point for local hosts and CI runners.
set -euo pipefail
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../test-log.sh"
quick=false
case "${1:-}" in
  --quick) quick=true;shift ;;
  '') ;;
  *) printf 'Usage: run-installer-tests.sh [--quick]\n' >&2;exit 2 ;;
esac
[ "$#" -eq 0 ] || { printf 'Unexpected arguments\n' >&2;exit 2; }
phase_started=$SECONDS
test_log "START shared installer suite"
repo_dir="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$repo_dir"
printf 'Runtime: %s\nBash: %s\n' "$(uname -srm)" "$BASH_VERSION"
python3 --version
jq --version
test_log "START syntax checks"
bash -n scripts/double-installer.sh tests/github-actions/test-double-installer.sh tests/github-actions/test-double-installer-platform.sh
test_log "START grouped output checks"
test_bash="$BASH"
case "$(uname -s)" in
  MINGW*|MSYS*|CYGWIN*) test_bash=$(cygpath -m "$BASH") ;;
esac
DOUBLE_TEST_BASH="$test_bash" python3 tests/github-actions/test-update-all-output.py
test_log "START platform checks"
bash tests/github-actions/test-double-installer-platform.sh
if [ "$quick" = true ];then
  test_log "Comprehensive fixtures omitted by temporary release policy; run without --quick for full coverage"
else
  test_log "START comprehensive fixtures"
  bash tests/github-actions/test-double-installer.sh
fi

test_log "END shared installer suite; elapsed=$((SECONDS-phase_started))s"
