#!/usr/bin/env bash
set -euo pipefail
# shellcheck source=../lib/common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/lib/common.sh"

require_cluster
NS=sim-net

check_ns_exists "${NS}"
check_deploy_ready "${NS}" api
check_svc_exists "${NS}" api
check_endpoints_nonempty "${NS}" api

port="$(kubectl -n "${NS}" get svc api -o jsonpath='{.spec.ports[0].port}' 2>/dev/null || echo "")"
if [[ "${port}" == "80" ]]; then
  pass "service api port=80"
else
  fail "service api port='${port}', want 80"
fi

finish_verify
