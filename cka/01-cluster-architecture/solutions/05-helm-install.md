# Solution 05 — Helm install

Example using Bitnami nginx (URLs can move — check chart docs if add fails):

```bash
kubectl create ns helm-lab

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

helm install web bitnami/nginx -n helm-lab
helm -n helm-lab status web
kubectl -n helm-lab get pods
```

Cleanup:

```bash
helm -n helm-lab uninstall web
```

**Failure modes:** Forgetting `-n`; repo add URL outdated; PVC pending if chart expects a StorageClass — set chart values or use bootstrap default SC.

Alternative OSS charts (e.g. official examples) are fine if Bitnami is unavailable.
