# Task 05 — Image signing with Cosign (notes + optional verify)

## Objective

Practice the Sigstore/Cosign mental model used on CKS supply-chain items.

## Requirements

1. Install Cosign locally **or** use the official container image.
2. Record the difference between key-based (`cosign generate-key-pair` + `sign`/`verify`) and keyless (OIDC) flows — short bullets in Gaps.
3. Optionally sign a local/test image you control; do **not** commit private keys.
4. Note how admission (Kyverno/Gatekeeper + Cosign) can require signatures before Pods start — link official docs, no paid dumps.

## Verify

You can explain sign → registry → verify/admit; optional `cosign verify` succeeds on your test image.
