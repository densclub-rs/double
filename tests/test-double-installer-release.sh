#!/usr/bin/env bash
# Disposable Git and fake-GitHub checks; never publishes a remote release.
set -euo pipefail
root=$(cd "$(dirname "$0")/.." && pwd)
source "$root/tests/test-log.sh"
test_log 'START installer release tests'
fixture=$(mktemp -d "${TMPDIR:-/tmp}/installer-release-test.XXXXXX")
trap 'rm -rf "$fixture"' EXIT
mkdir -p "$fixture/repo/scripts" "$fixture/bin"
cp "$root/scripts/double-release.sh" "$root/scripts/double-installer-release.sh" "$root/scripts/double-installer.sh" "$fixture/repo/scripts/"
cd "$fixture/repo"
git init -q
git config user.email fixture@example.invalid
git config user.name Fixture
git add scripts
git commit -qm fixture
commit=$(git rev-parse HEAD)
# Tags are created only inside this disposable local fixture repository.
for tag in double-installer-0.1.0 double-installer-0.1.0-rc double-installer-0.1.0-dev; do
  git tag "$tag"
  bash scripts/double-release.sh package --tag "$tag"
  cmp scripts/double-installer.sh "dist/$tag/double-installer.sh"
  test ! -e "dist/$tag/INSTALL.md"
  bash "dist/$tag/double-installer.sh" --help > "$fixture/help.txt"
  grep -F 'https://github.com/densclub-rs/double/blob/' "$fixture/help.txt" >/dev/null
  grep -F '/knowledge/double-installer/double-installer.md' "$fixture/help.txt" >/dev/null
  test "$(find "dist/$tag" -type f | wc -l | tr -d ' ')" = 2
  (cd "dist/$tag"; if command -v sha256sum >/dev/null; then sha256sum -c SHA256SUMS.txt; else shasum -a 256 -c SHA256SUMS.txt; fi)
done
# Uncommitted source cannot leak into an exact-tag package.
printf '\n# uncommitted change\n' >> scripts/double-installer.sh
bash scripts/double-release.sh package --tag double-installer-0.1.0-rc
git show "$commit:scripts/double-installer.sh" > expected.sh
cmp expected.sh dist/double-installer-0.1.0-rc/double-installer.sh
# Reproduce Windows checkout conversion while retaining exact published bytes.
git -c core.autocrlf=true checkout-index -f --prefix="$fixture/crlf/" -- scripts/double-installer.sh
if cmp -s "$fixture/crlf/scripts/double-installer.sh" expected.sh; then
  echo 'Expected CRLF checkout fixture' >&2; exit 1
fi
git show "$commit:scripts/double-installer.sh" > "$fixture/blob.sh"
cmp "$fixture/blob.sh" dist/double-installer-0.1.0-rc/double-installer.sh
reject() { if "$@" > "$fixture/rejected.log" 2>&1; then cat "$fixture/rejected.log"; echo 'Expected failure' >&2; exit 1; fi; }
# Resolver modes and guards are exercised offline against fixture tags.
resolve() {
  : > "$fixture/resolve.out"
  env INPUT_TAG= INPUT_REF= GITHUB_REF_TYPE=branch GITHUB_REF_NAME=main GITHUB_SHA="$commit" GITHUB_OUTPUT="$fixture/resolve.out" "$@" bash scripts/double-installer-release.sh resolve
}
resolve env GITHUB_EVENT_NAME=push
grep -Fx 'mode=test' "$fixture/resolve.out"
resolve env GITHUB_EVENT_NAME=push GITHUB_REF_TYPE=tag GITHUB_REF_NAME=double-installer-0.1.0-rc
grep -Fx 'mode=publish' "$fixture/resolve.out"
resolve env GITHUB_EVENT_NAME=workflow_dispatch INPUT_TAG=double-installer-0.1.0
grep -Fx 'mode=publish' "$fixture/resolve.out"
resolve env GITHUB_EVENT_NAME=push GITHUB_REF_TYPE=tag GITHUB_REF_NAME=double-installer-0.1.0 INPUT_REF="$commit"
grep -Fx 'mode=test' "$fixture/resolve.out"
reject resolve env GITHUB_EVENT_NAME=workflow_dispatch INPUT_REF="$commit" INPUT_TAG=double-installer-0.1.0
reject resolve env GITHUB_EVENT_NAME=workflow_dispatch INPUT_TAG=invalid
reject resolve env GITHUB_EVENT_NAME=workflow_dispatch INPUT_TAG=double-installer-9.9.9
reject bash scripts/double-release.sh package --tag double-installer-invalid
reject bash scripts/double-release.sh package --tag double-installer-9.9.9
reject env GITHUB_ACTIONS=false bash scripts/double-release.sh publish --tag double-installer-0.1.0-rc
cat > "$fixture/bin/gh" <<'GH'
#!/usr/bin/env bash
set -eu
if [ "$1" = api ]; then
  [ "${FAKE_API_FAIL:-0}" = 0 ] || exit 1
  printf '%s\n' "${FAKE_EXISTING:-}"
else
  printf '%s\n' "$@" > "$FAKE_GH_LOG"
  [ "${FAKE_CREATE_FAIL:-0}" = 0 ] || exit 1
fi
GH
chmod +x "$fixture/bin/gh"
export PATH="$fixture/bin:$PATH" GITHUB_ACTIONS=true GITHUB_REPOSITORY=fixture/repo VALIDATED_COMMIT="$commit" FAKE_GH_LOG="$fixture/gh.log"
reject env VALIDATED_COMMIT=wrong bash scripts/double-release.sh publish --tag double-installer-0.1.0-rc
reject env FAKE_EXISTING=double-installer-0.1.0-rc bash scripts/double-release.sh publish --tag double-installer-0.1.0-rc
reject env FAKE_API_FAIL=1 bash scripts/double-release.sh publish --tag double-installer-0.1.0-rc
reject env FAKE_CREATE_FAIL=1 bash scripts/double-release.sh publish --tag double-installer-0.1.0-rc
bash scripts/double-release.sh publish --tag double-installer-0.1.0-rc
grep -Fx -- --prerelease "$FAKE_GH_LOG"
grep -Fx -- --verify-tag "$FAKE_GH_LOG"
grep -Fx -- --latest=false "$FAKE_GH_LOG"
if grep -F 'INSTALL.md' "$FAKE_GH_LOG"; then exit 1; fi
grep -F "blob/$commit/knowledge/double-installer/double-installer.md" "$FAKE_GH_LOG"
bash scripts/double-release.sh publish --tag double-installer-0.1.0
if grep -Fx -- --prerelease "$FAKE_GH_LOG"; then exit 1; fi
# API-only auth adapter: fake token and fake curl, no external requests.
cat > "$fixture/bin/curl" <<'CURL'
#!/usr/bin/env bash
printf '%s\n' "$@" > "$FAKE_CURL_LOG"
CURL
chmod +x "$fixture/bin/curl"
export FAKE_CURL_LOG="$fixture/curl.log"
env GH_TOKEN=fixture-ci-token bash -c 'source "$1"; curl "$2"' -- "$root/tests/github-api-auth.sh" https://api.github.com/repos/fixture/repo/releases
grep -Fx 'Authorization: Bearer fixture-ci-token' "$FAKE_CURL_LOG" >/dev/null
env GH_TOKEN=fixture-ci-token bash -c 'source "$1"; curl "$2"' -- "$root/tests/github-api-auth.sh" https://github.com/fixture/repo/releases/download/tag/asset
if grep -F 'Authorization:' "$FAKE_CURL_LOG"; then exit 1; fi
env GH_TOKEN= bash -c 'source "$1"; curl "$2"' -- "$root/tests/github-api-auth.sh" https://api.github.com/repos/fixture/repo/releases
if grep -F 'Authorization:' "$FAKE_CURL_LOG"; then exit 1; fi
python3 "$root/tests/test-installer-release-workflow.py" "$root"
test_log 'END installer release tests; PASS'
