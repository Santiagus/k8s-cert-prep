# Solution 05 — AppArmor

Annotation style (widely shown in docs/tutorials):

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: apparmor-pod
  namespace: cks-sys
  annotations:
    container.apparmor.security.beta.kubernetes.io/pause: runtime/default
spec:
  containers:
    - name: pause
      image: registry.k8s.io/pause:3.9
```

Newer field (when API supports it):

```yaml
securityContext:
  appArmorProfile:
    type: RuntimeDefault
```

See [AppArmor](https://kubernetes.io/docs/tutorials/security/apparmor/). kind may not load custom profiles — `runtime/default` is the usual lab choice.
