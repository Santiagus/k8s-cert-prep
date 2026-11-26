# Solution 03 — Pod-to-Pod allow

```bash
kubectl create ns cks-setup --dry-run=client -o yaml | kubectl apply -f -
kubectl -n cks-setup run backend --image=nginx:1.25 --labels=app=backend
kubectl -n cks-setup run client --image=busybox:1.36 --labels=app=client --command -- sleep 3600
```

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-client-to-backend
  namespace: cks-setup
spec:
  podSelector:
    matchLabels:
      app: backend
  policyTypes: ["Ingress"]
  ingress:
    - from:
        - podSelector:
            matchLabels:
              app: client
      ports:
        - protocol: TCP
          port: 80
```

Ensure `default-deny-ingress` still exists (task 01). CNI must enforce for runtime effect.
