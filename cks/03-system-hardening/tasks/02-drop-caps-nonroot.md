# Task 02 — Non-root and drop capabilities

## Objective

Harden a Pod securityContext.

## Requirements

1. Pod `hardened` in `cks-sys` using an image that can run as non-root (e.g. `nginxinc/nginx-unprivileged:1.25` or configure nginx image appropriately).
2. `runAsNonRoot: true`, `allowPrivilegeEscalation: false`, `capabilities.drop: ["ALL"]`.
3. Pod Running (pick an image that works with these constraints).

## Verify

```bash
kubectl -n cks-sys get pod hardened
kubectl -n cks-sys get pod hardened -o jsonpath='{.spec.containers[0].securityContext}'
```
