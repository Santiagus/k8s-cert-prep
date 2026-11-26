# Task 03 — Job and CronJob

## Objective

Run a one-shot Job and a scheduled CronJob.

## Starting state

- Working cluster.

## Requirements

1. Namespace `batch-lab`.
2. Job `pi` that runs a short command (e.g. `busybox:1.36` with `echo done`) and completes successfully (`completions=1`).
3. CronJob `tick` that runs every 5 minutes with image `busybox:1.36` and command that prints the date; suspend is **false**.
4. Confirm Job pods succeeded; CronJob exists with the correct schedule.

## Verify

```bash
kubectl -n batch-lab get job pi
kubectl -n batch-lab get cronjob tick -o wide
```
