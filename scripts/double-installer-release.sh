#!/usr/bin/env bash
# Independent installer assets; normally routed through double-release.sh.
set -euo pipefail

# Internal workflow resolver. Explicit INPUT_REF selects validation-only mode.
if [ "${1:-}" = resolve ]; then
  mode=test; tag=''; ref="${INPUT_REF:-${GITHUB_SHA:-HEAD}}"
  if [ -n "${INPUT_REF:-}" ];then
    [ -z "${INPUT_TAG:-}" ] || { echo 'Validation-only calls cannot publish' >&2;exit 1; }
  elif [ "${GITHUB_EVENT_NAME:-}" = workflow_dispatch ];then
    if [ -n "${INPUT_TAG:-}" ];then mode=publish;tag=$INPUT_TAG;fi
  elif [ "${GITHUB_EVENT_NAME:-}" = push ] && [ "${GITHUB_REF_TYPE:-}" = tag ];then
    case "${GITHUB_REF_NAME:-}" in double-installer-*) mode=publish;tag=$GITHUB_REF_NAME ;; esac
  fi
  if [ "$mode" != test ];then
    [[ "$tag" =~ ^double-installer-[0-9]+\.[0-9]+\.[0-9]+(-(rc|dev))?$ ]] || { echo 'Invalid installer tag' >&2;exit 1; }
    ref="refs/tags/$tag"
  fi
  commit=$(git rev-parse --verify --end-of-options "${ref}^{commit}")
  test_ref=$commit
  printf 'mode=%s\ntag=%s\ncommit=%s\ntest_ref=%s\n' "$mode" "$tag" "$commit" "$test_ref" >> "${GITHUB_OUTPUT:?GITHUB_OUTPUT is required}"
  exit 0
fi

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
# Retire the former generated documentation asset in this owned output directory.
rm -f "$out/INSTALL.md"
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
documentation="https://github.com/$repo/blob/$commit/knowledge/double-installer/double-installer.md"
notes=$(printf 'Source commit: %s\n\n[Installation and usage instructions](%s)\n' "$commit" "$documentation")
gh release create "$tag" "$out/double-installer.sh" "$out/SHA256SUMS.txt" \
  --title "$tag" --notes "$notes" "${flags[@]}"
