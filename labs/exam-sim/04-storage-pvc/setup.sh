#!/usr/bin/env bash
# Initial broken state: PVC requests nonexistent StorageClass → Pending; Pod Pending.
set -euo pipefail
# shellcheck source=../lib/common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/lib/common.sh"

require_cluster
NS=sim-store
echo "Setting up broken state in namespace ${NS}…"
recreate_ns "${NS}"

# Ensure default SC exists (kind-bootstrap installs local-path).
if ! kubectl get sc >/dev/null 2>&1; then
  echo "Warning: no StorageClasses found. Run ./labs/kind-bootstrap/create-cluster.sh" >&2
fi

kubectl -n "${NS}" apply -f - <<'EOF'
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: db-data
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
  # Broken: StorageClass does not exist on kind-bootstrap
  storageClassName: fake-storage
---
apiVersion: v1
kind: Pod
metadata:
  name: db
  labels:
    app: db
spec:
  containers:
    - name: box
      image: busybox:1.36
      command: ["sh", "-c", "sleep 3600"]
      volumeMounts:
        - name: data
          mountPath: /data
  volumes:
    - name: data
      persistentVolumeClaim:
        claimName: db-data
EOF

echo
echo "Initial state (expect PVC Pending, Pod Pending):"
kubectl -n "${NS}" get pvc,pod
kubectl get sc
echo
echo "Setup complete. Fix storage binding, then run: ./labs/exam-sim/04-storage-pvc/verify.sh"
