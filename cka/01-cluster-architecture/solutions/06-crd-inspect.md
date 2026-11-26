# Solution 06 — CRDs and extension interfaces

Commands (fill notes with **your** output):

```bash
kubectl get crd
kubectl get crd --no-headers | wc -l

kubectl get nodes -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.status.nodeInfo.containerRuntimeVersion}{"\n"}{end}'

kubectl get ds -A
# kind: often kindnet / kube-proxy
# Calico lab: calico-node, etc.

kubectl get sc
# local-path → provisioner rancher.io/local-path after kind-bootstrap
```

One-liners to remember:

| Interface | Role |
|-----------|------|
| **CRI** | kubelet ↔ container runtime |
| **CNI** | Pod network attach / IPAM / policy (implementation-dependent) |
| **CSI** | Out-of-tree volume plugins |

CRDs extend the API; operators reconcile custom resources toward desired state.
