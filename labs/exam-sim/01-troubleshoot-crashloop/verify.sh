#!/usr/bin/env bash
# Exit 0 only when Pod web is Ready and stable (not CrashLooping).
set -euo pipefail
# shellcheck source=../lib/common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/lib/common.sh"

require_cluster
NS=sim-crash
NAME=web

check_ns_exists "${NS}"
check_pod_ready "${NS}" "${NAME}"

# Not restarting aggressively (waitingRestartBackoff / CrashLoop)
restarts="$(kubectl -n "${NS}" get pod "${NAME}" -o jsonpath='{.status.containerStatuses[0].restartCount}' 2>/dev/null || echo 99)"
waiting="$(kubectl -n "${NS}" get pod "${NAME}" -o jsonpath='{.status.containerStatuses[0].state.waiting.reason}' 2>/dev/null || true)"
if [[ "${waiting}" == "CrashLoopBackOff" || "${waiting}" == "Error" ]]; then
  fail "pod still in waiting reason=${waiting}"
else
  pass "pod not in CrashLoopBackOff (restarts=${restarts})"
fi

# Process should still be alive after a short sleep (fixed command stays up)
if kubectl -n "${NS}" get pod "${NAME}" >/dev/null 2>&1; then
  sleep 3
  phase="$(kubectl -n "${NS}" get pod "${NAME}" -o jsonpath='{.status.phase}' 2>/dev/null || echo MISSING)"
  ready="$(kubectl -n "${NS}" get pod "${NAME}" -o jsonpath='{.status.containerStatuses[0].ready}' 2>/dev/null || echo false)"
  if [[ "${phase}" == "Running" && "${ready}" == "true" ]]; then
    pass "pod still Ready after settle check"
  else
    fail "pod not stable after settle (phase=${phase}, ready=${ready})"
  fi
fi

finish_verify
