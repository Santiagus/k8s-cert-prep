#!/usr/bin/env bash
# Delete the cka-prep kind cluster.
set -euo pipefail

CLUSTER_NAME="cka-prep"

if ! command -v kind >/dev/null 2>&1; then
  echo "kind not found." >&2
  exit 1
fi

if kind get clusters 2>/dev/null | grep -qx "${CLUSTER_NAME}"; then
  kind delete cluster --name "${CLUSTER_NAME}"
  echo "Deleted cluster '${CLUSTER_NAME}'."
else
  echo "Cluster '${CLUSTER_NAME}' not found."
fi
