#!/usr/bin/env bash
# Bootstrap the released Double Installer. Requires Bash 3.2 or later.
set -eu

fail() { printf 'Error: %s\n' "$*" >&2; exit 1; }
usage() { printf '%s\n' 'Usage: bash install.sh [--system] [--install-dir DIR] [--accept-rc]' 'Installs double-installer; it does not run it.'; }
scope=user
install_dir=
accept_rc=no
while [ "$#" -gt 0 ]; do
  case $1 in
    --system) scope=system ;;
    --install-dir) [ "$#" -ge 2 ] || fail '--install-dir requires a directory'; install_dir=$2; shift ;;
    --accept-rc) accept_rc=yes ;;
    --help|-h) usage; exit 0 ;;
    *) fail "Unknown argument: $1" ;;
  esac
  shift
done
case $(uname -s) in Darwin|Linux|MINGW*|MSYS*|CYGWIN*) ;; *) fail 'Supported platforms: Linux, macOS and Windows with Git Bash.' ;; esac
# Native Windows jq needs binary output to avoid CRLF in paths and checksums.
case "${OSTYPE:-}" in
  msys*|cygwin*) jq() { command jq --binary "$@"; } ;;
esac
for tool in curl jq mktemp mkdir mv chmod awk sed tr dirname basename cp rm uname sort cut; do
  command -v "$tool" >/dev/null 2>&1 || fail "Missing $tool; install it and retry."
done
if command -v sha256sum >/dev/null 2>&1; then hash_tool=sha256sum
elif command -v shasum >/dev/null 2>&1; then hash_tool=shasum
else fail 'Missing SHA-256 utility; install sha256sum or shasum and retry.'; fi
[ -n "${HOME:-}" ] || fail 'HOME is not set.'
tmp=$(mktemp -d "${TMPDIR:-/tmp}/double-bootstrap.XXXXXXXX") || fail 'Cannot create temporary directory.'
trap 'rm -rf "$tmp"' EXIT
trap 'exit 1' HUP INT TERM
api='https://api.github.com/repos/densclub-rs/double/releases'
page=1
: > "$tmp/releases"
while :; do
  curl -fsSL -H 'Accept: application/vnd.github+json' "$api?per_page=100&page=$page" -o "$tmp/page" || fail 'Could not retrieve the release list.'
  jq -e 'type == "array"' "$tmp/page" >/dev/null || fail 'Invalid release response.'
  jq -r '.[] | select(.draft == false) | select(.tag_name | test("^double-installer-[0-9]+\\.[0-9]+\\.[0-9]+(-rc)?$")) | [.tag_name, ([.assets[] | select(.name == "double-installer.sh") | .browser_download_url][0] // ""), ([.assets[] | select(.name == "SHA256SUMS.txt") | .browser_download_url][0] // "")] | @tsv' "$tmp/page" >> "$tmp/releases" || fail 'Cannot parse release list.'
  count=$(jq 'length' "$tmp/page")
  [ "$count" -eq 100 ] || break
  page=$((page + 1)); [ "$page" -le 100 ] || fail 'Release list exceeds the supported page limit.'
done
# Sorting decimal version components numerically avoids lexicographic ordering.
awk -F '\t' '{ tag=$1; sub(/^double-installer-/, "", tag); rc=(tag ~ /-rc$/); sub(/-rc$/, "", tag); split(tag,v,"."); printf "%012d %012d %012d %d\t%s\n",v[1],v[2],v[3],rc,$0 }' "$tmp/releases" | LC_ALL=C sort -r > "$tmp/sorted"
stable=$(awk -F '\t' '$1 ~ / 0$/ {print; exit}' "$tmp/sorted")
rc=$(awk -F '\t' '$1 ~ / 1$/ {print; exit}' "$tmp/sorted")
prompt() {
  [ -r /dev/tty ] && [ -w /dev/tty ] || return 1
  printf '%s [y/N] ' "$1" > /dev/tty
  IFS= read -r reply < /dev/tty || return 1
  case $reply in y|Y|yes|YES) return 0 ;; *) return 1 ;; esac
}
explicit=yes
if [ -z "$install_dir" ]; then explicit=no; if [ "$scope" = system ]; then install_dir=/usr/local/bin; else install_dir=$HOME/.local/bin; fi; fi
in_path() { case ":${PATH:-}:" in *":$1:"*) return 0 ;; *) return 1 ;; esac; }
if [ "$explicit" = no ] && ! in_path "$install_dir"; then
  printf 'Default directory %s is not in PATH: %s\n' "$install_dir" "${PATH:-}" >&2
  [ -r /dev/tty ] && [ -w /dev/tty ] || fail 'Specify a directory with --install-dir; no terminal is available.'
  printf 'Installation directory: ' > /dev/tty
  IFS= read -r install_dir < /dev/tty || fail 'No directory selected.'
  [ -n "$install_dir" ] || fail 'No directory selected.'
fi
case $install_dir in /*) ;; *) fail 'Installation directory must be an absolute path.' ;; esac
case $install_dir in *$'\n'*|*$'\r'*) fail 'Installation directory contains a newline.' ;; esac
profile=
if ! in_path "$install_dir"; then
  prompt "Add $install_dir to PATH?" || fail 'PATH change was not confirmed; no installation performed.'
  case ${scope}:${SHELL:-} in
    user:*/bash)
      if [ -e "$HOME/.bash_profile" ]; then profile=$HOME/.bash_profile
      elif [ -e "$HOME/.bash_login" ]; then profile=$HOME/.bash_login
      elif [ -e "$HOME/.profile" ]; then profile=$HOME/.profile
      else profile=$HOME/.bash_profile; fi ;;
    user:*/zsh) profile=$HOME/.zprofile ;;
    *)
    printf 'Cannot identify the shell configuration. Enter its absolute path: ' > /dev/tty
    IFS= read -r profile < /dev/tty || fail 'No configuration file selected.' ;;
  esac
  case $profile in /*) ;; *) fail 'Configuration file path must be absolute.' ;; esac
  [ ! -L "$profile" ] && { [ ! -e "$profile" ] || [ -f "$profile" ]; } || fail 'Unsafe shell configuration file.'
  printf 'PATH configuration file: %s\n' "$profile" > /dev/tty
  prompt 'Update this file?' || fail 'PATH change was not confirmed; no installation performed.'
  [ -w "$(dirname "$profile")" ] || fail "Cannot write configuration directory: $(dirname "$profile")"
  [ ! -e "$profile" ] || [ -w "$profile" ] || fail "Cannot write configuration file: $profile"
fi
target=$install_dir/double-installer
current_version='not installed'
if [ -e "$target" ] || [ -L "$target" ]; then
  current_version='unknown'
  if [ -f "$target" ] && [ ! -L "$target" ]; then
    if [ "$hash_tool" = sha256sum ]; then installed_hash=$(sha256sum "$target" 2>/dev/null || true); else installed_hash=$(shasum -a 256 "$target" 2>/dev/null || true); fi
    installed_hash=${installed_hash%% *}
    matches=''
    index=0
    while IFS=$'\t' read -r release_tag release_script release_sums; do
      [ -n "$release_tag" ] && [ -n "$release_sums" ] || continue
      index=$((index + 1))
      if curl -fsSL --connect-timeout 5 --max-time 15 "$release_sums" -o "$tmp/installed-sums-$index" 2>/dev/null; then
        release_hash=$(awk '$2 == "double-installer.sh" || $2 == "*double-installer.sh" {print $1}' "$tmp/installed-sums-$index")
        if [ -n "$installed_hash" ] && [ "$(printf '%s' "$release_hash" | tr 'A-F' 'a-f')" = "$installed_hash" ]; then
          version=${release_tag#double-installer-}
          if [ -z "$matches" ]; then matches=$version; else matches="$matches, $version"; fi
        fi
      fi
    done < "$tmp/releases"
    [ -z "$matches" ] || current_version=$matches
  fi
fi
printf 'Current installer version: %s\n' "$current_version"
if [ -n "$stable" ]; then
  stable_tag=$(printf '%s\n' "$stable" | cut -f2)
  printf 'Latest stable version: %s\n' "${stable_tag#double-installer-}"
else
  printf 'Latest stable version: not available\n'
fi
selected=$stable
if [ -n "$rc" ]; then
  rckey=${rc%%$'\t'*}; stablekey=${stable%%$'\t'*}
  rcversion=${rckey% *}; stableversion=${stablekey% *}
  if [ -z "$stable" ] || [[ "$rcversion" > "$stableversion" ]]; then
    rc_tag=$(printf '%s\n' "$rc" | cut -f2)
    printf 'Available release candidate: %s\n' "${rc_tag#double-installer-}"
    if [ "$accept_rc" = yes ] || prompt "Release candidate ${rc_tag#double-installer-} is available. Install it?"; then selected=$rc; fi
  fi
fi
[ -n "$selected" ] || fail 'No stable release selected. An RC requires confirmation or --accept-rc.'
tag=$(printf '%s\n' "$selected" | cut -f2)
printf 'Selected installer version: %s\n' "${tag#double-installer-}"
script_url=$(printf '%s\n' "$selected" | cut -f3)
sums_url=$(printf '%s\n' "$selected" | cut -f4)
[ -n "$script_url" ] && [ -n "$sums_url" ] || fail "Release $tag is missing required assets."
curl -fsSL "$script_url" -o "$tmp/double-installer.sh" || fail 'Installer download failed.'
curl -fsSL "$sums_url" -o "$tmp/SHA256SUMS.txt" || fail 'Checksum download failed.'
expected=$(awk '$2 == "double-installer.sh" || $2 == "*double-installer.sh" {print $1}' "$tmp/SHA256SUMS.txt")
case $expected in ''|*[!0-9a-fA-F]* ) fail 'Missing or invalid installer checksum.' ;; esac
[ "${#expected}" -eq 64 ] || fail 'Invalid installer checksum length.'
if [ "$hash_tool" = sha256sum ]; then actual=$(sha256sum "$tmp/double-installer.sh"); else actual=$(shasum -a 256 "$tmp/double-installer.sh"); fi
actual=${actual%% *}
[ "$(printf '%s' "$expected" | tr 'A-F' 'a-f')" = "$actual" ] || fail 'Installer checksum mismatch.'
[ ! -L "$install_dir" ] || fail 'Installation directory must not be a symlink.'
[ -d "$install_dir" ] || { [ "$scope" = user ] && mkdir -p "$install_dir"; } || fail "Cannot create $install_dir; retry with appropriate permissions."
[ -w "$install_dir" ] || fail "Cannot write $install_dir; retry with appropriate permissions."
[ ! -L "$target" ] && { [ ! -e "$target" ] || [ -f "$target" ]; } || fail 'Unsafe existing target.'
staged=$(mktemp "$install_dir/.double-installer.XXXXXXXX") || fail 'Cannot stage installer in target directory.'
cp "$tmp/double-installer.sh" "$staged" && chmod 755 "$staged" || { rm -f "$staged"; fail 'Cannot stage installer.'; }
if [ -n "$profile" ]; then
  # Shell-escaped path avoids interpreting directory contents as shell code.
  escaped=$(printf '%q' "$install_dir")
  profile_existed=no
  if [ -e "$profile" ]; then profile_existed=yes; cp -p "$profile" "$tmp/profile-backup" || { rm -f "$staged"; fail 'Cannot back up PATH configuration.'; }; fi
  restore_profile() {
    if [ "$profile_existed" = yes ]; then cp -p "$tmp/profile-backup" "$profile"; else rm -f "$profile"; fi
  }
  if ! printf '\n# Double Installer\nexport PATH=%s:"$PATH"\n' "$escaped" >> "$profile"; then restore_profile || printf 'Error: failed to restore %s\n' "$profile" >&2; rm -f "$staged"; fail 'Cannot update PATH configuration.'; fi
fi
if ! mv -f "$staged" "$target"; then
  [ -z "$profile" ] || restore_profile || printf 'Error: failed to restore %s\n' "$profile" >&2
  rm -f "$staged"
  fail 'Cannot install the staged file.'
fi
printf 'Installed %s from %s\nRun separately: %s help\n' "$target" "$tag" "$target"
[ -z "$profile" ] || printf 'Start a new shell to use the updated PATH.\n'
