#!/usr/bin/env bash
set -euo pipefail
# shellcheck source=../lib/common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/lib/common.sh"

require_cluster
NS=sim-psa

check_ns_exists "${NS}"

enforce="$(kubectl get ns "${NS}" -o go-template='{{index .metadata.labels "pod-security.kubernetes.io/enforce"}}' 2>/dev/null || echo "")"
if [[ "${enforce}" == "baseline" ]]; then
  pass "namespace enforce=baseline"
else
  fail "namespace pod-security enforce='${enforce}', want baseline"
fi

# warn/audit optional but recommended — soft pass if enforce is correct
warn="$(kubectl get ns "${NS}" -o go-template='{{index .metadata.labels "pod-security.kubernetes.io/warn"}}' 2>/dev/null || echo "")"
if [[ "${warn}" == "baseline" || "${warn}" == "restricted" ]]; then
  pass "namespace warn=${warn}"
else
  pass "namespace warn unset or non-baseline (enforce is what blocks)"
fi

hostnet="$(kubectl -n "${NS}" get deploy web -o jsonpath='{.spec.template.spec.hostNetwork}' 2>/dev/null || echo MISSING)"
if [[ "${hostnet}" == "true" ]]; then
  fail "deployment web still has hostNetwork=true"
else
  pass "deployment web does not set hostNetwork=true"
fi

check_deploy_ready "${NS}" web 1

finish_verify
