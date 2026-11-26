# Solution — 06 rbac fix

## Diagnose

```bash
kubectl -n sim-rbac get sa,role,rolebinding
kubectl -n sim-rbac describe role auditor-role
kubectl -n sim-rbac describe rolebinding auditor-binding
kubectl auth can-i list pods --as=system:serviceaccount:sim-rbac:auditor -n sim-rbac
```

## Fix

```bash
kubectl -n sim-rbac apply -f - <<'EOF'
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: auditor-role
  namespace: sim-rbac
rules:
  - apiGroups: [""]
    resources: ["pods"]
    verbs: ["get", "list"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: auditor-binding
  namespace: sim-rbac
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: auditor-role
subjects:
  - kind: ServiceAccount
    name: auditor
    namespace: sim-rbac
EOF

kubectl auth can-i list pods --as=system:serviceaccount:sim-rbac:auditor -n sim-rbac
kubectl auth can-i delete pods --as=system:serviceaccount:sim-rbac:auditor -n sim-rbac
```

## Verify

```bash
./labs/exam-sim/06-rbac-fix/verify.sh
```
