#!/usr/bin/env bash
# Broken/insecure SecurityContext on a running Deployment.
set -euo pipefail
# shellcheck source=../lib/common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/lib/common.sh"

require_cluster
NS=sim-sc
echo "Setting up insecure SecurityContext drill in namespace ${NS}…"
recreate_ns "${NS}"

kubectl -n "${NS}" apply -f - <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api
spec:
  replicas: 1
  selector:
    matchLabels:
      app: api
  template:
    metadata:
      labels:
        app: api
    spec:
      containers:
        - name: api
          image: nginx:1.25
          ports:
            - containerPort: 80
          # Intentionally weak / missing hardening
          securityContext:
            allowPrivilegeEscalation: true
EOF

wait_pods_ready "${NS}" "app=api" 90
echo
echo "Setup complete. Harden securityContext (and image/mounts if needed), then:"
echo "  ./labs/exam-sim/09-securitycontext-harden/verify.sh"
