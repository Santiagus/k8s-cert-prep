#!/usr/bin/env bash
set -euo pipefail
# shellcheck source=../lib/common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/lib/common.sh"

require_cluster
NS=sim-sc

check_ns_exists "${NS}"
check_deploy_ready "${NS}" api 1

# seccomp RuntimeDefault on pod or first container
pod_sec="$(kubectl -n "${NS}" get deploy api -o jsonpath='{.spec.template.spec.securityContext.seccompProfile.type}' 2>/dev/null || echo "")"
ctr_sec="$(kubectl -n "${NS}" get deploy api -o jsonpath='{.spec.template.spec.containers[0].securityContext.seccompProfile.type}' 2>/dev/null || echo "")"
if [[ "${pod_sec}" == "RuntimeDefault" || "${ctr_sec}" == "RuntimeDefault" ]]; then
  pass "seccompProfile RuntimeDefault set"
else
  fail "seccompProfile.type missing RuntimeDefault (pod='${pod_sec}' ctr='${ctr_sec}')"
fi

ape="$(kubectl -n "${NS}" get deploy api -o jsonpath='{.spec.template.spec.containers[0].securityContext.allowPrivilegeEscalation}' 2>/dev/null || echo "")"
if [[ "${ape}" == "false" ]]; then
  pass "allowPrivilegeEscalation=false"
else
  fail "allowPrivilegeEscalation='${ape}', want false"
fi

caps="$(kubectl -n "${NS}" get deploy api -o jsonpath='{.spec.template.spec.containers[0].securityContext.capabilities.drop[*]}' 2>/dev/null || echo "")"
if echo "${caps}" | grep -qw ALL; then
  pass "capabilities.drop includes ALL"
else
  fail "capabilities.drop='${caps}', want ALL"
fi

ro="$(kubectl -n "${NS}" get deploy api -o jsonpath='{.spec.template.spec.containers[0].securityContext.readOnlyRootFilesystem}' 2>/dev/null || echo "")"
if [[ "${ro}" == "true" ]]; then
  pass "readOnlyRootFilesystem=true"
else
  fail "readOnlyRootFilesystem='${ro}', want true"
fi

priv="$(kubectl -n "${NS}" get deploy api -o jsonpath='{.spec.template.spec.containers[0].securityContext.privileged}' 2>/dev/null || echo "")"
if [[ "${priv}" == "true" ]]; then
  fail "privileged must not be true"
else
  pass "privileged not set/true"
fi

finish_verify
