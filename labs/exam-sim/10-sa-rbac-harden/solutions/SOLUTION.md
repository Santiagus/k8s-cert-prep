# Solution — 10 SA + RBAC harden

```bash
# Fix Pod automount (recreate — field is immutable on many clusters)
kubectl -n sim-saharden delete pod worker --wait=true
kubectl -n sim-saharden apply -f - <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: worker
  labels:
    app: worker
spec:
  automountServiceAccountToken: false
  containers:
    - name: pause
      image: registry.k8s.io/pause:3.9
EOF

# Fix Role + RoleBinding
kubectl -n sim-saharden apply -f - <<'EOF'
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: secret-reader
rules:
  - apiGroups: [""]
    resources: ["secrets"]
    verbs: ["get", "list"]
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
    name: secret-reader
    namespace: sim-saharden
EOF

./labs/exam-sim/10-sa-rbac-harden/verify.sh
```
