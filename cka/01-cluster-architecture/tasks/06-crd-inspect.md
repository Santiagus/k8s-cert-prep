# Task 06 — CRDs and extension interfaces

## Objective

Inventory CRDs and map CNI / CSI / CRI in your lab cluster.

## Starting state

- Working kind or kubeadm cluster.

## Requirements

1. List CustomResourceDefinitions; note count and 2–3 example names.
2. Identify the container runtime from node status / `node.info` (CRI).
3. Identify which CNI plugin is in use (kindnet, Calico, etc.) from DaemonSets / node annotations / docs for your lab.
4. List StorageClasses and name the CSI driver or provisioner string if present (local-path uses a provisioner name, not always a full CSI driver).
5. Write 3–5 bullet answers into `cka/01-cluster-architecture/notes.md` under Gaps or a short “Lab inventory” section — do not invent values; use your cluster.

## Verify

```bash
kubectl get crd
kubectl get nodes -o wide
kubectl get ds -A
kubectl get sc
```

You can explain in one sentence each: what CNI, CSI/provisioner, and CRI do.
