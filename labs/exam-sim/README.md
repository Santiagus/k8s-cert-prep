# Exam simulations

Timed, performance-style drills: **broken / incomplete cluster state → fix → verify**.

These mimic how CKA / CKS sittings feel (live cluster, kubectl, docs allowed, clock running) without copying paid vendor scenarios.

## How real exams work (high level)

Confirm logistics on the [CNCF exam pages](https://www.cncf.io/training/certification/cka/) and the [Linux Foundation candidate handbook](https://docs.linuxfoundation.org/tc-docs/certification/lf-candidate-handbook) before you sit — details change.

| Aspect | Typical exam | These sims |
|--------|--------------|------------|
| Format | Performance-based (create / fix / diagnose) | Same |
| Cluster | One (or few) live clusters, kubeconfig provided | Your local **kind** cluster (`cka-prep`) |
| Tools | `kubectl`, editor, terminal; docs allow-list (usually kubernetes.io) | Same habits; use kubernetes.io freely |
| Time | Fixed window; skip and return | Suggested timebox per sim |
| Scoring | Graders check final state | `verify.sh` checks final state (exit 0 = pass) |
| Content | Unique exam items | **Original** broken-state drills in this repo |

**Not simulated here:** PSI remote proctoring, the exact LF base image, multi-cluster kubeconfig switching at exam scale, or kubeadm etcd restore on bare VMs (use a VM lab for those).

## Mimic resources

| Resource | Cost | Role |
|----------|------|------|
| [kind-bootstrap](../kind-bootstrap/) in this repo | Free | Daily practice cluster |
| [Killer.sh](https://killer.sh/) | Paid / often **included with exam voucher** | Closest full mock — **do not** paste scenarios into this public repo |
| [KillerCoda](https://killercoda.com/) | Free browser scenarios | Warm-up; link only, no content dumps |
| Community CKA practice repos | Free | Inspiration only — keep this tree original |

More links: [docs/sources.md](../../docs/sources.md), [resources/exam-tips.md](../../resources/exam-tips.md).

## Prerequisites

1. Docker (or compatible runtime), `kind`, `kubectl`
2. Cluster up:

```bash
./labs/kind-bootstrap/create-cluster.sh
kubectl config current-context   # expect kind-cka-prep
```

3. From **repository root**, run each sim’s scripts (paths are relative to the repo root).

**NetworkPolicy sims:** default kindnet may not fully enforce policy. Still write correct policies; `verify.sh` checks the objects. For enforcement practice, install Calico (or similar) per that project’s kind docs — see [kind-bootstrap CNI notes](../kind-bootstrap/README.md).

## How to run a simulation

```bash
# 1. Break the cluster into the starting state
./labs/exam-sim/01-troubleshoot-crashloop/setup.sh

# 2. Start a timer (see each README timebox). Fix with kubectl only.
#    Do not open solutions/ until the timer ends.

# 3. Grade yourself
./labs/exam-sim/01-troubleshoot-crashloop/verify.sh
# exit 0 + OVERALL: PASS  → done
# FAIL lines               → keep fixing or check solutions/ after time
```

`setup.sh` is idempotent (recreates its namespace). `verify.sh` is safe to re-run; it only reads the cluster.

## Simulation index

| # | Dir | Cert | Domains | Timebox |
|---|-----|------|---------|---------|
| 01 | [01-troubleshoot-crashloop/](01-troubleshoot-crashloop/) | CKA | Troubleshooting | 15 min |
| 02 | [02-workloads-rollout/](02-workloads-rollout/) | CKA | Workloads & Scheduling | 20 min |
| 03 | [03-networking-endpoints/](03-networking-endpoints/) | CKA | Services & Networking | 15 min |
| 04 | [04-storage-pvc/](04-storage-pvc/) | CKA | Storage | 20 min |
| 05 | [05-mixed-broken-stack/](05-mixed-broken-stack/) | CKA | Workloads + Net + Storage + Troubleshoot | 40 min |
| 06 | [06-rbac-fix/](06-rbac-fix/) | CKA / light CKS | Architecture / Cluster Hardening | 20 min |
| 07 | [07-networkpolicy/](07-networkpolicy/) | light CKS | Cluster Setup / Networking | 25 min |

## When to use sims vs topic tasks

| Stage | Use |
|-------|-----|
| Learning a domain | `cka/*/tasks/` or `cks/*/tasks/` (one skill at a time) |
| After domain notes + tasks | Matching exam-sim (01–04, 06–07) under time |
| December weeks 6–8 | Heavy troubleshooting (01) + mixed (05) + weak-topic redo |
| Dress rehearsal | Optional Killer.sh via voucher; then light review of missed sims |

See the [December study path](../../README.md#december-cka-study-path-suggested) in the root README.

## Conventions (authors)

Each sim directory must include:

- `README.md` — scenario, timebox, constraints, success criteria (**no spoilers**)
- `setup.sh` — creates **initial broken / incomplete** state
- `verify.sh` — exit **0** only when expected final state is met; print `PASS` / `FAIL` per check
- `solutions/` — worked fix (spoilers)

Shared helpers: [lib/common.sh](lib/common.sh). Prefer original content; never commit kubeconfigs or secrets.
