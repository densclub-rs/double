#!/usr/bin/env bash
# Package a local or tagged Double machine release, or publish a tagged release.
# Implementation of the github-actions-maintenance subplan.

set -u

if [ -n "${FORCE_COLOR:-}" ] || { [ -t 1 ] && [ -z "${NO_COLOR:-}" ]; }; then
  color_blue="$(printf '\033[34m')"
  color_green="$(printf '\033[32m')"
  color_bold="$(printf '\033[1m')"
  color_warning="$(printf '\033[1;33m')"
  color_error="$(printf '\033[1;31m')"
  color_reset="$(printf '\033[0m')"
else
  color_blue=''
  color_green=''
  color_bold=''
  color_warning=''
  color_error=''
  color_reset=''
fi

info() {
  printf '%s%s%s\n' "$color_blue" "$*" "$color_reset"
}

success() {
  printf '%s%s%s\n' "$color_green" "$*" "$color_reset"
}

printf '%sImplementation of subplan:%s %sgithub-actions-maintenance%s\n' "$color_blue" "$color_reset" "$color_bold" "$color_reset"

usage() {
  printf '%sUsage:%s\n' "$color_bold" "$color_reset"
  cat <<'EOF'
  scripts/double-release.sh list-machines
  scripts/double-release.sh package --tag <machine>-<major>.<minor>.<patch>[-dev|-rc]
  scripts/double-release.sh package --machine <machine-of-ideas|machine-of-goals|machine-of-knowledge>
  scripts/double-release.sh publish --tag <machine>-<major>.<minor>.<patch>[-dev|-rc]

Without --tag, package reads the current directory (no Git repository required),
includes all machine Markdown files regardless of status, and uses local version
knowledge. Output: dist/double-<machine>-<version>-local.tar.gz and SHA256SUMS.txt.
Use either --tag or --machine. Publish always requires --tag.
EOF
}

warning() {
  printf '::warning::%s%s%s\n' "$color_warning" "$*" "$color_reset" >&2
}

error() {
  printf '::error::%s%s%s\n' "$color_error" "$*" "$color_reset" >&2
}

frontmatter_value() {
  local key="$1"
  awk -v requested_key="$key" '
    NR == 1 && $0 == "---" { in_frontmatter = 1; next }
    in_frontmatter && $0 == "---" { exit }
    in_frontmatter && $0 ~ "^[[:space:]]*" requested_key "[[:space:]]*:" {
      sub("^[[:space:]]*" requested_key "[[:space:]]*:[[:space:]]*", "")
      gsub(/^['\"']|['\"']$/, "")
      print
      exit
    }
  '
}

knowledge_value() {
  awk '
    /^## Value[[:space:]]*$/ { in_value = 1; next }
    in_value && /^[[:space:]]*$/ { next }
    in_value {
      value = $0
      sub(/^[[:space:]]*`/, "", value)
      sub(/`[[:space:]]*$/, "", value)
      print value
      exit
    }
  '
}

with_export_version() {
  local release_version="$1"
  awk -v release_version="$release_version" '
    NR == 1 && $0 == "---" { in_frontmatter = 1; print; next }
    in_frontmatter && $0 == "---" {
      print "version: " release_version
      print
      in_frontmatter = 0
      next
    }
    in_frontmatter && $0 ~ "^[[:space:]]*version[[:space:]]*:" { next }
    { print }
  '
}

checksum() {
  local archive_name="$1"
  if command -v sha256sum >/dev/null 2>&1; then
    sha256sum "$archive_name"
  else
    shasum -a 256 "$archive_name"
  fi
}

command_name="${1:-}"
shift || true

tag=""
machine=""
while [ "$#" -gt 0 ]; do
  case "$1" in
    --tag)
      if [ "$#" -lt 2 ]; then
        warning 'Missing value for --tag; no package was created.'
        exit 0
      fi
      tag="$2"
      shift 2
      ;;
    --machine)
      if [ "$#" -lt 2 ]; then
        warning 'Missing value for --machine; no package was created.'
        exit 0
      fi
      machine="$2"
      shift 2
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      warning "Unknown argument: $1; no package was created."
      exit 0
      ;;
  esac
done

if [ "$command_name" = 'list-machines' ]; then
  if [ ! -d .double ]; then
    warning 'Working catalog .double was not found in the current directory.'
    exit 0
  fi
  for machine_dir in .double/*/*; do
    [ -d "$machine_dir" ] || continue
    printf '%s\n' "${machine_dir##*/}"
  done | LC_ALL=C sort -u
  exit 0
fi

if [ "$command_name" != 'package' ] && [ "$command_name" != 'publish' ]; then
  usage >&2
  exit 0
fi

if [ -z "$tag" ]; then
  if [ "$command_name" = 'publish' ]; then
    warning 'A release tag is required for publish; no package was created.'
    exit 0
  fi
  case "$machine" in
    machine-of-ideas|machine-of-goals|machine-of-knowledge) ;;
    *) warning 'Select --machine machine-of-ideas, machine-of-goals, or machine-of-knowledge; no package was created.'; exit 0 ;;
  esac
  required_status=''
elif [ -n "$machine" ]; then
  warning 'Use either --tag or --machine; no package was created.'
  exit 0
elif [[ ! "$tag" =~ ^([a-z0-9][a-z0-9-]*)-([0-9]+\.[0-9]+\.[0-9]+)(-(dev|rc))?$ ]]; then
  warning "Invalid release tag: $tag; no package was created."
  exit 0
else
  machine="${BASH_REMATCH[1]}"
  version="${BASH_REMATCH[2]}"
  release_class="${BASH_REMATCH[4]:-stable}"

  case "$release_class" in
    dev) required_status='draft' ;;
    rc) required_status='release-candidate' ;;
    stable) required_status='stable' ;;
  esac

  if ! git rev-parse --verify --quiet "refs/tags/$tag" >/dev/null; then
    warning "Git tag does not exist: $tag; no package was created."
    exit 0
  fi
fi

read_source() {
  if [ -n "$tag" ]; then
    git show "$tag:$1"
  else
    cat "$1"
  fi
}

version_knowledge_path="knowledge/${machine}-version/${machine}-version.md"
version_knowledge_contents="$(read_source "$version_knowledge_path" 2>/dev/null)" || {
  error "Machine version knowledge is missing: $version_knowledge_path."
  exit 1
}
machine_version="$(printf '%s\n' "$version_knowledge_contents" | knowledge_value)"
if [ -z "$tag" ]; then
  if [[ ! "$machine_version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    error "Invalid local machine version: '${machine_version:-missing}'."
    exit 1
  fi
  version="$machine_version"
elif [ "$machine_version" != "$version" ]; then
  error "Machine version mismatch: tag is '$version', knowledge value is '${machine_version:-missing}'."
  exit 1
fi

temporary_dir="$(mktemp -d "${TMPDIR:-/tmp}/double-release.XXXXXX")" || exit 1
candidate_file="$temporary_dir/candidates.txt"
selected_file="$temporary_dir/selected.txt"
archive_path=''
cleanup() {
  rm -rf "$temporary_dir"
}
trap cleanup EXIT HUP INT TERM

if [ -n "$tag" ]; then
  git ls-tree -r --name-only "$tag" -- .double
elif [ -d .double ]; then
  find .double -type f -name '*.md'
fi \
  | awk -v selected_machine="/$machine/" \
      'index($0, selected_machine) && $0 ~ /\.md$/ { print }' \
  > "$candidate_file"

while IFS= read -r path; do
  [ -n "$path" ] || continue
  contents="$(read_source "$path")" || {
    warning "Could not read $path; candidate was excluded."
    continue
  }
  status="$(printf '%s\n' "$contents" | frontmatter_value status)"
  if [ -n "$required_status" ] && [ "$status" != "$required_status" ]; then
    warning "Excluded $path: status '${status:-missing}' does not match '$required_status'."
    continue
  fi
  printf '%s\n' "$path" >> "$selected_file"
done < "$candidate_file"

if [ ! -s "$selected_file" ]; then
  warning "No ${required_status:-local} files matched machine '$machine'; no package or GitHub Release was created."
  exit 0
fi

while IFS= read -r path; do
  [ -n "$path" ] || continue
  mkdir -p "$temporary_dir/$(dirname "$path")"
  read_source "$path" | with_export_version "$version" > "$temporary_dir/$path"
done < "$selected_file"

output_dir='dist'
archive_name="double-${tag:-$machine-$version-local}.tar.gz"
archive_path="$output_dir/$archive_name"
mkdir -p "$output_dir"
tar -C "$temporary_dir" -czf "$archive_path" .double
(
  cd "$output_dir"
  checksum "$archive_name" > SHA256SUMS.txt
)
success "Created package: $archive_path"
success "Created checksums: $output_dir/SHA256SUMS.txt"

if [ "$command_name" = 'package' ]; then
  exit 0
fi

if [ "${GITHUB_ACTIONS:-}" != 'true' ]; then
  warning 'Publish is restricted to GitHub Actions; package was created locally but not published.'
  exit 0
fi

if ! command -v gh >/dev/null 2>&1; then
  warning 'GitHub CLI is unavailable; package was not published.'
  exit 0
fi

release_flags=''
if [ "$release_class" = 'dev' ] || [ "$release_class" = 'rc' ]; then
  release_flags='--prerelease'
fi

if gh release view "$tag" >/dev/null 2>&1; then
  info "Uploading assets to existing GitHub Release: $tag"
  if ! gh release upload "$tag" "$archive_path" "$output_dir/SHA256SUMS.txt" --clobber; then
    warning "GitHub Release upload failed for $tag."
  fi
else
  info "Creating GitHub Release: $tag"
  if ! gh release create "$tag" "$archive_path" "$output_dir/SHA256SUMS.txt" --title "double-$tag" $release_flags; then
    warning "GitHub Release creation failed for $tag."
  fi
fi
