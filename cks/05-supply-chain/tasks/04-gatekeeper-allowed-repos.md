# Task 04 — Gatekeeper allowed repos sketch

## Objective

Author a Gatekeeper-style ConstraintTemplate + Constraint that allows only approved registries (paper task; install optional).

## Requirements

1. Write YAML for a ConstraintTemplate that validates Pod image strings (Rego can be minimal / illustrative).
2. Write a Constraint listing allowed prefixes: `registry.k8s.io/`, `docker.io/library/`.
3. Document the denial message for `evil.example/malware:1.0`.
4. Optional: install Gatekeeper on kind and apply; otherwise keep YAML in scratch and compare to [gatekeeper-library](https://github.com/open-policy-agent/gatekeeper-library) patterns.

## Verify

YAML is coherent; if installed, evil image Pod is denied and allowlisted image admitted.
