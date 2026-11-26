# Task 04 — Pending Pod (resources)

## Objective

Get Pod `heavy` scheduled and Running.

## Starting state

```bash
kubectl apply -f cka/05-troubleshooting/setup/04-pending.yaml
```

## Requirements

1. Determine why `heavy` in `ts-pend` is Pending (`describe` / Events).
2. Fix resource requests to something realistic for your lab nodes (keep the Pod name).
3. Pod is Running.

## Verify

```bash
kubectl -n ts-pend describe pod heavy | grep -A5 Events
kubectl -n ts-pend get pod heavy
```
