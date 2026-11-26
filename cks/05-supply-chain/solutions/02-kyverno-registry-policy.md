# Solution 02 — Kyverno registry allowlist (illustrative)

Install Kyverno per https://kyverno.io/docs/installation/ then apply a ClusterPolicy using `validate` rules on `image` (see Kyverno "Allowed Image Registries" sample policies). Gatekeeper alternative: `k8sallowedrepos` constraint templates from Gatekeeper library.

Do not commit a full vendor policy dump — keep a minimal original policy in your private notes or a future PR.
