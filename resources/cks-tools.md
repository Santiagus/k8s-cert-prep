# CKS tooling (free / OSS)

Quick map of tools that show up in CKS study. Prefer official docs over blog posts. Do not paste paid exam scenarios or proprietary CIS PDF text into this repo.

| Area | Tool | Use in practice |
|------|------|-----------------|
| Image / config scan | [Trivy](https://aquasecurity.github.io/trivy/) | `trivy image`, `trivy config` before admit |
| Runtime detection | [Falco](https://falco.org/docs/) | Syscall rules: shell in container, sensitive mounts |
| Admission (K8s-native) | [Kyverno](https://kyverno.io/) | Registry allowlist, disallow `:latest`, verifyImages |
| Admission (OPA) | [Gatekeeper](https://open-policy-agent.github.io/gatekeeper/website/) | ConstraintTemplates; [library](https://github.com/open-policy-agent/gatekeeper-library) |
| Image signing | [Cosign](https://docs.sigstore.dev/cosign/system_config/installation/) / [Sigstore](https://docs.sigstore.dev/) | Sign/verify; pair with admission |
| SBOM | [Syft](https://github.com/anchore/syft) or Trivy SBOM | Inventory deps in CI |
| YAML risk score | [Kubesec](https://kubesec.io/) | Static Pod/Deployment checks |
| Kernel profiles | [seccomp](https://kubernetes.io/docs/tutorials/security/seccomp/) / [AppArmor](https://kubernetes.io/docs/tutorials/security/apparmor/) | RuntimeDefault + drop caps |
| API audit | [Kubernetes auditing](https://kubernetes.io/docs/tasks/debug/debug-cluster/audit/) | Policy + apiserver flags |
| Network | [NetworkPolicy](https://kubernetes.io/docs/concepts/services-networking/network-policies/) | Default-deny + allowlists |
| Authz | [RBAC](https://kubernetes.io/docs/reference/access-authn-authz/rbac/) | Least-privilege Roles + SA hygiene |
| Pod baselines | [PSA / PSS](https://kubernetes.io/docs/concepts/security/pod-security-admission/) | Namespace enforce baseline/restricted |

## Install hints (lab)

```bash
# Trivy — see project install docs for your OS, or:
docker run --rm aquasec/trivy:latest image nginx:1.25

# Kyverno / Gatekeeper / Falco — follow each project's kind/helm install;
# keep cluster free of committed kubeconfigs and keys.
```

## Where practice lives in this repo

| Topic | Path |
|-------|------|
| Domain notes + tasks | [cks/](../cks/) |
| Timed sims (PSA, SecurityContext, SA/RBAC) | [labs/exam-sim/](../labs/exam-sim/) |
| Full link list | [docs/sources.md](../docs/sources.md) |

## Safety

- No secrets, signing private keys, or kubeconfigs in git.
- Record vulnerability **counts** in personal Gaps notes — not full CVE dumps.
- Killer.sh / paid mocks: practice there; **do not** copy scenarios here.
