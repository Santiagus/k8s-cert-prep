# Task 06 — Immutable container combo

## Objective

Combine runtime hardening fields into one Pod that still Runs.

## Requirements

1. Namespace `cks-runtime`.
2. Pod `immutable` with:
   - `readOnlyRootFilesystem: true`
   - `allowPrivilegeEscalation: false`
   - `capabilities.drop: ["ALL"]`
   - `seccompProfile.type: RuntimeDefault` (Pod or container)
3. Use `emptyDir` mounts if the image needs writable `/tmp`.
4. Pod Running.

## Verify

```bash
kubectl -n cks-runtime get pod immutable -o jsonpath='{.spec.containers[0].securityContext}'
```
