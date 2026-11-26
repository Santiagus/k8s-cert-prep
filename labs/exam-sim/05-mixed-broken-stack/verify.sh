#!/usr/bin/env bash
set -euo pipefail
# shellcheck source=../lib/common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/lib/common.sh"

require_cluster
NS=sim-mixed

check_ns_exists "${NS}"
check_cm_key "${NS}" checkout-cfg APP_ENV stage
check_pvc_bound "${NS}" checkout-data
check_deploy_ready "${NS}" checkout 1

image="$(kubectl -n "${NS}" get deploy checkout -o jsonpath='{.spec.template.spec.containers[0].image}' 2>/dev/null || echo "")"
if [[ "${image}" == "nginx:1.25" ]]; then
  pass "deployment checkout image=nginx:1.25"
else
  fail "deployment checkout image='${image}', want nginx:1.25"
fi

env_ok=false
env_ref="$(kubectl -n "${NS}" get deploy checkout -o jsonpath='{range .spec.template.spec.containers[0].env[*]}{.name}={.valueFrom.configMapKeyRef.name}/{.valueFrom.configMapKeyRef.key}{"\n"}{end}' 2>/dev/null || true)"
env_plain="$(kubectl -n "${NS}" get deploy checkout -o jsonpath='{range .spec.template.spec.containers[0].env[*]}{.name}={.value}{"\n"}{end}' 2>/dev/null || true)"
if echo "${env_ref}" | grep -q 'APP_ENV=checkout-cfg/APP_ENV' || echo "${env_plain}" | grep -q 'APP_ENV=stage'; then
  env_ok=true
fi
if [[ "${env_ok}" == true ]]; then
  pass "APP_ENV wired"
else
  fail "APP_ENV not wired from checkout-cfg"
fi

got="$(kubectl -n "${NS}" exec deploy/checkout -- printenv APP_ENV 2>/dev/null || echo "")"
if [[ "${got}" == "stage" ]]; then
  pass "runtime APP_ENV=stage"
else
  fail "runtime APP_ENV='${got}', want stage"
fi

check_svc_exists "${NS}" checkout
check_endpoints_nonempty "${NS}" checkout

if kubectl -n "${NS}" exec deploy/checkout -- ls /data >/dev/null 2>&1; then
  pass "checkout can ls /data"
else
  fail "checkout cannot access /data"
fi

finish_verify
