# Solution 02 — Ingress TLS

```bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /tmp/tls.key -out /tmp/tls.crt -subj "/CN=secure.example.com"
kubectl -n cks-setup create secret tls secure-web-tls --cert=/tmp/tls.crt --key=/tmp/tls.key
kubectl -n cks-setup create deployment secure-web --image=nginx:1.25
kubectl -n cks-setup expose deployment secure-web --port=80
```

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: secure-web
  namespace: cks-setup
spec:
  tls:
    - hosts: ["secure.example.com"]
      secretName: secure-web-tls
  rules:
    - host: secure.example.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: secure-web
                port:
                  number: 80
```
