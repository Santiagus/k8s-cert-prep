# Cluster Hardening (15%)

Competencies: least-privilege RBAC; ServiceAccount hygiene; restrict API access; upgrade Kubernetes securely.

## Skill checklist

- [ ] Role / ClusterRole with minimal verbs and resources (no `*` unless justified)
- [ ] RoleBinding vs ClusterRoleBinding scope
- [ ] Dedicated ServiceAccounts per workload; never reuse `default` with privileges
- [ ] `automountServiceAccountToken: false` when the Pod does not need the API
- [ ] `kubectl auth can-i` as SA for verification
- [ ] API server authn/authz flags; anonymous requests awareness
- [ ] kubelet authorization / anonymous (CIS-style awareness)
- [ ] kubeadm upgrade plan/apply (link CKA lifecycle — do not duplicate full notes)

## High-value commands

```bash
kubectl create sa app -n secure
kubectl create role cm-reader --verb=get,list --resource=configmaps -n secure
kubectl create rolebinding cm-reader --role=cm-reader --serviceaccount=secure:app -n secure
kubectl auth can-i list secrets --as=system:serviceaccount:secure:app -n secure
kubectl auth can-i --list --as=system:serviceaccount:secure:app -n secure
kubectl get clusterrole system:discovery -o yaml   # study built-ins; do not weaken
```

## Mental model

```
Subject (User / Group / SA)
    → RoleBinding / ClusterRoleBinding
        → Role / ClusterRole (verbs × resources × apiGroups)
            → API server authorization
```

## Doc links

- [RBAC](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)
- [Manage Service Accounts](https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/)
- [Using RBAC Authorization](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#service-account-permissions)
- [Anonymous requests](https://kubernetes.io/docs/reference/access-authn-authz/authentication/#anonymous-requests)
- [kubeadm upgrade](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/)
- [API Access Control](https://kubernetes.io/docs/concepts/security/api-server-audience-restriction/)
- CKA foundation: [cka/01-cluster-architecture/](../../cka/01-cluster-architecture/)

## Gaps

<!-- after practice -->
