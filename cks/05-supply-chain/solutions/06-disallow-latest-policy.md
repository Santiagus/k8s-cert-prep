# Solution 06 — Disallow latest (Kyverno sketch)

```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: disallow-latest-tag
spec:
  validationFailureAction: Enforce
  rules:
    - name: require-image-tag-not-latest
      match:
        any:
          - resources:
              kinds: ["Pod"]
      validate:
        message: "Using image tag 'latest' is not allowed"
        pattern:
          spec:
            containers:
              - image: "!*:latest"
```

Tighten further to require `@sha256:` if your exam item demands digests. Gatekeeper equivalent: Rego on `container.image` endswith `:latest`.
