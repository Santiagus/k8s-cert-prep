---
name: kubectl-exam
description: Exam-day kubectl and YAML habits — imperative-first, dry-run YAML, timeboxing, and what not to memorize.
---

# kubectl exam habits

Load this skill when writing exam-oriented notes, tasks, solutions, or labs that emphasize speed under the CKA/CKS environment.

## Imperative-first

- Prefer `kubectl run`, `create`, `expose`, `set`, `scale`, `rollout`, `autoscale` when they produce the object faster than hand-written YAML.
- Drop to YAML when the resource cannot be expressed cleanly with imperatives (NetworkPolicy, complex Deployment, RBAC bindings, etc.).

## Dry-run YAML

- Generate then edit: `kubectl … --dry-run=client -o yaml > file.yaml`.
- Apply from file after a quick review: `kubectl apply -f file.yaml`.
- Keep example manifests in `solutions/` minimal — fields you would actually type under time pressure.

## Timeboxing

- Read the whole question; note namespace and name constraints first.
- Skip and flag stuck items; return if time remains (troubleshooting domains reward triage).
- Verify with `kubectl get/describe/logs` before moving on — partial credit comes from a working result.

## What not to memorize

- Full API schemas — use `kubectl explain <resource>[.<field>]` and docs.
- Long YAML boilerplate — generate with dry-run.
- Vendor-specific paid lab answer keys — practice the pattern, not the dump.
- Exact flag order trivia when `--help` is available in the exam environment.

## Anti-patterns

- Teaching only hand-written YAML for objects that imperatives cover.
- Notes that require memorizing every field of common resources.
- Solutions that skip verification commands.

## Verification

- Exam-oriented notes mention dry-run / `kubectl explain` where relevant.
- Tasks state namespace and success check; solutions show a fast path, not a novel.
