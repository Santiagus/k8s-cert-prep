# Solution 04 — Hunt privileged Pods

```bash
kubectl create ns cks-runtime --dry-run=client -o yaml | kubectl apply -f -
kubectl -n cks-runtime apply -f - <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: risky
spec:
  containers:
    - name: pause
      image: registry.k8s.io/pause:3.9
      securityContext:
        privileged: true
EOF

kubectl get pods -A -o json | jq -r '
  .items[]
  | select(.spec.containers[]?.securityContext.privileged == true)
  | "\(.metadata.namespace)/\(.metadata.name)"'

kubectl -n cks-runtime delete pod risky
```

Remediation: fix the owning Deployment/DaemonSet template; enforce PSA restricted or admission policy so it cannot return.
