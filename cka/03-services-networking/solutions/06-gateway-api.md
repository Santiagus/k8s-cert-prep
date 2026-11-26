# Solution 06 — Gateway API

Install CRDs (standard channel example — pin a release in real use):

```bash
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.2.0/standard-install.yaml
kubectl get crd gateways.gateway.networking.k8s.io
```

Ensure backend exists:

```bash
kubectl create ns net-lab 2>/dev/null || true
kubectl -n net-lab create deployment web --image=nginx:1.25 2>/dev/null || true
kubectl -n net-lab expose deployment web --port=80 2>/dev/null || true
```

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: GatewayClass
metadata:
  name: cka-example
spec:
  controllerName: example.com/cka
---
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: shop-gw
  namespace: net-lab
spec:
  gatewayClassName: cka-example
  listeners:
    - name: http
      protocol: HTTP
      port: 80
      allowedRoutes:
        namespaces:
          from: Same
---
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: shop-route
  namespace: net-lab
spec:
  parentRefs:
    - name: shop-gw
  hostnames:
    - shop.example.com
  rules:
    - backendRefs:
        - name: web
          port: 80
```

```bash
kubectl apply -f /tmp/gateway.yaml
kubectl -n net-lab get gateway,httproute
```

Without a real controller, Gateway status may stay Pending — object authoring is still the learning goal. For traffic tests, install an OSS Gateway implementation and set `controllerName` accordingly.
