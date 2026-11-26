# Task 01 — Default-deny NetworkPolicy

## Objective

Lock down a namespace so Pods cannot receive unexpected ingress.

## Requirements

1. Namespace `cks-setup`.
2. Pod `web` (nginx:1.25) labeled `app=web`.
3. NetworkPolicy `default-deny-ingress` selecting all Pods, policyTypes Ingress, with **no** ingress rules (deny all ingress).
4. NetworkPolicy `allow-dns-egress` optional if you also deny egress — at minimum ingress deny is required.

## Verify

```bash
kubectl -n cks-setup get netpol
kubectl -n cks-setup describe netpol default-deny-ingress
```
