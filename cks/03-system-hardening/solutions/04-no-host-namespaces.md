# Solution 04 — No host namespaces

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: isolated
  namespace: cks-sys
spec:
  hostNetwork: false
  hostPID: false
  hostIPC: false
  containers:
    - name: pause
      image: registry.k8s.io/pause:3.9
```

`hostNetwork: true` bypasses NetworkPolicy for that Pod and exposes host interfaces — pair with PSA baseline (domain 04) to reject at admission.
