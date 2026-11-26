# Task 02 — Ingress with TLS

## Objective

Expose a Service via Ingress using a TLS Secret.

## Requirements

1. Namespace `cks-setup` (reuse).
2. Deployment+Service `secure-web` on port 80.
3. TLS Secret `secure-web-tls` (self-signed is fine for lab) for host `secure.example.com`.
4. Ingress `secure-web` with TLS host `secure.example.com` and HTTP path to the Service.
5. Ingress controller installed (see CKA networking notes).

## Verify

```bash
kubectl -n cks-setup get secret secure-web-tls
kubectl -n cks-setup get ing secure-web -o yaml
```
