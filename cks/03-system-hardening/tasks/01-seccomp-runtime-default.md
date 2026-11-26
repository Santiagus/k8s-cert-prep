# Task 01 — RuntimeDefault seccomp

## Objective

Run a Pod with the RuntimeDefault seccomp profile.

## Requirements

1. Namespace `cks-sys`.
2. Pod `seccomp-pod` with `securityContext.seccompProfile.type: RuntimeDefault` at Pod or container level.
3. Pod Running.

## Verify

```bash
kubectl -n cks-sys get pod seccomp-pod -o yaml | grep -A2 seccompProfile
```
