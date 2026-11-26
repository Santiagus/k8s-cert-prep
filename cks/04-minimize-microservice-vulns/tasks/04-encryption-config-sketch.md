# Task 04 — EncryptionConfiguration sketch

## Objective

Author a minimal at-rest encryption config for Secrets (paper/lab file — do not commit real keys).

## Requirements

1. Create a local file `encryption-config.yaml` (keep it out of git or use a clearly fake key).
2. Use `aescbc` (or `aesgcm`) provider for `secrets` with an identity fallback.
3. Note the kube-apiserver flag `--encryption-provider-config=` and that **all** control-plane API servers need the same config.
4. List the high-level rotate-key steps from official docs (link, do not paste long quotes).

## Verify

File matches the schema in [Encrypting Secret Data at Rest](https://kubernetes.io/docs/tasks/administer-cluster/encrypt-data/); flags noted in Gaps.
