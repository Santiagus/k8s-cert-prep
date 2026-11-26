# Solution 03 — PSA restricted

```bash
kubectl create ns cks-psa-restricted
kubectl label ns cks-psa-restricted \
  pod-security.kubernetes.io/enforce=restricted \
  pod-security.kubernetes.io/enforce-version=latest \
  pod-security.kubernetes.io/warn=restricted \
  pod-security.kubernetes.io/audit=restricted
```

Rejected example (runs as root / missing restricted fields):

```bash
kubectl -n cks-psa-restricted run bad --image=nginx:1.25 --restart=Never
# expect admission error
```

Compliant Pod:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: ok
  namespace: cks-psa-restricted
spec:
  securityContext:
    runAsNonRoot: true
    runAsUser: 1000
    seccompProfile:
      type: RuntimeDefault
  containers:
    - name: pause
      image: registry.k8s.io/pause:3.9
      securityContext:
        allowPrivilegeEscalation: false
        capabilities:
          drop: ["ALL"]
        runAsNonRoot: true
        runAsUser: 1000
```
