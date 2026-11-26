# Task 01 — Audit policy sketch

## Objective

Write a minimal audit policy that logs Secret metadata access at Metadata level and Pod exec at RequestResponse.

## Requirements

1. Create file `audit-policy.yaml` locally (do not commit cluster secrets).
2. Include rules for `secrets` (Metadata) and `pods/exec` (RequestResponse).
3. Note which kube-apiserver flags point at the policy file and log path (from official auditing docs).

## Verify

Policy YAML is valid against the documented schema; flags listed in your notes.
