#!/usr/bin/env bash
# Broken: worker automounts token; secret-reader RBAC wrong.
set -euo pipefail
# shellcheck source=../lib/common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/lib/common.sh"

require_cluster
NS=sim-saharden
echo "Setting up SA/RBAC harden drill in namespace ${NS}…"
recreate_ns "${NS}"

kubectl -n "${NS}" apply -f - <<'EOF'
apiVersion: v1
kind: ServiceAccount
metadata:
  name: secret-reader
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: wrong-sa
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: secret-reader
rules:
  - apiGroups: [""]
    resources: ["pods"]
    verbs: ["create", "delete"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: secret-reader
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: secret-reader
subjects:
  - kind: ServiceAccount
    name: wrong-sa
    namespace: sim-saharden
---
apiVersion: v1
kind: Pod
metadata:
  name: worker
  labels:
    app: worker
spec:
  # Broken for this drill: token automount left at default (true)
  containers:
    - name: pause
      image: registry.k8s.io/pause:3.9
---
apiVersion: v1
kind: Secret
metadata:
  name: demo
type: Opaque
stringData:
  key: value
EOF

echo
echo "Setup complete. Disable worker token automount and fix secret-reader RBAC, then:"
echo "  ./labs/exam-sim/10-sa-rbac-harden/verify.sh"
