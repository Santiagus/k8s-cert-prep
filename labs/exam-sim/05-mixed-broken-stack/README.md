# Sim 05 — Mixed broken stack (CKA multi-domain)

| | |
|--|--|
| **Timebox** | 40 minutes |
| **Domains** | Workloads, Services & Networking, Storage, Troubleshooting |
| **Cluster** | [kind-bootstrap](../kind-bootstrap/) (`cka-prep`) |
| **Namespace** | `sim-mixed` |

## Scenario

A small “checkout” stack was applied incorrectly. Bring the namespace to a working final state that meets **all** success criteria below. Multiple independent defects are present — triage like the exam.

## Constraints (exam-like)

- Work only in `sim-mixed`.
- Keep resource names: Deployment/Service `checkout`, ConfigMap `checkout-cfg`, PVC `checkout-data`.
- Prefer fixing over deleting the whole namespace (setup already owns recreate).
- Skip stuck sub-problems and return — verify at the end.

## Starting state

```bash
./labs/exam-sim/05-mixed-broken-stack/setup.sh
```

## Target final state

1. Deployment `checkout`: **1** replica, image `nginx:1.25`, Ready.
2. Env `APP_ENV=stage` from ConfigMap `checkout-cfg` key `APP_ENV`.
3. Service `checkout` ClusterIP port **80** with endpoints.
4. PVC `checkout-data` (1Gi RWO) Bound and mounted at `/data` on the Pod.

## Success criteria

```bash
./labs/exam-sim/05-mixed-broken-stack/verify.sh
```

## After the timer

Compare with [solutions/](solutions/). Redo weak single-domain sims (01–04) if needed.
