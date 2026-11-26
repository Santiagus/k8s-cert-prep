#!/usr/bin/env bash
# Create the cka-prep kind cluster and install a default StorageClass provisioner.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
CONFIG="${ROOT}/labs/kind-bootstrap/kind-config.yaml"
CLUSTER_NAME="cka-prep"
LOCAL_PATH_URL="https://raw.githubusercontent.com/rancher/local-path-provisioner/v0.0.30/deploy/local-path-storage.yaml"

if ! command -v kind >/dev/null 2>&1; then
  echo "kind not found. Install: https://kind.sigs.k8s.io/docs/user/quick-start/#installation" >&2
  exit 1
fi
if ! command -v kubectl >/dev/null 2>&1; then
  echo "kubectl not found. Install: https://kubernetes.io/docs/tasks/tools/" >&2
  exit 1
fi

if kind get clusters 2>/dev/null | grep -qx "${CLUSTER_NAME}"; then
  echo "Cluster '${CLUSTER_NAME}' already exists. Delete first or use: kind export kubeconfig --name ${CLUSTER_NAME}"
  kind export kubeconfig --name "${CLUSTER_NAME}"
else
  echo "Creating kind cluster '${CLUSTER_NAME}'…"
  kind create cluster --config "${CONFIG}"
fi

echo "Installing local-path-provisioner (default StorageClass)…"
kubectl apply -f "${LOCAL_PATH_URL}"
# Wait briefly for the deployment; ignore timeout failures so script stays usable offline after apply.
kubectl -n local-path-storage rollout status deploy/local-path-provisioner --timeout=120s || true
kubectl patch storageclass local-path -p '{"metadata":{"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}' 2>/dev/null || true

echo
echo "Nodes:"
kubectl get nodes -o wide
echo
echo "StorageClasses:"
kubectl get sc
echo
echo "Done. Context should be kind-${CLUSTER_NAME}."
