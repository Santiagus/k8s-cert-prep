# Solution 01 — Deployment rollout and rollback

```bash
kubectl create ns work-lab
kubectl -n work-lab create deployment web --image=nginx:1.25 --replicas=3
kubectl -n work-lab rollout status deploy/web

kubectl -n work-lab set image deploy/web nginx=nginx:1.26
kubectl -n work-lab rollout status deploy/web
kubectl -n work-lab rollout history deploy/web

kubectl -n work-lab rollout undo deploy/web
kubectl -n work-lab rollout status deploy/web
kubectl -n work-lab get pods -o jsonpath='{range .items[*]}{.spec.containers[0].image}{"\n"}{end}'
```

**Failure modes:** Wrong container name in `set image` (default is often `nginx` when created via `create deployment`); not waiting for rollout.
