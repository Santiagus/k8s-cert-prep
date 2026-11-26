# Solution 06 — logs --previous

```bash
kubectl apply -f cka/05-troubleshooting/setup/01-crashloop.yaml
# wait for a restart
kubectl -n ts-crash get pod flaky -w
# Ctrl+C when Restarts >= 1

kubectl -n ts-crash logs flaky
kubectl -n ts-crash logs flaky --previous | tee flaky-previous.txt

# then fix as in solution 01
kubectl -n ts-crash delete pod flaky
kubectl -n ts-crash run flaky --image=busybox:1.36 --restart=Always --command -- sleep 3600
```

`--previous` fails if the container never restarted — wait for CrashLoopBackOff first.
