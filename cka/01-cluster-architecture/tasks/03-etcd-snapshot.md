# Task 03 — etcd snapshot

## Objective

Take a consistent etcd snapshot to a file on the control-plane node (or kind control-plane container).

## Starting state

- kubeadm-style control plane **or** kind cluster `cka-prep`.
- You need sufficient privileges to reach etcd (root/ssh into CP, or `docker exec` into kind CP).

## Requirements

1. Identify how etcd is exposed on your lab (host network ports + PKI paths for kubeadm; static Pod in kind).
2. Create a snapshot file at `/tmp/etcd-snapshot-cka.db` (inside the control-plane OS / container).
3. Confirm the file is non-empty.
4. (Optional stretch) Document the restore high-level steps from the official docs — do not restore on a shared lab without a disposable cluster.

## Verify

- Snapshot file exists and size &gt; 0.
- You can explain where CA/cert/key were referenced for `etcdctl`.

Official reference: [Operating etcd clusters for Kubernetes](https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/).
