# Task 05 — Prefer emptyDir over hostPath

## Objective

Replace a dangerous hostPath pattern with emptyDir for scratch data.

## Requirements

1. Namespace `cks-psa` (or `cks-psa-restricted` if still labeled baseline-friendly).
2. Pod `scratch` mounting an `emptyDir` at `/data` (not hostPath).
3. Write a file in `/data` via `kubectl exec` to prove it works.
4. In Gaps: one sentence on why hostPath expands blast radius to the node.

## Verify

```bash
kubectl -n cks-psa get pod scratch -o jsonpath='{.spec.volumes[*]}{"\n"}'
kubectl -n cks-psa exec scratch -- sh -c 'echo hi > /data/x && cat /data/x'
```
