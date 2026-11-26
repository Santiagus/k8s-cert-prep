#!/usr/bin/env bash
set -euo pipefail
# shellcheck source=../lib/common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/lib/common.sh"

require_cluster
NS=sim-saharden

check_ns_exists "${NS}"
check_pod_ready "${NS}" worker

am="$(kubectl -n "${NS}" get pod worker -o jsonpath='{.spec.automountServiceAccountToken}' 2>/dev/null || echo "")"
if [[ "${am}" == "false" ]]; then
  pass "worker automountServiceAccountToken=false"
else
  fail "worker automountServiceAccountToken='${am}', want false"
fi

if kubectl -n "${NS}" get sa secret-reader >/dev/null 2>&1; then
  pass "serviceaccount secret-reader exists"
else
  fail "serviceaccount secret-reader missing"
fi

check_sa_can "${NS}" secret-reader get secrets
check_sa_can "${NS}" secret-reader list secrets
check_sa_cannot "${NS}" secret-reader create pods

finish_verify
