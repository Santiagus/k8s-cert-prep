# Task 02 — ImagePullBackOff

## Objective

Fix a Pod that cannot pull its image.

## Starting state

```bash
kubectl apply -f cka/05-troubleshooting/setup/02-imagepull.yaml
```

## Requirements

1. Explain the failure from Events / describe output.
2. Change the Pod so it uses a valid image `nginx:1.25` (same Pod name `bad-image` in `ts-pull`).
3. Pod becomes Running.

## Verify

```bash
kubectl -n ts-pull describe pod bad-image | tail -n 20
kubectl -n ts-pull get pod bad-image
```
