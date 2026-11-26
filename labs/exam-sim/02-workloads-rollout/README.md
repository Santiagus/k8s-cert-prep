# Sim 02 — Broken Deployment rollout (CKA Workloads)

| | |
|--|--|
| **Timebox** | 20 minutes |
| **Domains** | [Workloads & Scheduling](../../cka/02-workloads-scheduling/) |
| **Cluster** | [kind-bootstrap](../kind-bootstrap/) (`cka-prep`) |
| **Namespace** | `sim-wl` |

## Scenario

Deployment `shop` should run **3** replicas of `nginx:1.25` with ConfigMap `shop-cfg` key `MODE=prod` injected as env `SHOP_MODE`. The starting state is wrong: bad image tag, wrong replica count, missing env wiring.

## Constraints (exam-like)

- Work only in `sim-wl`.
- Imperative or YAML is fine; final state must match success criteria.
- Do not open `solutions/` until time is up.

## Starting state

```bash
./labs/exam-sim/02-workloads-rollout/setup.sh
```

## Success criteria

```bash
./labs/exam-sim/02-workloads-rollout/verify.sh
```

Expect: Deployment `shop` has 3 Ready replicas; image `nginx:1.25`; env `SHOP_MODE=prod` from ConfigMap `shop-cfg`.

## After the timer

Compare with [solutions/](solutions/). Capture gaps in `cka/02-workloads-scheduling/notes.md`.
