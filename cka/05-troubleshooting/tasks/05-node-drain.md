# Task 05 — Cordon and drain

## Objective

Safely evacuate a worker node and restore it.

## Starting state

- kind cluster with ≥1 worker.
- Create a disposable Deployment so you can see Pods move:

```bash
kubectl create ns ts-drain
kubectl -n ts-drain create deployment move --image=nginx:1.25 --replicas=3
```

## Requirements

1. Choose a **worker** node that has at least one `move` Pod (or any schedulable worker).
2. Cordon the node; confirm `SchedulingDisabled`.
3. Drain the node (`--ignore-daemonsets` and delete emptydir data as needed).
4. Confirm `move` Pods are not on that node.
5. Uncordon the node.

## Verify

```bash
kubectl get nodes
kubectl -n ts-drain get pods -o wide
```
