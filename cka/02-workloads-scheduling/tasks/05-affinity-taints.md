# Task 05 — Taints, tolerations, and node affinity

## Objective

Schedule a Pod onto a tainted worker using a matching toleration and a node label affinity.

## Starting state

- kind cluster with at least one worker node (bootstrap lab).

## Requirements

1. Pick one **worker** node. Label it `disk=ssd`.
2. Taint that node `dedicated=storage:NoSchedule`.
3. Namespace `sched-lab`.
4. Pod `ssd-pod` (image `nginx:1.25`) that:
   - tolerates `dedicated=storage` with effect `NoSchedule`
   - requires node affinity for `disk=ssd` (requiredDuringSchedulingIgnoredDuringExecution)
5. Pod reaches Running on the labeled/tainted node.

## Verify

```bash
kubectl -n sched-lab get pod ssd-pod -o wide
# NODE should be the worker you labeled
```

Cleanup when done: remove the taint so other drills are not blocked.
