# Solution 02 — NodePort

```bash
kubectl -n net-lab create deployment web --image=nginx:1.25 --replicas=1 2>/dev/null || true

kubectl -n net-lab expose deployment web --name=web-node --type=NodePort \
  --port=80 --target-port=80 --dry-run=client -o yaml > /tmp/web-node.yaml
# set nodePort: 30080 under ports[0]
```

Or:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: web-node
  namespace: net-lab
spec:
  type: NodePort
  selector:
    app: web
  ports:
    - port: 80
      targetPort: 80
      nodePort: 30080
```

Confirm labels: `create deployment web` labels Pods `app=web`.

```bash
kubectl apply -f /tmp/web-node.yaml
kubectl -n net-lab get svc web-node
```

**Failure modes:** nodePort outside 30000–32767 range; selector mismatch.
