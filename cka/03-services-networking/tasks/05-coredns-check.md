# Task 05 — CoreDNS health check

## Objective

Confirm CoreDNS is healthy and that cluster DNS resolution works.

## Starting state

- Working cluster.

## Requirements

1. Show CoreDNS Pods in `kube-system` are Ready.
2. Show the CoreDNS ConfigMap exists and contains a valid Corefile (do not break it).
3. From a test Pod in `default`, `nslookup kubernetes.default.svc.cluster.local` succeeds.
4. List one symptom you would check if DNS failed (e.g. kube-dns Service ClusterIP, CoreDNS logs) — add to your notes Gaps section.

## Verify

```bash
kubectl -n kube-system get pods -l k8s-app=kube-dns
kubectl -n kube-system get cm coredns
kubectl run dns-test --rm -it --restart=Never --image=busybox:1.36 -- nslookup kubernetes.default.svc.cluster.local
```
