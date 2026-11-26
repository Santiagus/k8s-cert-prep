#!/usr/bin/env bash
# Initial incomplete state: apps up, zero NetworkPolicies (need deny + allow rules).
set -euo pipefail
# shellcheck source=../lib/common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/lib/common.sh"

require_cluster
NS=sim-np
echo "Setting up incomplete NetworkPolicy state in namespace ${NS}…"
recreate_ns "${NS}"

kubectl -n "${NS}" apply -f - <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend
spec:
  replicas: 1
  selector:
    matchLabels:
      app: frontend
  template:
    metadata:
      labels:
        app: frontend
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
  name: frontend
spec:
  selector:
    app: frontend
  ports:
    - port: 80
      targetPort: 80
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: backend
spec:
  replicas: 1
  selector:
    matchLabels:
      app: backend
  template:
    metadata:
      labels:
        app: backend
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
  name: backend
spec:
  selector:
    app: backend
  ports:
    - port: 80
      targetPort: 80
EOF

wait_pods_ready "${NS}" "app=frontend" 90
wait_pods_ready "${NS}" "app=backend" 90

# Ensure no leftover policies
kubectl -n "${NS}" delete networkpolicy --all --ignore-not-found >/dev/null 2>&1 || true

echo
echo "Initial state (expect Ready apps, no NetworkPolicies):"
kubectl -n "${NS}" get deploy,svc,networkpolicy
echo
echo "Setup complete. Add NetworkPolicies, then run: ./labs/exam-sim/07-networkpolicy/verify.sh"
echo "Note: kindnet may not enforce policies; verify checks object correctness."
