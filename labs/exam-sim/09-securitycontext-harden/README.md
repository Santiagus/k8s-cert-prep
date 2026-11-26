# Sim 09 — Harden SecurityContext (CKS)

| | |
|--|--|
| **Timebox** | 25 minutes |
| **Domains** | [System Hardening](../../cks/03-system-hardening/) · [Monitoring / Runtime](../../cks/06-monitoring-logging-runtime/) |
| **Cluster** | [kind-bootstrap](../kind-bootstrap/) (`cka-prep`) |
| **Namespace** | `sim-sc` |

## Scenario

Deployment `api` runs but is insecure: privileged-capable container, writable root FS, no seccomp. Harden the **Pod template** so that:

1. `seccompProfile.type` is `RuntimeDefault` (Pod or container level).
2. Container has `allowPrivilegeEscalation: false`.
3. Container `capabilities.drop` includes `ALL`.
4. Container `readOnlyRootFilesystem: true`.
5. Deployment stays Ready (switch image or add emptyDir mounts if needed — `registry.k8s.io/pause:3.9` is an easy swap for this drill).

## Constraints

- Keep Deployment name `api` and namespace `sim-sc`.
- Do not set `privileged: true`.

## Starting state

```bash
./labs/exam-sim/09-securitycontext-harden/setup.sh
```

## Success criteria

```bash
./labs/exam-sim/09-securitycontext-harden/verify.sh
```

## After the timer

[solutions/](solutions/). Related: `cks/03-system-hardening/tasks/*`, `cks/06-monitoring-logging-runtime/tasks/02-readonly-rootfs.md`.
