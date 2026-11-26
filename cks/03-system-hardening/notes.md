# System Hardening (15%)

Competencies: reduce host OS attack surface; least-privilege IAM; minimize external network access; AppArmor / seccomp.

Weights: confirm on [CNCF CKS page](https://www.cncf.io/training/certification/cks/) / curriculum PDF before exam (some PDF revisions swap Setup vs System percentages).

## Skill checklist

- [ ] seccomp: `RuntimeDefault` and custom profiles (`localhost/<path>`)
- [ ] AppArmor: annotation `container.apparmor.security.beta.kubernetes.io/<ctr>` and/or `appArmorProfile` (API version-dependent)
- [ ] Drop Linux capabilities (`drop: ["ALL"]`); add only what is required
- [ ] `runAsNonRoot`, `runAsUser`, `allowPrivilegeEscalation: false`
- [ ] Avoid `hostNetwork` / `hostPID` / `hostIPC` unless justified
- [ ] Privileged containers: blast radius; prefer unprivileged
- [ ] Node OS: disable unused modules/services (CIS host — concepts); IAM least privilege on cloud nodes
- [ ] Firewall / NodePort / hostPort exposure awareness

## High-value commands / fields

```bash
kubectl explain pod.spec.securityContext
kubectl explain pod.spec.containers.securityContext
# Pod-level
securityContext:
  runAsNonRoot: true
  seccompProfile:
    type: RuntimeDefault
# Container-level
securityContext:
  allowPrivilegeEscalation: false
  capabilities:
    drop: ["ALL"]
  readOnlyRootFilesystem: true
```

## Mental model

```
Host kernel (AppArmor / seccomp / capabilities)
    ↑
  container runtime (CRI)
    ↑
  Pod securityContext + container securityContext
```

## Doc links

- [Seccomp](https://kubernetes.io/docs/tutorials/security/seccomp/)
- [AppArmor](https://kubernetes.io/docs/tutorials/security/apparmor/)
- [Security Context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)
- [Linux kernel security features](https://kubernetes.io/docs/concepts/security/linux-kernel-security-features/)
- [Restrict a Container's Syscalls with seccomp](https://kubernetes.io/docs/tutorials/security/seccomp/)
- Tools overview: [resources/cks-tools.md](../../resources/cks-tools.md)

## Lab notes

- kind nodes may lack loaded AppArmor profiles — write correct manifests; enforce on kubeadm VMs when available.
- Prefer images that run as non-root (`nginxinc/nginx-unprivileged`, `registry.k8s.io/pause`) for lab success.

## Gaps

<!-- after practice -->
