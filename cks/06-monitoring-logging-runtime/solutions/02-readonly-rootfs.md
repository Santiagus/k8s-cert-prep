# Solution 02 — readOnlyRootFilesystem

```bash
kubectl create ns cks-runtime
```

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: immutable
  namespace: cks-runtime
spec:
  containers:
    - name: pause
      image: registry.k8s.io/pause:3.9
      securityContext:
        readOnlyRootFilesystem: true
        allowPrivilegeEscalation: false
```

Apps needing `/tmp` should mount `emptyDir` there.
