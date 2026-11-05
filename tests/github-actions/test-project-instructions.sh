#!/usr/bin/env bash
set -euo pipefail
repo=$(cd "$(dirname "$0")/../.." && pwd)
installer="$repo/scripts/double-installer.sh"
fixture=$(mktemp -d "${TMPDIR:-/tmp}/double-instructions.XXXXXX")
fixture=$(cd "$fixture" && pwd -P)
trap 'rm -rf "$fixture"' EXIT
export DOUBLE_STATE_DIR="$fixture/state"
project="$fixture/project"; source_dir="$fixture/source"
mkdir -p "$project" "$source_dir/.double/skills/machine-of-ideas" "$source_dir/.double/skills/machine-of-goals"
printf 'idea skill\n' > "$source_dir/.double/skills/machine-of-ideas/SKILL.md"
printf 'goal skill\n' > "$source_dir/.double/skills/machine-of-goals/SKILL.md"
dev() { bash "$installer" dev --source "$source_dir" --project "$project" --machine "$1" --yes >/dev/null; }
remove() { bash "$installer" remove --project "$project" --machine "$1" --yes >/dev/null; }
dev machine-of-ideas
grep -F '.double/skills/machine-of-ideas/SKILL.md' "$project/AGENTS.md" >/dev/null
grep -Fx '@AGENTS.md' "$project/CLAUDE.md" >/dev/null
cp "$project/AGENTS.md" "$fixture/agents-before";cp "$project/CLAUDE.md" "$fixture/claude-before"
dev machine-of-ideas
cmp "$fixture/agents-before" "$project/AGENTS.md";cmp "$fixture/claude-before" "$project/CLAUDE.md"
printf 'User agent instructions\n' >> "$project/AGENTS.md"
printf 'User Claude instructions\n' >> "$project/CLAUDE.md"
dev machine-of-goals
grep -F 'User agent instructions' "$project/AGENTS.md" >/dev/null
grep -F 'User Claude instructions' "$project/CLAUDE.md" >/dev/null
grep -F '.double/skills/machine-of-goals/SKILL.md' "$project/AGENTS.md" >/dev/null
remove machine-of-ideas
! grep -F '.double/skills/machine-of-ideas/SKILL.md' "$project/AGENTS.md"
grep -F '.double/skills/machine-of-goals/SKILL.md' "$project/AGENTS.md" >/dev/null
cp "$project/AGENTS.md" "$fixture/valid"
printf '<!-- Double project integration: begin -->\n' >> "$project/AGENTS.md"
cp "$project/AGENTS.md" "$fixture/damaged"
if dev machine-of-goals 2>/dev/null;then exit 1;fi
cmp "$fixture/damaged" "$project/AGENTS.md"
if remove machine-of-goals 2>/dev/null;then exit 1;fi
cmp "$fixture/damaged" "$project/AGENTS.md"
cp "$fixture/valid" "$project/AGENTS.md"
# Editing the section body and an unclosed boundary are both refused.
sed 's/## Double workflows/## User-modified workflows/' "$fixture/valid" > "$project/AGENTS.md"
cp "$project/AGENTS.md" "$fixture/damaged"
if dev machine-of-goals 2>/dev/null;then exit 1;fi
cmp "$fixture/damaged" "$project/AGENTS.md"
printf 'User text\n<!-- Double project integration: begin -->\n' > "$project/AGENTS.md"
cp "$project/AGENTS.md" "$fixture/damaged"
if dev machine-of-goals 2>/dev/null;then exit 1;fi
cmp "$fixture/damaged" "$project/AGENTS.md"
cp "$fixture/valid" "$project/AGENTS.md"
remove machine-of-goals
grep -F 'User agent instructions' "$project/AGENTS.md" >/dev/null
grep -F 'User Claude instructions' "$project/CLAUDE.md" >/dev/null
! grep -F '@AGENTS.md' "$project/CLAUDE.md"
printf 'Existing machine-of-ideas mention\n' > "$project/AGENTS.md"
printf 'Personal\n@AGENTS.md\n' > "$project/CLAUDE.md"
dev machine-of-ideas
[ "$(grep -c '^@AGENTS.md$' "$project/CLAUDE.md")" -eq 1 ]
remove machine-of-ideas
grep -Fx '@AGENTS.md' "$project/CLAUDE.md" >/dev/null
grep -F 'Existing machine-of-ideas mention' "$project/AGENTS.md" >/dev/null
printf 'PASS project instructions\n'
