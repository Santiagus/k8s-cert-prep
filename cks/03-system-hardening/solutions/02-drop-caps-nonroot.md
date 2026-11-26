# Solution 02 — non-root + drop ALL

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: hardened
  namespace: cks-sys
spec:
  securityContext:
    runAsNonRoot: true
    runAsUser: 101
    seccompProfile:
      type: RuntimeDefault
  containers:
    - name: nginx
      image: nginxinc/nginx-unprivileged:1.25
      securityContext:
        allowPrivilegeEscalation: false
        capabilities:
          drop: ["ALL"]
```

If the image pull fails, any non-root-capable image is fine for the exercise.
