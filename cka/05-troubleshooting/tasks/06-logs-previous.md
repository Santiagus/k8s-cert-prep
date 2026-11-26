# Task 06 — Previous container logs

## Objective

Capture logs from a crashed container instance using `--previous`.

## Starting state

Reuse or recreate the crash setup, then fix it **after** capturing evidence:

```bash
kubectl apply -f cka/05-troubleshooting/setup/01-crashloop.yaml
# wait until CrashLoopBackOff / at least one restart
```

## Requirements

1. Show current logs and previous logs for `flaky` in `ts-crash`.
2. Save the previous log output to a local file `flaky-previous.txt` in your working directory (do not commit secrets; this content is harmless).
3. Then fix the Pod so it Runs (same as task 01) **or** delete the namespace if you already fixed it.

## Verify

```bash
kubectl -n ts-crash logs flaky --previous
test -s flaky-previous.txt
```

Add `flaky-previous.txt` to your personal gitignore if you create it locally — do not commit exam dumps; this file is optional practice output.
