# Solution — 03 networking endpoints

## Diagnose

```bash
kubectl -n sim-net get pods --show-labels
kubectl -n sim-net get svc api -o yaml | grep -A5 selector
kubectl -n sim-net get endpoints api
# Pods: app=api ; Service: app=api-v2 → no endpoints
```

## Fix

Align selector (fastest):

```bash
kubectl -n sim-net patch svc api -p '{"spec":{"selector":{"app":"api"}}}'
kubectl -n sim-net get endpoints api
```

Or relabel Pods (worse if Deployment keeps rewriting labels) — prefer fixing the Service.

## Verify

```bash
./labs/exam-sim/03-networking-endpoints/verify.sh
```
