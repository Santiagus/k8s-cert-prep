# Solution 06 — Immutable combo

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: immutable
  namespace: cks-runtime
spec:
  securityContext:
    seccompProfile:
      type: RuntimeDefault
    runAsNonRoot: true
    runAsUser: 1000
  containers:
    - name: pause
      image: registry.k8s.io/pause:3.9
      securityContext:
        readOnlyRootFilesystem: true
        allowPrivilegeEscalation: false
        capabilities:
          drop: ["ALL"]
        runAsNonRoot: true
        runAsUser: 1000
```

For nginx-class images, add `emptyDir` for `/tmp` and `/var/cache/nginx` as needed.
