# Task 02 — Cluster-scoped node reader

## Objective

Allow a user identity to list and get Nodes cluster-wide without granting namespace admin.

## Starting state

- Working cluster.
- You will use the virtual user name `audit-reader` with `kubectl auth can-i --as=…` (no real user account required).

## Requirements

1. Create a ClusterRole named `node-viewer` that can `get`, `list`, and `watch` `nodes`.
2. Create a ClusterRoleBinding named `audit-reader-nodes` that binds `node-viewer` to user `audit-reader`.
3. Confirm `audit-reader` can list nodes but **cannot** list secrets in `kube-system`.

## Verify

```bash
kubectl auth can-i list nodes --as=audit-reader
kubectl auth can-i list secrets --as=audit-reader -n kube-system
```

Expect: `yes` then `no`.
