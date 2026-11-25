---
name: cka
description: CKA domain folder map and how to add notes, tasks, and solutions for Certified Kubernetes Administrator prep.
---

# CKA

Load this skill when editing under `cka/` or when the task is CKA-specific.

## Domain map

Weights and folders: [`docs/curriculum.md`](../../../docs/curriculum.md). Index: [`cka/README.md`](../../../cka/README.md).

| Folder | Domain (weight) |
|--------|-----------------|
| `cka/01-cluster-architecture/` | Cluster Architecture, Installation & Configuration (25%) |
| `cka/02-workloads-scheduling/` | Workloads & Scheduling (15%) |
| `cka/03-services-networking/` | Services & Networking (20%) |
| `cka/04-storage/` | Storage (10%) |
| `cka/05-troubleshooting/` | Troubleshooting (30%) |

## Adding content

1. Pick **one** topic folder from the map above.
2. Expand `notes.md` with short original notes + kubernetes.io links (see `notes-and-tasks` skill).
3. Add practice prompts under `tasks/` without spoilers.
4. Put worked answers and manifests under `solutions/`.
5. Prefer studying CKA domains before CKS (CKA is a CKS sit prerequisite).

## Anti-patterns

- Editing every CKA topic in one PR.
- Copying paid simulator scenarios into the tree.
- Putting multi-domain timed drills here — those belong in `labs/`.

## Verification

- Files land under the correct numbered folder.
- Curriculum weight cited matches `docs/curriculum.md` (re-check CNCF if updating weights).
- Tasks remain solvable without opening `solutions/`.
