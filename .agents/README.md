# .agents — Agent workspace

Human-facing index for the agent setup. Agents load `AGENTS.md` always, then only matching skills — not this whole tree.

## Layout

```text
AGENTS.md                      always-loaded rules (repo root)
.agents/skills/<name>/SKILL.md topic conventions, loaded on demand
cka/ · cks/                    cert domains (notes, tasks, solutions)
shared/ · labs/ · resources/   cross-cutting study material
docs/                          curriculum map and sources
```

## Starting work

Open a fresh agent session and prompt with a **narrow** ask, for example:

> Expand notes and add two tasks under `cka/05-troubleshooting/` only.

or:

> Add a timed multi-topic lab under `labs/` for NetworkPolicy + RBAC.

`AGENTS.md` requires the agent to discover skills via:

```bash
grep -H '^description:' .agents/skills/*/SKILL.md
```

…and load only matches, then read only the folders/files needed for that ask.

This is a **study-domain** repo: no milestone protocol. Scope by cert domain, topic folder, or single lab.

## Skills

| Skill | Load when |
|-------|-----------|
| [`repository`](skills/repository/SKILL.md) | Tree layout, new folders, git hygiene |
| [`cka`](skills/cka/SKILL.md) | CKA domain notes/tasks/solutions |
| [`cks`](skills/cks/SKILL.md) | CKS domain notes/tasks/solutions |
| [`labs`](skills/labs/SKILL.md) | Multi-topic / timed scenarios under `labs/` |
| [`notes-and-tasks`](skills/notes-and-tasks/SKILL.md) | Formatting `notes.md`, `tasks/`, `solutions/` |
| [`kubectl-exam`](skills/kubectl-exam/SKILL.md) | Exam-day kubectl/YAML habits and timeboxing |

Keep the skill set small (≤7). Add a skill only when a recurring convention does not fit an existing one.

## Authoring rules

**Skills** live in `.agents/skills/<name>/SKILL.md` with YAML frontmatter (`name`, `description`). The description states when the skill applies. The body covers standards, preferred tools/commands, anti-patterns, and verification — narrowly scoped, never a project history or dump of all notes.

**Study content** follows the per-topic layout in [`docs/curriculum.md`](../docs/curriculum.md): `notes.md`, `tasks/` (no spoilers), `solutions/` (worked answers). Prefer short original notes plus kubernetes.io links over long pasted docs.
