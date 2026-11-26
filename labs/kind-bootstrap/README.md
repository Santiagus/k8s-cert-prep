# Lab: kind bootstrap

Create a multi-node-ish local cluster suitable for CKA domain tasks.

## Why kind

See [resources/local-clusters.md](../../resources/local-clusters.md). Short version: SIG-owned, multi-node configs, free/OSS, good fit for scheduling and node drills.

## What you get

| Role | Nodes (default config) |
|------|------------------------|
| Control plane | 1 (`cka-prep-control-plane`) |
| Workers | 2 (`…-worker`, `…-worker2`) |

Also:

- Cluster name: `cka-prep`
- [local-path-provisioner](https://github.com/rancher/local-path-provisioner) installed and set as default StorageClass (`local-path`)
- Namespaces used by practice tasks are **not** pre-created — tasks create what they need

## CNI notes

kind ships **kindnet** by default. Basic Pod networking and Services work.

**NetworkPolicy:** kindnet has limited / evolving policy support depending on version. For strict NetworkPolicy drills:

- Prefer installing a policy-capable CNI (e.g. Calico) per that project's kind docs, **or**
- Treat policy tasks as YAML + verification against a CNI you know enforces them (kubeadm VM lab).

Task solutions call out when policy enforcement depends on CNI.

## Prerequisites

- Docker (or Podman with kind support)
- `kind` CLI
- `kubectl`
- Optional: `helm` for Helm drills in domain 01

## Create

```bash
# from repository root
./labs/kind-bootstrap/create-cluster.sh
kubectl get nodes -o wide
kubectl get sc
```

Config file: [kind-config.yaml](kind-config.yaml).

## Delete

```bash
./labs/kind-bootstrap/delete-cluster.sh
```

## Success criteria

- `kubectl get nodes` shows 1 control-plane + 2 workers, all `Ready`
- A test PVC using default StorageClass reaches `Bound` when claimed by a Pod (storage domain tasks)
- Context `kind-cka-prep` is current

## Domains this enables

All CKA domains. etcd backup/restore and bare kubeadm install are closer to VM/kubeadm labs; kind covers the rest of daily practice.
