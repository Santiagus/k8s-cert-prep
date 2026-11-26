# k8s-cert-prep

Personal study repo for the **Certified Kubernetes Administrator (CKA)** and **Certified Kubernetes Security Specialist (CKS)** exams. Domain folders hold original notes, performance-based tasks, and worked solutions aligned to the [CNCF curricula](https://github.com/cncf/curriculum).

**Target path:** sit **CKA by December**, then build toward **CKS within a year**.

## Navigation

| Path | Purpose |
|------|---------|
| [docs/curriculum.md](docs/curriculum.md) | Official domains mapped to folders |
| [docs/sources.md](docs/sources.md) | Official docs, free/OSS tools, paid optional disclosure |
| [cka/](cka/) | CKA domains — notes, tasks, solutions |
| [cks/](cks/) | CKS domains — notes + starter tasks |
| [shared/](shared/) | Cross-exam reference material |
| [labs/](labs/) | kind bootstrap + [exam-sim](labs/exam-sim/) + mixed drills |
| [resources/](resources/) | Cheat sheets, exam tips, local-cluster guide |
| [AGENTS.md](AGENTS.md) | Rules for AI coding agents working in this repo |

## Local lab (primary: kind)

We standardize on **[kind](https://kind.sigs.k8s.io/)** (multi-node, SIG project, free/OSS). Rationale and alternatives: [resources/local-clusters.md](resources/local-clusters.md).

```bash
./labs/kind-bootstrap/create-cluster.sh
kubectl get nodes
# when finished:
./labs/kind-bootstrap/delete-cluster.sh
```

## December CKA study path (suggested)

Assumes ~5 focused sessions/week after work. Adjust to your calendar; **Troubleshooting (30%)** and **Architecture (25%)** get the most reps.

| Week | Focus | Repo path |
|------|--------|-----------|
| 1 | Lab up + kubectl speed; skim all domain notes | [resources/](resources/), [labs/kind-bootstrap/](labs/kind-bootstrap/) |
| 2 | Cluster architecture: RBAC, etcd, kubeadm, Helm/Kustomize | [cka/01-cluster-architecture/](cka/01-cluster-architecture/) → then [exam-sim 06](labs/exam-sim/06-rbac-fix/) |
| 3 | Workloads & scheduling | [cka/02-workloads-scheduling/](cka/02-workloads-scheduling/) → [exam-sim 02](labs/exam-sim/02-workloads-rollout/) |
| 4 | Services, NetworkPolicy, Ingress, Gateway API, DNS | [cka/03-services-networking/](cka/03-services-networking/) → [exam-sim 03](labs/exam-sim/03-networking-endpoints/) |
| 5 | Storage PV/PVC/SC | [cka/04-storage/](cka/04-storage/) → [exam-sim 04](labs/exam-sim/04-storage-pvc/) |
| 6 | Troubleshooting drills (heavy) | [cka/05-troubleshooting/](cka/05-troubleshooting/) → [exam-sim 01](labs/exam-sim/01-troubleshoot-crashloop/) |
| 7 | Mixed timed sims + build-from-scratch lab + weak-topic redo | [exam-sim 05](labs/exam-sim/05-mixed-broken-stack/), [cka-mixed-drill](labs/cka-mixed-drill/) |
| 8 | Mock under time (optional Killer.sh via voucher); light review | [labs/exam-sim/](labs/exam-sim/), [resources/exam-tips.md](resources/exam-tips.md) |

**How to practice each domain:** read `notes.md` → attempt `tasks/` without spoilers → compare `solutions/` → jot gaps back into notes → run the matching [exam-sim](labs/exam-sim/) under its timebox (`setup.sh` → fix → `verify.sh`).

## After CKA → CKS

1. Keep the same kind (or kubeadm) lab habit.
2. Work through [cks/](cks/) checklists; expand starter tasks.
3. Add Falco, Trivy, Kyverno/Gatekeeper, AppArmor/seccomp practice — links in [docs/sources.md](docs/sources.md).

## Agents

Load [AGENTS.md](AGENTS.md), then only matching skills under `.agents/skills/`. Prefer small PRs scoped to one domain or lab. See [.agents/README.md](.agents/README.md).

## Study hygiene

- Original notes + kubernetes.io links — no paid-course or Killer.sh scenario dumps.
- Tasks stay spoiler-free; solutions stay under `solutions/`.
- Never commit kubeconfigs, tokens, or `.env` files.
