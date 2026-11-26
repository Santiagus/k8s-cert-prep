# Solution — CKA mixed drill

One fast path. Adjust image tags if your mirror differs.

```bash
kubectl create ns drill

kubectl -n drill create configmap shop-cfg --from-literal=SHOP_MODE=sale

# PVC first
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: shop-data
  namespace: drill
spec:
  accessModes: ["ReadWriteOnce"]
  resources:
    requests:
      storage: 1Gi
EOF

# Deployment with env + volume (1 replica for RWO)
kubectl -n drill create deployment shop --image=nginx:1.25 --replicas=1 --dry-run=client -o yaml > /tmp/shop.yaml
# Edit /tmp/shop.yaml: add resources.requests, envFrom/configMapRef, volume + volumeMount
# Or apply the manifest below.
```

Manifest:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: shop
  namespace: drill
spec:
  replicas: 1
  selector:
    matchLabels:
      app: shop
  template:
    metadata:
      labels:
        app: shop
    spec:
      containers:
        - name: nginx
          image: nginx:1.25
          ports:
            - containerPort: 80
          resources:
            requests:
              cpu: 50m
              memory: 64Mi
          env:
            - name: SHOP_MODE
              valueFrom:
                configMapKeyRef:
                  name: shop-cfg
                  key: SHOP_MODE
          volumeMounts:
            - name: data
              mountPath: /data
      volumes:
        - name: data
          persistentVolumeClaim:
            claimName: shop-data
---
apiVersion: v1
kind: Service
metadata:
  name: shop
  namespace: drill
spec:
  selector:
    app: shop
  ports:
    - port: 80
      targetPort: 80
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: shop-allow-dns
  namespace: drill
spec:
  podSelector:
    matchLabels:
      app: shop
  policyTypes: ["Egress"]
  egress:
    - to:
        - namespaceSelector: {}
      ports:
        - protocol: UDP
          port: 53
        - protocol: TCP
          port: 53
    - ports:
        - protocol: TCP
          port: 80
```

```bash
kubectl -n drill expose deployment shop --port=80 --target-port=80 --name=shop
# if Service not in the multi-doc apply above

kubectl -n drill rollout status deploy/shop
kubectl -n drill exec deploy/shop -- printenv SHOP_MODE
kubectl -n drill get pvc shop-data
```

**Common failure:** PVC Pending — confirm default StorageClass from kind-bootstrap. Multi-replica + RWO → attach errors; keep replicas at 1 for this drill.
