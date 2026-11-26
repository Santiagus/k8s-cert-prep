# Solution 01 — Default-deny

```bash
kubectl create ns cks-setup
kubectl -n cks-setup run web --image=nginx:1.25 --labels=app=web
```

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-ingress
  namespace: cks-setup
spec:
  podSelector: {}
  policyTypes: ["Ingress"]
```

CNI must enforce policies for runtime effect.
