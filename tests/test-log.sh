#!/usr/bin/env bash
# Test-only phase logging; UTC timestamps, no product runtime dependency.
test_log() {
  printf '[%s] %s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$*"
}
