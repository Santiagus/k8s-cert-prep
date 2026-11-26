#!/usr/bin/env bash
# Initial broken state: Service selector does not match Pod labels.
set -euo pipefail
# shellcheck source=../lib/common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/lib/common.sh"

require_cluster
NS=sim-net
echo "Setting up broken state in namespace ${NS}…"
recreate_ns "${NS}"

kubectl -n "${NS}" apply -f - <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api
spec:
  replicas: 2
  selector:
    matchLabels:
      app: api
  template:
    metadata:
      labels:
        app: api
    spec:
      containers:
        - name: nginx
          image: nginx:1.25
          ports:
            - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: api
spec:
  # Broken: selector does not match Pod labels
  selector:
    app: api-v2
  ports:
    - port: 80
      targetPort: 80
EOF

wait_pods_ready "${NS}" "app=api" 90

echo
echo "Initial state (expect Ready pods, empty endpoints):"
kubectl -n "${NS}" get deploy,pods,svc,endpoints
echo
echo "Setup complete. Fix the Service/labels, then run: ./labs/exam-sim/03-networking-endpoints/verify.sh"
