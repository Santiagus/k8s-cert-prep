#!/usr/bin/env bash
set -euo pipefail
# shellcheck source=../lib/common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/lib/common.sh"

require_cluster
NS=sim-rbac

check_ns_exists "${NS}"

if kubectl -n "${NS}" get sa auditor >/dev/null 2>&1; then
  pass "serviceaccount auditor exists"
else
  fail "serviceaccount auditor missing"
fi

check_sa_can "${NS}" auditor get pods
check_sa_can "${NS}" auditor list pods
check_sa_cannot "${NS}" auditor delete pods

# Prefer Role not ClusterRole for this drill (soft check)
if kubectl -n "${NS}" get role auditor-role >/dev/null 2>&1 || kubectl -n "${NS}" get role -o name 2>/dev/null | grep -q .; then
  pass "namespaced Role present for sim-rbac"
else
  # ClusterRole is acceptable if least-privilege still holds via can-i checks above
  if kubectl get clusterrole | grep -qi auditor; then
    pass "ClusterRole used (ensure it is least-privilege — can-i checks above)"
  else
    fail "no Role/ClusterRole found for auditor permissions"
  fi
fi

finish_verify
