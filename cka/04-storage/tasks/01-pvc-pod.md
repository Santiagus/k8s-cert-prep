# Task 01 — Dynamic PVC mounted in a Pod

## Objective

Claim storage via the default StorageClass and mount it in a Pod.

## Starting state

- kind cluster from [labs/kind-bootstrap/](../../../labs/kind-bootstrap/) with default StorageClass.

## Requirements

1. Namespace `stor-lab`.
2. PVC `data-pvc` requesting **1Gi**, access mode **ReadWriteOnce**, using the default StorageClass (omit `storageClassName` or set it explicitly to the default).
3. Pod `data-pod` mounting that PVC at `/data`, image `busybox:1.36`, command `sleep 3600`.
4. PVC `Bound`; Pod `Running`; you can `touch /data/ok` inside the Pod.

## Verify

```bash
kubectl -n stor-lab get pvc data-pvc
kubectl -n stor-lab exec data-pod -- touch /data/ok
kubectl -n stor-lab exec data-pod -- ls /data
```
