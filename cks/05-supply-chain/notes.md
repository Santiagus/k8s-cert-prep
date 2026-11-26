# Supply Chain Security (20%)

Competencies: small base images; SBOM / CI awareness; allowed registries & signed artifacts; static analysis (Trivy, Kubesec, admission).

## Skill checklist

- [ ] Scan images with Trivy (OSS)
- [ ] ImagePullPolicy and digests vs tags
- [ ] Admission policy: OPA Gatekeeper or Kyverno to allow only certain registries
- [ ] SBOM concept (Syft/Trivy)
- [ ] Avoid `:latest` in production manifests

## Doc / tool links

- [Trivy](https://aquasecurity.github.io/trivy/)
- [Kyverno](https://kyverno.io/)
- [OPA Gatekeeper](https://open-policy-agent.github.io/gatekeeper/website/)
- [Kubesec](https://kubesec.io/)
- [Cosign](https://docs.sigstore.dev/cosign/system_config/installation/) (Sigstore signing)

## Gaps

<!-- after practice -->
