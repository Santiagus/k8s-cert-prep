# Sim 03 — Service with no Endpoints (CKA Networking)

| | |
|--|--|
| **Timebox** | 15 minutes |
| **Domains** | [Services & Networking](../../cka/03-services-networking/) |
| **Cluster** | [kind-bootstrap](../kind-bootstrap/) (`cka-prep`) |
| **Namespace** | `sim-net` |

## Scenario

Deployment `api` is healthy, but Service `api` has **no endpoints**. Clients cannot reach the app. Fix networking so the Service selects the Pods and has endpoints.

## Constraints (exam-like)

- Work only in `sim-net`.
- Do not delete the Service name `api` permanently — restore a working Service named `api` on port 80.
- Docs + kubectl only; no spoilers until time ends.

## Starting state

```bash
./labs/exam-sim/03-networking-endpoints/setup.sh
```

## Success criteria

```bash
./labs/exam-sim/03-networking-endpoints/verify.sh
```

Expect: Deployment Ready; Service `api` exists; endpoints non-empty.

## After the timer

Compare with [solutions/](solutions/). Capture gaps in `cka/03-services-networking/notes.md`.
