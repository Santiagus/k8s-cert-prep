# Task 01 — Disable SA token automount

## Objective

Run a Pod without an auto-mounted ServiceAccount token.

## Requirements

1. Namespace `cks-hard`.
2. Pod `notoken` using image `busybox:1.36` (sleep) with `automountServiceAccountToken: false`.
3. Confirm `/var/run/secrets/kubernetes.io/serviceaccount` is absent (or mount fails / empty as expected).

## Verify

```bash
kubectl -n cks-hard exec notoken -- ls /var/run/secrets/kubernetes.io/serviceaccount
# expect failure / no directory
```
