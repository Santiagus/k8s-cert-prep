---
name: cks
description: CKS domain folder map and how to add notes, tasks, and solutions for Certified Kubernetes Security Specialist prep.
---

# CKS

Load this skill when editing under `cks/` or when the task is CKS-specific.

## Domain map

Weights and folders: [`docs/curriculum.md`](../../../docs/curriculum.md). Index: [`cks/README.md`](../../../cks/README.md).

| Folder | Domain (weight) |
|--------|-----------------|
| `cks/01-cluster-setup/` | Cluster Setup (10%) |
| `cks/02-cluster-hardening/` | Cluster Hardening (15%) |
| `cks/03-system-hardening/` | System Hardening (15%) |
| `cks/04-minimize-microservice-vulns/` | Minimize Microservice Vulnerabilities (20%) |
| `cks/05-supply-chain/` | Supply Chain Security (20%) |
| `cks/06-monitoring-logging-runtime/` | Monitoring, Logging and Runtime Security (20%) |

## Adding content

1. Pick **one** topic folder from the map above.
2. Expand `notes.md` with short original notes + official docs (Kubernetes, Falco, Trivy, OPA/Gatekeeper, CIS as relevant — see `docs/sources.md`).
3. Add practice prompts under `tasks/` without spoilers.
4. Put worked answers and manifests under `solutions/`.
5. Assume CKA foundations; link to `shared/` or a CKA topic instead of duplicating basic kubectl notes.

## Anti-patterns

- Duplicating full CKA notes inside CKS folders.
- Committing proprietary CIS PDF text or paid lab dumps — link official pages instead.
- Mixing cluster-setup networking drills that span many domains into a single topic — prefer `labs/` when multi-topic.

## Verification

- Files land under the correct numbered folder.
- Curriculum weight cited matches `docs/curriculum.md`.
- Security tooling examples stay illustrative and free of real cluster secrets.
