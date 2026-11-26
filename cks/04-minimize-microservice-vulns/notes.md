# Minimize Microservice Vulnerabilities (20%)

Competencies: Pod Security Standards; Secrets management; isolation (tenancy/sandbox); Pod-to-Pod encryption (Cilium/Istio concepts).

## Skill checklist

- [ ] PSA labels: `pod-security.kubernetes.io/enforce` (privileged/baseline/restricted)
- [ ] Secrets as env vs volume; encryption at rest (concept)
- [ ] readOnlyRootFilesystem, non-root, seccomp together (restricted PSS)
- [ ] mTLS via service mesh — know where config lives; optional Cilium/Istio lab

## Doc links

- [Pod Security Standards](https://kubernetes.io/docs/concepts/security/pod-security-standards/)
- [Pod Security Admission](https://kubernetes.io/docs/concepts/security/pod-security-admission/)
- [Secrets good practices](https://kubernetes.io/docs/concepts/configuration/secret/#best-practices)
- [Istio](https://istio.io/latest/docs/) / [Cilium](https://docs.cilium.io/) (OSS mTLS options)

## Gaps

<!-- after practice -->
