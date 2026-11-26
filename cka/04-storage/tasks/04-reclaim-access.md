# Task 04 — Reclaim policy and access modes quiz-in-cluster

## Objective

Demonstrate understanding of reclaim policy after deleting a PVC bound to a Retain PV.

## Starting state

- Complete task 03 (static PV with Retain) or recreate equivalent objects.

## Requirements

1. With `static-pvc` Bound to a Retain PV, delete the PVC.
2. Observe PV status (expect **Released**, not automatically Available).
3. Document in notes what you must clear/edit on the PV before it can bind a new claim (claimRef).
4. State which access mode you would pick for a shared NFS-style read/write mount across nodes (**ReadWriteMany**) vs single-node database (**ReadWriteOnce**) — add one line to notes Gaps.

## Verify

```bash
kubectl get pv static-pv
# Phase: Released after PVC delete (Retain)
```
