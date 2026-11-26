# Solution 03 — Ingress

Install controller first (kind example — see kind ingress docs):

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
kubectl -n ingress-nginx rollout status deploy/ingress-nginx-controller
```

```bash
kubectl -n net-lab create deployment web --image=nginx:1.25 2>/dev/null || true
kubectl -n net-lab expose deployment web --port=80 2>/dev/null || true
```

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: web-ing
  namespace: net-lab
spec:
  # ingressClassName: nginx   # set if your controller requires it
  rules:
    - host: shop.example.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: web
                port:
                  number: 80
```

```bash
kubectl apply -f /tmp/web-ing.yaml
kubectl -n net-lab get ing web-ing
```

**Failure modes:** Missing IngressClass; controller not Ready; wrong Service name/port.
