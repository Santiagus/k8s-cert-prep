---
name: labs
description: When content belongs in labs/ vs a single-topic tasks/ folder; structure for timed multi-domain practice.
---

# Labs

Load this skill when creating or editing under `labs/`, or when deciding whether a drill is a topic task vs a lab.

## labs/ vs topic tasks/

| Put it in… | When |
|------------|------|
| `cka/…/tasks/` or `cks/…/tasks/` | Single domain, focused prompt, short |
| `labs/` | Spans **two or more** domains, timed exam-style, or needs a mini cluster scenario with success criteria |

Do not park single-topic practice under `labs/` just because it is hard.

## Lab structure

Prefer one directory per lab, e.g. `labs/<short-slug>/`:

- `README.md` — goal, timebox, domains touched, success criteria (no full spoilers)
- optional `setup/` or manifests needed to start
- optional `solution/` — worked path, kept separate from the prompt

Keep labs self-contained and small. Link domain notes instead of re-teaching everything.

## Anti-patterns

- Giant “full mock exam” dumps that violate paid-content ToS.
- Labs that require copying kubeconfigs or cloud credentials into the repo.
- Overlapping the same drill as both a topic task and a lab without a clear difference.

## Verification

- Lab README states domains + timebox + success criteria.
- Solution material is clearly separated from the prompt.
- Related single-domain skills stay in topic `tasks/`.
