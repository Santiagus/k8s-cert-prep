# Task 01 — RBAC for a deployer ServiceAccount

## Objective

Grant a ServiceAccount permission to manage Deployments and Pods in one namespace only.

## Starting state

- Working cluster (kind `cka-prep` is fine).
- No objects from this task exist yet.

## Requirements

1. Create namespace `rbac-lab`.
2. Create ServiceAccount `deployer` in `rbac-lab`.
3. Create a Role that allows `get`, `list`, `watch`, `create`, `update`, `patch`, `delete` on `pods` and `deployments` (include `deployments/scale` if you use scale subresource) in `rbac-lab`.
4. Bind that Role to ServiceAccount `deployer`.
5. Prove authorization: as that ServiceAccount, `create` of Deployments in `rbac-lab` should be allowed; the same check in namespace `default` should be denied.

## Verify

```bash
kubectl -n rbac-lab get sa deployer
kubectl -n rbac-lab get role,rolebinding
kubectl auth can-i create deployments --as=system:serviceaccount:rbac-lab:deployer -n rbac-lab
kubectl auth can-i create deployments --as=system:serviceaccount:rbac-lab:deployer -n default
```

Expect: `yes` then `no`.
