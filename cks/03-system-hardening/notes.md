# System Hardening (15%)

Competencies: reduce host OS attack surface; least-privilege IAM; minimize external network access; AppArmor / seccomp.

Weights: confirm on [CNCF CKS page](https://www.cncf.io/training/certification/cks/) / curriculum PDF before exam (some PDF revisions swap Setup vs System percentages).

## Skill checklist

- [ ] seccomp profile on Pods (`RuntimeDefault` / custom)
- [ ] AppArmor profile annotation / `appArmorProfile` (version-dependent API)
- [ ] Drop Linux capabilities; non-root user
- [ ] Host network/PID/IPC: when they expand blast radius
- [ ] Firewall / node port exposure awareness

## Doc links

- [Seccomp](https://kubernetes.io/docs/tutorials/security/seccomp/)
- [AppArmor](https://kubernetes.io/docs/tutorials/security/apparmor/)
- [Security Context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)
- [Linux kernel security features](https://kubernetes.io/docs/concepts/security/linux-kernel-security-features/)

## Gaps

<!-- after practice -->
