# Task 02 — ConfigMap and Secret consumption

## Objective

Inject configuration via environment variables and a mounted Secret file.

## Starting state

- Working cluster.

## Requirements

1. Namespace `cfg-lab`.
2. ConfigMap `app-config` with key `LOG_LEVEL=debug`.
3. Secret `app-creds` of type Opaque with key `token` (any value).
4. Pod `consumer` (image `busybox:1.36`, command sleep) that:
   - exposes `LOG_LEVEL` from the ConfigMap as an env var
   - mounts the Secret at `/etc/creds` (file `token` present)
5. Pod Running.

## Verify

```bash
kubectl -n cfg-lab exec consumer -- printenv LOG_LEVEL
kubectl -n cfg-lab exec consumer -- cat /etc/creds/token
```
