# Cluster Architecture, Installation & Configuration (25%)

Official competencies (CNCF curriculum): RBAC; install infrastructure; kubeadm create/manage; cluster lifecycle; HA control plane; Helm & Kustomize; CNI/CSI/CRI; CRDs & operators.

## Skill checklist

- [ ] Control plane: API server, scheduler, controller-manager, etcd, cloud-controller (if any)
- [ ] Node: kubelet, kube-proxy, container runtime (CRI)
- [ ] RBAC: Role / ClusterRole / RoleBinding / ClusterRoleBinding / ServiceAccount
- [ ] kubeadm: `init`, `join`, `upgrade`, certificates
- [ ] etcd: snapshot save / restore (kubeadm paths)
- [ ] HA: stacked vs external etcd (concepts); multiple control-plane join
- [ ] Helm: install / upgrade / rollback a chart
- [ ] Kustomize: `kubectl apply -k`
- [ ] Extension interfaces: CNI, CSI, CRI — what each plugs into
- [ ] CRDs: find installed CRDs; install a simple operator/chart that owns CRs

## Mental model

```
kubectl → API server → etcd
              ↓
         controllers / scheduler
              ↓
           kubelet (node) → CRI → containers
```

## High-value commands

```bash
kubectl get nodes -o wide
kubectl get --raw /readyz?verbose
kubectl get componentstatuses   # deprecated but still seen; prefer /readyz
kubectl auth can-i list pods --as=system:serviceaccount:ns:sa -n ns
etcdctl snapshot save /path/snap.db   # with etcdctl + certs on control plane
kubeadm upgrade plan
kubeadm upgrade apply <version>
helm list -A
kubectl apply -k overlays/prod
kubectl get crd
```

## Doc links

- [Components](https://kubernetes.io/docs/concepts/overview/components/)
- [kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/)
- [etcd backup/restore](https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/)
- [RBAC](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)
- [Certificates](https://kubernetes.io/docs/setup/best-practices/certificates/)
- [Helm](https://helm.sh/docs/)
- [Kustomize](https://kubectl.docs.kubernetes.io/references/kustomize/)
- [Operators](https://kubernetes.io/docs/concepts/extend-kubernetes/operator/)
- [CRI](https://kubernetes.io/docs/concepts/architecture/cri/) / [CNI](https://www.cni.dev/) / [CSI](https://kubernetes-csi.github.io/docs/)

## Lab notes

- Daily practice: [labs/kind-bootstrap/](../../labs/kind-bootstrap/).
- etcd snapshot on **kubeadm** nodes uses host certs under `/etc/kubernetes/pki/etcd/`. On **kind**, etcd runs in the control-plane container — solutions show both paths where relevant.
- HA control plane: understand `kubeadm join --control-plane`; full three-CP lab is optional on VMs.

## Gaps (fill after tasks)

<!-- What you missed -->
