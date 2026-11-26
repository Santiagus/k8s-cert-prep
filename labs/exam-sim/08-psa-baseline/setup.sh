#!/usr/bin/env bash
# Incomplete secure state: ns without PSA labels; Deployment violates baseline (hostNetwork).
set -euo pipefail
# shellcheck source=../lib/common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/lib/common.sh"

require_cluster
NS=sim-psa
echo "Setting up PSA baseline drill in namespace ${NS}…"
recreate_ns "${NS}"

# Intentionally NO pod-security labels yet.

kubectl -n "${NS}" apply -f - <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web
spec:
  replicas: 1
  selector:
    matchLabels:
      app: web
  template:
    metadata:
      labels:
        app: web
    spec:
      hostNetwork: true
      containers:
        - name: nginx
          image: nginx:1.25
          ports:
            - containerPort: 80
EOF

echo
echo "Namespace labels (expect no pod-security enforce yet):"
kubectl get ns "${NS}" --show-labels || true
echo
echo "Setup complete. Enforce baseline PSA and fix the Deployment, then:"
echo "  ./labs/exam-sim/08-psa-baseline/verify.sh"
