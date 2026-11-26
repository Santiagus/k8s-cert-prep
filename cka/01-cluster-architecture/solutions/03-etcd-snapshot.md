# Solution 03 — etcd snapshot

Official: [configure-upgrade-etcd](https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/).

## kubeadm (VM / bare metal)

On the control-plane node (paths typical for kubeadm):

```bash
ETCDCTL_API=3 etcdctl \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key \
  snapshot save /tmp/etcd-snapshot-cka.db

ETCDCTL_API=3 etcdctl --write-out=table snapshot status /tmp/etcd-snapshot-cka.db
ls -lh /tmp/etcd-snapshot-cka.db
```

Install `etcdctl` if missing (match etcd minor version when possible).

## kind

```bash
# find control-plane container
docker ps --format '{{.Names}}' | grep cka-prep-control-plane

docker exec -it cka-prep-control-plane bash
# inside container — etcd is a static Pod; use etcdctl with kind's cert paths:
# often under /etc/kubernetes/pki/etcd/ as with kubeadm-generated kind nodes
ETCDCTL_API=3 etcdctl \
  --endpoints=https://127.0.0.1:2379 \
  --cacert=/etc/kubernetes/pki/etcd/ca.crt \
  --cert=/etc/kubernetes/pki/etcd/server.crt \
  --key=/etc/kubernetes/pki/etcd/server.key \
  snapshot save /tmp/etcd-snapshot-cka.db
```

If `etcdctl` is absent in the container, copy a matching binary in or run etcdctl from a one-shot container networked to the CP. Exact packaging varies by kind node image — prefer kubeadm VMs for exam fidelity.

## Restore (do not run casually)

Follow the official restore procedure: restore snapshot to a new data directory, update static Pod manifest / volumes, ensure API server points at restored etcd. Practice only on disposable clusters.

**Failure modes:** Wrong cert files; HTTP vs HTTPS endpoint; snapshot on the wrong member in multi-etcd HA.
