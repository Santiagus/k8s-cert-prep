#!/usr/bin/env bash
# Initial broken state: SA present; Role grants wrong verbs; RoleBinding points at wrong SA.
set -euo pipefail
# shellcheck source=../lib/common.sh
source "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/lib/common.sh"

require_cluster
NS=sim-rbac
echo "Setting up broken RBAC in namespace ${NS}…"
recreate_ns "${NS}"

kubectl -n "${NS}" apply -f - <<'EOF'
apiVersion: v1
kind: ServiceAccount
metadata:
  name: auditor
---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: wrong-sa
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: auditor-role
rules:
  # Broken: only delete — missing get/list; too powerful for "auditor"
  - apiGroups: [""]
    resources: ["pods"]
    verbs: ["delete"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: auditor-binding
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: auditor-role
subjects:
  # Broken: bound to wrong ServiceAccount
  - kind: ServiceAccount
    name: wrong-sa
    namespace: sim-rbac
---
apiVersion: v1
kind: Pod
metadata:
  name: sample
  labels:
    app: sample
spec:
  containers:
    - name: pause
      image: registry.k8s.io/pause:3.9
EOF

echo
echo "Initial auth checks (expect failures for auditor get/list):"
kubectl auth can-i list pods --as=system:serviceaccount:sim-rbac:auditor -n sim-rbac || true
kubectl auth can-i delete pods --as=system:serviceaccount:sim-rbac:auditor -n sim-rbac || true
echo
echo "Setup complete. Fix RBAC, then run: ./labs/exam-sim/06-rbac-fix/verify.sh"
