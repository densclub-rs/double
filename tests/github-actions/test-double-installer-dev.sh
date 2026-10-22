#!/usr/bin/env bash
# Offline local development, recovery and transition-to-release regressions.
set -euo pipefail
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/../test-log.sh"
test_log 'START local development fixtures'
repo_dir="$(cd "$(dirname "$0")/../.." && pwd)"
installer="$repo_dir/scripts/double-installer.sh"
fixture=$(mktemp -d "${TMPDIR:-/tmp}/double-dev.XXXXXX")
fixture=$(cd "$fixture" && pwd -P)
trap 'rm -rf "$fixture"' EXIT
export DOUBLE_STATE_DIR="$fixture/state"
export DOUBLE_DEV_FIXTURE="$fixture"
mkdir -p "$fixture/bin" "$fixture/source тест ' %/.double/skills/machine-of-ideas/agents" "$fixture/project тест ' %"
source_dir="$fixture/source тест ' %"
project="$fixture/project тест ' %"
machine=machine-of-ideas
payload="$project/.double"
registry="$DOUBLE_STATE_DIR/installer/registry.json"
export DOUBLE_DEV_OFFLINE=1
cat > "$fixture/bin/curl" <<'SHIM'
#!/usr/bin/env bash
set -eu
printf 'request\n' >> "$DOUBLE_DEV_FIXTURE/requests"
[ "${DOUBLE_DEV_OFFLINE:-0}" != 1 ] || exit 22
while [ "$#" -gt 0 ];do
  case "$1" in --output) output="$2";shift 2 ;; *) url="$1";shift ;; esac
done
case "$url" in
  *api.github.com*) cp "$DOUBLE_DEV_FIXTURE/page.json" "$output" ;;
  *SHA256SUMS.txt) cp "$DOUBLE_DEV_FIXTURE/SHA256SUMS.txt" "$output" ;;
  *tar.gz) cp "$DOUBLE_DEV_FIXTURE/archive.tar.gz" "$output" ;;
  *) exit 22 ;;
esac
SHIM
chmod +x "$fixture/bin/curl"
export PATH="$fixture/bin:$PATH"
expect_failure() {
  if bash "$installer" "$@" > "$fixture/failure.log" 2>&1;then
    printf 'Unexpected success: %s\n' "$*" >&2;exit 1
  fi
}
dev() { bash "$installer" dev --source "$source_dir" --project "$project" --machine M-O-I "$@"; }
printf 'draft skill\n' > "$source_dir/.double/skills/$machine/SKILL.md"
printf 'name: support\n' > "$source_dir/.double/skills/$machine/agents/openai.yaml"
mkdir -p "$source_dir/.double/templates/$machine/nested" "$source_dir/.double/templates/machine-of-goals" "$source_dir/ideas"
printf 'working tree draft\n' > "$source_dir/.double/templates/$machine/nested/new file.md"
printf 'other machine\n' > "$source_dir/.double/templates/machine-of-goals/keep.md"
printf 'user artifact\n' > "$source_dir/ideas/keep.md"
printf 'user project sentinel\n' > "$project/keep.md"
mkdir -p "$payload/templates/machine-of-goals"
printf 'installed other machine\n' > "$payload/templates/machine-of-goals/keep.md"
dev
test ! -e "$fixture/requests"
test ! -e "$DOUBLE_STATE_DIR/installer/releases"
cmp "$source_dir/.double/skills/$machine/agents/openai.yaml" "$payload/skills/$machine/agents/openai.yaml"
cmp "$source_dir/.double/templates/$machine/nested/new file.md" "$payload/templates/$machine/nested/new file.md"
test ! -e "$project/ideas"
test -f "$project/.agents/skills/$machine/SKILL.md"
jq -e '.schema_version==1 and (.installations|length)==1 and
  (.installations[0] | .version=="development" and .tag=="local-development" and .channel=="dev" and
  .source.type=="development" and (.source.path|startswith("/")) and (.integrations|length)==1)' "$registry" >/dev/null
bash "$installer" status --json > "$fixture/status.json"
jq -e '.archives==[] and .installations[0].source.type=="development"' "$fixture/status.json" >/dev/null
bash "$installer" status > "$fixture/status.txt"
grep -F 'development  (dev)  source:' "$fixture/status.txt" >/dev/null
# A refresh removes obsolete managed files and preserves all bounded backups.
rm "$source_dir/.double/templates/$machine/nested/new file.md"
printf 'changed working tree\n' > "$source_dir/.double/skills/$machine/SKILL.md"
mkdir -p "$payload/templates/$machine/private"
printf 'local extra\n' > "$payload/templates/$machine/private/extra.md"
dev --agent claude
test ! -e "$payload/templates/$machine/nested/new file.md"
test -f "$payload/templates/$machine/private/extra.md"
test -f "$project/.claude/skills/$machine/SKILL.md"
jq -e '.installations[0].integrations|length==2' "$registry" >/dev/null
test -n "$(find "$DOUBLE_STATE_DIR/installer/backups" -name 'new file.md' -print)"
# Unsafe sources and overlapping directories fail before project replacement.
expect_failure dev --source "$source_dir" --project "$source_dir" --machine "$machine"
mkdir "$source_dir/nested project"
expect_failure dev --source "$source_dir" --project "$source_dir/nested project" --machine "$machine"
expect_failure dev --source "$project/subdirectory" --project "$project" --machine "$machine"
expect_failure dev --source "$source_dir" --project "$project" --machine absent
expect_failure dev --source "$source_dir" --project "$project" --machine '../escape'
expect_failure dev --source "$source_dir" --project "$project" --machine "$machine" --global
expect_failure dev --source "$source_dir" --project "$project" --machine "$machine" --version 1.0.0
mkdir "$fixture/link-target"
if ln -s "$fixture/link-target" "$source_dir/.double/skills/$machine/link" 2>/dev/null && [ -L "$source_dir/.double/skills/$machine/link" ];then
  expect_failure dev --source "$source_dir" --project "$project" --machine "$machine"
fi
rm -rf "$source_dir/.double/skills/$machine/link"
# New payload files cannot claim unregistered local files in an owned root.
printf 'foreign collision\n' > "$source_dir/.double/templates/$machine/private.md"
printf 'keep foreign\n' > "$payload/templates/$machine/private.md"
expect_failure dev --source "$source_dir" --project "$project" --machine "$machine"
grep -F 'keep foreign' "$payload/templates/$machine/private.md" >/dev/null
rm "$source_dir/.double/templates/$machine/private.md" "$payload/templates/$machine/private.md"
# A write failure after removals restores the entire old tree and registry.
cp "$registry" "$fixture/registry-before.json"
printf 'next draft\n' > "$source_dir/.double/skills/$machine/SKILL.md"
cat > "$fixture/bin/cp" <<'SHIM'
#!/usr/bin/env bash
case "${3:-}" in */unpacked/.double/*) exit 1 ;; esac
exec /bin/cp "$@"
SHIM
chmod +x "$fixture/bin/cp"
expect_failure dev --source "$source_dir" --project "$project" --machine "$machine"
rm "$fixture/bin/cp"
cmp "$registry" "$fixture/registry-before.json"
grep -F 'changed working tree' "$payload/skills/$machine/SKILL.md" >/dev/null
test -f "$payload/templates/$machine/private/extra.md"
test -f "$payload/templates/machine-of-goals/keep.md"
test -z "$(find "$DOUBLE_STATE_DIR/installer/transactions" -mindepth 1 -print)"
# A manual installation needs explicit adoption; a foreign agent skill survives.
manual="$fixture/manual";mkdir -p "$manual/.double/templates/$machine" "$manual/.agents/skills/$machine"
printf 'manual\n' > "$manual/.double/templates/$machine/manual.md"
printf 'foreign wrapper\n' > "$manual/.agents/skills/$machine/SKILL.md"
expect_failure dev --source "$source_dir" --project "$manual" --machine "$machine"
test -f "$manual/.double/templates/$machine/manual.md"
expect_failure dev --source "$source_dir" --project "$manual" --machine "$machine" --yes
test ! -e "$manual/.double/templates/$machine/manual.md"
test -f "$manual/.double/skills/$machine/SKILL.md"
grep -F 'foreign wrapper' "$manual/.agents/skills/$machine/SKILL.md" >/dev/null
bash "$installer" remove --project "$manual" --machine "$machine" --yes
test -f "$manual/.agents/skills/$machine/SKILL.md"
# Published development is distinct; default updates wait for stable or RC.
export DOUBLE_DEV_OFFLINE=0
catalog() {
  jq -n --arg tag "$machine-$1" --argjson pre "$2" '[{tag_name:$tag,draft:false,prerelease:$pre,
    assets:[{name:("double-"+$tag+".tar.gz"),browser_download_url:("https://github.com/densclub-rs/double/releases/download/"+$tag+"/double-"+$tag+".tar.gz")},
    {name:"SHA256SUMS.txt",browser_download_url:("https://github.com/densclub-rs/double/releases/download/"+$tag+"/SHA256SUMS.txt")}]}]' > "$fixture/page.json"
}
package() {
  mkdir -p "$fixture/released/.double/skills/$machine"
  printf 'published\n' > "$fixture/released/.double/skills/$machine/SKILL.md"
  tar -czf "$fixture/archive.tar.gz" -C "$fixture/released" .double
  local digest
  if command -v sha256sum >/dev/null;then digest=$(sha256sum "$fixture/archive.tar.gz" | awk '{print $1}')
  else digest=$(shasum -a 256 "$fixture/archive.tar.gz" | awk '{print $1}');fi
  printf '%s  double-%s-%s.tar.gz\n' "$digest" "$machine" "$1" > "$fixture/SHA256SUMS.txt"
}
catalog 99.0.0-dev true
expect_failure download --all
test ! -e "$DOUBLE_STATE_DIR/installer/releases/machine-of-ideas-99.0.0-dev"
bash "$installer" update --project "$project" --machine "$machine" --non-interactive
jq -e '.installations[0].source.type=="development"' "$registry" >/dev/null
grep -F 'changed working tree' "$payload/skills/$machine/SKILL.md" >/dev/null
catalog 1.0.0-rc true;package 1.0.0-rc
# A failed release replacement retains the development source and support files.
cp "$registry" "$fixture/registry-before.json"
cat > "$fixture/bin/cp" <<'SHIM'
#!/usr/bin/env bash
case "${3:-}" in */unpacked/.double/*) exit 1 ;; esac
exec /bin/cp "$@"
SHIM
chmod +x "$fixture/bin/cp"
expect_failure update --project "$project" --machine "$machine" --non-interactive
rm "$fixture/bin/cp"
cmp "$registry" "$fixture/registry-before.json"
test -f "$payload/skills/$machine/agents/openai.yaml"
bash "$installer" update-all --non-interactive
jq -e '.installations[0] | .version=="1.0.0" and .channel=="rc" and .source==null' "$registry" >/dev/null
test ! -e "$payload/skills/$machine/agents/openai.yaml"
test -f "$payload/templates/$machine/private/extra.md"
dev
# Prefer stable over a higher RC; allow a lower numeric version.
catalog 0.1.0 false;package 0.1.0
cp "$fixture/page.json" "$fixture/stable.json"
catalog 88.0.0-rc true
jq -s '.[0]+.[1]' "$fixture/stable.json" "$fixture/page.json" > "$fixture/combined.json"
mv "$fixture/combined.json" "$fixture/page.json"
bash "$installer" update --project "$project" --machine "$machine" --non-interactive
jq -e '.installations[0] | .version=="0.1.0" and .channel=="stable" and .source==null and (.integrations|length)==2' "$registry" >/dev/null
grep -F 'published' "$payload/skills/$machine/SKILL.md" >/dev/null
dev
# dev now means local directories exclusively, never a published channel.
expect_failure releases --channel dev
expect_failure download --machine "$machine" --channel dev
expect_failure add --project "$project" --machine "$machine" --channel dev
expect_failure add --global --machine "$machine" --channel dev
expect_failure update --project "$project" --machine "$machine" --channel dev
expect_failure update-all --channel dev
jq -e '.installations[0].source.type=="development"' "$registry" >/dev/null
bash "$installer" remove --project "$project" --machine "$machine" --yes
test ! -e "$project/.agents/skills/$machine"
test ! -e "$project/.claude/skills/$machine"
test -f "$project/keep.md"
test -f "$payload/templates/machine-of-goals/keep.md"
test -f "$payload/templates/$machine/private/extra.md"
test -f "$source_dir/.double/skills/$machine/agents/openai.yaml"
test_log 'PASS local development: offline copy, skills, refresh, backups, rollback, ownership, release replacement and removal'
