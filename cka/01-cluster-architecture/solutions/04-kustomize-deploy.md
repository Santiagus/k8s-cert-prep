# Solution 04 — Kustomize deploy

Example tree (also under [../manifests/kustomize-demo/](../manifests/kustomize-demo/)):

```bash
kubectl create ns kust-lab

kubectl apply -k cka/01-cluster-architecture/manifests/kustomize-demo/

kubectl -n kust-lab get deploy,svc
# demo-web Deployment and Service
```

Root `kustomization.yaml` uses `namePrefix: demo-` and `namespace: kust-lab`.

**Failure modes:** Running `kubectl apply -f` instead of `-k`; putting namespace only on resources and not in kustomization; label selectors not matching after rename (namePrefix does not rewrite arbitrary label values unless configured).
