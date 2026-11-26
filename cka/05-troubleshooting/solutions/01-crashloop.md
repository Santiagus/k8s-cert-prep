# Solution 01 — CrashLoopBackOff

```bash
kubectl apply -f cka/05-troubleshooting/setup/01-crashloop.yaml
kubectl -n ts-crash describe pod flaky
kubectl -n ts-crash logs flaky
# command exits 1 → CrashLoopBackOff
```

Fix (delete/recreate or replace Pod — immutable command field):

```bash
kubectl -n ts-crash delete pod flaky
kubectl -n ts-crash run flaky --image=busybox:1.36 --restart=Always --command -- sleep 3600
# or apply a corrected Pod YAML with the same name
```

**Failure modes:** Editing a live Pod's command via `kubectl edit` may be rejected; use replace/delete+create.
