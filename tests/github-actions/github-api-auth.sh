#!/usr/bin/env bash
# Optional CI-only API authentication; product defaults remain unauthenticated.
# Source in the live smoke so its child Bash installer inherits the adapter.
if [ -n "${GH_TOKEN:-}" ]; then
  curl() {
    local arg
    for arg in "$@"; do
      case "$arg" in
        https://api.github.com/*)
          command curl --header "Authorization: Bearer $GH_TOKEN" "$@"
          return
          ;;
      esac
    done
    command curl "$@"
  }
  export -f curl
fi
