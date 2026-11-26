# Solution 04 — Egress deny + DNS

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-egress
  namespace: cks-setup
spec:
  podSelector: {}
  policyTypes: ["Egress"]
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-web-dns
  namespace: cks-setup
spec:
  podSelector:
    matchLabels:
      app: web
  policyTypes: ["Egress"]
  egress:
    - ports:
        - protocol: UDP
          port: 53
        - protocol: TCP
          port: 53
```

Some clusters need an extra egress rule to the `kube-system` / kube-dns Pod or Service — check CoreDNS endpoints if resolution still fails under a real enforcing CNI.
