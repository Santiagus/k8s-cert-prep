#!/usr/bin/env bash
set -euo pipefail
# shellcheck source=../lib/common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/lib/common.sh"

require_cluster
NS=sim-store

check_ns_exists "${NS}"
check_pvc_bound "${NS}" db-data
check_pod_ready "${NS}" db

# Mount path exists
if kubectl -n "${NS}" exec db -- ls /data >/dev/null 2>&1; then
  pass "pod db can ls /data"
else
  fail "pod db cannot access /data mount"
fi

# Claim name still wired
claim="$(kubectl -n "${NS}" get pod db -o jsonpath='{.spec.volumes[?(@.persistentVolumeClaim)].persistentVolumeClaim.claimName}' 2>/dev/null || echo "")"
if [[ "${claim}" == "db-data" ]]; then
  pass "pod db mounts claim db-data"
else
  fail "pod db claimName='${claim}', want db-data"
fi

finish_verify
