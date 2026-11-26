# Solution 02 — Cluster-scoped node reader

```bash
kubectl create clusterrole node-viewer \
  --verb=get,list,watch \
  --resource=nodes

kubectl create clusterrolebinding audit-reader-nodes \
  --clusterrole=node-viewer \
  --user=audit-reader

kubectl auth can-i list nodes --as=audit-reader          # yes
kubectl auth can-i list secrets --as=audit-reader -n kube-system  # no
```

**Failure modes:** Using Role instead of ClusterRole for Nodes (cluster-scoped); binding a Group accidentally.
