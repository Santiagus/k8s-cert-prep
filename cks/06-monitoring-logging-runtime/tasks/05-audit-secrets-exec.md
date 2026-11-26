# Task 05 — Expand audit policy for Secrets + exec

## Objective

Extend the task 01 audit sketch with namespace narrowing and stage awareness.

## Requirements

1. Local `audit-policy.yaml` (do not commit real cluster paths with secrets).
2. Secrets at `Metadata` for all namespaces.
3. `pods/exec` and `pods/portforward` at `RequestResponse`.
4. A catch-all `level: None` or low-noise rule for noisy read-only verbs if you understand the tradeoff (document it).
5. List apiserver flags again: policy file + log path.

## Verify

Policy validates against [Auditing](https://kubernetes.io/docs/tasks/debug/debug-cluster/audit/) schema.
