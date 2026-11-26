# Solution 03 — No privilege escalation

```bash
kubectl create ns cks-sys --dry-run=client -o yaml | kubectl apply -f -
kubectl -n cks-sys apply -f - <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: no-escalation
spec:
  containers:
    - name: pause
      image: registry.k8s.io/pause:3.9
      securityContext:
        allowPrivilegeEscalation: false
        capabilities:
          drop: ["ALL"]
EOF
```
