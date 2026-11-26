# Solution — 09 SecurityContext harden

Easiest path that stays Ready under read-only root FS: switch to pause and set hardening fields.

```bash
kubectl -n sim-sc apply -f - <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api
spec:
  replicas: 1
  selector:
    matchLabels:
      app: api
  template:
    metadata:
      labels:
        app: api
    spec:
      securityContext:
        seccompProfile:
          type: RuntimeDefault
        runAsNonRoot: true
        runAsUser: 65532
      containers:
        - name: api
          image: registry.k8s.io/pause:3.9
          securityContext:
            allowPrivilegeEscalation: false
            readOnlyRootFilesystem: true
            capabilities:
              drop: ["ALL"]
            runAsNonRoot: true
            runAsUser: 65532
EOF

kubectl -n sim-sc rollout status deploy/api
./labs/exam-sim/09-securitycontext-harden/verify.sh
```

Keeping `nginx` works if you add emptyDir mounts for writable paths and use an unprivileged image — pause is faster under a timer.
