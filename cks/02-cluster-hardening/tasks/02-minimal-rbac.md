# Task 02 — Minimal RBAC for configmap read

## Objective

Grant a ServiceAccount read-only access to ConfigMaps in one namespace.

## Requirements

1. SA `cm-reader` in `cks-hard`.
2. Role allowing only `get` and `list` on `configmaps`.
3. RoleBinding to that SA.
4. `auth can-i` shows create pods = no, get configmaps = yes.

## Verify

```bash
kubectl auth can-i get configmaps --as=system:serviceaccount:cks-hard:cm-reader -n cks-hard
kubectl auth can-i create pods --as=system:serviceaccount:cks-hard:cm-reader -n cks-hard
```
