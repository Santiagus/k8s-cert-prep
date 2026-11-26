# Solution 03 — Digest pin

```bash
kubectl create ns cks-supply --dry-run=client -o yaml | kubectl apply -f -

# Example: resolve digest after docker/crane pull (your digest will differ)
DIGEST=$(docker inspect --format='{{index .RepoDigests 0}}' nginx:1.25 2>/dev/null || true)
# Or: crane digest nginx:1.25

kubectl -n cks-supply create deployment pinned --image=nginx@sha256:REPLACE_WITH_REAL_DIGEST
# ensure the image field contains @sha256:
kubectl -n cks-supply get deploy pinned -o jsonpath='{.spec.template.spec.containers[0].image}{"\n"}'
```

`:latest` moves under you — exams and prod prefer digest or explicit version tags.
