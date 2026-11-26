# Task 02 — NodePort Service

## Objective

Publish an app on a fixed NodePort.

## Starting state

- Working cluster; Deployment/Service from task 01 may be reused or recreated in `net-lab`.

## Requirements

1. Ensure Deployment `web` exists in `net-lab`.
2. Create or patch Service `web-node` of type **NodePort** exposing port 80 with **nodePort 30080**.
3. Confirm `kubectl get svc web-node` shows `80:30080/TCP`.

## Verify

```bash
kubectl -n net-lab get svc web-node -o yaml | grep -A3 ports
```

(From a kind node, traffic to `<nodeIP>:30080` may work depending on networking; API object correctness is the primary check.)
