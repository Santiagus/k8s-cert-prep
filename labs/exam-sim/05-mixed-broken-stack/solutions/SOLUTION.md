# Solution — 05 mixed broken stack

## Triage order (suggested)

1. PVC / StorageClass (blocks Pod scheduling when volume pending).
2. Image tag.
3. Replicas → 1 (RWO PVC + multi-replica is painful).
4. ConfigMap env.
5. Service selector.

## Fix sketch

```bash
NS=sim-mixed

# PVC: storageClassName often immutable → recreate
kubectl -n "$NS" delete deploy checkout
kubectl -n "$NS" delete pvc checkout-data
kubectl -n "$NS" apply -f - <<'EOF'
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: checkout-data
  namespace: sim-mixed
spec:
  accessModes: ["ReadWriteOnce"]
  resources:
    requests:
      storage: 1Gi
  storageClassName: local-path
EOF

kubectl -n "$NS" apply -f - <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: checkout
  namespace: sim-mixed
spec:
  replicas: 1
  selector:
    matchLabels:
      app: checkout
  template:
    metadata:
      labels:
        app: checkout
    spec:
      containers:
        - name: nginx
          image: nginx:1.25
          ports:
            - containerPort: 80
          env:
            - name: APP_ENV
              valueFrom:
                configMapKeyRef:
                  name: checkout-cfg
                  key: APP_ENV
          volumeMounts:
            - name: data
              mountPath: /data
      volumes:
        - name: data
          persistentVolumeClaim:
            claimName: checkout-data
EOF

kubectl -n "$NS" patch svc checkout -p '{"spec":{"selector":{"app":"checkout"}}}'
kubectl -n "$NS" rollout status deploy/checkout --timeout=120s
```

## Verify

```bash
./labs/exam-sim/05-mixed-broken-stack/verify.sh
```
