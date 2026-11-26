# Task 03 — Forbid privilege escalation

## Objective

Ensure a container cannot gain more privileges than its parent process.

## Requirements

1. Namespace `cks-sys`.
2. Pod `no-escalation` with container `securityContext.allowPrivilegeEscalation: false`.
3. Also set `capabilities.drop: ["ALL"]` on that container.
4. Pod Running.

## Verify

```bash
kubectl -n cks-sys get pod no-escalation -o jsonpath='{.spec.containers[0].securityContext}'
```
