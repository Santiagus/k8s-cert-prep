# Solution 04 — NetworkPolicy

```bash
kubectl create ns policy-lab
kubectl -n policy-lab run backend --image=nginx:1.25 --labels=role=backend
kubectl -n policy-lab expose pod backend --port=80 --name=backend
kubectl -n policy-lab run frontend --image=busybox:1.36 --labels=role=frontend --command -- sleep 3600
kubectl -n policy-lab run other --image=busybox:1.36 --labels=role=other --command -- sleep 3600
```

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: backend-allow-frontend
  namespace: policy-lab
spec:
  podSelector:
    matchLabels:
      role: backend
  policyTypes:
    - Ingress
  ingress:
    - from:
        - podSelector:
            matchLabels:
              role: frontend
      ports:
        - protocol: TCP
          port: 80
```

```bash
kubectl apply -f /tmp/netpol.yaml
```

**CNI:** Without policy enforcement, both wget calls may succeed — still valid YAML practice. For real deny behavior, install Calico (or similar) on kind.

**Failure modes:** Empty `podSelector: {}` accidentally selecting all pods; forgetting `policyTypes`.
