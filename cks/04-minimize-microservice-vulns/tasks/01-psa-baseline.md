# Task 01 — Enforce baseline Pod Security

## Objective

Label a namespace so baseline Pod Security is enforced.

## Requirements

1. Namespace `cks-psa` with enforce/warn/audit labels for **baseline** (latest version label as used in current docs).
2. Attempt to create a Pod that violates baseline (e.g. `hostNetwork: true`) and show it is rejected.
3. Create a compliant Pod that Runs.

## Verify

```bash
kubectl get ns cks-psa --show-labels
# privileged-ish Pod rejected; compliant Pod Running
```
