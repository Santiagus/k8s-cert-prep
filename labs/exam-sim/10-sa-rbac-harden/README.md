# Sim 10 — ServiceAccount token + RBAC harden (CKS)

| | |
|--|--|
| **Timebox** | 25 minutes |
| **Domains** | [Cluster Hardening](../../cks/02-cluster-hardening/) · [Minimize Microservice Vulns](../../cks/04-minimize-microservice-vulns/) |
| **Cluster** | [kind-bootstrap](../kind-bootstrap/) (`cka-prep`) |
| **Namespace** | `sim-saharden` |

## Scenario

1. Pod `worker` currently automounts a ServiceAccount token but **must not** (`automountServiceAccountToken: false`).
2. SA `secret-reader` must be able to **get/list Secrets** in this namespace and must **not** create Pods.
3. Starting Role/RoleBinding are wrong or missing — fix least privilege.

## Constraints

- Namespace `sim-saharden` only.
- Keep Pod name `worker` and SA name `secret-reader`.
- Prefer a namespaced Role (not ClusterRole).

## Starting state

```bash
./labs/exam-sim/10-sa-rbac-harden/setup.sh
```

## Success criteria

```bash
./labs/exam-sim/10-sa-rbac-harden/verify.sh
```

## After the timer

[solutions/](solutions/). Related: `cks/02-cluster-hardening/tasks/01-sa-automount.md`, `03-secret-reader-rbac.md`.
