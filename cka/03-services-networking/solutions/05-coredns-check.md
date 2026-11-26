# Solution 05 — CoreDNS check

```bash
kubectl -n kube-system get pods -l k8s-app=kube-dns
kubectl -n kube-system get cm coredns -o yaml
kubectl -n kube-system get svc kube-dns

kubectl run dns-test --rm -it --restart=Never --image=busybox:1.36 -- \
  nslookup kubernetes.default.svc.cluster.local
```

If DNS fails, typical checks: CoreDNS Pod logs (`kubectl -n kube-system logs -l k8s-app=kube-dns`); `kube-dns` Service Endpoints; node `/etc/resolv.conf` / kubelet DNS flags; recent Corefile edits.

Do **not** leave a broken Corefile in a shared lab.
