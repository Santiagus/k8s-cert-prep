# Task 02 — Secret as volume

## Objective

Mount a Secret as files (preferred over env for many cases).

## Requirements

1. Secret `db-pass` in `cks-psa` with key `password`.
2. Pod mounts it at `/etc/db` read-only.
3. `cat /etc/db/password` works.

## Verify

```bash
kubectl -n cks-psa exec <pod> -- cat /etc/db/password
```
