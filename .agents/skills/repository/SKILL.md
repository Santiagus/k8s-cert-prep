---
name: repository
description: Repo tree layout (cka/cks/shared/labs/resources/docs), when to add folders, and git hygiene for this cert-prep repo.
---

# Repository

## Tree

| Path | Purpose |
|------|---------|
| `cka/` | CKA domains — one numbered folder per curriculum domain |
| `cks/` | CKS domains — same pattern |
| `shared/` | Cross-exam references (not domain-specific) |
| `labs/` | Timed / multi-topic scenarios spanning domains |
| `resources/` | Cheat sheets, checklists, bookmarks (no secrets) |
| `docs/` | Curriculum map and source links only |

Each CKA/CKS topic folder: `notes.md`, `tasks/`, `solutions/`. See `docs/curriculum.md` for the domain ↔ folder map.

## When to add folders

- **New curriculum domain** — only if CNCF weights/folders change; update `docs/curriculum.md` and the cert `README.md` in the same change.
- **New topic under an existing domain** — prefer expanding the existing numbered folder; do not invent parallel numbering.
- **Cross-cutting material** — `shared/` if both certs need it; `resources/` for static aids; `labs/` for multi-domain drills.
- Do not create empty placeholder trees or duplicate the same note in `cka/` and `cks/`.

## Git hygiene

- Prefer small PRs scoped to one domain, one lab, or docs-only.
- Conventional Commits, e.g. `docs(cka): …`, `feat(labs): …`, `chore(agents): …`.
- Never commit kubeconfigs, credentials, `.env`, or paid exam dumps.
- Paths in docs and links stay relative to the repo root.

## Verification

- Diff stays inside the intended folder(s).
- No secrets or absolute machine paths.
- New topic folders include `notes.md` plus `tasks/` and `solutions/` READMEs (or real files) so nothing is empty.
