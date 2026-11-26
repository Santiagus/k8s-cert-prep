# Task 01 — Deployment rollout and rollback

## Objective

Perform a rolling update and roll back to the previous revision.

## Starting state

- Working cluster.

## Requirements

1. Namespace `work-lab`.
2. Deployment `web` with **3** replicas of `nginx:1.25`.
3. Update the container image to `nginx:1.26` and wait until the rollout finishes.
4. Confirm rollout history shows at least 2 revisions.
5. Roll back to the previous revision so running Pods use `nginx:1.25` again.

## Verify

```bash
kubectl -n work-lab rollout history deploy/web
kubectl -n work-lab get pods -o jsonpath='{range .items[*]}{.spec.containers[0].image}{"\n"}{end}'
# expect nginx:1.25 after rollback
```
