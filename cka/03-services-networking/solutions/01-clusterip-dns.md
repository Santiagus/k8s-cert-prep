# Solution 01 — ClusterIP and DNS

```bash
kubectl create ns net-lab
kubectl -n net-lab create deployment web --image=nginx:1.25 --replicas=2
kubectl -n net-lab expose deployment web --port=80 --target-port=80 --name=web
kubectl -n net-lab rollout status deploy/web

kubectl -n net-lab run tmp --rm -it --restart=Never --image=busybox:1.36 -- wget -qO- http://web
```

**Failure modes:** Service selector labels not matching Pod template labels; testing from wrong namespace without FQDN.
