# labs

Multi-topic or cluster-level practice. Single-domain drills stay under `cka/*/tasks/` or `cks/*/tasks/`.

| Lab | Purpose |
|-----|---------|
| [kind-bootstrap/](kind-bootstrap/) | Create / delete the primary multi-node kind cluster for daily CKA drills |
| [exam-sim/](exam-sim/) | Timed exam-style sims: broken state → fix → `verify.sh` (CKA + CKS; sims 08–10 are CKS-heavy) |
| [cka-mixed-drill/](cka-mixed-drill/) | Untimed/build-from-scratch multi-domain stack (workloads + net + storage) |

## When to use what

| Need | Go here |
|------|---------|
| Cluster up / tear down | [kind-bootstrap/](kind-bootstrap/) |
| Learn one skill | `cka/*/tasks/` or `cks/*/tasks/` |
| Exam-like repair under a timer | [exam-sim/](exam-sim/) (`setup.sh` → fix → `verify.sh`) |
| Build a stack from an empty namespace | [cka-mixed-drill/](cka-mixed-drill/) |
| December weeks 6–8 dress rehearsal | exam-sim 01 + 05, then weak-topic redo |

## Conventions

- Each lab has a `README.md` with goal, timebox, domains, and success criteria (no full spoilers).
- Exam sims also ship `setup.sh`, `verify.sh` (exit 0 = pass), and `solutions/`.
- Setup scripts/manifests are path-relative to the repo root.
- Solutions stay under `solution/` or `solutions/` inside the lab directory.
