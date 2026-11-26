# Solution 04 — Pending (CPU request)

```bash
kubectl apply -f cka/05-troubleshooting/setup/04-pending.yaml
kubectl -n ts-pend describe pod heavy
# Insufficient cpu — request "100" means 100 cores
```

```bash
kubectl -n ts-pend delete pod heavy
```

Recreate with e.g. `cpu: 50m`:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: heavy
  namespace: ts-pend
spec:
  containers:
    - name: pause
      image: registry.k8s.io/pause:3.9
      resources:
        requests:
          cpu: 50m
          memory: 128Mi
```

**Failure modes:** Misreading `cpu: "100"` as millicores; node taints unrelated to this setup.
