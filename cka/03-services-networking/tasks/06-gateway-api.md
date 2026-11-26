# Task 06 — Gateway API HTTPRoute (authoring)

## Objective

Author Gateway API objects that route `shop.example.com` to Service `web` in `net-lab`.

## Starting state

- Service `web` in `net-lab` (create a minimal Deployment+Service if needed).
- Installing a full Gateway controller is optional for this task; focus on correct YAML. If you install one (OSS), verify end-to-end.

## Requirements

1. Install Gateway API standard CRDs **or** assume they are present (`kubectl get crd gateways.gateway.networking.k8s.io`).
2. Create a `GatewayClass` named `cka-example` (controllerName can be a placeholder string if no controller is installed, e.g. `example.com/cka`).
3. Create a `Gateway` `shop-gw` in `net-lab` listening HTTP `:80` with that GatewayClass.
4. Create an `HTTPRoute` `shop-route` attaching to that Gateway, matching host `shop.example.com`, forwarding to Service `web` port 80.

## Verify

```bash
kubectl get gatewayclass cka-example
kubectl -n net-lab get gateway shop-gw
kubectl -n net-lab get httproute shop-route -o yaml
```

Docs: [Gateway API](https://gateway-api.sigs.k8s.io/).
