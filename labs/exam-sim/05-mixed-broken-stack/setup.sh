#!/usr/bin/env bash
# Multiple defects: bad image, wrong service selector, bad PVC SC, ConfigMap not wired, crashy sidecar-like command.
set -euo pipefail
# shellcheck source=../lib/common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/lib/common.sh"

require_cluster
NS=sim-mixed
echo "Setting up broken multi-defect state in namespace ${NS}…"
recreate_ns "${NS}"

kubectl -n "${NS}" apply -f - <<'EOF'
apiVersion: v1
kind: ConfigMap
metadata:
  name: checkout-cfg
data:
  APP_ENV: stage
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: checkout-data
spec:
  accessModes: ["ReadWriteOnce"]
  resources:
    requests:
      storage: 1Gi
  storageClassName: not-a-real-sc
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: checkout
spec:
  replicas: 2
  selector:
    matchLabels:
      app: checkout
  template:
    metadata:
      labels:
        app: checkout
    spec:
      containers:
        - name: nginx
          image: nginx:bogus-tag
          ports:
            - containerPort: 80
          volumeMounts:
            - name: data
              mountPath: /data
      volumes:
        - name: data
          persistentVolumeClaim:
            claimName: checkout-data
---
apiVersion: v1
kind: Service
metadata:
  name: checkout
spec:
  selector:
    app: checkout-frontend
  ports:
    - port: 80
      targetPort: 80
EOF

echo
echo "Initial state (expect Pending / ImagePull / empty endpoints):"
kubectl -n "${NS}" get deploy,pods,svc,pvc,cm
echo
echo "Setup complete. Fix all defects, then run: ./labs/exam-sim/05-mixed-broken-stack/verify.sh"
