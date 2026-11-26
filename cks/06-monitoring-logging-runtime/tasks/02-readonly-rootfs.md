# Task 02 — Immutable root filesystem

## Objective

Run a Pod with `readOnlyRootFilesystem: true` and an emptyDir for temp writes if needed.

## Requirements

1. Namespace `cks-runtime`.
2. Pod that starts successfully with read-only root FS (choose a compatible image/command).
3. Confirm securityContext in the live Pod object.

## Verify

```bash
kubectl -n cks-runtime get pod <name> -o jsonpath='{.spec.containers[0].securityContext.readOnlyRootFilesystem}'
# true
```
