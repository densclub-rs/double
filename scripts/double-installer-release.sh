#!/usr/bin/env bash
# Independent installer assets; normally routed through double-release.sh.
set -euo pipefail
operation=${1:-}
shift || true
[ "$#" -eq 2 ] && [ "$1" = --tag ] || { echo 'Usage: double-installer-release.sh package|publish --tag double-installer-X.Y.Z[-rc|-dev]' >&2; exit 1; }
tag=$2
[[ "$tag" =~ ^double-installer-([0-9]+\.[0-9]+\.[0-9]+)(-(rc|dev))?$ ]] || { echo 'Invalid installer tag' >&2; exit 1; }
case "$operation" in package|publish) ;; *) exit 1 ;; esac
commit=$(git rev-parse --verify --end-of-options "refs/tags/${tag}^{commit}")
if [ "$operation" = publish ]; then
  [ "${GITHUB_ACTIONS:-}" = true ] || { echo 'Publication requires GitHub Actions' >&2; exit 1; }
  [ "${VALIDATED_COMMIT:-}" = "$commit" ] && [ "$(git rev-parse HEAD)" = "$commit" ] || { echo 'Validated commit mismatch' >&2; exit 1; }
  command -v gh >/dev/null
fi
out="dist/$tag"
mkdir -p "$out"
git show "$commit:scripts/double-installer.sh" > "$out/double-installer.sh"
bash -n "$out/double-installer.sh"
chmod +x "$out/double-installer.sh"
(
  cd "$out"
  if command -v sha256sum >/dev/null; then sha256sum double-installer.sh; else shasum -a 256 double-installer.sh; fi
) > "$out/SHA256SUMS.txt"
cat > "$out/INSTALL.md" <<EOF
# Double Installer $tag

Source commit: $commit

Download double-installer.sh and SHA256SUMS.txt from this installer release.
Select stable tags with the double-installer- prefix by numeric version;
rc/dev releases require explicit selection. The repository-wide latest release
may belong to another component.

Requirements: Bash (3.2 or newer), curl, jq, tar, and SHA-256 tooling.
On Windows use Git Bash from Git for Windows. Invoke from Bash:

    sha256sum -c SHA256SUMS.txt
    # On macOS without sha256sum: shasum -a 256 -c SHA256SUMS.txt
    bash double-installer.sh help
    bash double-installer.sh doctor

Review help before adding machines to a project. Stable machine releases are
selected by default; explicitly request rc/dev when needed. Shared state lives
under ~/.local/state/double. Downloading this script does not install a stable
executable entry point or create a cron task.
EOF
printf 'Prepared %s from %s\n' "$out" "$commit"
[ "$operation" = publish ] || exit 0
# Refuse overwrites. A failed inventory request must never be treated as absence.
repo=${GITHUB_REPOSITORY:-}
[ -n "$repo" ] || { echo 'GITHUB_REPOSITORY is required' >&2; exit 1; }
releases=$(gh api --paginate "repos/$repo/releases?per_page=100" --jq '.[].tag_name')
if printf '%s\n' "$releases" | grep -Fx -- "$tag" >/dev/null; then
  echo 'Release already exists; refusing to overwrite assets' >&2
  exit 1
fi
flags=(--verify-tag --latest=false)
case "$tag" in *-rc|*-dev) flags+=(--prerelease) ;; esac
gh release create "$tag" "$out/double-installer.sh" "$out/SHA256SUMS.txt" "$out/INSTALL.md" \
  --title "$tag" --notes-file "$out/INSTALL.md" "${flags[@]}"
