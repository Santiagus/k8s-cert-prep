# Sim 07 — NetworkPolicy allowlist (light CKS)

| | |
|--|--|
| **Timebox** | 25 minutes |
| **Domains** | [CKS Cluster Setup](../../cks/01-cluster-setup/) · [CKA Services & Networking](../../cka/03-services-networking/) |
| **Cluster** | [kind-bootstrap](../kind-bootstrap/) (`cka-prep`) |
| **Namespace** | `sim-np` |

## Scenario

Namespace `sim-np` runs frontend (`app=frontend`) and backend (`app=backend`) Deployments plus Services. Apply NetworkPolicies so that:

1. **Default deny** all Ingress (and preferably Egress) for Pods in the namespace, then open only what is required.
2. Frontend Pods may reach backend on TCP **80**.
3. Backend Pods may egress to **DNS** (UDP/TCP 53) so name resolution works.
4. Policy names: `default-deny`, `allow-frontend-to-backend`, `allow-backend-dns`.

## Constraints (exam-like)

- Work only in `sim-np`.
- Do not remove the Deployments/Services; add/fix NetworkPolicy objects.
- **CNI note:** kind’s default kindnet may not fully enforce NetworkPolicy. Still create correct policies — `verify.sh` checks objects and selected fields. For enforcement, install Calico (or similar); see [kind-bootstrap](../kind-bootstrap/README.md).

## Starting state

```bash
./labs/exam-sim/07-networkpolicy/setup.sh
```

Workloads are healthy; **no** NetworkPolicies exist yet (incomplete secure state).

## Success criteria

```bash
./labs/exam-sim/07-networkpolicy/verify.sh
```

## After the timer

Compare with [solutions/](solutions/). Related: `cks/01-cluster-setup/tasks/01-default-deny-netpol.md`, `cka/03-services-networking/tasks/04-networkpolicy.md`.
