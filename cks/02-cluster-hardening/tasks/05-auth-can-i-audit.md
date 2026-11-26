# Task 05 — RBAC can-i audit worksheet

## Objective

Use `kubectl auth can-i` to map what a ServiceAccount can do (exam speed habit).

## Requirements

1. Reuse SA `cm-reader` from task 02 (or recreate it).
2. Run `kubectl auth can-i --list --as=system:serviceaccount:cks-hard:cm-reader -n cks-hard`.
3. In your Gaps notes (not committed secrets), record: which resources appear, and one verb you would remove if the Role were too wide.
4. Negative check: `create deployments.apps` should be no.

## Verify

```bash
kubectl auth can-i --list --as=system:serviceaccount:cks-hard:cm-reader -n cks-hard
kubectl auth can-i create deployments.apps --as=system:serviceaccount:cks-hard:cm-reader -n cks-hard
```
