# Minimize Microservice Vulnerabilities (20%)

Competencies: Pod Security Standards; Secrets management; isolation (tenancy/sandbox); Pod-to-Pod encryption (Cilium/Istio concepts).

## Skill checklist

- [ ] PSA labels: `pod-security.kubernetes.io/{enforce,audit,warn}` = `privileged|baseline|restricted`
- [ ] Version label `pod-security.kubernetes.io/enforce-version: latest` (or pin a version)
- [ ] Restricted PSS: non-root, drop ALL caps, RuntimeDefault seccomp, no privilege escalation, often read-only root FS
- [ ] Secrets as **volumes** preferred over env for many threat models; never commit Secret data
- [ ] Encryption at rest (`EncryptionConfiguration`) — concept + sketch for apiserver
- [ ] Avoid `hostPath`; prefer emptyDir / PVC; gVisor / Kata awareness (sandbox)
- [ ] mTLS via service mesh — know where policy lives (Istio/Cilium); optional deep lab
- [ ] Namespace tenancy: NetworkPolicy + RBAC + PSA together

## High-value commands

```bash
kubectl create ns secure
kubectl label ns secure \
  pod-security.kubernetes.io/enforce=baseline \
  pod-security.kubernetes.io/warn=baseline \
  pod-security.kubernetes.io/audit=baseline
kubectl create secret generic db --from-literal=password=s3cret -n secure
# Mount as volume (not env) in Pod spec
kubectl explain pod.spec.volumes.secret
```

## Mental model

```
Namespace PSA (admission) → rejects non-compliant Pods
Pod SecurityContext → runtime constraints
Secret → volume mount (tmpfs) → app reads file
Mesh sidecar / Cilium → mTLS between Pods
```

## Doc links

- [Pod Security Standards](https://kubernetes.io/docs/concepts/security/pod-security-standards/)
- [Pod Security Admission](https://kubernetes.io/docs/concepts/security/pod-security-admission/)
- [Secrets good practices](https://kubernetes.io/docs/concepts/configuration/secret/#best-practices)
- [Encrypting Secret Data at Rest](https://kubernetes.io/docs/tasks/administer-cluster/encrypt-data/)
- [Istio](https://istio.io/latest/docs/) / [Cilium](https://docs.cilium.io/) (OSS mTLS options)
- [gVisor](https://gvisor.dev/) / [Kata Containers](https://katacontainers.io/) (sandbox runtimes)

## Gaps

<!-- after practice -->
