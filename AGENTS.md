# AGENTS.md

Operating rules for AI coding agents in this repository.
This file is loaded into every agent session — keep it short. Put topic detail in skills under `.agents/skills/`.

## Project

Personal **CKA + CKS** certification prep: original notes, practice tasks, solutions, multi-topic labs, and curated links — not a product monorepo.

Layout overview and authoring rules for humans: [`.agents/README.md`](.agents/README.md).

## Context loading (mandatory)

Load, in order:

1. this file;
2. discover skills with `grep -H '^description:' .agents/skills/*/SKILL.md` and load **only** skills whose description matches the task;
3. read **only** the cert domain folder(s) / files needed for the task (e.g. one `cka/0N-*/` topic, or one lab under `labs/`).

Do **not** read all of `cka/`, `cks/`, `docs/`, or every `notes.md`. Prefer `ls` / targeted reads over tree-wide dumps. Consult [`docs/curriculum.md`](docs/curriculum.md) only when mapping domains or weights; consult [`docs/sources.md`](docs/sources.md) only when adding or checking links.

## Scope discipline

- One domain or one task at a time unless the user asks for more.
- Prefer small, reviewable PRs. Do not invent parallel study tracks or reorganize the tree without being asked.
- Decide routine formatting autonomously. Stop and ask when a change would move folders, rename domains, or alter curriculum mappings.

## Study-domain protocol

When adding or editing prep content:

1. Identify the cert (`cka` / `cks`) and the topic folder from [`docs/curriculum.md`](docs/curriculum.md).
2. Load matching skills (`repository`, `cka` or `cks`, `notes-and-tasks`, and `labs` / `kubectl-exam` when relevant).
3. Edit only that topic (or one lab / shared resource). Keep tasks spoiler-free; solutions stay under `solutions/`.
4. Link kubernetes.io (or other official docs) instead of pasting long quoted material.

## Public-repo security

Never commit secrets, kubeconfigs, tokens, `.env` files, or personal cluster details.

Do not dump paid exam content, killer.sh scenarios, or other material that violates vendor ToS. Prefer **original** notes and **official** doc links (`docs/sources.md`).

## Path-agnostic and portable

Never use machine-specific absolute paths in docs, links, or scripts. Use paths relative to the repository root.

## Validation and commits

Before proposing a commit: inspect the diff for secrets, absolute paths, and accidental spoilers in `tasks/`. Prefer Conventional Commits with a short scope, e.g. `docs(cka): expand etcd backup notes`, `feat(labs): add networkpolicy drill`. Keep commits atomic and PRs small.
