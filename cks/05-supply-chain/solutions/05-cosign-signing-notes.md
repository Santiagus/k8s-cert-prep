# Solution 05 — Cosign notes

- **Key-based:** `cosign generate-key-pair` → `cosign sign --key cosign.key <image>` → `cosign verify --key cosign.pub <image>`. Protect `cosign.key`; never commit it.
- **Keyless:** OIDC identity + Sigstore transparency log; verify with identity/issuer claims per [Sigstore docs](https://docs.sigstore.dev/).
- **Admission:** Kyverno `verifyImages` / Gatekeeper + Cosign imageverify — cluster rejects unsigned or wrong-identity images.

Install: [Cosign](https://docs.sigstore.dev/cosign/system_config/installation/).
