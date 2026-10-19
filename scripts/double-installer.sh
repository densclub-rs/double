#!/usr/bin/env bash
# Double Installer: release discovery and verified downloads.
# Goal: https://github.com/densclub-rs/double/blob/main/goals/double-installer/double-installer.md
set -euo pipefail

# Git Bash needs LF jq output, literal JSON string values and explicit native
# input filenames: MSYS conversion is unreliable for paths containing quotes.
case "${OSTYPE:-}" in
  msys*|cygwin*)
    jq() {
      local arg expect=0
      local args=()
      for arg in "$@"; do
        if [ "$expect" -eq 2 ]; then
          args+=("$arg"); expect=0
        elif [ "$expect" -eq 1 ]; then
          args+=("$arg"); expect=2
        elif [ "$arg" = --arg ]; then
          args+=("$arg"); expect=1
        elif [[ "$arg" == /* ]] && [ -e "$arg" ]; then
          args+=("$(cygpath -w "$arg")")
        else
          args+=("$arg")
        fi
      done
      MSYS2_ARG_CONV_EXCL='*' command jq --binary "${args[@]}"
    }
    ;;
esac

usage() {
  cat <<'EOF'
Double Installer

  double-installer.sh help
  double-installer.sh explain
  double-installer.sh doctor
  double-installer.sh releases [--machine ID] [--channel stable|rc|dev]
  double-installer.sh download --machine ID [--version VERSION] [--channel CHANNEL]
  double-installer.sh download [--all]   (all machines: stable -> rc -> dev)
  double-installer.sh install ...   (alias of download)
  double-installer.sh add --project DIR --machine ID [--agent codex|claude] [--version VERSION] [--channel CHANNEL] [--yes]
  double-installer.sh remove --project DIR --machine ID [--yes]
  double-installer.sh status [--json]
  double-installer.sh update --project DIR --machine ID [--channel CHANNEL] [--non-interactive]
  double-installer.sh add --global [--agent codex|claude] [--machine ID] [--channel CHANNEL] [--yes]
  double-installer.sh update --global [--agent codex|claude] [--machine ID] [--channel CHANNEL]
  double-installer.sh remove --global --machine ID [--agent codex|claude] [--yes]
  double-installer.sh update-all [--channel CHANNEL] [--non-interactive]
  double-installer.sh backups-clean [--project DIR] [--machine ID] [--yes]
  double-installer.sh cron-add --schedule 'CRON EXPRESSION'
  double-installer.sh cron-remove
  double-installer.sh uninstall-all [--yes]

Use COMMAND --help or COMMAND --explain for detailed command guidance.
Bulk selection: one latest version per machine, stable then rc then dev.
add lists detected agents and asks to integrate all; decline keeps shared skills only.
Non-terminal input defaults to shared skills; --agent selects an explicit adapter.
add --global installs globally; update --global updates registered machines.
Download/install only cache packages; add integrates projects or global agents.
add automatically downloads missing releases; a separate download is optional.
Minimal flow: [doctor] -> releases -> add.
Agent skills: ~/.agents/skills (Codex), ~/.claude/skills (Claude Code).
CLAUDE_CONFIG_DIR overrides the Claude directory; foreign skills are preserved.

Default state root: ~/.local/state/double
DOUBLE_STATE_DIR overrides the state root for isolated tests.
Implemented: all listed commands.
Installation and usage instructions:
https://github.com/densclub-rs/double/blob/066bd419c649ca0fa20bc77d11fb21a54f35af97/knowledge/double-installer/double-installer.md
EOF
}


format_explanation() {
  if [ ! -t 1 ] || [ "${TERM:-}" = dumb ] || [ -n "${NO_COLOR+x}" ]; then
    cat
    return
  fi
  # Styling is presentation-only; redirected help remains byte-for-byte plain.
  awk '
    BEGIN { esc=sprintf("%c",27); reset=esc "[0m"; heading=esc "[1;36m"; usage=esc "[32m"; option=esc "[33m" }
    /^[a-z][a-z-]*$/ || /^Double Installer/ || /^Command explanations:$/ {
      print heading $0 reset; next
    }
    /Usage:/ || /^         double-installer.sh/ {
      print usage $0 reset; next
    }
    { gsub(/--[a-z][a-z-]*/, option "&" reset); print }
  '
}

format_releases() {
  if [ ! -t 1 ] || [ "${TERM:-}" = dumb ] || [ -n "${NO_COLOR+x}" ];then
    cat
    return
  fi
  awk '
    BEGIN { FS=OFS="\t"; esc=sprintf("%c",27); reset=esc "[0m" }
    NR==1 { print esc "[1;36m" $0 reset; next }
    { color=($3=="stable" ? "32" : ($3=="rc" ? "33" : "35")); $3=esc "[" color "m" $3 reset; print }
  '
}

explain_command() {
  case "$1" in
    help)
      cat <<'EOF'
help
  Show the command synopsis, state directory and documentation link.
  Usage: double-installer.sh help
  For complete explanations use explain; for one command use COMMAND --help
  or COMMAND --explain. Help performs no downloads or installation changes.
EOF
      ;;
    explain)
      cat <<'EOF'
explain
  Explain the installer and every command, including selection rules and effects.
  Usage: double-installer.sh explain
  COMMAND --help and COMMAND --explain show only that command's explanation.
  These informational requests perform no network or installation operations.
EOF
      ;;
    doctor)
      cat <<'EOF'
doctor
  Report Bash, state root, required tools, optional cron and detected agents.
  Usage: double-installer.sh doctor
  Does not install dependencies or alter projects. Missing required tools cause
  a nonzero exit. Windows uses Git Bash; cron is optional.
  List Codex, Claude Code, Cursor, Copilot, Gemini CLI, OpenCode, Cascade/Windsurf
  and Pi with DETECTED/NOT FOUND and CLI/config/app evidence. Never launch agents
  or read credential contents. Config can outlive an uninstall; unknown locations
  can be missed. Detection does not verify authentication or skill loading, and
  does not enable new --agent adapters. Missing agents do not fail doctor.
  Terminal colors highlight results; NO_COLOR, TERM=dumb or redirection disable them.
EOF
      ;;
    releases)
      cat <<'EOF'
releases
  Query GitHub releases and list machine, version, channel and tag.
  Usage: double-installer.sh releases [--machine ID] [--channel stable|rc|dev]
  Stable is the default. Select rc or dev explicitly to list that channel.
  Uses the network; does not download archives or install machines.
  Terminal colors distinguish stable/rc/dev; NO_COLOR, TERM=dumb or redirection
  disables styling and retains plain tab-separated output.
EOF
      ;;
    download|install)
      cat <<EOF
$1
  Download verified machine packages into the local installer cache.
  Usage: double-installer.sh $1 [--all]
         double-installer.sh $1 --machine ID [--version VERSION] [--channel stable|rc|dev]
  With no options, or --all, choose one version per machine: prefer stable,
  otherwise rc, otherwise dev; select the latest numeric version in that channel.
  Explicit --machine defaults to stable. --version selects a numeric version
  within the chosen channel. --all cannot combine with machine/version/channel.
  install is an alias of download; neither integrates machines into projects.
  Downloads come from GitHub releases. Verify SHA-256 and archive safety before
  caching. Bulk mode verifies and reuses cached packages; an explicit duplicate
  download is refused. Invalid cache entries are not silently overwritten.
EOF
      ;;
    add)
      cat <<'EOF'
add
  Install machine files and register skills with selected AI agents.
  Usage: double-installer.sh add --project DIR --machine ID [--agent codex|claude] [--version VERSION] [--channel stable|rc|dev] [--yes]
         double-installer.sh add --global [--agent codex|claude] [--machine ID] [--channel stable|rc|dev] [--yes]
  Prefer stable, then rc, then dev; newest numeric version within that channel.
  --channel restricts selection; --version accepts an exact numeric version.
  Prerelease installation requires confirmation, even with explicit --channel.
  Found unregistered machine directories require separate adoption confirmation.
  Adoption backs up complete machine directories, replaces them and registers
  the published files. Other machines are preserved. add --yes approves these
  two confirmations for automation; it does not select all detected agents.
  Non-terminal input without --yes cannot authorize prerelease or adoption.
  No prior download is required: add downloads missing releases using the same
  verified mechanism as download, or reuses and revalidates a cached archive.
  Minimal flow: [doctor] -> releases -> add. releases helps choose the machine;
  add refreshes release selection itself and checks dependencies automatically.
  Without --agent, list detected agents and ask whether to integrate all of them.
  No (the default) writes only DIR/.agents/skills or ~/.agents/skills globally.
  Yes reuses that shared skill for compatible agents and adds dedicated roots
  where required (currently Claude Code's .claude/skills). Each operation is
  independent. No agents or non-terminal input selects shared skills only;
  --agent selects an explicit adapter without this list or prompt.
  --agent codex uses the same standard shared root; --agent claude explicitly
  creates DIR/.claude/skills or the global Claude skills root. Claude Code is not
  assumed to discover the shared root automatically. Omitted global --machine
  selects all machines, preferring stable, then rc, then dev. Global skills live
  in ~/.agents/skills and ~/.claude/skills (CLAUDE_CONFIG_DIR overrides Claude).
  Repeating global add may attach/repair skills; existing payloads are not upgraded.
  Use update for upgrades. Download and verify packages; track payload and skills
  in the registry. Refuse foreign skill collisions. Agent operations are independent:
  failures roll back only that agent; retain payload and successful registrations,
  continue other agents, then return nonzero on any failure. Repeat add to retry
  integration without reinstalling/upgrading the machine payload.
EOF
      ;;
    remove)
      cat <<'EOF'
remove
  Remove registered machine files and update the registry, preserving unrelated files.
  Usage: double-installer.sh remove --project DIR --machine ID [--yes]
         double-installer.sh remove --global --machine ID [--agent codex|claude] [--yes]
  Global removal with --agent detaches that agent; other connections retain the
  shared payload. Removing all connections also removes the global payload.
  Destructive removal requires confirmation or --yes. Cache and existing backups
  are separate; use backups-clean or uninstall-all when appropriate.
EOF
      ;;
    status)
      cat <<'EOF'
status
  Show downloaded machine archives and all registered local/global installations.
  Usage: double-installer.sh status [--json]
  Default output includes an archive table followed by projects with nested
  machine/version/channel lists, colored in terminals. NO_COLOR or TERM=dumb disables colors; redirected output is plain.
  --json emits one object: archives and installations arrays, with no headings
  or ANSI colors. Archive records contain machine, version, channel and archive.
  Reads local state only; it neither queries GitHub nor rechecks archive hashes.
EOF
      ;;
    update)
      cat <<'EOF'
update
  Update registered project or global machines; use add for initial installation.
  Usage: double-installer.sh update --project DIR --machine ID [--channel stable|rc|dev] [--non-interactive]
         double-installer.sh update --global [--agent codex|claude] [--machine ID] [--channel stable|rc|dev] [--non-interactive]
  Project updates retain the recorded channel unless explicitly overridden.
  Global selection defaults to stable, then rc, then dev. Only registered global
  machines are updated; --agent filters by an existing agent connection. It never
  discovers or registers new agents. Use add --global for new connections.
  Global payload lives in installer state; tracked skill entry points connect
  ~/.agents/skills (Codex) and ~/.claude/skills (Claude Code). CLAUDE_CONFIG_DIR
  overrides the Claude root. Foreign skills are preserved; collisions are refused.
  Download/verify newer packages, back up replaced files, then update the registry.
  Do not downgrade versions. Interactive updates offer backup cleanup;
  --non-interactive retains backups. Does not upgrade this installer script.
EOF
      ;;
    update-all)
      cat <<'EOF'
update-all
  Update every registered project and global machine installation.
  Usage: double-installer.sh update-all [--channel stable|rc|dev] [--non-interactive]
  Project entries retain their channel; global entries use stable -> rc -> dev
  unless --channel overrides it. Download verified updates, back up replacements
  and update registry records. No version downgrades. Continue across entries;
  any failed update causes a nonzero final exit.
  Does not update cache-only machines, add new machines/agents or upgrade the
  installer itself. --non-interactive keeps backups and suppresses cleanup prompts.
EOF
      ;;
    backups-clean)
      cat <<'EOF'
backups-clean
  Delete saved installer backups, optionally limited to one project or machine.
  Usage: double-installer.sh backups-clean [--project DIR] [--machine ID] [--yes]
  With no filters, select all owned backups. Show selected backups and require
  confirmation or --yes. Does not uninstall machines or clear downloaded archives.
EOF
      ;;
    cron-add)
      cat <<'EOF'
cron-add
  Register a user cron job for unattended updates of all registered installations.
  Usage: double-installer.sh cron-add --schedule 'CRON EXPRESSION'
  Use a numeric five-field expression, for example '0 9 * * *'. Requires crontab;
  Windows without cron supports manual updates instead. The job runs this script's
  update-all --non-interactive with the configured state root. Keep the script
  at its installed path. Preserve unrelated cron entries; manage only owned jobs.
EOF
      ;;
    cron-remove)
      cat <<'EOF'
cron-remove
  Remove this installer's owned cron entries and scheduling metadata.
  Usage: double-installer.sh cron-remove
  Preserve unrelated user cron jobs, machine installations, downloads and backups.
  Does not require cron when no owned scheduling metadata needs removal.
EOF
      ;;
    uninstall-all)
      cat <<'EOF'
uninstall-all
  Completely remove installer-owned integrations, cache, backups and cron jobs.
  Usage: double-installer.sh uninstall-all [--yes]
  Remove registered machines across projects and global agents, registry and owned
  installer state. Preserve unrelated project files, foreign skills and state
  owned by other Double components. Requires confirmation or --yes.
  Does not delete the installer script itself or system dependencies.
EOF
      ;;
    *) usage_error "Unknown command: $1" ;;
  esac
}

explain_all() {
  cat <<'EOF'
Double Installer — detailed guide

A Bash installer for Linux, macOS and Windows (Git Bash). It discovers machine
packages from densclub-rs/double GitHub releases, verifies downloads, and manages
machine files in projects and global AI-agent integrations through a local registry.
State root: ~/.local/state/double; installer-owned data lives in its installer/
subdirectory. DOUBLE_STATE_DIR overrides the root for isolated environments.
Downloads alone do not install machines. Use add for project integration,
add --global for agent integration, and update-all for registered installations.
Updates save backups before replacing files; cleanup/removal preserves foreign files.
The installer does not update its own script. Network commands require curl;
JSON processing requires jq, and packages use tar and a SHA-256 utility.

Command explanations:
EOF
  local name
  for name in help explain doctor releases download install add remove status update update-all backups-clean cron-add cron-remove uninstall-all; do
    printf '\n';explain_command "$name"
  done
}

doctor_path() {
  detected_path="$1"
  # Environment directories can use native Windows drive-letter paths.
  case "$detected_path" in
    [a-zA-Z]:*)
      if command -v cygpath >/dev/null 2>&1;then
        detected_path=$(cygpath -u "$detected_path") || return 1
      fi ;;
  esac
}

doctor_agent() {
  local id="$1" label="$2" cli="$3" config="$4" evidence='' probe found='' detected_path
  shift 4
  for probe in $cli;do
    found=$(type -P "$probe" 2>/dev/null) || found=''
    if [ -n "$found" ];then evidence="${evidence}${evidence:+; }CLI: $found";fi
  done
  doctor_path "$config"
  if [ -d "$detected_path" ];then evidence="${evidence}${evidence:+; }config: $detected_path";fi
  # Remaining probes are known application paths, not generic editor launchers.
  for probe in "$@";do
    [ -n "$probe" ] || continue
    local probe_kind=app
    case "$probe" in config:*) probe_kind=config;probe=${probe#config:} ;; extension:*) probe_kind=extension;probe=${probe#extension:} ;; esac
    doctor_path "$probe"
    if [ -e "$detected_path" ];then evidence="${evidence}${evidence:+; }$probe_kind: $detected_path";fi
  done
  if [ -n "$evidence" ];then
    detected_agents+=("$id")
    printf '  %-12s  %-23s  %s%-10s%s  %s\n' "$id" "$label" "$doctor_ok" 'DETECTED' "$doctor_reset" "$evidence"
  elif [ "${agent_scan_mode:-all}" = all ];then
    printf '  %-12s  %-23s  %s%-10s%s  %s\n' "$id" "$label" "$doctor_warning" 'NOT FOUND' "$doctor_reset" '-'
  fi
}

doctor_agents() {
  local app_root='' user_apps='' win_apps='' extension
  local copilot_extensions=('')
  detected_agents=('')
  case "${OSTYPE:-}" in
    darwin*) app_root=/Applications;user_apps="$HOME/Applications" ;;
    msys*|cygwin*) [ -z "${LOCALAPPDATA:-}" ] || win_apps="$LOCALAPPDATA/Programs" ;;
  esac
  printf '\n%sAgent detection:%s\n' "$doctor_heading" "$doctor_reset"
  printf '%s  %-12s  %-23s  %-10s  %s%s\n' "$doctor_heading" 'ID' 'AGENT' 'STATUS' 'EVIDENCE' "$doctor_reset"
  doctor_agent codex 'Codex' 'codex' "${CODEX_HOME:-$HOME/.codex}" \
    "${app_root:+$app_root/Codex.app}" "${user_apps:+$user_apps/Codex.app}"
  doctor_agent claude 'Claude Code' 'claude' "${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
  doctor_agent cursor 'Cursor' 'cursor-agent cursor' "$HOME/.cursor" \
    "${app_root:+$app_root/Cursor.app}" "${user_apps:+$user_apps/Cursor.app}" "${win_apps:+$win_apps/cursor/Cursor.exe}"
  for extension in "$HOME"/.vscode/extensions/github.copilot-* "$HOME"/.vscode-insiders/extensions/github.copilot-*;do
    [ ! -d "$extension" ] || copilot_extensions+=("extension:$extension")
  done
  doctor_agent copilot 'GitHub Copilot' 'copilot' "${COPILOT_HOME:-$HOME/.copilot}" "${copilot_extensions[@]}"
  doctor_agent gemini 'Gemini CLI' 'gemini' "$HOME/.gemini"
  doctor_agent opencode 'OpenCode' 'opencode' "${XDG_CONFIG_HOME:-$HOME/.config}/opencode"
  doctor_agent cascade 'Cascade / Windsurf' 'windsurf devin' "$HOME/.codeium/windsurf" \
    "${app_root:+$app_root/Windsurf.app}" "${user_apps:+$user_apps/Windsurf.app}" \
    "${app_root:+$app_root/Devin.app}" "${user_apps:+$user_apps/Devin.app}" \
    "${win_apps:+$win_apps/Windsurf/Windsurf.exe}" "config:${XDG_CONFIG_HOME:-$HOME/.config}/devin"
  doctor_agent pi 'Pi' 'pi' "${PI_CODING_AGENT_DIR:-$HOME/.pi/agent}"
  if [ "${agent_scan_mode:-all}" = all ];then
  printf 'Detection uses executable paths and existing directories/files; agents are never launched.\n'
  printf 'Config alone may be stale; NOT FOUND means no known local evidence, not confirmed absence.\n'
  printf 'Detection does not verify login, versions, skill support or skill loading.\n'
  printf 'Agent detection is independent of add adapters (currently codex/claude; shared by default).\n'
  fi
}

doctor() {
  local tool missing=0 doctor_heading='' doctor_ok='' doctor_warning='' doctor_reset='' doctor_error='' doctor_error_reset=''
  if [ -t 1 ] && [ "${TERM:-}" != dumb ] && [ -z "${NO_COLOR+x}" ];then
    doctor_heading=$'\033[1;36m';doctor_ok=$'\033[32m';doctor_warning=$'\033[33m';doctor_reset=$'\033[0m'
    if [ -t 2 ];then doctor_error=$'\033[31m';doctor_error_reset=$doctor_reset;fi
  fi
  printf '%sBash:%s %s\n' "$doctor_heading" "$doctor_reset" "$BASH_VERSION"
  printf '%sState root:%s %s\n' "$doctor_heading" "$doctor_reset" "${DOUBLE_STATE_DIR:-$HOME/.local/state/double}"
  for tool in cat curl jq tar awk find sort uniq wc cp mv mkdir rm rmdir mktemp dirname tr cmp basename; do
    if { [ "$tool" = jq ] && type -P jq >/dev/null 2>&1; } || { [ "$tool" != jq ] && command -v "$tool" >/dev/null 2>&1; }; then
      printf '%sOK:%s %s\n' "$doctor_ok" "$doctor_reset" "$tool"
    else
      printf '%sMissing required dependency: %s%s\n' "$doctor_error" "$tool" "$doctor_error_reset" >&2
      missing=1
    fi
  done
  if command -v sha256sum >/dev/null 2>&1; then
    printf '%sSHA-256: sha256sum%s\n' "$doctor_ok" "$doctor_reset"
  elif command -v shasum >/dev/null 2>&1; then
    printf '%sSHA-256: shasum -a 256%s\n' "$doctor_ok" "$doctor_reset"
  else
    printf '%sMissing SHA-256 tool: install sha256sum or shasum.%s\n' "$doctor_error" "$doctor_error_reset" >&2
    missing=1
  fi
  if command -v crontab >/dev/null 2>&1; then
    printf '%sOptional cron: available (not modified)%s\n' "$doctor_ok" "$doctor_reset"
  else
    printf '%sOptional cron: unavailable; use interactive updates%s\n' "$doctor_warning" "$doctor_reset"
  fi
  doctor_agents
  return "$missing"
}


action_printf() {
  local level="$1" format="$2" color='' reset='' message label=''
  shift 2
  printf -v message "$format" "$@"
  case "${command_name:-}" in
    add|update|update-all) ;;
    *) printf '%s' "$message";return ;;
  esac
  case "$level" in
    info) label='[INFO]' ;;
    success) label='[OK]' ;;
    warning) label='[WARN]' ;;
    error) label='[ERROR]';message=${message#Error: } ;;
  esac
  if [ "${action_colors:-false}" = true ] && [ -t 1 ];then
    case "$level" in
      info) color=$'\033[36m' ;;
      success) color=$'\033[32m' ;;
      warning) color=$'\033[33m' ;;
      error) color=$'\033[31m' ;;
    esac
    reset=$'\033[0m'
  fi
  printf '%s%s%s %s' "$color" "$label" "$reset" "$message"
}

fail() { action_printf error 'Error: %s\n' "$*" >&2; exit 1; }
usage_error() { action_printf error 'Error: %s\n' "$*" >&2; exit 2; }
work_dir=''
cache_staging=''
cache_pending=''
mutation_lock=''
transaction=''
transaction_project=''
transaction_kind=''
# Payload recovery always captures complete, bounded machine/skill directories.
machine_roots() {
  awk -F/ 'NF>=4 {print $1 "/" $2 "/" $3}' "$1" | LC_ALL=C sort -u
}

snapshot_directories() {
  local base="$1" roots="$2" dest="$3" root
  mkdir -p "$dest/old" || fail 'Cannot prepare directory snapshot.'
  cp "$roots" "$dest/roots" || fail 'Cannot record snapshot roots.'
  while IFS= read -r root;do
    [ -n "$root" ] || continue
    no_symlinks "$base/$root"
    if [ -e "$base/$root" ];then
      [ -d "$base/$root" ] || fail 'Machine root is not a directory.'
      # Do not traverse links or copy devices/FIFOs from a manually edited tree.
      [ -z "$(find "$base/$root" ! -type d ! -type f -print)" ] || fail 'Snapshot directory contains unsupported entries.'
      mkdir -p "$dest/old/$(dirname "$root")" || fail 'Cannot prepare directory snapshot parent.'
      cp -Rp -- "$base/$root" "$dest/old/$root" || fail 'Cannot preserve directory snapshot.'
    fi
  done < "$roots"
  printf 'complete\n' > "$dest/snapshot-complete"
}

restore_directories() {
  local base="$1" source="$2" root result=0
  while IFS= read -r root;do
    [ -n "$root" ] || continue
    rm -rf -- "$base/$root" || { result=1;continue; }
    if [ -d "$source/old/$root" ];then
      mkdir -p "$base/$(dirname "$root")" && cp -Rp -- "$source/old/$root" "$base/$root" || result=1
    fi
  done < "$source/roots"
  return "$result"
}

installation_consent() {
  local answer
  action_printf warning '%s\n' "$1"
  [ "${yes:-false}" = true ] && return 0
  [ -t 0 ] || fail 'Installation requires confirmation; rerun interactively or use add --yes.'
  action_printf warning 'Continue? [y/N] '
  read -r answer || answer=''
  case "$answer" in y|Y|yes) ;; *) fail 'Installation cancelled.' ;; esac
}

cleanup() {
  local item rollback_failed=0
  if [ -n "$transaction" ]; then
    if [ -f "$transaction/snapshot-complete" ];then
      restore_directories "$transaction_project" "$transaction" || rollback_failed=1
      if [ -f "$transaction/directories" ];then
        LC_ALL=C sort -r "$transaction/directories" > "$transaction/prune"
        while IFS= read -r item;do
          [ -z "$item" ] || rmdir "$transaction_project/$item" 2>/dev/null || true
        done < "$transaction/prune"
      fi
    fi
    if [ -f "$transaction/external-paths" ];then
      local n=0
      while IFS= read -r item;do
        rm -rf -- "$item" || rollback_failed=1
        if [ -d "$transaction/external/$n" ];then
          mkdir -p "$(dirname "$item")" && cp -Rp -- "$transaction/external/$n" "$item" || rollback_failed=1
        fi
        n=$((n+1))
      done < "$transaction/external-paths"
    fi
    if [ -f "$transaction/registry-before.json" ];then
      cp -p "$transaction/registry-before.json" "$registry" || rollback_failed=1
    fi
    if [ "$transaction_kind" = integration ] && [ -f "$transaction/directories" ];then
      LC_ALL=C sort -r "$transaction/directories" > "$transaction/prune"
      while IFS= read -r item;do rmdir "$item" 2>/dev/null || true;done < "$transaction/prune"
    fi
    if [ "$rollback_failed" -eq 0 ]; then
      rm -rf -- "$transaction"
    else
      action_printf error 'Rollback incomplete; retained recovery data: %s\n' "$transaction" >&2
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
      | select($channel == "all" or .channel == $channel)
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
  action_printf success 'Verified download: %s\n' "$destination/$archive"
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
    all(.installations[]; . as $r | (.integrations // []) as $i |
      ($i|type)=="array" and all($i[];
        (.agent=="shared" or .agent=="codex" or .agent=="claude") and
        (.root|type)=="string" and (.root|startswith("/")) and .root!="/" and
        (.root|explode|all(.>=32)) and .file==("skills/"+$r.machine+"/SKILL.md") and
        (.directories|type)=="array" and (. as $a | all(.directories[];
          .==$a.root or .==($a.root+"/skills") or .==($a.root+"/skills/"+$r.machine)))) and
      ([$i[].agent]|length)==([$i[].agent]|unique|length)) and
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
    printf '{"schema_version":1,"installations":[]}\n' > "$state/registry.new" || fail 'Cannot stage registry update.'
    mv "$state/registry.new" "$registry" || fail 'Cannot commit registry update.'
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
  local file scope category owner rest
  while IFS= read -r file; do
    IFS=/ read -r scope category owner rest <<< "$file"
    [ "$scope" = .double ] && [ -n "$category" ] && [ "$owner" = "$machine" ] && [ -n "$rest" ] || fail 'Invalid machine directory scope.'
    case "$file" in .double/*/"$machine"/*) ;; *) fail 'Invalid managed inventory scope.' ;; esac
    case "$file" in /*|*\\*|*/../*|*/..|*/./*|*//*|*$'\t'*|*$'\r'*) fail 'Unsafe managed inventory path.' ;; esac
    no_symlinks "$project/$file"
  done < "$work_dir/files"
}

add_machine() {
  local cached tag archive row file dir created backup='' manual=false
  project_init
  state_init
  mutation_begin
  row=$(jq --arg p "$project" --arg m "$machine" '.installations[]|select(.project==$p and .machine==$m)' "$registry")
  if [ -n "$row" ];then
    action_printf info 'Machine already installed: %s in %s; integrating selected agents only.\n' "$machine" "$project"
    integrate_selected_agents
    return $?
  fi
  # Catalog remains authoritative for explicit channel/version selection.
  if [ -z "$channel" ] || [ "$channel" = all ];then
    channel=all;release_catalog
    jq --arg v "$version" '[.[]|select($v=="" or .version==$v)]' "$work_dir/catalog.json" > "$work_dir/eligible.json"
    row=$(jq 'sort_by([{stable:2,rc:1,dev:0}[.channel],(.version|split(".")|map(tonumber))]) | last // empty' "$work_dir/eligible.json")
  else
    release_catalog
    row=$(jq --arg v "$version" '[.[]|select($v=="" or .version==$v)][0] // empty' "$work_dir/catalog.json")
  fi
  [ -n "$row" ] || fail 'No matching published machine release.'
  channel=$(printf '%s' "$row"|jq -r .channel)
  version=$(printf '%s' "$row"|jq -r .version)
  if [ "$channel" != stable ];then
    installation_consent "Selected prerelease: $machine $version ($channel)."
  fi
  printf '%s' "$row" | jq '[.]' > "$work_dir/catalog.json"
  tag=$(printf '%s' "$row" | jq -r '.tag')
  cached="$state/releases/$tag";archive="$cached/double-$tag.tar.gz"
  if [ ! -d "$cached" ];then
    action_printf info 'Release not cached; downloading: %s\n' "$tag"
    download_release
  else
    action_printf info 'Using cached release: %s\n' "$tag"
  fi
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
  machine_roots "$work_dir/files" > "$work_dir/roots"
  # Include obsolete categories of the same manual machine, not other machines.
  for dir in "$project"/.double/*/"$machine";do
    [ ! -e "$dir" ] && [ ! -L "$dir" ] && continue
    no_symlinks "$dir"
    [ -d "$dir" ] || fail 'Manual machine root is not a directory.'
    printf '%s\n' "${dir#"$project/"}" >> "$work_dir/roots"
    manual=true
  done
  LC_ALL=C sort -u "$work_dir/roots" > "$work_dir/roots.sorted"
  mv "$work_dir/roots.sorted" "$work_dir/roots"
  if [ "$manual" = true ];then
    installation_consent "Unregistered machine found: $machine in $project. Back up and replace its directories?"
    no_symlinks "$state/backups";mkdir -p "$state/backups"
    backup=$(mktemp -d "$state/backups/backup.XXXXXX")
    jq -n --arg p "$project" --arg m "$machine" '{project:$p,machine:$m,source:"manual"}' > "$backup/installation.json"
    snapshot_directories "$project" "$work_dir/roots" "$backup"
    printf 'complete\n' > "$backup/complete"
    action_printf warning 'Manual machine directory backup: %s\n' "$backup"
  fi
  mkdir "$work_dir/unpacked"
  tar -xzf "$archive" -C "$work_dir/unpacked" || fail 'Cannot extract validated package.'
  transaction=$(mktemp -d "$state/transactions/add.XXXXXX")
  transaction_project="$project"
  snapshot_directories "$project" "$work_dir/roots" "$transaction"
  transaction_kind=add
  cp -p "$registry" "$transaction/registry-before.json" || fail 'Cannot preserve installation registry.'
  : > "$transaction/written"; : > "$transaction/directories"
  cp "$work_dir/files" "$transaction/files"
  jq -n --arg p "$project" --arg m "$machine" '{operation:"add",project:$p,machine:$m}' > "$transaction/operation.json"
  if [ "$manual" = true ];then
    while IFS= read -r dir;do rm -rf -- "$project/$dir" || fail 'Cannot replace manual machine directory.';done < "$work_dir/roots"
  fi
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
    "$registry" > "$state/registry.new" || fail 'Cannot stage registry update.'
  mv "$state/registry.new" "$registry" || fail 'Cannot commit registry update.'
  if [ "${integration_scope:-project}" = global ];then
    jq --arg p "$project" --arg m "$machine" '(.installations[]|select(.project==$p and .machine==$m)).scope="global"' "$registry" > "$state/registry.new" || fail 'Cannot stage registry update.'
    mv "$state/registry.new" "$registry" || fail 'Cannot commit registry update.'
  fi
  local done_transaction="$transaction";transaction=''
  rm -rf -- "$done_transaction"
  action_printf success 'Installed %s in %s (%s)\n' "$machine" "$project" "$tag"
  offer_backup_cleanup "$backup"
  integrate_selected_agents
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
  # Detach each agent independently; keep payload if any detach needs a retry.
  if ! detach_registered_agents "$row";then return 1;fi
  mutation_begin
  row=$(jq --arg p "$project" --arg m "$machine" '.installations[]|select(.project==$p and .machine==$m)' "$registry")
  # Prepare complete rollback copies before deleting anything.
  local backup
  backup=$(mktemp -d "$state/transactions/remove.XXXXXX")
  cp "$work_dir/files" "$backup/files"
  jq -n --arg p "$project" --arg m "$machine" '{operation:"remove",project:$p,machine:$m}' > "$backup/operation.json"
  machine_roots "$work_dir/files" > "$work_dir/roots"
  snapshot_directories "$project" "$work_dir/roots" "$backup"
  transaction="$backup";transaction_project="$project";transaction_kind=remove
  remove_integrations "$row"
  while IFS= read -r file; do rm -f -- "$project/$file" || fail 'Removal failed.'; done < "$work_dir/files"
  jq --arg p "$project" --arg m "$machine" '.installations |= map(select(.project!=$p or .machine!=$m))' "$registry" > "$state/registry.new" || fail 'Cannot stage registry update.'
  mv "$state/registry.new" "$registry" || fail 'Cannot commit registry update.'
  local done_transaction="$transaction";transaction=''
  rm -rf -- "$done_transaction"
  printf '%s' "$row" | jq -r '.directories[]' | LC_ALL=C sort -r > "$work_dir/dirs"
  while IFS= read -r dir; do
    case "$dir" in .double|.double/*) ;; *) continue ;; esac
    case "$dir" in *..*|*\\*) continue ;; esac
    no_symlinks "$project/$dir"
    rmdir "$project/$dir" 2>/dev/null || true
  done < "$work_dir/dirs"
  prune_integrations "$row"
  printf 'Removed %s from %s\n' "$machine" "$project"
}


offer_backup_cleanup() {
  local backup="$1" answer
  [ -n "$backup" ] || return 0
  if [ "${non_interactive:-false}" = false ] && [ -t 0 ];then
    action_printf warning 'Delete this backup? [y/N] '
    read -r answer || answer=''
    case "$answer" in y|Y|yes) rm -rf -- "$backup" ;; esac
  fi
  return 0
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
  integration_check "$installed"
  if [ -z "$channel" ] && [ "$(printf '%s' "$installed"|jq -r '.scope // "project"')" = global ];then
    channel=all;latest_machines
    row=$(jq '.[0] // empty' "$work_dir/latest.json")
    [ -z "$row" ] || channel=$(printf '%s' "$row"|jq -r .channel)
  else
    [ -n "$channel" ] || channel=$(printf '%s' "$installed" | jq -r .channel)
    release_catalog
    row=$(jq '.[0] // empty' "$work_dir/catalog.json")
  fi
  [ -n "$row" ] || { action_printf warning 'No applicable release: %s (%s) in %s\n' "$machine" "$channel" "$project"; return 0; }
  if ! jq -ne --arg a "$(printf '%s' "$row"|jq -r .version)" --arg b "$(printf '%s' "$installed"|jq -r .version)" \
    --arg old "$(printf '%s' "$installed"|jq -r '.tag|if endswith("-dev") then "dev" elif endswith("-rc") then "rc" else "stable" end')" --arg new "$channel" \
    '($a|split(".")|map(tonumber)) as $av | ($b|split(".")|map(tonumber)) as $bv |
      {dev:0,rc:1,stable:2} as $rank | ($av > $bv) or ($av == $bv and $rank[$new] > $rank[$old])' >/dev/null; then
    jq --arg p "$project" --arg m "$machine" --arg c "$channel" \
      '(.installations[]|select(.project==$p and .machine==$m)).channel=$c' "$registry" > "$state/registry.new" || fail 'Cannot stage registry update.'
    mv "$state/registry.new" "$registry" || fail 'Cannot commit registry update.'
    refresh_integrations
    action_printf success 'Already current: %s in %s\n' "$machine" "$project"; return 0
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
  cat "$work_dir/files" "$work_dir/new-files" > "$work_dir/all-files"
  machine_roots "$work_dir/all-files" > "$work_dir/roots"
  snapshot_directories "$project" "$work_dir/roots" "$backup"
  printf 'complete\n' > "$backup/complete"
  mkdir "$work_dir/unpacked"
  tar -xzf "$archive" -C "$work_dir/unpacked" || fail 'Cannot extract validated package.'
  transaction=$(mktemp -d "$state/transactions/update.XXXXXX")
  cp "$work_dir/files" "$transaction/files"
  cp "$work_dir/new-files" "$transaction/new-files"
  cp -Rp "$backup/old" "$transaction/old" || fail 'Cannot preserve update recovery directories.'
  cp "$backup/roots" "$transaction/roots" || fail 'Cannot preserve update roots.'
  cp "$backup/snapshot-complete" "$transaction/snapshot-complete" || fail 'Cannot preserve snapshot marker.'
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
    "$registry" > "$state/registry.new" || fail 'Cannot stage registry update.'
  mv "$state/registry.new" "$registry" || fail 'Cannot commit registry update.'
  transaction_done="$transaction";transaction='';rm -rf -- "$transaction_done"
  refresh_integrations
  action_printf success 'Updated %s in %s to %s; backup: %s\n' "$machine" "$project" "$version" "$backup"
  offer_backup_cleanup "$backup"
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

# Internal all-channel discovery; explicit --all/global operations own fallback.
latest_machines() {
  release_catalog
  jq '
    [.[] | . as $r | select(([.assets[]|select(.name == ("double-"+$r.tag+".tar.gz"))]|length)==1)
      | select(([.assets[]|select(.name=="SHA256SUMS.txt")]|length)==1)]
    | group_by(.machine) | map(max_by([{stable:2,rc:1,dev:0}[.channel], (.version|split(".")|map(tonumber))]))
    | sort_by(.machine)
  ' "$work_dir/catalog.json" > "$work_dir/latest.json" || fail 'Cannot select latest machine releases.'
}

verify_cached() {
  local cached="$1" tag="$2" expected actual archive
  archive="$cached/double-$tag.tar.gz"
  no_symlinks "$archive"; no_symlinks "$cached/SHA256SUMS.txt"; no_symlinks "$cached/release.json"
  [ -f "$archive" ] && [ -f "$cached/SHA256SUMS.txt" ] && [ -f "$cached/release.json" ] || fail 'Incomplete cached release.'
  jq -e --arg tag "$tag" '.tag==$tag' "$cached/release.json" >/dev/null || fail 'Cached metadata mismatch.'
  expected=$(awk -v name="double-$tag.tar.gz" '$2==name || $2=="*"name {print $1}' "$cached/SHA256SUMS.txt")
  [[ "$expected" =~ ^[a-fA-F0-9]{64}$ ]] || fail 'Invalid cached checksum.'
  if command -v sha256sum >/dev/null; then actual=$(sha256sum "$archive"|awk '{print $1}');else actual=$(shasum -a 256 "$archive"|awk '{print $1}');fi
  [ "$(printf '%s' "$expected"|tr A-F a-f)" = "$actual" ] || fail 'Cached checksum mismatch.'
  validate_archive "$archive"
}

download_all() {
  local row tag result=0 script_path
  channel=all;machine='';version='';latest_machines
  [ "$(jq 'length' "$work_dir/latest.json")" -gt 0 ] || fail 'No published machine packages available.'
  jq -c '.[]' "$work_dir/latest.json" > "$work_dir/bulk"
  script_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)/$(basename "${BASH_SOURCE[0]}")"
  state_init
  while IFS= read -r row; do
    machine=$(printf '%s' "$row"|jq -r .machine); tag=$(printf '%s' "$row"|jq -r .tag)
    if [ -d "$state/releases/$tag" ]; then
      if (verify_cached "$state/releases/$tag" "$tag");then printf 'Verified cached: %s\n' "$tag";else result=1;fi
    elif ! bash "$script_path" download --machine "$machine" --version "$(printf '%s' "$row"|jq -r .version)" --channel "$(printf '%s' "$row"|jq -r .channel)"; then result=1; fi
  done < "$work_dir/bulk"
  return "$result"
}

select_agents() {
  local agent_scan_mode=found detected_agents=('') detected answer=''
  local doctor_heading='' doctor_ok='' doctor_warning='' doctor_reset=''
  selected_agents=()
  if [ -n "$agent" ];then selected_agents+=("$agent");return;fi
  selected_agents+=(shared)
  if [ -t 1 ] && [ "${TERM:-}" != dumb ] && [ -z "${NO_COLOR+x}" ];then
    doctor_heading=$'\033[1;36m';doctor_ok=$'\033[32m';doctor_warning=$'\033[33m';doctor_reset=$'\033[0m'
  fi
  doctor_agents
  if [ "${#detected_agents[@]}" -le 1 ];then
    action_printf warning 'No agents detected; installing shared .agents/skills only.\n';return
  fi
  action_printf warning 'Detection is based on local evidence; it does not verify agent login or skill loading.\n'
  if [ ! -t 0 ];then
    action_printf warning 'Non-interactive input; installing shared .agents/skills only. Use --agent for an explicit integration.\n';return
  fi
  action_printf info 'Add integrations for all detected agents? [y/N] '
  if ! IFS= read -r answer;then answer='';fi
  case "$answer" in
    y|Y|yes|YES)
      for detected in "${detected_agents[@]}";do
        case "$detected" in
          claude) selected_agents+=(claude) ;;
          # These agents discover the common Agent Skills root; one copy is enough.
          ''|codex|cursor|copilot|gemini|opencode|cascade|pi) ;;
        esac
      done
      action_printf info 'Selected: shared .agents/skills for compatible agents; dedicated roots where required.\n'
      ;;
    *) action_printf info 'Selected: shared .agents/skills only.\n' ;;
  esac
}

integrate_selected_agents() {
  local a result=0
  # Payload commits independently; every agent owns its own lock and rollback.
  if [ -n "$mutation_lock" ];then rmdir "$mutation_lock";mutation_lock='';fi
  for a in "${add_agents[@]}";do
    if (
      work_dir=$(mktemp -d "${TMPDIR:-/tmp}/double-installer.XXXXXX")
      transaction='';mutation_lock='';trap cleanup EXIT
      attach_agent "$a"
    );then
      action_printf success 'Agent registration OK: %s / %s\n' "$machine" "$a"
    else
      action_printf error 'Agent registration FAILED: %s / %s; other registrations retained.\n' "$machine" "$a" >&2
      result=1
    fi
  done
  return "$result"
}

refresh_integrations() {
  local registered a add_agents=()
  registered=$(jq --arg p "$project" --arg m "$machine" '.installations[]|select(.project==$p and .machine==$m)' "$registry")
  printf '%s' "$registered"|jq -r '.integrations[]?.agent' > "$work_dir/refresh-agents"
  while IFS= read -r a;do
    [ -z "${agent:-}" ] || [ "$agent" = "$a" ] || continue
    add_agents+=("$a")
  done < "$work_dir/refresh-agents"
  integrate_selected_agents
}

agent_root() {
  case "$1" in
    shared|codex) if [ "${integration_scope:-global}" = project ];then agent_dir="$project/.agents";else agent_dir="$HOME/.agents";fi ;;
    claude) if [ "${integration_scope:-global}" = project ];then agent_dir="$project/.claude";else agent_dir="${CLAUDE_CONFIG_DIR:-$HOME/.claude}";fi ;;
    *) usage_error 'Supported agents: codex, claude.' ;;
  esac
  agent_dir="${agent_dir%/}"
  case "$agent_dir" in /*) ;; *) usage_error 'Agent directory must be absolute (use a Git Bash path on Windows).' ;; esac
  case "$agent_dir" in *$'\n'*|*$'\r'*|*$'\t'*|*'<'*|*'>'*) usage_error 'Unsupported agent path characters.' ;; esac
  [ "$agent_dir" != / ] || usage_error 'Agent directory cannot be filesystem root.'
  [ -d "$(dirname "$agent_dir")" ] || usage_error 'Agent directory parent must already exist.'
  no_symlinks "$agent_dir/skills/$machine/SKILL.md"
}

integration_check() {
  # Existing external inventory has strict generated names and directory scopes.
  printf '%s' "$1" | jq -e '
    . as $r | (.integrations // []) as $i | ($i|type)=="array" and
    all($i[]; (.agent=="shared" or .agent=="codex" or .agent=="claude") and
      (.root|type)=="string" and (.root|startswith("/")) and .root!="/" and
      (.root|explode|all(.>=32)) and .file==("skills/"+$r.machine+"/SKILL.md") and
      (.directories|type)=="array" and all(.directories[]; type=="string")) and
    ([$i[].agent]|length)==([$i[].agent]|unique|length)
  ' >/dev/null || fail 'Invalid agent integration inventory.'
  local line target
  printf '%s' "$1"|jq -c '.integrations[]?' > "$work_dir/check-integrations"
  while IFS= read -r line; do
    target=$(printf '%s' "$line"|jq -r '.root+"/"+.file');no_symlinks "$target"
    printf '%s' "$line" | jq -e '. as $i | all(.directories[]; .==$i.root or .==($i.root+"/skills") or .==($i.root+"/skills/"+($i.file|split("/")[1])))' >/dev/null || fail 'Invalid agent directory inventory.'
  done < "$work_dir/check-integrations"
}

external_snapshot() {
  local target n
  target=$(dirname "$1")
  mkdir -p "$transaction/external"
  [ -f "$transaction/external-paths" ] || : > "$transaction/external-paths"
  n=$(wc -l < "$transaction/external-paths"|tr -d ' ')
  if [ -e "$target" ]; then
    [ -d "$target" ] || fail 'Agent skill root is not a directory.'
    [ -z "$(find "$target" ! -type d ! -type f -print)" ] || fail 'Agent directory contains unsupported entries.'
    cp -Rp -- "$target" "$transaction/external/$n" || fail 'Cannot preserve agent directory.'
  fi
  printf '%s\n' "$target" >> "$transaction/external-paths"
}

detach_registered_agents() {
  local row="$1" item result=0
  printf '%s' "$row"|jq -c '.integrations[]?' > "$work_dir/detach-agents"
  if [ -n "$mutation_lock" ];then rmdir "$mutation_lock";mutation_lock='';fi
  while IFS= read -r item;do
    if (
      work_dir=$(mktemp -d "${TMPDIR:-/tmp}/double-installer.XXXXXX")
      transaction='';mutation_lock='';trap cleanup EXIT
      state_init;mutation_begin
      integration_check "$row"
      transaction=$(mktemp -d "$state/transactions/detach.XXXXXX");transaction_kind=integration
      transaction_project="$project";: > "$transaction/directories"
      target=$(printf '%s' "$item"|jq -r '.root+"/"+.file')
      external_snapshot "$target"
      if ! jq -e --arg p "$project" --arg m "$machine" --arg a "$(printf '%s' "$item"|jq -r .agent)" --arg target "$target" \
        'any(.installations[]|select(.project==$p and .machine==$m)|.integrations[]?; .agent!=$a and (.root+"/"+.file)==$target)' "$registry" >/dev/null;then
        rm -f -- "$target" || fail 'Cannot remove agent entry point.'
      fi
      jq --arg p "$project" --arg m "$machine" --arg a "$(printf '%s' "$item"|jq -r .agent)" \
        '(.installations[]|select(.project==$p and .machine==$m)).integrations |= map(select(.agent!=$a))' "$registry" > "$state/registry.new" || fail 'Cannot stage registry update.'
      mv "$state/registry.new" "$registry" || fail 'Cannot commit registry update.'
      done_transaction="$transaction";transaction='';rm -rf -- "$done_transaction"
      prune_integrations "$(printf '%s' "$row"|jq --arg a "$(printf '%s' "$item"|jq -r .agent)" '.integrations |= map(select(.agent==$a))')"
    );then
      printf 'Agent removal OK: %s / %s\n' "$machine" "$(printf '%s' "$item"|jq -r .agent)"
    else
      printf 'Agent removal FAILED: %s / %s; successful removals retained.\n' "$machine" "$(printf '%s' "$item"|jq -r .agent)" >&2
      result=1
    fi
  done < "$work_dir/detach-agents"
  return "$result"
}

remove_integrations() {
  local row="$1" line target
  integration_check "$row"
  printf '%s' "$row" | jq -c '.integrations[]?' > "$work_dir/remove-integrations"
  while IFS= read -r line; do
    target=$(printf '%s' "$line"|jq -r '.root+"/"+.file')
    external_snapshot "$target"
    if ! jq -e --arg p "$project" --arg m "$machine" --arg a "$(printf '%s' "$line"|jq -r .agent)" --arg target "$target" \
      'any(.installations[]|select(.project==$p and .machine==$m)|.integrations[]?; .agent!=$a and (.root+"/"+.file)==$target)' "$registry" >/dev/null;then
      rm -f -- "$target" || fail 'Cannot remove agent entry point.'
    fi
  done < "$work_dir/remove-integrations"
}

prune_integrations() {
  local row="$1" dir
  printf '%s' "$row"|jq -r '.integrations[]?.directories[]'|LC_ALL=C sort -ru > "$work_dir/prune-integrations"
  while IFS= read -r dir; do no_symlinks "$dir";rmdir "$dir" 2>/dev/null || true;done < "$work_dir/prune-integrations"
}

attach_agent() {
  local agent="$1" row target existing backup dir dirs entry integration_scope
  state_init;mutation_begin
  row=$(jq --arg p "$project" --arg m "$machine" '.installations[]|select(.project==$p and .machine==$m)' "$registry")
  integration_check "$row"
  integration_scope=$(printf '%s' "$row"|jq -r '.scope // "project"')
  agent_root "$agent";target="$agent_dir/skills/$machine/SKILL.md"
  existing=$(printf '%s' "$row"|jq -r --arg a "$agent" '.integrations[]?|select(.agent==$a)|.root+"/"+.file')
  # Codex uses the shared root too; reuse owned files without claiming foreign ones.
  if [ -z "$existing" ];then
    existing=$(printf '%s' "$row"|jq -r --arg target "$target" '[.integrations[]?|select((.root+"/"+.file)==$target)][0]|if .==null then empty else .root+"/"+.file end')
  fi
  [ -z "$existing" ] || [ "$existing" = "$target" ] || fail 'Agent location changed; remove its previous integration first.'
  [ ! -e "$(dirname "$target")" ] || [ "$existing" = "$target" ] || fail "Unowned skill directory exists: $(dirname "$target")"
  entry="$project/.double/skills/$machine/SKILL.md"
  [ -f "$entry" ] || entry="$project/.double/workflows/$machine/$machine-workflow.md"
  [ -f "$entry" ] || fail "Machine has no published skill/workflow entry point: $machine"
  no_symlinks "$entry"
  cat > "$work_dir/agent-skill.md" <<EOF || fail 'Cannot prepare agent entry point.'
---
name: $machine
description: Use Double $machine workflows and templates when the user asks to work with this machine.
---

Read and follow the [canonical machine entry point](<$entry>).
If an update moves that entry, use the published skill at
<$project/.double/skills/$machine/SKILL.md> or workflow at
<$project/.double/workflows/$machine/$machine-workflow.md>.
Machine operating materials are rooted at <$project/.double/>.
Resolve .double/ operating references against that managed root, including
references to other installed machines. Keep user ideas/, goals/, knowledge/
and project files in the user's active project, never in the managed root.
This skill is an integration entry point, not a background agent or daemon.
EOF
  if [ -f "$target" ] && cmp -s "$work_dir/agent-skill.md" "$target" &&
    printf '%s' "$row"|jq -e --arg a "$agent" 'any(.integrations[]?;.agent==$a)' >/dev/null;then
    action_printf success 'Agent integration already current: %s / %s\n' "$machine" "$agent";return
  fi
  # Back up user edits before replacing a registered wrapper.
  if [ -f "$target" ] && ! cmp -s "$work_dir/agent-skill.md" "$target"; then
    no_symlinks "$state/backups";mkdir -p "$state/backups"
    backup=$(mktemp -d "$state/backups/backup.XXXXXX")
    printf '%s\n' "$row" > "$backup/installation.json"
    printf 'skills/%s\n' "$machine" > "$work_dir/agent-backup-roots"
    snapshot_directories "$agent_dir" "$work_dir/agent-backup-roots" "$backup"
    printf 'complete\n' > "$backup/complete"
    printf '%s\n' "$target" > "$backup/agent-path"
    action_printf warning 'Agent entry point backup: %s\n' "$backup"
  fi
  transaction=$(mktemp -d "$state/transactions/integrate.XXXXXX");transaction_kind=integration
  transaction_project="$project"
  external_snapshot "$target"
  : > "$transaction/directories"
  dir=$(dirname "$target")
  while [ ! -d "$dir" ]; do printf '%s\n' "$dir" >> "$transaction/directories";dir=$(dirname "$dir");done
  mkdir -p "$(dirname "$target")"
  cp -p -- "$work_dir/agent-skill.md" "$target" || fail 'Cannot write agent entry point.'
  # Carry ownership of shared created directories to the last remaining skill.
  jq -Rn '[inputs]' < "$transaction/directories" > "$work_dir/agent-dirs.json"
  jq --arg p "$project" --arg m "$machine" --arg a "$agent" --arg root "$agent_dir" --arg file "skills/$machine/SKILL.md" --arg scope "$integration_scope" --slurpfile d "$work_dir/agent-dirs.json" '
    . as $reg | ([$d[0][]] + [.installations[].integrations[]? | select(.root==$root) | .directories[] | select(.==$root or .==($root+"/skills") or .==($root+"/skills/"+$m))])|unique as $dirs |
    $reg | (.installations[]|select(.project==$p and .machine==$m)) |=
      (.scope=$scope | .integrations=((.integrations // [] | map(select(.agent!=$a))) + [{agent:$a,root:$root,file:$file,directories:$dirs}]))
  ' "$registry" > "$state/registry.new" || fail 'Cannot stage registry update.'
  mv "$state/registry.new" "$registry" || fail 'Cannot commit registry update.'
  local done_transaction="$transaction";transaction='';rm -rf -- "$done_transaction"
  action_printf success 'Integrated %s with %s: %s\n' "$machine" "$agent" "$target"
  offer_backup_cleanup "${backup:-}"
}

global_add() {
  local wanted_machine="$machine" policy="$channel" row a result=0 integration_scope=global
  local selected_agents=() add_agents=()
  state_init;select_agents
  add_agents=("${selected_agents[@]}")
  channel="${policy:-all}";machine="$wanted_machine";latest_machines
  [ "$(jq 'length' "$work_dir/latest.json")" -gt 0 ] || fail 'No published machine packages available.'
  jq -c '.[]' "$work_dir/latest.json" > "$work_dir/global-machines"
  no_symlinks "$state/global";mkdir -p "$state/global";project=$(cd "$state/global" && pwd -P)
  while IFS= read -r row;do
    machine=$(printf '%s' "$row"|jq -r .machine)
    registry_check
    if [ -f "$registry" ] && jq -e --arg p "$project" --arg m "$machine" '.installations[]|select(.project==$p and .machine==$m)' "$registry" >/dev/null;then
      if ! integrate_selected_agents;then result=1;fi
    else
      if ! (
        work_dir=$(mktemp -d "${TMPDIR:-/tmp}/double-installer.XXXXXX")
        trap cleanup EXIT
        channel=$(printf '%s' "$row"|jq -r .channel);version=$(printf '%s' "$row"|jq -r .version)
        add_machine
      );then result=1;fi
    fi
  done < "$work_dir/global-machines"
  return "$result"
}

global_update() {
  local row result=0 script_path
  state_init;registry_check
  [ -f "$registry" ] || fail 'No global installations; use add --global first.'
  jq -c --arg m "$machine" --arg a "$agent" '.installations[]|select(.scope=="global")|select($m=="" or .machine==$m)|select($a=="" or any(.integrations[]?;.agent==$a))' "$registry" > "$work_dir/global-updates"
  [ -s "$work_dir/global-updates" ] || fail 'No matching global installations; use add --global first.'
  script_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)/$(basename "${BASH_SOURCE[0]}")"
  while IFS= read -r row;do
    local args=(update --project "$(printf '%s' "$row"|jq -r .project)" --machine "$(printf '%s' "$row"|jq -r .machine)")
    [ -z "$channel" ] || args+=(--channel "$channel")
    [ "$non_interactive" = false ] || args+=(--non-interactive)
    if ! bash "$script_path" "${args[@]}";then result=1;fi
  done < "$work_dir/global-updates"
  return "$result"
}

global_remove() {
  local row remaining target filtered
  state_init;project="$state/global";project_init;mutation_begin
  row=$(jq --arg p "$project" --arg m "$machine" '.installations[]|select(.project==$p and .machine==$m)' "$registry")
  [ -n "$row" ] || fail 'Global machine is not registered.'
  integration_check "$row"
  if [ -n "$agent" ];then
    filtered=$(printf '%s' "$row"|jq --arg a "$agent" '.integrations |= map(select(.agent==$a))')
    [ "$(printf '%s' "$filtered"|jq '.integrations|length')" -gt 0 ] || fail 'Agent integration is not registered.'
    remaining=$(printf '%s' "$row"|jq --arg a "$agent" '[.integrations[]|select(.agent!=$a)]|length')
    if [ "$remaining" -gt 0 ];then
      confirm_action
      transaction=$(mktemp -d "$state/transactions/detach.XXXXXX");transaction_kind=integration;transaction_project="$project"
      : > "$transaction/directories"
      remove_integrations "$filtered"
      jq --arg p "$project" --arg m "$machine" --arg a "$agent" '(.installations[]|select(.project==$p and .machine==$m)).integrations |= map(select(.agent!=$a))' "$registry" > "$state/registry.new" || fail 'Cannot stage registry update.'
      mv "$state/registry.new" "$registry" || fail 'Cannot commit registry update.'
      local done_transaction="$transaction";transaction='';rm -rf -- "$done_transaction"
      prune_integrations "$filtered";printf 'Removed %s integration for %s\n' "$machine" "$agent";return
    fi
  fi
  remove_machine
}

command_name="${1:-help}"
# Help is dispatched before dependencies, network access or state mutation.
for argument in "${@:2}"; do
  case "$argument" in --help|--explain|-h) explain_command "$command_name" | format_explanation; exit 0 ;; esac
done
[ "$command_name" != install ] || command_name=download
action_colors=false
case "$command_name" in
  add|update|update-all)
    if [ -t 1 ] && [ "${TERM:-}" != dumb ] && [ -z "${NO_COLOR+x}" ];then action_colors=true;fi ;;
esac
case "$command_name" in
  help|--help|-h) usage ;;
  explain|--explain) [ "$#" -eq 1 ] || usage_error 'explain accepts no arguments.';explain_all | format_explanation ;;
  doctor)
    [ "$#" -eq 1 ] || usage_error 'doctor accepts no arguments.'
    doctor
    ;;
  releases|download)
    shift
    machine='' channel='stable' version='' all=false explicit_channel=false
    if [ "$command_name" = download ] && [ "$#" -eq 0 ]; then all=true; fi
    while [ "$#" -gt 0 ]; do
      if [ "$1" = --all ];then [ "$command_name" = download ] || usage_error '--all requires download/install';all=true;shift;continue;fi
      [ "$#" -ge 2 ] || usage_error "Missing value for $1"
      case "$1" in
        --machine) machine="$2" ;;
        --channel) channel="$2";explicit_channel=true ;;
        --version) [ "$command_name" = download ] || usage_error '--version requires download'; version="$2" ;;
        *) usage_error "Unknown option: $1" ;;
      esac
      shift 2
    done
    case "$channel" in stable|rc|dev) ;; *) usage_error 'Channel must be stable, rc, or dev.' ;; esac
    [ -z "$machine" ] || [[ "$machine" =~ ^[a-z0-9][a-z0-9-]*$ ]] || usage_error 'Invalid machine identifier.'
    [ -z "$version" ] || [[ "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] || usage_error 'Invalid numeric version.'
    [ "$command_name" != download ] || [ "$all" = true ] || [ -n "$machine" ] || usage_error 'download requires --machine.'
    doctor >/dev/null || fail 'Install missing dependencies before proceeding.'
    work_dir=$(mktemp -d "${TMPDIR:-/tmp}/double-installer.XXXXXX")
    if [ "$all" = true ];then
      [ -z "$machine$version" ] && [ "$explicit_channel" = false ] || usage_error '--all cannot be combined with --machine, --version or --channel.'
      download_all;exit $?
    fi
    release_catalog
    if [ "$command_name" = releases ]; then
      if [ "$(jq 'length' "$work_dir/catalog.json")" -eq 0 ]; then
        printf 'No published %s machine releases available.\n' "$channel"
      else
        {
          printf 'MACHINE\tVERSION\tCHANNEL\tTAG\n'
          jq -r '.[] | [.machine,.version,.channel,.tag] | @tsv' "$work_dir/catalog.json"
        } | format_releases
      fi
    else
      download_release
    fi
    ;;
  add|remove)
    shift
    project='' machine='' version='' channel='' yes=false global=false agent='' non_interactive=false
    integration_scope=project;add_agents=();selected_agents=()
    while [ "$#" -gt 0 ]; do
      if [ "$1" = --global ];then global=true;shift;continue;fi
      if [ "$1" = --yes ]; then
        yes=true;shift;continue
      fi
      [ "$#" -ge 2 ] || usage_error "Missing value for $1"
      case "$1" in
        --project) project="$2" ;; --machine) machine="$2" ;;
        --agent) agent="$2" ;;
        --version) [ "$command_name" = add ] || usage_error '--version is only for add';version="$2" ;;
        --channel) [ "$command_name" = add ] || usage_error '--channel is only for add';channel="$2" ;;
        *) usage_error "Unknown option: $1" ;;
      esac
      shift 2
    done
    [ "$global" = true ] || [ -n "$project" ] || usage_error "Provide --project or --global."
    if [ "$global" != true ] || [ "$command_name" = remove ];then [ -n "$machine" ] || usage_error 'Provide --machine.';fi
    [ -z "$machine" ] || [[ "$machine" =~ ^[a-z0-9][a-z0-9-]*$ ]] || usage_error 'Invalid machine.'
    case "$channel" in ''|stable|rc|dev) ;; *) usage_error 'Invalid channel.' ;; esac
    [ -z "$version" ] || [[ "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]] || usage_error 'Invalid version.'
    doctor >/dev/null || fail 'Missing dependencies.'
    work_dir=$(mktemp -d "${TMPDIR:-/tmp}/double-installer.XXXXXX")
    [ -z "$agent" ] || [ "$agent" = codex ] || [ "$agent" = claude ] || usage_error 'Supported agents: codex, claude.'
    if [ "$global" = true ];then
      [ -z "$project" ] || usage_error '--global conflicts with --project'
      [ -z "$version" ] || usage_error '--version is currently supported only for project add.'
      if [ "$command_name" = add ];then global_add;else global_remove;fi
    elif [ "$command_name" = add ];then
      project_init
      select_agents;add_agents=("${selected_agents[@]}")
      add_machine
    else
      [ -z "$agent" ] || usage_error '--agent on remove requires --global; project remove detaches all registered agents.'
      remove_machine
    fi
    ;;
  status)
    status_json=false
    if [ "$#" -eq 2 ] && [ "$2" = --json ]; then status_json=true
    elif [ "$#" -ne 1 ]; then usage_error 'Usage: status [--json]'; fi
    type -P jq >/dev/null 2>&1 || fail 'Install jq to read local status.'
    state_init;registry_check
    no_symlinks "$state/releases"
    color_reset='' color_heading='' color_stable='' color_rc='' color_dev='' color_muted=''
    if [ "$status_json" = false ] && [ -t 1 ] && [ "${TERM:-}" != dumb ] && [ -z "${NO_COLOR+x}" ]; then
      color_reset=$'\033[0m';color_heading=$'\033[1;36m'
      color_stable=$'\033[32m';color_rc=$'\033[33m';color_dev=$'\033[35m';color_muted=$'\033[2m'
    fi
    if [ "$status_json" = false ]; then printf '%sDownloaded machine archives:%s\n' "$color_heading" "$color_reset"; fi
    archive_count=0;archive_json='';archive_separator=''
    for cached in "$state/releases/"*; do
      [ -d "$cached" ] && [ ! -L "$cached" ] || continue
      tag=${cached##*/}
      [[ "$tag" =~ ^(machine-[a-z0-9-]+)-([0-9]+\.[0-9]+\.[0-9]+)(-(rc|dev))?$ ]] || continue
      machine=${BASH_REMATCH[1]};version=${BASH_REMATCH[2]};channel=${BASH_REMATCH[4]:-stable}
      archive="$cached/double-$tag.tar.gz"
      [ -f "$archive" ] && [ ! -L "$archive" ] || continue
      if [ "$status_json" = true ]; then
        archive_row=$(jq -cn --arg machine "$machine" --arg version "$version" --arg channel "$channel" --arg archive "$archive" \
          '{machine:$machine,version:$version,channel:$channel,archive:$archive}')
        archive_json="$archive_json$archive_separator$archive_row";archive_separator=','
        continue
      fi
      if [ "$archive_count" -eq 0 ]; then
        printf '%s  %-32s  %-14s  %-7s  %s%s\n' "$color_heading" 'MACHINE' 'VERSION' 'CHANNEL' 'ARCHIVE' "$color_reset"
        printf '  %-32s  %-14s  %-7s  %s\n' '-------' '-------' '-------' '-------'
      fi
      case "$channel" in stable) channel_color=$color_stable ;; rc) channel_color=$color_rc ;; dev) channel_color=$color_dev ;; esac
      printf '  %-32s  %-14s  %s%-7s%s  %s\n' "$machine" "$version" "$channel_color" "$channel" "$color_reset" "$archive"
      archive_count=$((archive_count + 1))
    done
    if [ "$status_json" = true ]; then
      if [ -f "$registry" ]; then
        # Bash opens Unicode paths; native Windows jq --slurpfile does not.
        jq -M --argjson archives "[$archive_json]" \
          '{archives:$archives,installations:.installations}' < "$registry"
      else
        jq -Mn --argjson archives "[$archive_json]" '{archives:$archives,installations:[]}'
      fi
    else
      [ "$archive_count" -gt 0 ] || printf '%sNo downloaded machine archives.%s\n' "$color_muted" "$color_reset"
      printf '\n%sRegistered installations:%s\n' "$color_heading" "$color_reset"
      if [ ! -f "$registry" ] || [ "$(jq '.installations | length' "$registry")" -eq 0 ];then
        printf '%sNo registered installations.%s\n' "$color_muted" "$color_reset"
      else
        jq -r --arg heading "$color_heading" --arg reset "$color_reset" \
          --arg stable "$color_stable" --arg rc "$color_rc" --arg dev "$color_dev" '
          .installations | group_by(.project) | .[] |
          ("  " + $heading + .[0].project + $reset),
          (sort_by(.machine)[] | "    - " + .machine + "  " + .version + "  (" +
            ({stable:$stable,rc:$rc,dev:$dev}[.channel]) + .channel + $reset + ")")
        ' "$registry"
      fi
    fi
    ;;
  update|update-all|backups-clean)
    shift;project='' machine='' channel='' version='' yes=false non_interactive=false global=false agent=''
    while [ "$#" -gt 0 ]; do
      case "$1" in
        --global) [ "$command_name" = update ] || usage_error '--global is for update';global=true;shift;continue ;;
        --yes) [ "$command_name" = backups-clean ] || usage_error '--yes is for backup cleanup';yes=true;shift;continue ;;
        --non-interactive) [ "$command_name" != backups-clean ] || usage_error 'Use --yes for cleanup';non_interactive=true;shift;continue ;;
      esac
      [ "$#" -ge 2 ] || usage_error "Missing value for $1"
      case "$1" in
        --agent) agent="$2" ;;
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
    [ -z "$agent" ] || [ "$global" = true ] || usage_error '--agent requires --global.'
    if [ "$global" = true ];then
      [ -z "$project" ] || usage_error '--global conflicts with --project'
      global_update
    elif [ "$command_name" = update ]; then
      [ -n "$project" ] && [ -n "$machine" ] || usage_error 'update requires --project and --machine.'
      update_machine
    elif [ "$command_name" = backups-clean ]; then
      [ -z "$project" ] || project_init
      clean_backups
    else
      state_init;registry_check
      [ -f "$registry" ] || { action_printf warning 'No registered installations.\n';exit 0; }
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
