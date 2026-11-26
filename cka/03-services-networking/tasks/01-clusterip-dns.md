# Task 01 — ClusterIP Service and DNS

## Objective

Expose a Deployment over ClusterIP and resolve it via in-cluster DNS.

## Starting state

- Working cluster.

## Requirements

1. Namespace `net-lab`.
2. Deployment `web` with 2 replicas of `nginx:1.25`.
3. ClusterIP Service `web` selecting those Pods, port **80**.
4. From a throwaway Pod in `net-lab`, resolve `web.net-lab.svc.cluster.local` and fetch HTTP from `http://web`.

## Verify

```bash
kubectl -n net-lab get svc web
kubectl -n net-lab run tmp --rm -it --restart=Never --image=busybox:1.36 -- wget -qO- http://web
```
