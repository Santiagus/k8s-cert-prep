#!/usr/bin/env bash
set -euo pipefail
# shellcheck source=../lib/common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/lib/common.sh"

require_cluster
NS=sim-wl

check_ns_exists "${NS}"
check_cm_key "${NS}" shop-cfg MODE prod
check_deploy_ready "${NS}" shop 3

image="$(kubectl -n "${NS}" get deploy shop -o jsonpath='{.spec.template.spec.containers[0].image}' 2>/dev/null || echo "")"
if [[ "${image}" == "nginx:1.25" ]]; then
  pass "deployment shop image=nginx:1.25"
else
  fail "deployment shop image='${image}', want nginx:1.25"
fi

# Env from ConfigMap
env_ref="$(kubectl -n "${NS}" get deploy shop -o jsonpath='{range .spec.template.spec.containers[0].env[*]}{.name}={.valueFrom.configMapKeyRef.name}/{.valueFrom.configMapKeyRef.key}{"\n"}{end}' 2>/dev/null || true)"
env_plain="$(kubectl -n "${NS}" get deploy shop -o jsonpath='{range .spec.template.spec.containers[0].env[*]}{.name}={.value}{"\n"}{end}' 2>/dev/null || true)"
if echo "${env_ref}" | grep -q 'SHOP_MODE=shop-cfg/MODE' || echo "${env_plain}" | grep -q 'SHOP_MODE=prod'; then
  pass "SHOP_MODE wired to prod (ConfigMap or literal)"
else
  # Also accept envFrom
  env_from="$(kubectl -n "${NS}" get deploy shop -o jsonpath='{.spec.template.spec.containers[0].envFrom[*].configMapRef.name}' 2>/dev/null || true)"
  if [[ "${env_from}" == *"shop-cfg"* ]]; then
    # Need key MODE exposed somehow — envFrom uses keys as env names (MODE not SHOP_MODE)
    fail "envFrom shop-cfg sets MODE not SHOP_MODE; use env valueFrom or rename"
  else
    fail "SHOP_MODE not set from ConfigMap shop-cfg key MODE"
  fi
fi

# Live check if pods Ready
if kubectl -n "${NS}" get deploy shop >/dev/null 2>&1; then
  got="$(kubectl -n "${NS}" exec deploy/shop -- printenv SHOP_MODE 2>/dev/null || echo "")"
  if [[ "${got}" == "prod" ]]; then
    pass "runtime SHOP_MODE=prod"
  else
    fail "runtime SHOP_MODE='${got}', want prod"
  fi
fi

finish_verify
