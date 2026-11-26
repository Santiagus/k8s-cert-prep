# Task 04 — Do not privilege the default SA

## Objective

Run a workload with a dedicated SA and prove `default` stays unprivileged.

## Requirements

1. Namespace `cks-hard`.
2. SA `app-sa`; Role allowing `get/list` on `configmaps`; RoleBinding to **`app-sa` only**.
3. Pod `app` that sets `serviceAccountName: app-sa` and `automountServiceAccountToken: true` (needs API) **or** false if unused — pick one and document.
4. Show `auth can-i` as `default` SA cannot get configmaps; `app-sa` can.

## Verify

```bash
kubectl auth can-i get configmaps --as=system:serviceaccount:cks-hard:app-sa -n cks-hard
kubectl auth can-i get configmaps --as=system:serviceaccount:cks-hard:default -n cks-hard
kubectl -n cks-hard get pod app -o jsonpath='{.spec.serviceAccountName}{"\n"}'
```
