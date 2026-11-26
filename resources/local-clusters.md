# Local clusters

## Primary: kind

This repo standardizes on **[kind](https://kind.sigs.k8s.io/)** (Kubernetes IN Docker).

Why kind over k3d / minikube for CKA prep:

- Multi-node topologies are first-class (`kind create cluster --config`).
- Control-plane and worker nodes map cleanly to scheduling / taint drills.
- CNI is replaceable; default kindnet is enough for most NetworkPolicy learning when a supporting CNI is installed (see lab notes).
- Closer mental model to kubeadm-managed nodes than k3s abstractions.
- Official Kubernetes SIG project; free and OSS (Apache-2.0).

k3d is a fine **secondary** when you want faster recreate cycles. minikube is useful for addon experiments but is less ideal as the default multi-node CKA lab.

## Quick start

Prerequisites: Docker (or compatible runtime), [`kubectl`](https://kubernetes.io/docs/tasks/tools/), [`kind`](https://kind.sigs.k8s.io/docs/user/quick-start/#installation).

```bash
# from repo root
./labs/kind-bootstrap/create-cluster.sh
kubectl cluster-info --context kind-cka-prep
```

Tear down:

```bash
./labs/kind-bootstrap/delete-cluster.sh
```

Details: [labs/kind-bootstrap/README.md](../labs/kind-bootstrap/README.md).

## kubeadm topics

CKA install / upgrade / etcd tasks assume kubeadm-style clusters. Options:

1. Practice kubeadm on VMs (Multipass, local VMs) — closest to the exam.
2. Use kind for day-to-day drills; for etcd backup/restore, either use a kubeadm VM lab or follow kind-specific container/`crictl` paths documented in task solutions.
3. Optional: nested “kubeadm-in-kind” experiments — advanced; not required for the weekly Dec plan.

## StorageClass on kind

kind does not ship a default dynamic provisioner. The bootstrap lab installs [local-path-provisioner](https://github.com/rancher/local-path-provisioner) (OSS) so PVCs can bind during storage drills.
