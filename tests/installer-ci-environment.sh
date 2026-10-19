#!/usr/bin/env bash
set -euo pipefail
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/test-log.sh"
phase_started=$SECONDS
test_log "START environment report"
printf 'Commit: %s\nRunner OS: %s\nRunner architecture: %s\nExpected architecture: %s\n' "$(git rev-parse HEAD)" "${HOST_OS:-local}" "${HOST_ARCH:-unknown}" "${EXPECTED_ARCH:-unknown}"
printf 'Image: %s / %s\nKernel: %s\nBash: %s\n' "${ImageOS:-unknown}" "${ImageVersion:-unknown}" "$(uname -srm)" "$BASH_VERSION"
case "${EXPECTED_ARCH:-}" in
  x64) test "${HOST_ARCH:-}" = X64;;
  arm64) test "${HOST_ARCH:-}" = ARM64;;
  '') ;;
  *) exit 1;;
esac
case "${HOST_OS:-}" in
  Windows) case "$(uname -s)" in MINGW*|MSYS*) ;; *) echo 'Expected Git Bash, not WSL'; exit 1;; esac;;
esac
for tool in bash python3 curl jq tar awk find sort uniq wc cp mv mkdir rm rmdir mktemp dirname tr cmp basename; do
  command -v "$tool"
done
if ! command -v sha256sum; then command -v shasum; fi
python3 -c 'import platform,struct; print("Python:", platform.python_version(), platform.machine(), struct.calcsize("P")*8)'
jq --version
curl --version | head -n 1
tar --version | head -n 1
# Report actual binaries, so a runner label cannot be mistaken for native tools.
if command -v file >/dev/null 2>&1; then
  for tool in bash python3 jq; do file -L "$(command -v "$tool")"; done
fi

test_log "END environment report; elapsed=$((SECONDS-phase_started))s"
