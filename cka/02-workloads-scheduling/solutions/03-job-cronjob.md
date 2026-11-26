# Solution 03 — Job and CronJob

```bash
kubectl create ns batch-lab

kubectl -n batch-lab create job pi --image=busybox:1.36 -- echo done
kubectl -n batch-lab wait --for=condition=complete job/pi --timeout=60s

kubectl -n batch-lab create cronjob tick --image=busybox:1.36 \
  --schedule="*/5 * * * *" -- /bin/sh -c 'date; echo tick'

kubectl -n batch-lab get job pi
kubectl -n batch-lab get cronjob tick -o wide
```

**Failure modes:** Cron schedule quoting; Job image needing a real command (`--` separator).
