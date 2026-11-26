# Solution — 01 troubleshoot crashloop

## Diagnose

```bash
kubectl -n sim-crash get pod web
kubectl -n sim-crash describe pod web
kubectl -n sim-crash logs web
# expect: boom / exit 1 → CrashLoopBackOff
```

## Fix

Replace the command with a process that stays alive (exam style: delete+recreate or edit).

```bash
kubectl -n sim-crash delete pod web --force --grace-period=0
kubectl -n sim-crash apply -f - <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: web
  labels:
    app: web
spec:
  restartPolicy: Always
  containers:
    - name: web
      image: busybox:1.36
      command: ["sh", "-c", "echo ok; sleep 3600"]
EOF
kubectl -n sim-crash wait --for=condition=Ready pod/web --timeout=60s
```

Alternatively keep an HTTP server:

```bash
# image nginx:1.25 with no custom command also works if you recreate the Pod
```

## Verify

```bash
./labs/exam-sim/01-troubleshoot-crashloop/verify.sh
```

## Common misses

- Fixing only with `kubectl logs` and not changing the spec.
- Editing a field that kubelet ignores without recreating an immutable Pod field incorrectly — prefer delete + apply for Pods.
