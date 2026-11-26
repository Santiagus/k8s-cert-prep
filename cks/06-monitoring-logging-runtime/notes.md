# Monitoring, Logging and Runtime Security (20%)

Competencies: behavioral detection; threat investigation; immutability at runtime; Kubernetes audit logs.

## Skill checklist

- [ ] Audit `Policy` YAML: levels `None` / `Metadata` / `Request` / `RequestResponse`
- [ ] Stage / resource / user / namespace filters; omit noisy system calls when appropriate
- [ ] kube-apiserver flags: `--audit-policy-file`, `--audit-log-path`, maxage/size/backup
- [ ] **Falco**: install concept, rules for shell in container / sensitive mounts / unexpected network
- [ ] Immutable workload: `readOnlyRootFilesystem`, no privilege escalation, drop caps
- [ ] Investigate: `kubectl get/describe/logs`, events, `hostPath` / privileged Pods, unexpected SAs
- [ ] Runtime: detect then contain (NetworkPolicy, delete Pod, cordon) — exam often wants detect + fix config

## High-value commands

```bash
# Audit policy lives on control plane; sketch locally first
kubectl explain --api-version=audit.k8s.io/v1 policy
# Immutability
kubectl -n runtime patch pod X --type=json -p='[…]'   # or re-apply YAML
# Hunt suspicious Pods
kubectl get pods -A -o json | jq '.items[] | select(.spec.hostNetwork==true) | .metadata'
kubectl get pods -A -o json | jq '.items[] | select(.spec.containers[].securityContext.privileged==true)'
# Falco (if installed)
kubectl -n falco logs -l app.kubernetes.io/name=falco --tail=50
```

## Mental model

```
API requests → audit log (who/what/when)
syscalls / container events → Falco alerts
Pod securityContext → reduce what malware can do if it lands
```

## Doc / tool links

- [Auditing](https://kubernetes.io/docs/tasks/debug/debug-cluster/audit/)
- [Falco docs](https://falco.org/docs/)
- [Falco rules](https://falco.org/docs/rules/)
- [Pod Security Standards](https://kubernetes.io/docs/concepts/security/pod-security-standards/) (immutability overlap)
- [Debug Running Pods](https://kubernetes.io/docs/tasks/debug/debug-application/debug-running-pod/)
- [resources/cks-tools.md](../../resources/cks-tools.md)

## Gaps

<!-- after practice -->
