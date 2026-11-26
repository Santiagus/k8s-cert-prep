# Task 03 — Least-privilege Secret reader

## Objective

Grant a ServiceAccount read access to Secrets in one namespace only — nothing else.

## Requirements

1. Namespace `cks-hard`.
2. SA `secret-reader`.
3. Role `secret-reader` with verbs `get` and `list` on `secrets` only.
4. RoleBinding binding that Role to the SA.
5. Confirm: get secrets = yes; list pods = no; get secrets in another namespace = no (if you can create a second ns for the negative test).

## Verify

```bash
kubectl auth can-i get secrets --as=system:serviceaccount:cks-hard:secret-reader -n cks-hard
kubectl auth can-i list pods --as=system:serviceaccount:cks-hard:secret-reader -n cks-hard
```
