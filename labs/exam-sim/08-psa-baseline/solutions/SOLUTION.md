# Solution — 08 PSA baseline

## Fix

```bash
kubectl label ns sim-psa \
  pod-security.kubernetes.io/enforce=baseline \
  pod-security.kubernetes.io/enforce-version=latest \
  pod-security.kubernetes.io/warn=baseline \
  pod-security.kubernetes.io/audit=baseline --overwrite

# Remove hostNetwork from the Pod template
kubectl -n sim-psa patch deploy web --type=json -p='[
  {"op":"remove","path":"/spec/template/spec/hostNetwork"}
]'
# If patch fails because field missing after edits, re-apply a clean template without hostNetwork.

kubectl -n sim-psa rollout status deploy/web
```

## Verify

```bash
./labs/exam-sim/08-psa-baseline/verify.sh
```
