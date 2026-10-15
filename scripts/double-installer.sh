#!/usr/bin/env bash
# Double Installer: release discovery and verified downloads.
set -euo pipefail

usage() {
  cat <<'EOF'
Double Installer

  double-installer.sh help
  double-installer.sh doctor
  double-installer.sh releases [--machine ID] [--channel stable|rc|dev]
  double-installer.sh download --machine ID [--version VERSION] [--channel CHANNEL]
  double-installer.sh add --project DIR --machine ID [--version VERSION] [--channel CHANNEL]
  double-installer.sh remove --project DIR --machine ID [--yes]
  double-installer.sh list
  double-installer.sh update --project DIR --machine ID [--channel CHANNEL] [--non-interactive]
  double-installer.sh update-all [--channel CHANNEL] [--non-interactive]
  double-installer.sh backups-clean [--project DIR] [--machine ID] [--yes]
  double-installer.sh cron-add --schedule 'CRON EXPRESSION'
  double-installer.sh cron-remove
  double-installer.sh uninstall-all [--yes]

Default state root: ~/.local/state/double
DOUBLE_STATE_DIR overrides the state root for isolated tests.
Implemented: all listed commands. See the knowledge artifact for validation status.
EOF
}

doctor() {
  local tool missing=0
  printf 'Bash: %s\n' "$BASH_VERSION"
  printf 'State root: %s\n' "${DOUBLE_STATE_DIR:-$HOME/.local/state/double}"
  for tool in curl jq tar awk find sort uniq wc cp mv mkdir rm rmdir mktemp dirname tr cmp basename; do
    if command -v "$tool" >/dev/null 2>&1; then
      printf 'OK: %s\n' "$tool"
    else
      printf 'Missing required dependency: %s\n' "$tool" >&2
      missing=1
    fi
  done
  if command -v sha256sum >/dev/null 2>&1; then
    printf 'SHA-256: sha256sum\n'
  elif command -v shasum >/dev/null 2>&1; then
    printf 'SHA-256: shasum -a 256\n'
  else
    printf 'Missing SHA-256 tool: install sha256sum or shasum.\n' >&2
    missing=1
  fi
  if command -v crontab >/dev/null 2>&1; then
    printf 'Optional cron: available (not modified)\n'
  else
    printf 'Optional cron: unavailable; use interactive updates\n'
  fi
  return "$missing"
}


fail() { printf 'Error: %s\n' "$*" >&2; exit 1; }
usage_error() { printf 'Error: %s\n' "$*" >&2; exit 2; }
work_dir=''
cache_staging=''
cache_pending=''
mutation_lock=''
transaction=''
transaction_project=''
transaction_kind=''
cleanup() {
  local item rollback_failed=0
  if [ -n "$transaction" ]; then
    if [ "$transaction_kind" = add ]; then
      while IFS= read -r item; do
        rm -f -- "$transaction_project/$item" || rollback_failed=1
      done < "$transaction/written"
      LC_ALL=C sort -r "$transaction/directories" > "$transaction/prune"
      while IFS= read -r item; do
        [ -z "$item" ] || rmdir "$transaction_project/$item" 2>/dev/null || true
      done < "$transaction/prune"
    elif [ "$transaction_kind" = update ]; then
      while IFS= read -r item; do
        rm -f -- "$transaction_project/$item" || rollback_failed=1
      done < "$transaction/new-files"
      while IFS= read -r item; do
        if [ -f "$transaction/old/$item" ]; then
          cp -p -- "$transaction/old/$item" "$transaction_project/$item" || rollback_failed=1
        fi
      done < "$transaction/files"
      if [ -f "$transaction/directories" ]; then
        LC_ALL=C sort -r "$transaction/directories" > "$transaction/prune"
        while IFS= read -r item; do
          [ -z "$item" ] || rmdir "$transaction_project/$item" 2>/dev/null || true
        done < "$transaction/prune"
      fi
    elif [ "$transaction_kind" = remove ]; then
      while IFS= read -r item; do
        if [ -f "$transaction/old/$item" ]; then
          cp -p -- "$transaction/old/$item" "$transaction_project/$item" || rollback_failed=1
        fi
      done < "$transaction/files"
    fi
    if [ "$rollback_failed" -eq 0 ]; then
      rm -rf -- "$transaction"
    else
      printf 'Rollback incomplete; retained recovery data: %s\n' "$transaction" >&2
    fi
  fi
  [ -z "$mutation_lock" ] || rmdir "$mutation_lock" 2>/dev/null || true
  [ -z "$cache_staging" ] || rm -rf -- "$cache_staging"
  [ -z "$cache_pending" ] || rm -rf -- "$cache_pending"
  [ -z "$work_dir" ] || rm -rf -- "$work_dir"
}
trap cleanup EXIT
trap 'exit 130' INT
trap 'exit 143' TERM HUP

http_get() {
  # Curl errors include HTTP failures; response bodies never enter the cache.
  curl --fail --silent --show-error --location --proto '=https' \
    --proto-redir '=https' --connect-timeout 15 --max-time 120 \
    --retry 2 --output "$2" "$1" || fail 'GitHub request failed (network, HTTP error, or rate limit); retry later.'
}

release_catalog() {
  local page=1 count
  printf '[]\n' > "$work_dir/all.json"
  while :; do
    http_get "https://api.github.com/repos/densclub-rs/double/releases?per_page=100&page=$page" "$work_dir/page.json"
    jq -e 'type == "array" and all(.[]; (.tag_name|type)=="string" and (.assets|type)=="array")' \
      "$work_dir/page.json" >/dev/null || fail 'Invalid GitHub release response.'
    count=$(jq 'length' "$work_dir/page.json")
    jq -s '.[0] + .[1]' "$work_dir/all.json" "$work_dir/page.json" > "$work_dir/next.json"
    mv "$work_dir/next.json" "$work_dir/all.json"
    [ "$count" -eq 100 ] || break
    page=$((page + 1))
  done
  jq --arg machine "$machine" --arg channel "$channel" '
    [ .[] | select(.draft == false)
      | . as $release
      | try (.tag_name | capture("^(?<machine>[a-z0-9][a-z0-9-]*)-(?<version>[0-9]+\\.[0-9]+\\.[0-9]+)(?:-(?<channel>rc|dev))?$")) catch empty
      | .channel = (.channel // "stable")
      | select(.channel == $channel)
      | select($machine == "" or .machine == $machine)
      | select((.channel != "stable") or ($release.prerelease == false))
      | .tag = $release.tag_name | .assets = $release.assets
    ] | unique_by(.tag) | sort_by(.machine, (.version | split(".") | map(tonumber))) | reverse
  ' "$work_dir/all.json" > "$work_dir/catalog.json" || fail 'Cannot parse release catalog.'
}

validate_archive() {
  local archive="$1" member clean
  tar -tzf "$archive" > "$work_dir/members" || fail 'Invalid tar archive.'
  tar -tvzf "$archive" > "$work_dir/types" || fail 'Cannot inspect tar member types.'
  LC_ALL=C awk 'substr($0,1,1)!="-" && substr($0,1,1)!="d" {bad=1} END {exit bad}' \
    "$work_dir/types" || fail 'Archive contains links or special files.'
  [ -s "$work_dir/members" ] || fail 'Empty archive.'
  local files=0
  while IFS= read -r member; do
    clean="${member#./}"
    case "$clean" in
      /*|*\\*|../*|*/../*|*/..|*//*|./*|*/./*) fail 'Unsafe archive path.' ;;
    esac
    case "$clean" in .double|.double/|.double/*) ;; *) fail 'Archive path outside .double.' ;; esac
    case "$clean" in
      */) ;;
      *)
        # tar listings of directory names normally end in /; allow .double root.
        [ "$clean" != '.double' ] || continue
        case "$clean" in .double/*/"$machine"/*) ;; *) fail 'File outside selected machine scope.' ;; esac
        files=$((files + 1))
        ;;
    esac
  done < "$work_dir/members"
  [ "$files" -gt 0 ] || fail 'Archive has no machine files.'
}

download_release() {
  local selected tag archive url sum_url expected actual destination state_root
  selected=$(jq --arg version "$version" '[.[] | select($version=="" or .version==$version)][0] // empty' "$work_dir/catalog.json")
  [ -n "$selected" ] || fail "No published $channel release found for $machine${version:+ version $version}."
  tag=$(printf '%s' "$selected" | jq -r '.tag')
  archive="double-$tag.tar.gz"
  url=$(printf '%s' "$selected" | jq -r --arg name "$archive" '[.assets[] | select(.name==$name) | .browser_download_url] | if length==1 then .[0] else empty end')
  sum_url=$(printf '%s' "$selected" | jq -r '[.assets[] | select(.name=="SHA256SUMS.txt") | .browser_download_url] | if length==1 then .[0] else empty end')
  [ -n "$url" ] && [ -n "$sum_url" ] || fail 'Release lacks unique package/checksum assets.'
  case "$url" in "https://github.com/densclub-rs/double/releases/download/$tag/$archive") ;; *) fail 'Unexpected package URL.' ;; esac
  case "$sum_url" in "https://github.com/densclub-rs/double/releases/download/$tag/SHA256SUMS.txt") ;; *) fail 'Unexpected checksum URL.' ;; esac
  http_get "$url" "$work_dir/$archive"
  http_get "$sum_url" "$work_dir/SHA256SUMS.txt"
  expected=$(awk -v name="$archive" '$2==name || $2=="*"name {print $1}' "$work_dir/SHA256SUMS.txt")
  [[ "$expected" =~ ^[a-fA-F0-9]{64}$ ]] || fail 'Missing, duplicate, or invalid archive checksum.'
  if command -v sha256sum >/dev/null 2>&1; then
    actual=$(sha256sum "$work_dir/$archive" | awk '{print $1}')
  else
    actual=$(shasum -a 256 "$work_dir/$archive" | awk '{print $1}')
  fi
  [ "$(printf '%s' "$expected" | tr 'A-F' 'a-f')" = "$actual" ] || fail 'SHA-256 mismatch; package not cached.'
  validate_archive "$work_dir/$archive"
  state_root="${DOUBLE_STATE_DIR:-$HOME/.local/state/double}"
  destination="$state_root/installer/releases/$tag"
  # Immutable cache entries avoid races and preserve previously verified packages.
  [ ! -L "$state_root" ] && [ ! -L "$state_root/installer" ] && [ ! -L "$state_root/installer/releases" ] || fail 'State path is a symlink.'
  mkdir -p "$state_root/installer/releases"
  if [ -e "$destination" ] || [ -L "$destination" ]; then
    fail 'Release cache entry already exists; refusing to overwrite it.'
  fi
  local staged
  staged=$(mktemp -d "$state_root/installer/releases/.download.XXXXXX") || fail 'Cannot stage cache.'
  cache_staging="$staged"
  if ! cp "$work_dir/$archive" "$work_dir/SHA256SUMS.txt" "$staged/"; then
    rm -rf -- "$staged"; fail 'Cannot stage assets.'
  fi
  printf '%s\n' "$selected" > "$staged/release.json"
  # mkdir reservation prevents another downloader replacing the same entry.
  if ! mkdir "$destination"; then rm -rf -- "$staged"; fail 'Concurrent cache creation.'; fi
  cache_pending="$destination"
  if ! mv "$staged/"* "$destination/"; then
    rm -rf -- "$staged" "$destination"; fail 'Cache write failed.'
  fi
  rmdir "$staged"
  cache_staging=''
  cache_pending=''
  printf 'Verified download: %s\n' "$destination/$archive"
}


# Reject symlinks anywhere in an existing path, including ancestor components.
no_symlinks() {
  local path="$1"
  while [ "$path" != / ] && [ "$path" != . ]; do
    [ ! -L "$path" ] || fail "Symlink path refused: $path"
    path=$(dirname "$path")
  done
}

state_init() {
  state_root="${DOUBLE_STATE_DIR:-$HOME/.local/state/double}"
  case "$state_root" in /*) ;; *) usage_error 'State directory must be absolute.' ;; esac
  no_symlinks "$state_root/installer"
  state="$state_root/installer"
  registry="$state/registry.json"
}

registry_check() {
  [ -e "$registry" ] || return 0
  no_symlinks "$registry"
  jq -e '
    .schema_version == 1 and (.installations|type)=="array" and
    all(.installations[];
      (.project|type)=="string" and (.project|startswith("/")) and
      (.machine|type)=="string" and (.machine|test("^[a-z0-9][a-z0-9-]*$")) and
      (.files|type)=="array" and all(.files[]; type=="string" and (explode|all(. >= 32))) and
      (.directories|type)=="array" and all(.directories[]; type=="string") and
      (.version|type)=="string" and (.tag|type)=="string" and
      (.channel=="stable" or .channel=="rc" or .channel=="dev")) and
    ([.installations[]|[.project,.machine]]|length) ==
    ([.installations[]|[.project,.machine]]|unique|length)
  ' "$registry" >/dev/null || fail 'Invalid installation registry; no project changes made.'
}

mutation_begin() {
  if [ -n "$mutation_lock" ]; then registry_check; return 0; fi
  no_symlinks "$state/transactions"
  mkdir -p "$state/transactions"
  mkdir "$state/mutation.lock" 2>/dev/null || fail 'Another operation or stale lock exists; inspect before retrying.'
  mutation_lock="$state/mutation.lock"
  no_symlinks "$state/registry.new"
  [ -z "$(find "$state/transactions" -mindepth 1 -maxdepth 1 -print)" ] || fail 'Unfinished transaction exists; inspect recovery data before retrying.'
  registry_check
  if [ ! -e "$registry" ]; then
    printf '{"schema_version":1,"installations":[]}\n' > "$state/registry.new"
    mv "$state/registry.new" "$registry"
  fi
}

project_init() {
  [ -d "$project" ] || usage_error 'Project must be an existing directory.'
  project=$(cd "$project" && pwd -P)
  case "$project" in *$'\n'*|*$'\r'*|*$'\t'*) usage_error 'Control characters in project paths are unsupported.' ;; esac
  [ "$project" != / ] || usage_error 'Filesystem root cannot be a project.'
  no_symlinks "$project/.double"
}

inventory_check() {
  local file
  while IFS= read -r file; do
    case "$file" in .double/*/"$machine"/*) ;; *) fail 'Invalid managed inventory scope.' ;; esac
    case "$file" in /*|*\\*|*/../*|*/..|*/./*|*//*|*$'\t'*|*$'\r'*) fail 'Unsafe managed inventory path.' ;; esac
    no_symlinks "$project/$file"
  done < "$work_dir/files"
}

add_machine() {
  local cached tag archive row file dir created
  project_init
  state_init
  mutation_begin
  row=$(jq --arg p "$project" --arg m "$machine" '.installations[]|select(.project==$p and .machine==$m)' "$registry")
  [ -z "$row" ] || fail 'Machine already registered in this project; use update.'
  # Catalog remains authoritative for explicit channel/version selection.
  release_catalog
  row=$(jq --arg v "$version" '[.[]|select($v=="" or .version==$v)][0] // empty' "$work_dir/catalog.json")
  [ -n "$row" ] || fail 'No matching published machine release.'
  tag=$(printf '%s' "$row" | jq -r '.tag')
  cached="$state/releases/$tag";archive="$cached/double-$tag.tar.gz"
  if [ ! -d "$cached" ]; then download_release; fi
  no_symlinks "$archive"; no_symlinks "$cached/SHA256SUMS.txt"
  [ -f "$archive" ] && [ -f "$cached/SHA256SUMS.txt" ] || fail 'Incomplete cache entry.'
  local expected actual
  expected=$(awk -v name="double-$tag.tar.gz" '$2==name || $2=="*"name {print $1}' "$cached/SHA256SUMS.txt")
  [[ "$expected" =~ ^[a-fA-F0-9]{64}$ ]] || fail 'Invalid cached checksum.'
  if command -v sha256sum >/dev/null 2>&1; then actual=$(sha256sum "$archive" | awk '{print $1}'); else actual=$(shasum -a 256 "$archive" | awk '{print $1}'); fi
  [ "$(printf '%s' "$expected" | tr A-F a-f)" = "$actual" ] || fail 'Cached package checksum mismatch.'
  validate_archive "$archive"
  awk '!/\/$/ && $0!=".double" && $0!="./.double" {sub(/^\.\//, ""); print}' "$work_dir/members" > "$work_dir/files"
  [ "$(sort "$work_dir/files" | uniq -d | wc -l | tr -d ' ')" = 0 ] || fail 'Duplicate archive file paths.'
  inventory_check
  while IFS= read -r file; do
    [ ! -e "$project/$file" ] || fail "Unowned destination exists: $file"
  done < "$work_dir/files"
  mkdir "$work_dir/unpacked"
  tar -xzf "$archive" -C "$work_dir/unpacked" || fail 'Cannot extract validated package.'
  transaction=$(mktemp -d "$state/transactions/add.XXXXXX")
  transaction_kind=add; transaction_project="$project"
  : > "$transaction/written"; : > "$transaction/directories"
  cp "$work_dir/files" "$transaction/files"
  jq -n --arg p "$project" --arg m "$machine" '{operation:"add",project:$p,machine:$m}' > "$transaction/operation.json"
  while IFS= read -r file; do
    dir=$(dirname "$file"); created=''
    while [ "$dir" != . ] && [ ! -d "$project/$dir" ]; do
      created="$dir"$'\n'"$created";dir=$(dirname "$dir")
    done
    printf '%s' "$created" >> "$transaction/directories"
    mkdir -p "$project/$(dirname "$file")"
    printf '%s\n' "$file" >> "$transaction/written"
    cp -p -- "$work_dir/unpacked/$file" "$project/$file" || fail 'Installation write failed.'
  done < "$work_dir/files"
  jq -Rn '[inputs]' < "$work_dir/files" > "$work_dir/files.json"
  sort -u "$transaction/directories" | jq -Rn '[inputs|select(length>0)]' > "$work_dir/created.json"
  # Every installation remembers shared directories created by this installer,
  # so the final removal can prune them irrespective of machine removal order.
  jq --arg p "$project" --slurpfile d "$work_dir/created.json" \
    '([$d[0][]] + [.installations[]|select(.project==$p)|.directories[]])|unique' \
    "$registry" > "$work_dir/dirs.json"
  jq --arg p "$project" --arg m "$machine" --arg tag "$tag" --arg c "$channel" \
    --arg v "$(printf '%s' "$row"|jq -r .version)" --slurpfile f "$work_dir/files.json" --slurpfile d "$work_dir/dirs.json" \
    '.installations += [{project:$p,machine:$m,version:$v,tag:$tag,channel:$c,files:$f[0],directories:$d[0]}]' \
    "$registry" > "$state/registry.new"
  mv "$state/registry.new" "$registry"
  local done_transaction="$transaction";transaction=''
  rm -rf -- "$done_transaction"
  printf 'Installed %s in %s (%s)\n' "$machine" "$project" "$tag"
}

remove_machine() {
  local row file dir
  project_init;state_init;mutation_begin
  row=$(jq --arg p "$project" --arg m "$machine" '.installations[]|select(.project==$p and .machine==$m)' "$registry")
  [ -n "$row" ] || fail 'Machine is not registered in this project.'
  printf '%s' "$row" | jq -r '.files[]' > "$work_dir/files"
  inventory_check
  printf 'Remove %s from %s\n' "$machine" "$project"
  if [ "$yes" != true ]; then
    local answer
    [ -t 0 ] || fail 'Removal requires confirmation; use --yes.'
    printf 'Continue? [y/N] '; read -r answer
    case "$answer" in y|Y|yes) ;; *) fail 'Removal cancelled.' ;; esac
  fi
  # Prepare complete rollback copies before deleting anything.
  local backup
  backup=$(mktemp -d "$state/transactions/remove.XXXXXX")
  cp "$work_dir/files" "$backup/files"
  jq -n --arg p "$project" --arg m "$machine" '{operation:"remove",project:$p,machine:$m}' > "$backup/operation.json"
  while IFS= read -r file; do
    if [ -e "$project/$file" ]; then
      [ -f "$project/$file" ] || fail 'Managed path is no longer a regular file.'
      mkdir -p "$backup/old/$(dirname "$file")"
      cp -p -- "$project/$file" "$backup/old/$file" || fail 'Cannot preserve removal rollback copy.'
    fi
  done < "$work_dir/files"
  transaction="$backup";transaction_project="$project";transaction_kind=remove
  while IFS= read -r file; do rm -f -- "$project/$file" || fail 'Removal failed.'; done < "$work_dir/files"
  jq --arg p "$project" --arg m "$machine" '.installations |= map(select(.project!=$p or .machine!=$m))' "$registry" > "$state/registry.new"
  mv "$state/registry.new" "$registry"
  local done_transaction="$transaction";transaction=''
  rm -rf -- "$done_transaction"
  printf '%s' "$row" | jq -r '.directories[]' | LC_ALL=C sort -r > "$work_dir/dirs"
  while IFS= read -r dir; do
    case "$dir" in .double|.double/*) ;; *) continue ;; esac
    case "$dir" in *..*|*\\*) continue ;; esac
    no_symlinks "$project/$dir"
    rmdir "$project/$dir" 2>/dev/null || true
  done < "$work_dir/dirs"
  printf 'Removed %s from %s\n' "$machine" "$project"
}


confirm_action() {
  local answer
  [ "$yes" = true ] && return 0
  [ -t 0 ] || fail 'Confirmation required; use --yes.'
  printf 'Continue? [y/N] '; read -r answer
  case "$answer" in y|Y|yes) ;; *) fail 'Cancelled.' ;; esac
}

update_machine() {
  local installed row tag cached archive expected actual file dir backup transaction_done
  project_init;state_init;mutation_begin
  installed=$(jq --arg p "$project" --arg m "$machine" '.installations[]|select(.project==$p and .machine==$m)' "$registry")
  [ -n "$installed" ] || fail 'Machine is not registered in this project.'
  [ -n "$channel" ] || channel=$(printf '%s' "$installed" | jq -r .channel)
  release_catalog
  row=$(jq '.[0] // empty' "$work_dir/catalog.json")
  [ -n "$row" ] || { printf 'No applicable release: %s (%s) in %s\n' "$machine" "$channel" "$project"; return 0; }
  if ! jq -ne --arg a "$(printf '%s' "$row"|jq -r .version)" --arg b "$(printf '%s' "$installed"|jq -r .version)" \
    --arg old "$(printf '%s' "$installed"|jq -r '.tag|if endswith("-dev") then "dev" elif endswith("-rc") then "rc" else "stable" end')" --arg new "$channel" \
    '($a|split(".")|map(tonumber)) as $av | ($b|split(".")|map(tonumber)) as $bv |
      {dev:0,rc:1,stable:2} as $rank | ($av > $bv) or ($av == $bv and $rank[$new] > $rank[$old])' >/dev/null; then
    jq --arg p "$project" --arg m "$machine" --arg c "$channel" \
      '(.installations[]|select(.project==$p and .machine==$m)).channel=$c' "$registry" > "$state/registry.new"
    mv "$state/registry.new" "$registry"
    printf 'Already current: %s in %s\n' "$machine" "$project"; return 0
  fi
  version=$(printf '%s' "$row"|jq -r .version)
  tag=$(printf '%s' "$row" | jq -r '.tag')
  cached="$state/releases/$tag";archive="$cached/double-$tag.tar.gz"
  if [ ! -d "$cached" ]; then download_release; fi
  no_symlinks "$archive"; no_symlinks "$cached/SHA256SUMS.txt"
  [ -f "$archive" ] && [ -f "$cached/SHA256SUMS.txt" ] || fail 'Incomplete cache entry.'
  local expected actual
  expected=$(awk -v name="double-$tag.tar.gz" '$2==name || $2=="*"name {print $1}' "$cached/SHA256SUMS.txt")
  [[ "$expected" =~ ^[a-fA-F0-9]{64}$ ]] || fail 'Invalid cached checksum.'
  if command -v sha256sum >/dev/null 2>&1; then actual=$(sha256sum "$archive" | awk '{print $1}'); else actual=$(shasum -a 256 "$archive" | awk '{print $1}'); fi
  [ "$(printf '%s' "$expected" | tr A-F a-f)" = "$actual" ] || fail 'Cached package checksum mismatch.'
  validate_archive "$archive"
  awk '!/\/$/ && $0!=".double" && $0!="./.double" {sub(/^\.\//, ""); print}' "$work_dir/members" > "$work_dir/files"
  [ "$(sort "$work_dir/files" | uniq -d | wc -l | tr -d ' ')" = 0 ] || fail 'Duplicate archive file paths.'

  cp "$work_dir/files" "$work_dir/new-files"
  inventory_check
  printf '%s' "$installed" | jq -r '.files[]' > "$work_dir/files"
  inventory_check
  # A new release must not claim existing files outside the previous inventory.
  while IFS= read -r file; do
    if [ -e "$project/$file" ]; then
      jq -e --arg f "$file" '.files|index($f)!=null' <<< "$installed" >/dev/null || fail "Unowned destination exists: $file"
      [ -f "$project/$file" ] || fail 'Managed destination is not a regular file.'
    fi
  done < "$work_dir/new-files"
  no_symlinks "$state/backups"
  mkdir -p "$state/backups"
  backup=$(mktemp -d "$state/backups/backup.XXXXXX")
  printf '%s\n' "$installed" > "$backup/installation.json"
  mkdir "$backup/old"
  while IFS= read -r file; do
    if [ -e "$project/$file" ]; then
      [ -f "$project/$file" ] || fail 'Managed path is no longer a regular file.'
      mkdir -p "$backup/old/$(dirname "$file")"
      cp -p -- "$project/$file" "$backup/old/$file" || fail 'Backup failed; installation unchanged.'
    fi
  done < "$work_dir/files"
  printf 'complete\n' > "$backup/complete"
  mkdir "$work_dir/unpacked"
  tar -xzf "$archive" -C "$work_dir/unpacked" || fail 'Cannot extract validated package.'
  transaction=$(mktemp -d "$state/transactions/update.XXXXXX")
  cp "$work_dir/files" "$transaction/files"
  cp "$work_dir/new-files" "$transaction/new-files"
  cp -Rp "$backup/old" "$transaction/old"
  printf '%s\n' "$installed" > "$transaction/installation.json"
  transaction_kind=update;transaction_project="$project"
  while IFS= read -r file; do rm -f -- "$project/$file" || fail 'Cannot remove previous file.'; done < "$work_dir/files"
  : > "$transaction/directories"
  while IFS= read -r file; do
    dir=$(dirname "$file")
    while [ "$dir" != . ] && [ ! -d "$project/$dir" ]; do
      printf '%s\n' "$dir" >> "$transaction/directories"; dir=$(dirname "$dir")
    done
    mkdir -p "$project/$(dirname "$file")"
    cp -p -- "$work_dir/unpacked/$file" "$project/$file" || fail 'Update write failed; rolling back.'
  done < "$work_dir/new-files"
  jq -Rn '[inputs]' < "$work_dir/new-files" > "$work_dir/files.json"
  jq -Rn '[inputs]' < "$transaction/directories" > "$work_dir/dirs.json"
  jq --arg p "$project" --arg m "$machine" --arg t "$tag" --arg v "$version" --arg c "$channel" \
    --slurpfile f "$work_dir/files.json" --slurpfile d "$work_dir/dirs.json" \
    '(.installations[]|select(.project==$p and .machine==$m)) |= (.version=$v|.tag=$t|.channel=$c|.files=$f[0]|.directories=((.directories+$d[0])|unique))' \
    "$registry" > "$state/registry.new"
  mv "$state/registry.new" "$registry"
  transaction_done="$transaction";transaction='';rm -rf -- "$transaction_done"
  printf 'Updated %s in %s to %s; backup: %s\n' "$machine" "$project" "$version" "$backup"
  if [ "$non_interactive" = false ] && [ -t 0 ]; then
    local answer
    printf 'Delete this backup? [y/N] ';read -r answer
    case "$answer" in y|Y|yes) rm -rf -- "$backup" ;; esac
  fi
}

clean_backups() {
  local entry selected=0 p m
  state_init;mutation_begin
  no_symlinks "$state/backups"
  [ -d "$state/backups" ] || { printf 'No backups.\n';return 0; }
  : > "$work_dir/selected-backups"
  for entry in "$state"/backups/backup.*; do
    [ -e "$entry" ] || continue
    no_symlinks "$entry";no_symlinks "$entry/installation.json"
    p=$(jq -er '.project|select(type=="string")' "$entry/installation.json") || fail 'Invalid backup metadata.'
    m=$(jq -er '.machine|select(type=="string")' "$entry/installation.json") || fail 'Invalid backup metadata.'
    [ -z "$project" ] || [ "$p" = "$project" ] || continue
    [ -z "$machine" ] || [ "$m" = "$machine" ] || continue
    printf 'Delete backup: %s (%s / %s)\n' "$entry" "$p" "$m"
    printf '%s\n' "$entry" >> "$work_dir/selected-backups";selected=$((selected+1))
  done
  [ "$selected" -gt 0 ] || { printf 'No matching backups.\n';return 0; }
  confirm_action
  while IFS= read -r entry; do rm -rf -- "$entry" || fail 'Backup cleanup failed.';done < "$work_dir/selected-backups"
}


cron_marker() {
  local digest
  if command -v sha256sum >/dev/null 2>&1; then digest=$(printf '%s' "$state" | sha256sum); else digest=$(printf '%s' "$state" | shasum -a 256); fi
  marker="# double-installer:${digest%% *}"
}

cron_read() {
  # crontab uses exit 1 for an empty table, but also for operational errors.
  if LC_ALL=C crontab -l > "$work_dir/crontab.old" 2> "$work_dir/crontab.error"; then return 0; fi
  if LC_ALL=C awk 'tolower($0) ~ /no crontab for/ {found=1} END {exit !found}' "$work_dir/crontab.error"; then
    : > "$work_dir/crontab.old"
  else
    fail 'Cannot read crontab; existing entries were not changed.'
  fi
}

cron_without_owned() {
  awk -v marker="$marker" 'length($0)<length(marker) || substr($0,length($0)-length(marker)+1)!=marker' \
    "$work_dir/crontab.old" > "$work_dir/crontab.new"
}

shell_quote() {
  local value="$1" prefix
  printf "'"
  while [[ "$value" == *"'"* ]]; do
    prefix="${value%%\'*}"
    printf '%s' "$prefix" "'\"'\"'"
    value="${value#*\'}"
  done
  printf "%s'" "$value"
}

cron_remove_owned() {
  cron_marker
  if ! command -v crontab >/dev/null 2>&1; then
    [ ! -f "$state/scheduling.json" ] || fail 'Owned cron metadata exists, but crontab is unavailable; cannot confirm removal.'
    printf 'Cron unavailable; interactive updates remain available.\n';return 0
  fi
  cron_read;cron_without_owned
  if ! cmp -s "$work_dir/crontab.old" "$work_dir/crontab.new"; then
    crontab "$work_dir/crontab.new" || fail 'Cannot remove owned cron task.'
  fi
  rm -f -- "$state/scheduling.json"
  printf 'Owned cron tasks removed.\n'
}

cron_create() {
  local schedule="$1" bash_path script_path command_line field count=0 log_path
  command -v crontab >/dev/null 2>&1 || fail 'Cron unavailable; use interactive updates.'
  case "$schedule" in *$'\n'*|*$'\r'*|*%*) usage_error 'Invalid cron schedule.' ;; esac
  # Accept a portable numeric five-field schedule; crontab validates ranges.
  set -f
  for field in $schedule; do
    [[ "$field" =~ ^[0-9*/,-]+$ ]] || usage_error 'Use a numeric five-field cron schedule.'
    count=$((count+1))
  done
  set +f
  [ "$count" -eq 5 ] || usage_error 'Cron schedule requires five fields.'
  state_init;mutation_begin;cron_marker
  bash_path=$(command -v bash)
  script_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)/$(basename "${BASH_SOURCE[0]}")"
  for field in "$bash_path" "$script_path" "$PATH" "$HOME" "$state_root"; do
    case "$field" in *$'\n'*|*$'\r'*) fail 'Cron paths/environment must not contain newlines.' ;; esac
  done
  # Quote for cron's POSIX shell; percent has special meaning even in quotes.
  command_line="$(shell_quote "$bash_path") $(shell_quote "$script_path") update-all --non-interactive"
  command_line="PATH=$(shell_quote "$PATH") HOME=$(shell_quote "$HOME") DOUBLE_STATE_DIR=$(shell_quote "$state_root") $command_line"
  log_path="$state/cron.log"
  command_line="$command_line >> $(shell_quote "$log_path") 2>&1"
  command_line="${command_line//%/\\%}"
  cron_read;cron_without_owned
  printf '%s %s %s\n' "$schedule" "$command_line" "$marker" >> "$work_dir/crontab.new"
  no_symlinks "$state/scheduling.json";no_symlinks "$log_path"
  # Store intent first so a failed/interrupted cron write remains discoverable.
  jq -n --arg s "$schedule" --arg m "$marker" --arg script "$script_path" \
    '{schedule:$s,marker:$m,script:$script}' > "$state/scheduling.json"
  crontab "$work_dir/crontab.new" || fail 'Cron creation failed; retained scheduling metadata for cleanup.'
  printf 'Scheduled automatic updates: %s\n' "$schedule"
}

uninstall_everything() {
  local row
  state_init;registry_check
  printf 'Full uninstall: all registered machines and installer state in %s\n' "$state"
  if [ -f "$registry" ]; then jq -r '.installations[]|"  \(.project) / \(.machine)"' "$registry";fi
  confirm_action
  mutation_begin
  cron_remove_owned
  jq -c '.installations[]' "$registry" > "$work_dir/uninstall-installations"
  # Keep the shared lock through project removals and final state cleanup.
  yes=true
  while IFS= read -r row; do
    project=$(printf '%s' "$row" | jq -r .project)
    machine=$(printf '%s' "$row" | jq -r .machine)
    remove_machine
  done < "$work_dir/uninstall-installations"
  [ "$(jq '.installations|length' "$registry")" -eq 0 ] || fail 'Uninstall incomplete; registry retained.'
  # Delete installer-owned state only. Other components share the parent root.
  # Keep lock in place until files are gone, then remove owned directories.
  local entry
  for entry in "$state"/* "$state"/.[!.]* "$state"/..?*; do
    [ -e "$entry" ] || [ -L "$entry" ] || continue
    [ "$entry" != "$mutation_lock" ] || continue
    rm -rf -- "$entry" || fail 'State cleanup incomplete.'
  done
  rmdir "$mutation_lock";mutation_lock=''
  rmdir "$state" || fail 'Installer state directory is not empty.'
  rmdir "$state_root" 2>/dev/null || true
  printf 'Full uninstall complete.\n'
}

command_name="${1:-help}"
case "$command_name" in
  help|--help|-h) usage ;;
  doctor)
    [ "$#" -eq 1 ] || usage_error 'doctor accepts no arguments.'
    doctor
    ;;
  releases|download)
    shift
    machine='' channel='stable' version=''
    while [ "$#" -gt 0 ]; do
      [ "$#" -ge 2 ] || usage_error "Missing value for $1"
      case "$1" in
        --machine) machine="$2" ;;
        --channel) channel="$2" ;;
        --version) [ "$command_name" = download ] || usage_error '--version requires download'; version="$2" ;;
        *) usage_error "Unknown option: $1" ;;
      esac
      shift 2
    done
    case "$channel" in stable|rc|dev) ;; *) usage_error 'Channel must be stable, rc, or dev.' ;; esac
    [ -z "$machine" ] || [[ "$machine" =~ ^[a-z0-9][a-z0-9-]*$ ]] || usage_error 'Invalid machine identifier.'
    [ -z "$version" ] || [[ "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] || usage_error 'Invalid numeric version.'
    [ "$command_name" != download ] || [ -n "$machine" ] || usage_error 'download requires --machine.'
    doctor >/dev/null || fail 'Install missing dependencies before proceeding.'
    work_dir=$(mktemp -d "${TMPDIR:-/tmp}/double-installer.XXXXXX")
    release_catalog
    if [ "$command_name" = releases ]; then
      if [ "$(jq 'length' "$work_dir/catalog.json")" -eq 0 ]; then
        printf 'No published %s machine releases available.\n' "$channel"
      else
        printf 'MACHINE\tVERSION\tCHANNEL\tTAG\n'
        jq -r '.[] | [.machine,.version,.channel,.tag] | @tsv' "$work_dir/catalog.json"
      fi
    else
      download_release
    fi
    ;;
  add|remove)
    shift
    project='' machine='' version='' channel=stable yes=false
    while [ "$#" -gt 0 ]; do
      if [ "$1" = --yes ]; then
        [ "$command_name" = remove ] || usage_error '--yes is only for remove.'
        yes=true;shift;continue
      fi
      [ "$#" -ge 2 ] || usage_error "Missing value for $1"
      case "$1" in
        --project) project="$2" ;; --machine) machine="$2" ;;
        --version) [ "$command_name" = add ] || usage_error '--version is only for add';version="$2" ;;
        --channel) [ "$command_name" = add ] || usage_error '--channel is only for add';channel="$2" ;;
        *) usage_error "Unknown option: $1" ;;
      esac
      shift 2
    done
    [ -n "$project" ] && [[ "$machine" =~ ^[a-z0-9][a-z0-9-]*$ ]] || usage_error 'Provide --project and valid --machine.'
    case "$channel" in stable|rc|dev) ;; *) usage_error 'Invalid channel.' ;; esac
    [ -z "$version" ] || [[ "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] || usage_error 'Invalid version.'
    doctor >/dev/null || fail 'Missing dependencies.'
    work_dir=$(mktemp -d "${TMPDIR:-/tmp}/double-installer.XXXXXX")
    if [ "$command_name" = add ]; then add_machine; else remove_machine; fi
    ;;
  list)
    [ "$#" -eq 1 ] || usage_error 'list accepts no arguments.'
    command -v jq >/dev/null 2>&1 || fail 'Install jq to read the registry.'
    state_init;registry_check
    if [ ! -f "$registry" ]; then printf 'No registered installations.\n'; else jq '.installations' "$registry"; fi
    ;;
  update|update-all|backups-clean)
    shift;project='' machine='' channel='' version='' yes=false non_interactive=false
    while [ "$#" -gt 0 ]; do
      case "$1" in
        --yes) [ "$command_name" = backups-clean ] || usage_error '--yes is for backup cleanup';yes=true;shift;continue ;;
        --non-interactive) [ "$command_name" != backups-clean ] || usage_error 'Use --yes for cleanup';non_interactive=true;shift;continue ;;
      esac
      [ "$#" -ge 2 ] || usage_error "Missing value for $1"
      case "$1" in
        --project) [ "$command_name" != update-all ] || usage_error 'update-all does not accept --project';project="$2" ;;
        --machine) [ "$command_name" != update-all ] || usage_error 'update-all does not accept --machine';machine="$2" ;;
        --channel) [ "$command_name" != backups-clean ] || usage_error 'Cleanup has no channel';channel="$2" ;;
        *) usage_error "Unknown option: $1" ;;
      esac;shift 2
    done
    [ -z "$machine" ] || [[ "$machine" =~ ^[a-z0-9][a-z0-9-]*$ ]] || usage_error 'Invalid machine identifier.'
    case "$channel" in ''|stable|rc|dev) ;; *) usage_error 'Invalid channel.' ;; esac
    doctor >/dev/null || fail 'Missing dependencies.'
    work_dir=$(mktemp -d "${TMPDIR:-/tmp}/double-installer.XXXXXX")
    if [ "$command_name" = update ]; then
      [ -n "$project" ] && [ -n "$machine" ] || usage_error 'update requires --project and --machine.'
      update_machine
    elif [ "$command_name" = backups-clean ]; then
      [ -z "$project" ] || project_init
      clean_backups
    else
      state_init;registry_check
      [ -f "$registry" ] || { printf 'No registered installations.\n';exit 0; }
      jq -c '.installations[]' "$registry" > "$work_dir/installations"
      result=0
      script_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)/$(basename "${BASH_SOURCE[0]}")"
      while IFS= read -r row; do
        args=(update --project "$(printf '%s' "$row"|jq -r .project)" --machine "$(printf '%s' "$row"|jq -r .machine)")
        [ -z "$channel" ] || args+=(--channel "$channel")
        [ "$non_interactive" = false ] || args+=(--non-interactive)
        if ! bash "$script_path" "${args[@]}"; then result=1;fi
      done < "$work_dir/installations"
      exit "$result"
    fi
    ;;
  cron-add|cron-remove|uninstall-all)
    shift;yes=false schedule=''
    while [ "$#" -gt 0 ]; do
      case "$1" in
        --yes) [ "$command_name" = uninstall-all ] || usage_error '--yes is for uninstall-all';yes=true;shift ;;
        --schedule)
          [ "$command_name" = cron-add ] && [ "$#" -ge 2 ] || usage_error 'Provide cron-add --schedule EXPRESSION.'
          schedule="$2";shift 2 ;;
        *) usage_error "Unknown option: $1" ;;
      esac
    done
    doctor >/dev/null || fail 'Missing dependencies.'
    work_dir=$(mktemp -d "${TMPDIR:-/tmp}/double-installer.XXXXXX")
    case "$command_name" in
      cron-add) [ -n "$schedule" ] || usage_error 'Provide --schedule';cron_create "$schedule" ;;
      cron-remove) state_init;mutation_begin;cron_remove_owned ;;
      uninstall-all) uninstall_everything ;;
    esac
    ;;
  *) usage_error "Unknown command: $command_name" ;;
esac
