# Task 02 — Custom StorageClass

## Objective

Create a non-default StorageClass and bind a PVC to it.

## Starting state

- Cluster with local-path provisioner (kind-bootstrap) **or** another provisioner you document.

## Requirements

1. StorageClass `cka-local` using the same provisioner as `local-path` (or your lab's dynamic provisioner), reclaimPolicy **Retain**, VolumeBindingMode **WaitForFirstConsumer**.
2. Ensure `cka-local` is **not** the default class.
3. PVC `retain-pvc` in `stor-lab` requesting 500Mi RWO with `storageClassName: cka-local`.
4. Pod that mounts `retain-pvc` so binding can complete (WaitForFirstConsumer).
5. PVC becomes Bound.

## Verify

```bash
kubectl get sc cka-local -o yaml
kubectl -n stor-lab get pvc retain-pvc
```
