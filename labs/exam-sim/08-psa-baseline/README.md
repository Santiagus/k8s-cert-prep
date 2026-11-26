# Sim 08 — Pod Security Admission baseline (CKS)

| | |
|--|--|
| **Timebox** | 20 minutes |
| **Domains** | [CKS Minimize Microservice Vulnerabilities](../../cks/04-minimize-microservice-vulns/) |
| **Cluster** | [kind-bootstrap](../kind-bootstrap/) (`cka-prep`) |
| **Namespace** | `sim-psa` |

## Scenario

Namespace `sim-psa` exists but has **no** Pod Security labels. A Deployment `web` is stuck because its Pod template uses `hostNetwork: true` (baseline violation once PSA is enforced). Your job:

1. Label the namespace to **enforce** (and warn/audit) **baseline** Pod Security (`latest` version label).
2. Fix the Deployment so Pods are admitted and become Ready (remove hostNetwork / other baseline violations).
3. Do **not** weaken the namespace to `privileged`.

## Constraints (exam-like)

- Work in `sim-psa` only.
- Keep Deployment name `web`.
- Prefer fixing the workload over deleting PSA labels.

## Starting state

```bash
./labs/exam-sim/08-psa-baseline/setup.sh
```

## Success criteria

```bash
./labs/exam-sim/08-psa-baseline/verify.sh
```

## After the timer

Compare with [solutions/](solutions/). Related: `cks/04-minimize-microservice-vulns/tasks/01-psa-baseline.md`.
