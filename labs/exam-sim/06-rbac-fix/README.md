# Sim 06 — Broken RBAC (CKA Architecture / light CKS)

| | |
|--|--|
| **Timebox** | 20 minutes |
| **Domains** | [Cluster Architecture](../../cka/01-cluster-architecture/) · [CKS Cluster Hardening](../../cks/02-cluster-hardening/) |
| **Cluster** | [kind-bootstrap](../kind-bootstrap/) (`cka-prep`) |
| **Namespace** | `sim-rbac` |

## Scenario

ServiceAccount `auditor` must be able to **get/list** Pods in `sim-rbac` and must **not** be able to delete Pods. Starting state: SA exists, but Role/RoleBinding are missing or wrong.

## Constraints (exam-like)

- Work only in `sim-rbac` (Role + RoleBinding, not ClusterRole, unless you justify it — prefer namespaced Role).
- Keep SA name `auditor`.
- Principle of least privilege: no `*` verbs on pods.

## Starting state

```bash
./labs/exam-sim/06-rbac-fix/setup.sh
```

## Success criteria

```bash
./labs/exam-sim/06-rbac-fix/verify.sh
```

Expect: `kubectl auth can-i` as `system:serviceaccount:sim-rbac:auditor` → get/list pods **yes**, delete pods **no**.

## After the timer

Compare with [solutions/](solutions/). Related tasks: `cka/01-cluster-architecture/tasks/01-rbac-serviceaccount.md`, `cks/02-cluster-hardening/tasks/02-minimal-rbac.md`.
