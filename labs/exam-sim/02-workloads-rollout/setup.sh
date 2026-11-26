#!/usr/bin/env bash
# Initial broken state: bad image, 1 replica, ConfigMap present but not mounted as env.
set -euo pipefail
# shellcheck source=../lib/common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/lib/common.sh"

require_cluster
NS=sim-wl
echo "Setting up broken state in namespace ${NS}…"
recreate_ns "${NS}"

kubectl -n "${NS}" apply -f - <<'EOF'
apiVersion: v1
kind: ConfigMap
metadata:
  name: shop-cfg
data:
  MODE: prod
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: shop
spec:
  replicas: 1
  selector:
    matchLabels:
      app: shop
  template:
    metadata:
      labels:
        app: shop
    spec:
      containers:
        - name: nginx
          # Broken: nonexistent tag → ImagePullBackOff
          image: nginx:1.25-does-not-exist
          ports:
            - containerPort: 80
EOF

echo
echo "Initial state (expect ImagePullBackOff / not Ready):"
kubectl -n "${NS}" get deploy,pods,cm
echo
echo "Setup complete. Fix the Deployment, then run: ./labs/exam-sim/02-workloads-rollout/verify.sh"
