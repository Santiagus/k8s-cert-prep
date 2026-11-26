# Task 06 — Disallow `:latest` tag (policy sketch)

## Objective

Write a Kyverno (or Gatekeeper) policy that blocks container images ending in `:latest` or lacking a tag digest.

## Requirements

1. Author a ClusterPolicy / Constraint YAML in scratch (minimal original policy).
2. State two test cases: `nginx:latest` (deny) and `nginx:1.25` or `@sha256:…` (allow — depending on your rule strictness).
3. Optional apply on kind if Kyverno/Gatekeeper is installed.

## Verify

Policy logic is clear; if applied, `:latest` Pod create fails.
