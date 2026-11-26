# Task 03 — Service with no Endpoints

## Objective

Make Service `store` route to its Deployment Pods.

## Starting state

```bash
kubectl apply -f cka/05-troubleshooting/setup/03-service-endpoints.yaml
kubectl -n ts-svc rollout status deploy/store
```

## Requirements

1. Confirm Endpoints for Service `store` are empty while Pods are Running.
2. Fix the misconfiguration (do not delete the Deployment unless necessary).
3. Endpoints list Pod IPs; `wget` to the Service from a test Pod succeeds.

## Verify

```bash
kubectl -n ts-svc get endpoints store
kubectl -n ts-svc run tmp --rm -it --restart=Never --image=busybox:1.36 -- wget -qO- http://store
```
