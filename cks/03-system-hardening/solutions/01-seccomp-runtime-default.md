# Solution 01 — seccomp RuntimeDefault

```bash
kubectl create ns cks-sys
```

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: seccomp-pod
  namespace: cks-sys
spec:
  securityContext:
    seccompProfile:
      type: RuntimeDefault
  containers:
    - name: nginx
      image: nginx:1.25
```
