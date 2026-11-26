# Task 03 — Pin an image by digest

## Objective

Deploy with an immutable image reference instead of a floating tag.

## Requirements

1. Namespace `cks-supply`.
2. Resolve a digest for `nginx:1.25` (crane, docker inspect, or Trivy/registry) **or** use any known `nginx@sha256:…` you trust from your local pull.
3. Deployment `pinned` with container image set to `nginx@sha256:…` (not `:1.25` alone).
4. Note in Gaps why `:latest` is dangerous on exams and in prod.

## Verify

```bash
kubectl -n cks-supply get deploy pinned -o jsonpath='{.spec.template.spec.containers[0].image}{"\n"}'
# must contain @sha256:
```
