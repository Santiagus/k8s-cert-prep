# Solution 04 — Reclaim policy behavior

```bash
kubectl -n stor-lab delete pod static-pod --wait=false 2>/dev/null || true
kubectl -n stor-lab delete pvc static-pvc

kubectl get pv static-pv
# Phase should be Released when reclaimPolicy is Retain
```

To reuse the PV: edit/remove `spec.claimRef` so the PV returns to **Available**, then create a new PVC that still matches the PV.

Access modes (notes):

- Single-node DB volume → **ReadWriteOnce**
- Shared NFS-style RW across nodes → **ReadWriteMany** (needs a supporting storage backend; local-path is typically RWO)

**Failure modes:** Expecting Retain PV to disappear on PVC delete; forgetting claimRef blocks rebinding.
