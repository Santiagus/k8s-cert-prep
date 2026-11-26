# Task 04 — Default-deny egress + DNS allow

## Objective

Lock down egress while preserving DNS resolution for selected Pods.

## Requirements

1. Namespace `cks-setup`.
2. NetworkPolicy `default-deny-egress` selecting all Pods, policyTypes Egress, no egress rules.
3. NetworkPolicy `allow-web-dns` selecting Pods `app=web`, allowing egress UDP and TCP port 53.
4. (Optional) Also allow egress to an in-cluster Service CIDR if your CNI requires it for kube-dns — document what you chose.

## Verify

```bash
kubectl -n cks-setup get netpol default-deny-egress allow-web-dns -o yaml
```
