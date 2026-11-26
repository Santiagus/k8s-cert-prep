#!/usr/bin/env bash
# Shared helpers for exam-sim setup/verify scripts.
# Source from a sim directory:  # shellcheck source=../lib/common.sh
#   source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/lib/common.sh"

set -euo pipefail

EXAM_SIM_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REPO_ROOT="$(cd "${EXAM_SIM_ROOT}/../.." && pwd)"

FAILS=0
PASSES=0

pass() {
  echo "PASS: $*"
  PASSES=$((PASSES + 1))
}

fail() {
  echo "FAIL: $*"
  FAILS=$((FAILS + 1))
}

require_kubectl() {
  if ! command -v kubectl >/dev/null 2>&1; then
    echo "kubectl not found. Install: https://kubernetes.io/docs/tasks/tools/" >&2
    exit 1
  fi
}

require_cluster() {
  require_kubectl
  if ! kubectl cluster-info >/dev/null 2>&1; then
    echo "No reachable cluster. Create one with: ./labs/kind-bootstrap/create-cluster.sh" >&2
    exit 1
  fi
}

# Recreate a namespace so setup is idempotent.
recreate_ns() {
  local ns="$1"
  kubectl delete namespace "${ns}" --ignore-not-found --wait=true >/dev/null 2>&1 || true
  # Wait until gone (delete can return before finalization finishes).
  local i=0
  while kubectl get namespace "${ns}" >/dev/null 2>&1; do
    i=$((i + 1))
    if [[ "${i}" -gt 60 ]]; then
      echo "Timed out waiting for namespace ${ns} to delete" >&2
      exit 1
    fi
    sleep 2
  done
  kubectl create namespace "${ns}"
}

# Wait until at least one Pod matching a label selector is Ready (or timeout).
wait_pods_ready() {
  local ns="$1"
  local selector="$2"
  local timeout="${3:-120}"
  kubectl -n "${ns}" wait --for=condition=Ready pod -l "${selector}" --timeout="${timeout}s" 2>/dev/null || true
}

# ---- verify helpers (do not exit early; tally FAILS) ----

check_ns_exists() {
  local ns="$1"
  if kubectl get namespace "${ns}" >/dev/null 2>&1; then
    pass "namespace ${ns} exists"
  else
    fail "namespace ${ns} missing"
  fi
}

check_deploy_ready() {
  local ns="$1"
  local name="$2"
  local want_replicas="${3:-}"
  if ! kubectl -n "${ns}" get deploy "${name}" >/dev/null 2>&1; then
    fail "deployment ${ns}/${name} missing"
    return
  fi
  local ready desired
  ready="$(kubectl -n "${ns}" get deploy "${name}" -o jsonpath='{.status.readyReplicas}' 2>/dev/null || echo 0)"
  desired="$(kubectl -n "${ns}" get deploy "${name}" -o jsonpath='{.status.replicas}' 2>/dev/null || echo 0)"
  ready="${ready:-0}"
  desired="${desired:-0}"
  if [[ -n "${want_replicas}" ]]; then
    local spec
    spec="$(kubectl -n "${ns}" get deploy "${name}" -o jsonpath='{.spec.replicas}')"
    if [[ "${spec}" != "${want_replicas}" ]]; then
      fail "deployment ${ns}/${name} replicas=${spec}, want ${want_replicas}"
      return
    fi
  fi
  if [[ "${desired}" -gt 0 && "${ready}" -eq "${desired}" ]]; then
    pass "deployment ${ns}/${name} Ready (${ready}/${desired})"
  else
    fail "deployment ${ns}/${name} not Ready (ready=${ready}, replicas=${desired})"
  fi
}

check_pod_ready() {
  local ns="$1"
  local name="$2"
  local phase
  phase="$(kubectl -n "${ns}" get pod "${name}" -o jsonpath='{.status.phase}' 2>/dev/null || echo MISSING)"
  if [[ "${phase}" == "Running" ]]; then
    local ready
    ready="$(kubectl -n "${ns}" get pod "${name}" -o jsonpath='{.status.containerStatuses[0].ready}' 2>/dev/null || echo false)"
    if [[ "${ready}" == "true" ]]; then
      pass "pod ${ns}/${name} Ready"
    else
      fail "pod ${ns}/${name} Running but not Ready"
    fi
  else
    fail "pod ${ns}/${name} phase=${phase}, want Running+Ready"
  fi
}

check_pods_ready_by_label() {
  local ns="$1"
  local selector="$2"
  local min="${3:-1}"
  local count
  count="$(kubectl -n "${ns}" get pods -l "${selector}" --field-selector=status.phase=Running -o jsonpath='{range .items[?(@.status.containerStatuses[0].ready==true)]}{.metadata.name}{"\n"}{end}' 2>/dev/null | grep -c . || true)"
  if [[ "${count}" -ge "${min}" ]]; then
    pass "pods -l ${selector} Ready count=${count} (>=${min})"
  else
    fail "pods -l ${selector} Ready count=${count}, want >=${min}"
  fi
}

check_svc_exists() {
  local ns="$1"
  local name="$2"
  if kubectl -n "${ns}" get svc "${name}" >/dev/null 2>&1; then
    pass "service ${ns}/${name} exists"
  else
    fail "service ${ns}/${name} missing"
  fi
}

check_endpoints_nonempty() {
  local ns="$1"
  local name="$2"
  local addrs
  # Prefer EndpointSlice; fall back to Endpoints.
  addrs="$(kubectl -n "${ns}" get endpointslices -l kubernetes.io/service-name="${name}" -o jsonpath='{.items[*].endpoints[*].addresses[*]}' 2>/dev/null || true)"
  if [[ -z "${addrs}" ]]; then
    addrs="$(kubectl -n "${ns}" get endpoints "${name}" -o jsonpath='{.subsets[*].addresses[*].ip}' 2>/dev/null || true)"
  fi
  if [[ -n "${addrs}" ]]; then
    pass "service ${ns}/${name} has endpoints"
  else
    fail "service ${ns}/${name} has no endpoints"
  fi
}

check_pvc_bound() {
  local ns="$1"
  local name="$2"
  local phase
  phase="$(kubectl -n "${ns}" get pvc "${name}" -o jsonpath='{.status.phase}' 2>/dev/null || echo MISSING)"
  if [[ "${phase}" == "Bound" ]]; then
    pass "pvc ${ns}/${name} Bound"
  else
    fail "pvc ${ns}/${name} phase=${phase}, want Bound"
  fi
}

check_cm_key() {
  local ns="$1"
  local name="$2"
  local key="$3"
  local want="$4"
  local got
  got="$(kubectl -n "${ns}" get configmap "${name}" -o jsonpath="{.data.${key}}" 2>/dev/null || echo "")"
  if [[ "${got}" == "${want}" ]]; then
    pass "configmap ${ns}/${name} ${key}=${want}"
  else
    fail "configmap ${ns}/${name} ${key}='${got}', want '${want}'"
  fi
}

check_sa_can() {
  # Usage: check_sa_can <ns> <sa> <verb> <resource> [resource-name]
  local ns="$1"
  local sa="$2"
  local verb="$3"
  local resource="$4"
  local resname="${5:-}"
  local args=(auth can-i "${verb}" "${resource}" --as="system:serviceaccount:${ns}:${sa}" -n "${ns}")
  if [[ -n "${resname}" ]]; then
    args+=("${resname}")
  fi
  if kubectl "${args[@]}" >/dev/null 2>&1; then
    pass "SA ${ns}/${sa} can ${verb} ${resource}${resname:+/${resname}}"
  else
    fail "SA ${ns}/${sa} cannot ${verb} ${resource}${resname:+/${resname}}"
  fi
}

check_sa_cannot() {
  local ns="$1"
  local sa="$2"
  local verb="$3"
  local resource="$4"
  if kubectl auth can-i "${verb}" "${resource}" --as="system:serviceaccount:${ns}:${sa}" -n "${ns}" >/dev/null 2>&1; then
    fail "SA ${ns}/${sa} should NOT ${verb} ${resource}"
  else
    pass "SA ${ns}/${sa} correctly denied ${verb} ${resource}"
  fi
}

check_netpol_exists() {
  local ns="$1"
  local name="$2"
  if kubectl -n "${ns}" get networkpolicy "${name}" >/dev/null 2>&1; then
    pass "networkpolicy ${ns}/${name} exists"
  else
    fail "networkpolicy ${ns}/${name} missing"
  fi
}

finish_verify() {
  echo
  echo "----"
  echo "Results: ${PASSES} passed, ${FAILS} failed"
  if [[ "${FAILS}" -gt 0 ]]; then
    echo "OVERALL: FAIL"
    exit 1
  fi
  echo "OVERALL: PASS"
  exit 0
}
