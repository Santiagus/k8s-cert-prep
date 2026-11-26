# Task 04 — NetworkPolicy

## Objective

Restrict ingress so only Pods with label `role=frontend` can reach `role=backend` on TCP 80.

## Starting state

- Namespace `policy-lab`.
- CNI that enforces NetworkPolicy preferred; if using default kindnet, still author a correct policy and note enforcement limits.

## Requirements

1. Create namespace `policy-lab`.
2. Pod `backend` labeled `role=backend`, image `nginx:1.25`.
3. Pod `frontend` labeled `role=frontend`, image `busybox:1.36` (sleep).
4. Pod `other` labeled `role=other`, image `busybox:1.36` (sleep).
5. NetworkPolicy `backend-allow-frontend` selecting `role=backend`, policyTypes Ingress, allowing from `role=frontend` on TCP 80 only.
6. With an enforcing CNI: frontend can wget backend; other cannot.

## Verify

```bash
kubectl -n policy-lab get netpol
# with enforcing CNI:
kubectl -n policy-lab exec frontend -- wget -qO- --timeout=2 http://backend
kubectl -n policy-lab exec other -- wget -qO- --timeout=2 http://backend   # should fail
```

Create a ClusterIP Service named `backend` if you use the Service DNS name.
