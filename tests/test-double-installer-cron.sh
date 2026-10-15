#!/usr/bin/env bash
# Real cron only on an explicitly designated disposable GitHub Linux runner.
set -euo pipefail
if [ "${GITHUB_ACTIONS:-}" != true ] || [ "${RUNNER_OS:-}" != Linux ] || [ "${DOUBLE_DISPOSABLE_CRON:-}" != 1 ]; then
  echo 'Refusing real cron test outside explicitly designated disposable GitHub Linux runner.' >&2
  exit 2
fi
repo="$(cd "$(dirname "$0")/.." && pwd -P)"
fixture="$(mktemp -d /tmp/double-real-cron.XXXXXX)"
export DOUBLE_STATE_DIR="$fixture/state"
installer="$repo/scripts/double-installer.sh"
original_present=false
if crontab -l > "$fixture/original" 2> "$fixture/read-error"; then
  original_present=true
elif ! grep -qi 'no crontab for' "$fixture/read-error"; then
  cat "$fixture/read-error" >&2
  exit 1
fi
cleanup() {
  result=$?
  trap - EXIT
  if [ "$original_present" = true ]; then
    crontab "$fixture/original" || result=1
  else
    # Restore absence, not merely an empty crontab.
    crontab -r || result=1
  fi
  rm -rf "$fixture"
  exit "$result"
}
trap cleanup EXIT
# Prove preservation of a distinct unrelated entry, without executing a workload.
cat "$fixture/original" > "$fixture/baseline"
printf '\n# unrelated CI sentinel\n' >> "$fixture/baseline"
crontab "$fixture/baseline"
bash "$installer" cron-add --schedule '* * * * *'
bash "$installer" cron-add --schedule '* * * * *'
# cron-add creates an empty registry. Remove only this verified test-owned
# empty registry so scheduled no-op emits its explicit completion message.
jq -e '.installations | length == 0' "$DOUBLE_STATE_DIR/installer/registry.json" >/dev/null
rm "$DOUBLE_STATE_DIR/installer/registry.json"
crontab -l > "$fixture/installed"
test "$(grep -c '# double-installer:' "$fixture/installed")" = 1
# Actual cron must launch the real update-all command, not a fake adapter.
# Empty isolated registry proves unattended no-op invocation without network.
deadline=$((SECONDS+150))
until [ -f "$DOUBLE_STATE_DIR/installer/cron.log" ] && grep -q 'No registered installations.' "$DOUBLE_STATE_DIR/installer/cron.log"; do
  if [ "$SECONDS" -ge "$deadline" ]; then
    cat "$DOUBLE_STATE_DIR/installer/cron.log" 2>/dev/null || true
    echo 'Current crontab:' >&2
    crontab -l >&2 || true
    ps -ef | grep '[c]ron' >&2 || true
    sudo journalctl --since '-5 minutes' --no-pager 2>/dev/null | grep -i -E 'cron|pam|runner' | tail -n 60 >&2 || true
    sudo tail -n 60 /var/log/syslog >&2 2>/dev/null || true
    echo 'Timed out waiting for actual scheduled update-all.' >&2
    exit 1
  fi
  sleep 2
done
cat "$DOUBLE_STATE_DIR/installer/cron.log"
bash "$installer" cron-remove
crontab -l > "$fixture/after"
cmp "$fixture/baseline" "$fixture/after"
bash "$installer" uninstall-all --yes
test ! -e "$DOUBLE_STATE_DIR/installer"
printf 'PASS: real cron launched unattended update-all, idempotent entry, removal and baseline preservation\n'
