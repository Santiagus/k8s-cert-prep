# Task 02 — Registry allowlist (Kyverno or Gatekeeper)

## Objective

Write (and optionally apply) a policy that only allows images from `registry.k8s.io/` and `docker.io/library/`.

## Requirements

1. Author a Kyverno ClusterPolicy **or** Gatekeeper ConstraintTemplate+Constraint (YAML in your scratch dir).
2. Document how a Pod using `evil.example/malware:latest` would be blocked.
3. Installing the admission controller on kind is optional but recommended once.

## Verify

Policy YAML validates conceptually; if controller installed, evil image Pod is denied.
