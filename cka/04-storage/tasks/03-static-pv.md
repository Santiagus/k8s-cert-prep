# Task 03 — Static PV and PVC

## Objective

Pre-provision a PersistentVolume and bind a matching claim.

## Starting state

- Working cluster. For kind, `hostPath` PVs are acceptable for learning (node-specific).

## Requirements

1. PersistentVolume `static-pv` with capacity **1Gi**, accessModes RWO, reclaimPolicy Retain, hostPath `/mnt/cka-static` (or equivalent), storageClassName **`manual`**.
2. PVC `static-pvc` in `stor-lab` requesting 1Gi RWO with `storageClassName: manual` (no dynamic provisioner for `manual`).
3. PVC binds to `static-pv`.
4. Pod `static-pod` mounts `static-pvc` at `/mnt/data`.

## Verify

```bash
kubectl get pv static-pv
kubectl -n stor-lab get pvc static-pvc
# STATUS Bound; VOLUME static-pv
```
