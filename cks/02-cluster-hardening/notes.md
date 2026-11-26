# Cluster Hardening (15%)

Competencies: least-privilege RBAC; ServiceAccount hygiene; restrict API access; upgrade Kubernetes.

## Skill checklist

- [ ] Roles/ClusterRoles with minimal verbs/resources
- [ ] Disable automount of SA token when unused (`automountServiceAccountToken: false`)
- [ ] Avoid default SA privileges; bind explicit SAs
- [ ] API server authn/authz flags awareness; anonymous access
- [ ] kubeadm upgrade plan/apply practice (link CKA lifecycle)

## Doc links

- [RBAC](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)
- [Manage Service Accounts](https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/)
- [kubeadm upgrade](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/)
- [Anonymous requests](https://kubernetes.io/docs/reference/access-authn-authz/authentication/#anonymous-requests)

## Gaps

<!-- after practice -->
