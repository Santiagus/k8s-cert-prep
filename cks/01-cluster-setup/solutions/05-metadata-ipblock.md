# Solution 05 — Metadata ipBlock

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: deny-metadata
  namespace: cks-setup
spec:
  podSelector:
    matchLabels:
      app: web
  policyTypes: ["Egress"]
  egress:
    - to:
        - ipBlock:
            cidr: 0.0.0.0/0
            except:
              - 169.254.169.254/32
```

If a namespace-wide default-deny egress already exists, this policy **adds** allowed egress for `app=web` excluding metadata. Combine with DNS allow (task 04) as needed.

Docs: [NetworkPolicy](https://kubernetes.io/docs/concepts/services-networking/network-policies/).
