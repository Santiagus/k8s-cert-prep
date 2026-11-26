# Sources

Prefer primary CNCF / Kubernetes docs when third-party material disagrees. Re-check links and curriculum PDFs before an exam sitting.

## Official curriculum & exam

- [CKA exam page (CNCF)](https://www.cncf.io/training/certification/cka/)
- [CKS exam page (CNCF)](https://www.cncf.io/training/certification/cks/)
- [CNCF open curriculum (GitHub)](https://github.com/cncf/curriculum) — CKA / CKS PDFs and domain weights
- [Linux Foundation Training candidate handbook](https://docs.linuxfoundation.org/tc-docs/certification/lf-candidate-handbook) — PSI Online, allowed materials, exam environment
- Domain ↔ folder map in this repo: [curriculum.md](curriculum.md)

## Kubernetes documentation (primary study)

- [Kubernetes docs home](https://kubernetes.io/docs/home/)
- [kubectl reference](https://kubernetes.io/docs/reference/kubectl/)
- [kubectl cheat sheet (official)](https://kubernetes.io/docs/reference/kubectl/quick-reference/)
- [API reference](https://kubernetes.io/docs/reference/kubernetes-api/)
- [kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/)
- [etcd backup / restore (kubeadm)](https://kubernetes.io/docs/tasks/administer-cluster/configure-upgrade-etcd/)
- [RBAC](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)
- [NetworkPolicy](https://kubernetes.io/docs/concepts/services-networking/network-policies/)
- [Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/)
- [Gateway API](https://gateway-api.sigs.k8s.io/)
- [Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)
- [StorageClasses](https://kubernetes.io/docs/concepts/storage/storage-classes/)
- [Debugging applications](https://kubernetes.io/docs/tasks/debug/debug-application/)
- [Debug clusters](https://kubernetes.io/docs/tasks/debug/debug-cluster/)

## Local clusters (free / OSS)

Primary in this repo: **kind** — see [resources/local-clusters.md](../resources/local-clusters.md) and [labs/kind-bootstrap/](../labs/kind-bootstrap/).

Timed broken-state drills with `setup.sh` / `verify.sh`: [labs/exam-sim/](../labs/exam-sim/).

| Tool | License / cost | Notes |
|------|----------------|-------|
| [kind](https://kind.sigs.k8s.io/) | Apache-2.0 | Multi-node Docker clusters; good CKA fit |
| [k3d](https://k3d.io/) | MIT | Fast k3s-in-Docker alternative |
| [minikube](https://minikube.sigs.k8s.io/) | Apache-2.0 | Single-node oriented; many addons |
| [kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/) | Apache-2.0 | Closest to exam cluster-install tasks |

## Free / OSS practice (attribution — do not copy wholesale)

Link and practice against these; write your own tasks in this repo rather than pasting their scenarios.

- [kubernetes/kubernetes](https://github.com/kubernetes/kubernetes) examples and e2e patterns
- [Kubernetes the Hard Way](https://github.com/kelseyhightower/kubernetes-the-hard-way) — deep bootstrap (CKA architecture)
- [killercoda](https://killercoda.com/) — free browser scenarios (community + vendor); use as warm-up, not as content to dump here
- Community “CKA practice” repos on GitHub — treat as inspiration only; keep this tree original

## Paid optional (disclosed)

- [Killer.sh](https://killer.sh/) CKA / CKS simulators — typically **included with the exam voucher** for a limited window; otherwise paid. Excellent mock environments; **do not** copy scenarios into this public repo.

## CKS-oriented tooling (free / OSS)

Repo cheat-sheet: [resources/cks-tools.md](../resources/cks-tools.md).

### Scanning, SBOM, signing

- [Trivy](https://aquasecurity.github.io/trivy/) — image / config / IaC / SBOM scanning
- [Syft](https://github.com/anchore/syft) — SBOM generation (OSS)
- [Cosign](https://docs.sigstore.dev/cosign/system_config/installation/) / [Sigstore docs](https://docs.sigstore.dev/) — image signing and verification
- [Kubesec](https://kubesec.io/) — static risk scoring for Kubernetes YAML

### Admission and policy

- [Kyverno](https://kyverno.io/) — Kubernetes-native policies (registry allowlist, verifyImages, restrict tags)
- [Kyverno policy library](https://kyverno.io/policies/)
- [OPA Gatekeeper](https://open-policy-agent.github.io/gatekeeper/website/) — admission policy
- [Gatekeeper library](https://github.com/open-policy-agent/gatekeeper-library) — ConstraintTemplates (e.g. allowed repos)

### Runtime, kernel, audit

- [Falco](https://falco.org/docs/) — runtime detection
- [Falco rules](https://falco.org/docs/rules/)
- [AppArmor](https://kubernetes.io/docs/tutorials/security/apparmor/) / [seccomp](https://kubernetes.io/docs/tutorials/security/seccomp/)
- [Auditing](https://kubernetes.io/docs/tasks/debug/debug-cluster/audit/) — API server audit policy + log flags
- [Encrypting Secret Data at Rest](https://kubernetes.io/docs/tasks/administer-cluster/encrypt-data/)

### Network, RBAC, Pod security (CKS-heavy)

- [NetworkPolicy](https://kubernetes.io/docs/concepts/services-networking/network-policies/)
- [RBAC](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)
- [Service Accounts](https://kubernetes.io/docs/reference/access-authn-authz/service-accounts-admin/)
- [Pod Security Admission](https://kubernetes.io/docs/concepts/security/pod-security-admission/) / [Pod Security Standards](https://kubernetes.io/docs/concepts/security/pod-security-standards/)
- [Security Context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)

### Benchmarks / threat models (link only)

- [CIS Kubernetes Benchmark](https://www.cisecurity.org/benchmark/kubernetes) — hardening baselines (do not paste proprietary PDF text)
- [OWASP Kubernetes Top Ten](https://owasp.org/www-project-kubernetes-top-ten/)

## Helm / Kustomize / operators

- [Helm](https://helm.sh/docs/)
- [Kustomize](https://kubectl.docs.kubernetes.io/references/kustomize/) (`kubectl apply -k`)
- [Operator pattern](https://kubernetes.io/docs/concepts/extend-kubernetes/operator/)
- [Custom Resources](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/)

## Exam logistics

- Confirm current Kubernetes version on the CKA / CKS exam pages before booking.
- Docs allowed in the exam environment: typically kubernetes.io and a short allow-list — verify the handbook for your sitting.
- CKA is a prerequisite to **schedule** CKS; check CNCF/LF pages for whether an active CKA is required at sit time.
