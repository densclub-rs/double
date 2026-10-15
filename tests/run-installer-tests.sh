#!/usr/bin/env bash
# Same installer validation entry point for local hosts and CI runners.
set -euo pipefail
repo_dir="$(cd "$(dirname "$0")/.." && pwd)"
cd "$repo_dir"
printf 'Runtime: %s\nBash: %s\n' "$(uname -srm)" "$BASH_VERSION"
python3 --version
jq --version
bash -n scripts/double-installer.sh tests/test-double-installer.sh tests/test-double-installer-platform.sh
bash tests/test-double-installer-platform.sh
bash tests/test-double-installer.sh
