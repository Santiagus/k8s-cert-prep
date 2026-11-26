# Task 04 — Resource requests and HPA

## Objective

Set CPU requests on a Deployment and attach a HorizontalPodAutoscaler.

## Starting state

- Working cluster.
- For HPA to change replica counts based on CPU, Metrics Server must be installed. If metrics are unavailable, still create a valid HPA object and note that in verification.

## Requirements

1. Namespace `hpa-lab`.
2. Deployment `api` with image `nginx:1.25`, **2** replicas, container CPU **request** `100m` and **limit** `200m`.
3. HPA named `api` targeting Deployment `api`: min **2**, max **5**, target CPU utilization **70%**.

## Verify

```bash
kubectl -n hpa-lab get deploy api -o yaml | grep -A5 resources
kubectl -n hpa-lab get hpa api
```
