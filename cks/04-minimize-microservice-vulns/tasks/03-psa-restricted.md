# Task 03 — Enforce restricted Pod Security

## Objective

Tighten a namespace from baseline to **restricted** and land a compliant Pod.

## Requirements

1. Namespace `cks-psa-restricted` (new) with enforce/warn/audit = `restricted`.
2. Attempt a Pod that only meets baseline (e.g. runs as root) and show rejection.
3. Create Pod `ok` that satisfies restricted (non-root, drop ALL, RuntimeDefault seccomp, allowPrivilegeEscalation false). Use an image that works (`nginxinc/nginx-unprivileged:1.25` or `registry.k8s.io/pause:3.9` with runAsUser).
4. Pod `ok` Running.

## Verify

```bash
kubectl get ns cks-psa-restricted --show-labels
kubectl -n cks-psa-restricted get pod ok
```
