# Task 04 — Install with Kustomize

## Objective

Deploy a small app using `kubectl apply -k` with a name prefix.

## Starting state

- Working cluster.
- Create your own kustomization under a temp directory or under `cka/01-cluster-architecture/manifests/kustomize-demo/` (you may create files as part of the task).

## Requirements

1. Namespace `kust-lab` exists (create if needed).
2. A Kustomize base that defines a Deployment `web` (image `nginx:1.25`) and Service `web` (ClusterIP port 80).
3. An overlay or root `kustomization.yaml` that:
   - sets `namespace: kust-lab`
   - sets `namePrefix: demo-`
4. Apply with `kubectl apply -k <dir>`.
5. Resources appear as `demo-web` Deployment and Service in `kust-lab`.

## Verify

```bash
kubectl -n kust-lab get deploy,svc
# expect names prefixed with demo-
kubectl -n kust-lab get pods -l app=web   # or whatever label you chose
```
