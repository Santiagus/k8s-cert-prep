# Solution 02 — ConfigMap and Secret

```bash
kubectl create ns cfg-lab
kubectl -n cfg-lab create configmap app-config --from-literal=LOG_LEVEL=debug
kubectl -n cfg-lab create secret generic app-creds --from-literal=token=s3cret-token

kubectl -n cfg-lab run consumer --image=busybox:1.36 --restart=Never \
  --dry-run=client -o yaml --command -- sleep 3600 > /tmp/consumer.yaml
```

Edit `/tmp/consumer.yaml` to add env + volumeMounts, or apply:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: consumer
  namespace: cfg-lab
spec:
  containers:
    - name: consumer
      image: busybox:1.36
      command: ["sleep", "3600"]
      env:
        - name: LOG_LEVEL
          valueFrom:
            configMapKeyRef:
              name: app-config
              key: LOG_LEVEL
      volumeMounts:
        - name: creds
          mountPath: /etc/creds
          readOnly: true
  volumes:
    - name: creds
      secret:
        secretName: app-creds
```

```bash
kubectl apply -f /tmp/consumer.yaml   # or the YAML above
kubectl -n cfg-lab exec consumer -- printenv LOG_LEVEL
kubectl -n cfg-lab exec consumer -- cat /etc/creds/token
```
