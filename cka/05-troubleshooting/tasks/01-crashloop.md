# Task 01 — CrashLoopBackOff

## Objective

Restore a crashing Pod so it stays Running.

## Starting state

```bash
kubectl apply -f cka/05-troubleshooting/setup/01-crashloop.yaml
```

## Requirements

1. Diagnose why Pod `flaky` in `ts-crash` is not staying up.
2. Fix the Pod so it runs a long-lived process (e.g. sleep) without changing the Pod name or namespace.
3. Pod status becomes `Running` and remains Ready.

## Verify

```bash
kubectl -n ts-crash get pod flaky
kubectl -n ts-crash logs flaky
```
