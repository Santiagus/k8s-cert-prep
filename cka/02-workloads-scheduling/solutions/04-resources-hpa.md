# Solution 04 — Resources and HPA

```bash
kubectl create ns hpa-lab
kubectl -n hpa-lab create deployment api --image=nginx:1.25 --replicas=2 --dry-run=client -o yaml > /tmp/api.yaml
```

Add under the container:

```yaml
resources:
  requests:
    cpu: 100m
  limits:
    cpu: 200m
```

```bash
kubectl apply -f /tmp/api.yaml

kubectl -n hpa-lab autoscale deployment api --min=2 --max=5 --cpu-percent=70
# creates HPA named api

kubectl -n hpa-lab get hpa api
```

Optional Metrics Server on kind: follow [kubernetes-sigs/metrics-server](https://github.com/kubernetes-sigs/metrics-server) kind instructions (often need `--kubelet-insecure-tls`). Without metrics, HPA still exists but may show `<unknown>` current CPU.

**Failure modes:** Missing CPU request (HPA CPU target ineffective); HPA name mismatch.
