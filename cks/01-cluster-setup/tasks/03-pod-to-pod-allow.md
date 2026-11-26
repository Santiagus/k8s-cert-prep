# Task 03 — Pod-to-Pod allow NetworkPolicy

## Objective

Allow only labeled clients to reach a backend while keeping a default-deny baseline.

## Requirements

1. Namespace `cks-setup` (reuse or create).
2. Pods: `backend` labeled `app=backend`, `client` labeled `app=client` (any simple image).
3. Keep or create `default-deny-ingress` selecting all Pods.
4. NetworkPolicy `allow-client-to-backend` selecting `app=backend`, Ingress from `app=client` on TCP port 80.

## Verify

```bash
kubectl -n cks-setup get netpol allow-client-to-backend -o yaml
kubectl -n cks-setup describe netpol allow-client-to-backend
```
