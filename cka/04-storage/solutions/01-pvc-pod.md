# Solution 01 — Dynamic PVC + Pod

```bash
kubectl create ns stor-lab

cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: data-pvc
  namespace: stor-lab
spec:
  accessModes: ["ReadWriteOnce"]
  resources:
    requests:
      storage: 1Gi
---
apiVersion: v1
kind: Pod
metadata:
  name: data-pod
  namespace: stor-lab
spec:
  containers:
    - name: busybox
      image: busybox:1.36
      command: ["sleep", "3600"]
      volumeMounts:
        - name: data
          mountPath: /data
  volumes:
    - name: data
      persistentVolumeClaim:
        claimName: data-pvc
EOF

kubectl -n stor-lab get pvc data-pvc
kubectl -n stor-lab exec data-pod -- touch /data/ok
```

**Failure modes:** No default StorageClass → Pending forever; provisioner Pod not Ready.
