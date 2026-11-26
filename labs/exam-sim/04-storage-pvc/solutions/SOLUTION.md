# Solution — 04 storage pvc

## Diagnose

```bash
kubectl get sc
kubectl -n sim-store describe pvc db-data
# storageClassName: fake-storage → no provisioner
kubectl -n sim-store describe pod db
```

## Fix

Point the PVC at the default class from kind-bootstrap (`local-path`), or omit `storageClassName` to use the default.

PVC `storageClassName` is immutable on many versions — delete and recreate the PVC (and Pod if needed):

```bash
kubectl -n sim-store delete pod db
kubectl -n sim-store delete pvc db-data
kubectl -n sim-store apply -f - <<'EOF'
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: db-data
spec:
  accessModes: ["ReadWriteOnce"]
  resources:
    requests:
      storage: 1Gi
  storageClassName: local-path
---
apiVersion: v1
kind: Pod
metadata:
  name: db
  labels:
    app: db
spec:
  containers:
    - name: box
      image: busybox:1.36
      command: ["sh", "-c", "sleep 3600"]
      volumeMounts:
        - name: data
          mountPath: /data
  volumes:
    - name: data
      persistentVolumeClaim:
        claimName: db-data
EOF
kubectl -n sim-store wait --for=condition=Ready pod/db --timeout=120s
```

## Verify

```bash
./labs/exam-sim/04-storage-pvc/verify.sh
```
