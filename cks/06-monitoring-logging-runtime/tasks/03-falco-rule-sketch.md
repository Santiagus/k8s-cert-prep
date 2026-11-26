# Task 03 — Falco rule sketch

## Objective

Write a minimal Falco rule that detects a shell spawned in a container.

## Requirements

1. Author a local `falco-shell.yaml` (or `.rules`) fragment with rule / desc / condition / output / priority.
2. Condition should match common shell binaries (`bash`, `sh`) under a container (use Falco macros/fields from current docs — do not invent proprietary exam rules).
3. Optional: install Falco on kind ([Falco docs](https://falco.org/docs/)) and trigger with `kubectl exec … -- sh`.
4. Record in Gaps where alerts appear (stdout / stdout+k8s enrichment).

## Verify

Rule YAML is valid per Falco docs; optional alert fires on exec.
