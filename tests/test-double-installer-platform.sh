#!/usr/bin/env bash
# Shared platform smoke: native tools, POSIX shell fixtures, no network/real cron.
set -euo pipefail
repo_dir="$(cd "$(dirname "$0")/.." && pwd)"
installer="$repo_dir/scripts/double-installer.sh"
fixture="$(mktemp -d "${TMPDIR:-/tmp}/double-platform.XXXXXX")"
fixture="$(cd "$fixture" && pwd -P)"
trap 'rm -rf "$fixture"' EXIT
export DOUBLE_STATE_DIR="$fixture/state with spaces"
export DOUBLE_PLATFORM_FIXTURE="$fixture"
mkdir -p "$fixture/bin" "$fixture/payload/.double/templates/machine-of-ideas"
printf 'platform fixture\n' > "$fixture/payload/.double/templates/machine-of-ideas/example.md"
archive='double-machine-of-ideas-1.0.0.tar.gz'
tar -czf "$fixture/$archive" -C "$fixture/payload" .double
if command -v sha256sum >/dev/null 2>&1; then
  (cd "$fixture" && sha256sum "$archive") > "$fixture/SHA256SUMS.txt"
else
  (cd "$fixture" && shasum -a 256 "$archive") > "$fixture/SHA256SUMS.txt"
fi
cat > "$fixture/page.json" <<'JSON'
[{"tag_name":"machine-of-ideas-1.0.0","draft":false,"prerelease":false,"assets":[{"name":"double-machine-of-ideas-1.0.0.tar.gz","browser_download_url":"https://github.com/densclub-rs/double/releases/download/machine-of-ideas-1.0.0/double-machine-of-ideas-1.0.0.tar.gz"},{"name":"SHA256SUMS.txt","browser_download_url":"https://github.com/densclub-rs/double/releases/download/machine-of-ideas-1.0.0/SHA256SUMS.txt"}]}]
JSON
cat > "$fixture/bin/curl" <<'SHIM'
#!/usr/bin/env bash
set -eu
output=''
while [ "$#" -gt 0 ]; do
  case "$1" in --output) output="$2"; shift 2;; *) url="$1"; shift;; esac
done
case "$url" in
  *api.github.com*) cp "$DOUBLE_PLATFORM_FIXTURE/page.json" "$output";;
  *SHA256SUMS.txt) cp "$DOUBLE_PLATFORM_FIXTURE/SHA256SUMS.txt" "$output";;
  *tar.gz) cp "$DOUBLE_PLATFORM_FIXTURE/double-machine-of-ideas-1.0.0.tar.gz" "$output";;
  *) exit 22;;
esac
SHIM
cat > "$fixture/bin/crontab" <<'SHIM'
#!/usr/bin/env bash
# Never reach host scheduler, including uninstall cleanup.
printf 'no crontab for fixture\n' >&2
exit 1
SHIM
chmod +x "$fixture/bin/curl" "$fixture/bin/crontab"
export PATH="$fixture/bin:$PATH"
case "$(uname -s)" in
  MINGW*|MSYS*)
    command -v cygpath >/dev/null
    printf 'Git Bash: %s\n' "$BASH_VERSION"
    # Keep real native jq behavior (including CRLF); do not normalize in fixtures.
    jq -nr '"native-jq-probe"' > "$fixture/jq-output"
    printf 'Native jq raw output bytes: '
    od -An -tx1 "$fixture/jq-output"
    ;;
  *) printf 'POSIX platform smoke: %s\n' "$(uname -srm)";;
esac
bash "$installer" doctor
project="$fixture/project space тест ' percent %"
mkdir "$project"
printf 'unowned sentinel\n' > "$project/keep.txt"
bash "$installer" add --project "$project" --machine machine-of-ideas
cmp "$fixture/payload/.double/templates/machine-of-ideas/example.md" "$project/.double/templates/machine-of-ideas/example.md"
bash "$installer" list > "$fixture/list.txt"
grep -F 'machine-of-ideas' "$fixture/list.txt" >/dev/null
# Compare against the shell's canonical path: checks native-jq/MSYS argument handling.
canonical="$(cd "$project" && pwd -P)"
MSYS2_ARG_CONV_EXCL="$canonical" jq -e --arg project "$canonical" '.installations | length == 1 and .[0].project == $project' "$DOUBLE_STATE_DIR/installer/registry.json" >/dev/null
bash "$installer" update --project "$project" --machine machine-of-ideas --non-interactive
bash "$installer" remove --project "$project" --machine machine-of-ideas --yes
test ! -e "$project/.double/templates/machine-of-ideas/example.md"
bash "$installer" uninstall-all --yes
test -f "$project/keep.txt"
test ! -e "$DOUBLE_STATE_DIR/installer"
printf 'PASS: real jq, canonical paths with spaces/Unicode/apostrophe/percent, registry persistence, no-op update, remove and isolated cleanup\n'
