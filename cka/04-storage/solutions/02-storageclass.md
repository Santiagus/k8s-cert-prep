# Solution 02 — Custom StorageClass

```bash
cat <<'EOF' | kubectl apply -f -
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: cka-local
provisioner: rancher.io/local-path
reclaimPolicy: Retain
volumeBindingMode: WaitForFirstConsumer
EOF

# ensure not default
kubectl get sc

cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: retain-pvc
  namespace: stor-lab
spec:
  storageClassName: cka-local
  accessModes: ["ReadWriteOnce"]
  resources:
    requests:
      storage: 500Mi
---
apiVersion: v1
kind: Pod
metadata:
  name: retain-pod
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
        claimName: retain-pvc
EOF

kubectl -n stor-lab get pvc retain-pvc
```

**Failure modes:** Wrong provisioner string; expecting Immediate bind with WaitForFirstConsumer before a Pod exists.
