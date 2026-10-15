#!/usr/bin/env bash
set -eu
source "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/test-log.sh"
phase_started=$SECONDS
test_log "START navigation tests"

script_dir="$(cd "$(dirname "$0")" && pwd)"
validator="$script_dir/../scripts/validate-machine-of-goals-navigation.py"
fixture_dir="$(mktemp -d "${TMPDIR:-/tmp}/machine-of-goals-navigation.XXXXXX")"
trap 'rm -rf "$fixture_dir"' EXIT HUP INT TERM

mkdir -p "$fixture_dir/goals/demo/run" "$fixture_dir/goals/demo/realizations"
cat > "$fixture_dir/goals/demo/demo.md" <<'EOF'
---
id: demo
kind: goal-artifact
project-id: demo-project
goal-scope: main-goal
---
<a id="demo"></a>
# Goal: Demo
## Machine of Goals Artifacts
- [Plan](./plan.md#demo-plan)
- [Paths](./path-options.md#demo-path-options)
- [Decision](./realization-decision.md#demo-realization-decision)
- [Realization](./realizations/demo-manual.md#demo-manual)
- [Runs](./run/index.md#demo-run-index)
EOF
cat > "$fixture_dir/goals/demo/path-options.md" <<'EOF'
---
id: demo-path-options
kind: path-options
project-id: demo-project
goal-id: demo
---
<a id="demo-path-options"></a>
# Paths
## Source Goal
- [Demo](./demo.md#demo)
<a id="path-demo"></a>
### Path
- Path id: `path-demo`
- Plan element: [S01](./plan.md#stage-s01)
EOF
cat > "$fixture_dir/goals/demo/plan.md" <<'EOF'
---
id: demo-plan
kind: plan-artifact
project-id: demo-project
goal-id: demo
---
<a id="demo-plan"></a>
# Plan
## Plan Summary
- [Demo](./demo.md#demo)
<a id="stage-s01"></a>
### Stage
- Stage id: `S01`
EOF
cat > "$fixture_dir/goals/demo/realization-decision.md" <<'EOF'
---
id: demo-realization-decision
kind: realization-decision
project-id: demo-project
---
<a id="demo-realization-decision"></a>
# Decision
- Selected immutable plan revision: [r1](./plan.md#demo-plan)
- Selected path: [path](./path-options.md#path-demo)
- Realization: [manual](./realizations/demo-manual.md#demo-manual)
EOF
cat > "$fixture_dir/goals/demo/realizations/demo-manual.md" <<'EOF'
---
id: demo-manual
kind: realization-artifact
project-id: demo-project
realization-revision: 1
---
<a id="demo-manual"></a>
# Realization
- Plan: [plan](../plan.md#demo-plan)
- Decision: [decision](../realization-decision.md#demo-realization-decision)
- Path: [path](../path-options.md#path-demo)
- Runs: [index](../run/index.md#demo-run-index)
<a id="demo-manual-revision-1"></a>
## Revision 1
EOF
cat > "$fixture_dir/goals/demo/run/index.md" <<'EOF'
---
id: demo-run-index
kind: run-index
project-id: demo-project
---
<a id="demo-run-index"></a>
# Runs
- [Run](./demo-manual--20260915T120000Z.md#demo-run) from [realization](../realizations/demo-manual.md#demo-manual)
EOF
cat > "$fixture_dir/goals/demo/run/demo-manual--20260915T120000Z.md" <<'EOF'
---
id: demo-run
kind: plan-run
project-id: demo-project
realization-artifact: goals/demo/realizations/demo-manual.md
---
<a id="demo-run"></a>
# Run
- Plan: [plan](../plan.md#demo-plan)
- Decision: [decision](../realization-decision.md#demo-realization-decision)
- Path: [path](../path-options.md#path-demo)
- Realization revision: [revision 1](../realizations/demo-manual.md#demo-manual-revision-1)
- Immutable revision locator: local revision 1
EOF

python3 "$validator" "$fixture_dir/goals"

sed 's|./plan.md#stage-s01|./missing.md#stage-s01|' \
  "$fixture_dir/goals/demo/path-options.md" > "$fixture_dir/broken.md"
if python3 "$validator" "$fixture_dir/broken.md" >/dev/null 2>&1; then
  echo "validator accepted a broken link" >&2
  exit 1
fi

broken_run="$fixture_dir/goals/demo/run/broken-run.md"
sed '/Realization revision:/d' \
  "$fixture_dir/goals/demo/run/demo-manual--20260915T120000Z.md" > "$broken_run"
if python3 "$validator" "$broken_run" >/dev/null 2>&1; then
  echo "validator accepted a run without its realization artifact link" >&2
  exit 1
fi

echo "Machine of Goals navigation validator tests passed"

test_log "END navigation tests; elapsed=$((SECONDS-phase_started))s"
