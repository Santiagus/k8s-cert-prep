# Solution 01 — PSA baseline

```bash
kubectl create ns cks-psa
kubectl label ns cks-psa \
  pod-security.kubernetes.io/enforce=baseline \
  pod-security.kubernetes.io/enforce-version=latest \
  pod-security.kubernetes.io/warn=baseline \
  pod-security.kubernetes.io/audit=baseline
```

HostNetwork Pod should fail admission; normal nginx Pod succeeds.
