#!/usr/bin/env bash
# Isolated local checks for scripts/double-release.sh.
# Implementation of the github-actions-maintenance subplan.

set -eu

script_dir="$(cd "$(dirname "$0")" && pwd)"
release_script="$script_dir/double-release.sh"
original_dir="$(pwd)"
fixture_dir="$(mktemp -d "${TMPDIR:-/tmp}/double-release-test.XXXXXX")"
current_test='initialization'
test_count=0
release_tag=''

if [ -n "${FORCE_COLOR:-}" ] || { [ -t 1 ] && [ -z "${NO_COLOR:-}" ]; }; then
  color_blue="$(printf '\033[34m')"
  color_green="$(printf '\033[1;32m')"
  color_red="$(printf '\033[1;31m')"
  color_bold="$(printf '\033[1m')"
  color_reset="$(printf '\033[0m')"
else
  color_blue=''
  color_green=''
  color_red=''
  color_bold=''
  color_reset=''
fi

printf '%sImplementation of subplan:%s github-actions-maintenance\n\n' "$color_blue" "$color_reset"

cleanup() {
  exit_status="$?"
  trap - EXIT HUP INT TERM
  rm -rf "$fixture_dir"
  if [ "$exit_status" -eq 0 ]; then
    printf '%sexit status: %s%s\n' "$color_green" "$exit_status" "$color_reset"
  else
    printf '%sexit status: %s%s\n' "$color_red" "$exit_status" "$color_reset"
  fi
  exit "$exit_status"
}
trap cleanup EXIT HUP INT TERM

usage() {
  printf '%sUsage:%s\n' "$color_bold" "$color_reset"
  cat <<'EOF'
  scripts/test-double-release.sh [--tag <machine>-<major>.<minor>.<patch>[-dev|-rc]]
EOF
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --tag)
      if [ "$#" -lt 2 ]; then
        printf '%sFAIL:%s missing value for --tag\n' "$color_red" "$color_reset" >&2
        exit 2
      fi
      release_tag="$2"
      shift 2
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      printf '%sFAIL:%s unknown argument: %s\n' "$color_red" "$color_reset" "$1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

fail_current_test() {
  exit_status="$?"
  line_number="$1"
  printf '%sFAIL:%s %s (line %s, status %s)\n' "$color_red" "$color_reset" "$current_test" "$line_number" "$exit_status" >&2
  exit "$exit_status"
}
enable_failure_trap() {
  trap 'fail_current_test "$LINENO"' ERR
}
enable_failure_trap

begin_test() {
  current_test="$1"
  test_count=$((test_count + 1))
  if [ "$test_count" -gt 1 ]; then
    printf '\n'
  fi
  printf '%s==>%s %s%s%s\n' "$color_blue" "$color_reset" "$color_bold" "$current_test" "$color_reset"
}

pass_test() {
  printf '%sPASS:%s %s\n' "$color_green" "$color_reset" "$current_test"
}

capture_status() {
  trap - ERR
  set +e
  "$@"
  command_status="$?"
  set -e
  enable_failure_trap
}

run_release() {
  GITHUB_ACTIONS= bash "$release_script" "$@"
}

test_release_tag_package() {
  [ -n "$release_tag" ] || return 0

  begin_test "release tag can be packaged: $release_tag"
  if ! (
    cd "$original_dir"
    run_release package --tag "$release_tag" > "$fixture_dir/release-tag.out" 2> "$fixture_dir/release-tag.err" &&
    [ -f "dist/double-$release_tag.tar.gz" ] &&
    [ -f dist/SHA256SUMS.txt ] &&
    (cd dist && sha256sum -c SHA256SUMS.txt)
  ); then
    printf '%sFAIL:%s %s\n' "$color_red" "$color_reset" "$current_test" >&2
    if [ -s "$fixture_dir/release-tag.out" ]; then
      printf 'stdout:\n' >&2
      sed -n '1,120p' "$fixture_dir/release-tag.out" >&2
    fi
    if [ -s "$fixture_dir/release-tag.err" ]; then
      printf 'stderr:\n' >&2
      sed -n '1,120p' "$fixture_dir/release-tag.err" >&2
    fi
    exit 1
  fi
  pass_test
}

assert_contains() {
  archive="$1"
  expected_path="$2"
  tar -tzf "$archive" | grep -Fqx "$expected_path" || tar -tzf "$archive" | grep -Fqx "./$expected_path"
}

write_machine_file() {
  path="$1"
  status="$2"
  mkdir -p "$(dirname "$path")"
  cat > "$path" <<EOF
---
status: $status
---

# Fixture
EOF
}

write_machine_version_knowledge() {
  machine="$1"
  machine_version="$2"
  mkdir -p "knowledge/${machine}-version"
  cat > "knowledge/${machine}-version/${machine}-version.md" <<EOF
---
id: ${machine}-version
kind: knowledge-artifact
---

# ${machine} Version

## Value

\`${machine_version}\`
EOF
}

cd "$fixture_dir"
git init -q
git config user.email release-test@example.invalid
git config user.name release-test

write_machine_file .double/agents/machine-of-ideas/stable.md stable
write_machine_file .double/agents/machine-of-ideas/draft.md draft
write_machine_file .double/agents/machine-of-ideas/rc.md release-candidate
mkdir -p .double/agents/machine-of-ideas
cat > .double/agents/machine-of-ideas/missing-status.md <<'EOF'
---
---

# Fixture
EOF
write_machine_file .double/agents/machine-of-goals/draft.md draft
write_machine_version_knowledge machine-of-ideas 9.9.9
write_machine_version_knowledge machine-of-goals 1.2.3

git add .double knowledge
git commit -qm fixture
git tag machine-of-ideas-1.2.3
git tag machine-of-ideas-1.2.3-dev
git tag machine-of-ideas-1.2.3-rc
git tag machine-of-goals-1.2.3

begin_test 'stable package rejects a tag that differs from machine version knowledge'
capture_status run_release package --tag machine-of-ideas-1.2.3 > stable.out 2> stable.err
stable_status="$command_status"
[ "$stable_status" -eq 1 ]
grep -Fq 'Machine version mismatch' stable.err
[ ! -e dist/double-machine-of-ideas-1.2.3.tar.gz ]
pass_test

write_machine_version_knowledge machine-of-ideas 1.2.4
write_machine_version_knowledge machine-of-goals 1.2.4
git add -A
git commit -qm update-fixture
git tag machine-of-ideas-1.2.4
git tag machine-of-ideas-1.2.4-dev
git tag machine-of-ideas-1.2.4-rc
git tag machine-of-goals-1.2.4

begin_test 'stable package includes only stable files, generated versions, and checksums'
run_release package --tag machine-of-ideas-1.2.4 > stable.out 2> stable.err
assert_contains dist/double-machine-of-ideas-1.2.4.tar.gz .double/agents/machine-of-ideas/stable.md
! assert_contains dist/double-machine-of-ideas-1.2.4.tar.gz .double/agents/machine-of-ideas/draft.md
! assert_contains dist/double-machine-of-ideas-1.2.4.tar.gz .double/agents/machine-of-ideas/rc.md
grep -Fq 'missing-status.md' stable.err
[ "$(tar -xOf dist/double-machine-of-ideas-1.2.4.tar.gz .double/agents/machine-of-ideas/stable.md | awk '/^version:/{print $2}')" = '1.2.4' ]
! grep -q '^version:' .double/agents/machine-of-ideas/stable.md
[ -f dist/SHA256SUMS.txt ]
(cd dist && sha256sum -c SHA256SUMS.txt)
pass_test

begin_test 'dev package includes only draft files'
run_release package --tag machine-of-ideas-1.2.4-dev > dev.out 2> dev.err
assert_contains dist/double-machine-of-ideas-1.2.4-dev.tar.gz .double/agents/machine-of-ideas/draft.md
! assert_contains dist/double-machine-of-ideas-1.2.4-dev.tar.gz .double/agents/machine-of-ideas/stable.md
pass_test

begin_test 'rc package includes only release-candidate files'
run_release package --tag machine-of-ideas-1.2.4-rc > rc.out 2> rc.err
assert_contains dist/double-machine-of-ideas-1.2.4-rc.tar.gz .double/agents/machine-of-ideas/rc.md
! assert_contains dist/double-machine-of-ideas-1.2.4-rc.tar.gz .double/agents/machine-of-ideas/draft.md
pass_test

begin_test 'stable package reports when no files match the machine'
run_release package --tag machine-of-goals-1.2.4 > no-match.out 2> no-match.err
grep -Fq 'No stable files matched machine' no-match.err
[ ! -e dist/double-machine-of-goals-1.2.4.tar.gz ]
pass_test

begin_test 'publish is restricted outside GitHub Actions'
run_release publish --tag machine-of-ideas-1.2.4 > publish.out 2> publish.err
grep -Fq 'Publish is restricted to GitHub Actions' publish.err
pass_test

test_release_tag_package

printf '\n%sdouble release script tests passed%s\n' "$color_green" "$color_reset"
