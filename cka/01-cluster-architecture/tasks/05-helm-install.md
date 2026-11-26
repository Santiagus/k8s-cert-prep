# Task 05 — Helm install

## Objective

Install a chart with Helm into a dedicated namespace and verify release status.

## Starting state

- Working cluster.
- Helm 3 CLI installed locally ([helm.sh](https://helm.sh/docs/intro/install/)).

## Requirements

1. Create namespace `helm-lab`.
2. Add a public chart repository (e.g. Bitnami or the chart author's repo of your choice — **OSS only**).
3. Install a lightweight chart (e.g. `bitnami/nginx` or similar) as release name `web` into `helm-lab`.
4. Confirm release is `deployed` and at least one Pod is Ready.

If Bitnami repos change URLs, use any small OSS chart; record the repo URL you used in your notes.

## Verify

```bash
helm -n helm-lab status web
kubectl -n helm-lab get pods
```
