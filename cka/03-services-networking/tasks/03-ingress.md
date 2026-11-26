# Task 03 — Ingress

## Objective

Route host-based HTTP traffic to Service `web` via an Ingress.

## Starting state

- Working cluster with an Ingress controller installed (for kind: [ingress-nginx kind deploy](https://kind.sigs.k8s.io/docs/user/ingress/)).
- Service `web` in `net-lab` from earlier tasks (create if missing).

## Requirements

1. Ingress `web-ing` in `net-lab`.
2. Host `shop.example.com` path `/` (Prefix or ImplementationSpecific as appropriate) backend Service `web` port 80.
3. Ingress shows an address once the controller processes it (may be pending on bare kind without port mappings — object correctness still required).

## Verify

```bash
kubectl -n net-lab get ing web-ing -o yaml
```
