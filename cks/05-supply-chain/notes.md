# Supply Chain Security (20%)

Competencies: minimize base images; SBOM / CI awareness; allowed registries & signed artifacts; static analysis (Trivy, admission controllers).

## Skill checklist

- [ ] Scan images with **Trivy** (vuln + config); act on HIGH/CRITICAL
- [ ] Pin images by **digest** (`image@sha256:…`) not mutable tags; avoid `:latest`
- [ ] Admission: **Kyverno** or **OPA Gatekeeper** registry / tag / signature policies
- [ ] SBOM concept (Trivy / Syft); know why CI gates matter
- [ ] Image signing: **Cosign** / Sigstore — verify before admit (policy + notes)
- [ ] Dockerfile / K8s YAML static checks (Trivy config, Kubesec)
- [ ] `imagePullPolicy: IfNotPresent` vs `Always` tradeoffs with digests
- [ ] Private registries + imagePullSecrets hygiene (no secrets in git)

## High-value commands

```bash
trivy image nginx:1.25
trivy image --severity HIGH,CRITICAL nginx:1.25
trivy config deploy.yaml
# Digest pin example
kubectl -n supply set image deploy/web web=nginx@sha256:<digest>
# Cosign (local)
cosign verify --key cosign.pub <image>   # or keyless OIDC flows per Sigstore docs
```

## Mental model

```
Build → scan (Trivy) → sign (Cosign) → registry
                          ↓
Admission (Kyverno/Gatekeeper) → only allowed / verified images
                          ↓
Cluster runtime
```

## Doc / tool links

- [Trivy](https://aquasecurity.github.io/trivy/)
- [Kyverno](https://kyverno.io/) · [Kyverno policies](https://kyverno.io/policies/)
- [OPA Gatekeeper](https://open-policy-agent.github.io/gatekeeper/website/)
- [Gatekeeper library](https://github.com/open-policy-agent/gatekeeper-library)
- [Cosign](https://docs.sigstore.dev/cosign/system_config/installation/) · [Sigstore](https://docs.sigstore.dev/)
- [Kubesec](https://kubesec.io/)
- [Syft (SBOM)](https://github.com/anchore/syft)
- Repo aid: [resources/cks-tools.md](../../resources/cks-tools.md)

## Gaps

<!-- after practice: record HIGH/CRITICAL counts for images you scan — not CVE dumps -->
