# Task 04 — Reject hostNetwork / hostPID pattern

## Objective

Practice spotting and fixing Pods that share host namespaces.

## Requirements

1. Namespace `cks-sys`.
2. Create Pod `isolated` that explicitly sets `hostNetwork: false`, `hostPID: false`, `hostIPC: false` (or omits them — default false) and Runs.
3. Show a **dry-run** or rejected attempt of a Pod with `hostNetwork: true` under a baseline PSA namespace **or** document why that Pod is dangerous (blast radius) if PSA is not labeled yet.
4. Prefer linking PSA task in domain 04 for the admission rejection path.

## Verify

```bash
kubectl -n cks-sys get pod isolated -o jsonpath='{.spec.hostNetwork} {.spec.hostPID} {.spec.hostIPC}{"\n"}'
# expect empty/false
```
