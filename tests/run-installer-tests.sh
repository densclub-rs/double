#!/usr/bin/env bash
# Same installer validation entry point for local hosts and CI runners.
set -euo pipefail
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/test-log.sh"
phase_started=$SECONDS
test_log "START shared installer suite"
repo_dir="$(cd "$(dirname "$0")/.." && pwd)"
cd "$repo_dir"
printf 'Runtime: %s\nBash: %s\n' "$(uname -srm)" "$BASH_VERSION"
python3 --version
jq --version
test_log "START syntax checks"
bash -n scripts/double-installer.sh tests/test-double-installer.sh tests/test-double-installer-platform.sh
test_log "START platform checks"
bash tests/test-double-installer-platform.sh
test_log "START comprehensive fixtures"
bash tests/test-double-installer.sh

test_log "END shared installer suite; elapsed=$((SECONDS-phase_started))s"
