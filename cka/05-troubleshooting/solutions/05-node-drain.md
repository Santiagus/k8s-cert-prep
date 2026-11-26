# Solution 05 — Cordon and drain

```bash
kubectl create ns ts-drain
kubectl -n ts-drain create deployment move --image=nginx:1.25 --replicas=3
kubectl -n ts-drain rollout status deploy/move

NODE=$(kubectl -n ts-drain get pods -o jsonpath='{.items[0].spec.nodeName}')
echo "$NODE"

kubectl cordon "$NODE"
kubectl get node "$NODE"   # SchedulingDisabled

kubectl drain "$NODE" --ignore-daemonsets --delete-emptydir-data
kubectl -n ts-drain get pods -o wide

kubectl uncordon "$NODE"
```

**Failure modes:** Draining the only node; forgetting `--ignore-daemonsets`; leaving the node cordoned.
