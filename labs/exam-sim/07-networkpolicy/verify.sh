#!/usr/bin/env bash
set -euo pipefail
# shellcheck source=../lib/common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/lib/common.sh"

require_cluster
NS=sim-np

check_ns_exists "${NS}"
check_deploy_ready "${NS}" frontend 1
check_deploy_ready "${NS}" backend 1

check_netpol_exists "${NS}" default-deny
check_netpol_exists "${NS}" allow-frontend-to-backend
check_netpol_exists "${NS}" allow-backend-dns

# default-deny: should select all pods and deny ingress (empty ingress or policyTypes Ingress with no rules)
deny_types="$(kubectl -n "${NS}" get networkpolicy default-deny -o jsonpath='{.spec.policyTypes[*]}' 2>/dev/null || echo "")"
deny_sel="$(kubectl -n "${NS}" get networkpolicy default-deny -o jsonpath='{.spec.podSelector}' 2>/dev/null || echo "")"
if echo "${deny_types}" | grep -qi Ingress; then
  pass "default-deny includes Ingress policyType"
else
  fail "default-deny missing Ingress in policyTypes ('${deny_types}')"
fi
# empty podSelector {} selects all pods in the namespace
if [[ -z "${deny_sel}" || "${deny_sel}" == "{}" || "${deny_sel}" == "map[]" ]]; then
  pass "default-deny selects all pods (empty podSelector)"
else
  fail "default-deny podSelector should be empty {} to select all (got ${deny_sel})"
fi

# allow-frontend-to-backend: targets backend, from frontend, port 80
to_sel="$(kubectl -n "${NS}" get networkpolicy allow-frontend-to-backend -o jsonpath='{.spec.podSelector.matchLabels.app}' 2>/dev/null || echo "")"
from_sel="$(kubectl -n "${NS}" get networkpolicy allow-frontend-to-backend -o jsonpath='{.spec.ingress[*].from[*].podSelector.matchLabels.app}' 2>/dev/null || echo "")"
ports="$(kubectl -n "${NS}" get networkpolicy allow-frontend-to-backend -o jsonpath='{.spec.ingress[*].ports[*].port}' 2>/dev/null || echo "")"
if [[ "${to_sel}" == "backend" ]]; then
  pass "allow-frontend-to-backend selects app=backend"
else
  fail "allow-frontend-to-backend podSelector.app='${to_sel}', want backend"
fi
if echo "${from_sel}" | grep -q frontend; then
  pass "allow-frontend-to-backend allows from app=frontend"
else
  fail "allow-frontend-to-backend from selector missing frontend ('${from_sel}')"
fi
if echo "${ports}" | grep -qw 80; then
  pass "allow-frontend-to-backend allows port 80"
else
  fail "allow-frontend-to-backend ports='${ports}', want 80"
fi

# allow-backend-dns: egress 53 udp/tcp for backend
dns_sel="$(kubectl -n "${NS}" get networkpolicy allow-backend-dns -o jsonpath='{.spec.podSelector.matchLabels.app}' 2>/dev/null || echo "")"
dns_types="$(kubectl -n "${NS}" get networkpolicy allow-backend-dns -o jsonpath='{.spec.policyTypes[*]}' 2>/dev/null || echo "")"
dns_ports="$(kubectl -n "${NS}" get networkpolicy allow-backend-dns -o jsonpath='{.spec.egress[*].ports[*].port}' 2>/dev/null || echo "")"
if [[ "${dns_sel}" == "backend" ]]; then
  pass "allow-backend-dns selects app=backend"
else
  fail "allow-backend-dns podSelector.app='${dns_sel}', want backend"
fi
if echo "${dns_types}" | grep -qi Egress; then
  pass "allow-backend-dns includes Egress"
else
  fail "allow-backend-dns missing Egress policyType"
fi
if echo "${dns_ports}" | grep -qw 53; then
  pass "allow-backend-dns allows port 53"
else
  fail "allow-backend-dns egress ports='${dns_ports}', want 53"
fi

finish_verify
