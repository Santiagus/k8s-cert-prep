---
name: notes-and-tasks
description: Format for notes.md, tasks/, and solutions/ — task first, solution separate; short notes; link kubernetes.io.
---

# Notes and tasks

Load this skill when writing or restructuring study content under any topic folder.

## notes.md

- Short original bullets: concepts, commands, gotchas — not a textbook reprint.
- Link primary docs ([kubernetes.io](https://kubernetes.io/docs/home/), API / kubectl reference) instead of long quotes.
- Lead with the domain title and weight when useful; keep stubs expandable.
- Capture gaps after attempting tasks (what you missed), not full solution dumps.

## tasks/

- One prompt per file (or clearly numbered sections). Prefer filenames like `01-etcd-backup.md`.
- **Task first, no spoilers** — no answer manifests, no “hint: the flag is …” that gives the solution away.
- State expected outcome (e.g. “Pod runs in namespace X”) without the exact YAML.
- Keep solutions out of this folder (`tasks/README.md` already says so).

## solutions/

- Mirror task numbering/names where possible.
- Include commands and/or manifests that achieve the outcome.
- Call out common failure modes briefly.
- Do not paste paid exam answers; write original worked solutions.

## Shared habits

- Relative links only.
- Prefer imperative kubectl in solutions when that matches exam style (see `kubectl-exam`).
- Update `docs/sources.md` when a new durable official/public link is worth keeping.

## Verification

- Opening `tasks/` alone does not reveal the solution.
- Notes stay skimmable; heavy detail lives in linked official docs.
- New files sit beside the matching topic’s existing stubs.
