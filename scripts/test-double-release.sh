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
begin_test 'machine list follows the current catalog and deduplicates machine directories'
mkdir -p 'catalog workspace/.double/agents/custom-machine'
mkdir -p 'catalog workspace/.double/workflows/custom-machine'
mkdir -p 'catalog workspace/.double/skills/double-agent/nested-directory'
mkdir -p 'catalog workspace/.double/templates/machine-of-knowledge'
touch 'catalog workspace/.double/agents/not-a-machine.md'
(
  cd 'catalog workspace'
  run_release list-machines > list.out 2> list.err
  tail -n +2 list.out > names.out
  printf '%s\n' custom-machine double-agent machine-of-knowledge > expected.out
  diff -u expected.out names.out
  [ ! -s list.err ]
  mv .double/agents/custom-machine .double/agents/renamed-machine
  run_release list-machines > renamed.out
  grep -Fxq renamed-machine renamed.out
  mkdir -p empty/.double missing
  (cd empty && run_release list-machines) > empty.out 2> empty.err
  [ "$(wc -l < empty.out | tr -d ' ')" -eq 1 ]
  [ ! -s empty.err ]
  (cd missing && run_release list-machines) > missing.out 2> missing.err
  grep -Fq 'Working catalog .double was not found' missing.err
  [ ! -e dist ]
)
pass_test

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

begin_test 'local package includes working changes, untracked files, and all statuses'
write_machine_version_knowledge machine-of-ideas 2.0.0
printf '\nLocal edit\n' >> .double/agents/machine-of-ideas/stable.md
write_machine_file '.double/agents/machine-of-ideas/new file.md' draft
run_release package --machine machine-of-ideas > local.out 2> local.err
local_archive=dist/double-machine-of-ideas-2.0.0-local.tar.gz
for filename in stable.md draft.md rc.md missing-status.md 'new file.md'; do
  assert_contains "$local_archive" ".double/agents/machine-of-ideas/$filename"
done
! assert_contains "$local_archive" .double/agents/machine-of-goals/draft.md
tar -xOf "$local_archive" .double/agents/machine-of-ideas/stable.md > exported.md
grep -Fxq 'Local edit' exported.md
grep -Fxq 'version: 2.0.0' exported.md
! grep -q '^version:' .double/agents/machine-of-ideas/stable.md
(cd dist && sha256sum -c SHA256SUMS.txt)
run_release package --tag machine-of-ideas-1.2.4 > tagged.out 2> tagged.err
! tar -xOf dist/double-machine-of-ideas-1.2.4.tar.gz .double/agents/machine-of-ideas/stable.md | grep -Fxq 'Local edit'
! assert_contains dist/double-machine-of-ideas-1.2.4.tar.gz '.double/agents/machine-of-ideas/new file.md'
pass_test

begin_test 'all three machines can be packaged from a directory without Git'
mkdir 'plain workspace'
cd 'plain workspace'
for selected_machine in machine-of-ideas machine-of-goals machine-of-knowledge; do
  write_machine_file ".double/templates/$selected_machine/example.md" draft
  write_machine_version_knowledge "$selected_machine" 3.2.1
done
# Block Git explicitly: this directory happens to be inside the fixture repo.
mkdir bin
printf '#!/usr/bin/env bash\nexit 99\n' > bin/git
chmod +x bin/git
for selected_machine in machine-of-ideas machine-of-goals machine-of-knowledge; do
  PATH="$PWD/bin:$PATH" run_release package --machine "$selected_machine" > local.out 2> local.err
  assert_contains "dist/double-$selected_machine-3.2.1-local.tar.gz" ".double/templates/$selected_machine/example.md"
done
pass_test

begin_test 'local arguments, empty selection, and publish without a tag do not create packages'
mv dist saved-dist
run_release package > missing.out 2> missing.err
run_release package --machine ../invalid > invalid.out 2> invalid.err
run_release package --machine machine-of-ideas --tag machine-of-ideas-3.2.1 > conflict.out 2> conflict.err
run_release publish --machine machine-of-ideas > publish.out 2> publish.err
grep -Fq 'required for publish' publish.err
mv .double/templates/machine-of-ideas .double/templates/other
run_release package --machine machine-of-ideas > empty.out 2> empty.err
grep -Fq 'No local files matched' empty.err
[ ! -e dist ]
pass_test

begin_test 'local package rejects missing or invalid version knowledge'
capture_status run_release package --machine machine-of-goals > version.out 2> version.err
[ "$command_status" -eq 0 ]
mv knowledge/machine-of-goals-version knowledge/saved-version
capture_status run_release package --machine machine-of-goals > version.out 2> version.err
[ "$command_status" -eq 1 ]
grep -Fq 'Machine version knowledge is missing' version.err
write_machine_version_knowledge machine-of-goals invalid
capture_status run_release package --machine machine-of-goals > version.out 2> version.err
[ "$command_status" -eq 1 ]
grep -Fq 'Invalid local machine version' version.err
pass_test
cd "$fixture_dir"

test_release_tag_package

printf '\n%sdouble release script tests passed%s\n' "$color_green" "$color_reset"
